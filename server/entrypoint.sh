#!/usr/bin/env bash

if [ "$ENABLE_RTVRTM" == "true" ]; then
   ######### Download / Update RTVRTM
   echo "RTVRTM is enabled, downloadind latest version."
   mkdir /opt/rtvrtm/ &>/dev/null
   wget -O /opt/rtvrtm/RTVRTM.zip https://www.moviebattles.org/download/RTVRTM.zip
   unzip /opt/rtvrtm/RTVRTM.zip "Linux/*" -d "/opt/rtvrtm/" && mv /opt/rtvrtm/Linux/* /opt/rtvrtm/ && rmdir /opt/rtvrtm/Linux
   # Copy configuration files to RTVRTM directory
   echo "Update config and starting RTV RTM Service"
   j2 /config/rtvrtm.cfg.j2 >/opt/rtvrtm/rtvrtm.cfg
   # Copy custom maps files, if they exist.
   if [ -f "/config/maps.txt" ]; then
      cp /config/maps.txt /opt/rtvrtm/maps.txt
   fi
   if [ -f "/config/secondary_maps.txt" ]; then
      cp /config/secondary_maps.txt /opt/rtvrtm/secondary_maps.txt
   fi
   # Start RTVRTM
   until (
      sleep 10
      python2 /opt/rtvrtm/rtvrtm.py -c /opt/rtvrtm/rtvrtm.cfg --noupdate
   ); do
      echo "RTVRTM crashed with exit code $?. Restarting..." >&2
   done &
fi

#########
# Run script to update your server to the current version (use argument "openjk" if using OpenJK engine).
# Customize variables below as necessary.
### Check for Updates on MBII on startup
echo "**** Checking MBII Updates ****"
cd /opt/openjk
dotnet MBII_CommandLine_Update_XPlatform.dll
if [ "$GAME_ENGINE" == "openjk" ]; then
   cd /opt/openjk/MBII
   mv -f jampgamei386.so jampgamei386.jamp.so
   cp jampgamei386.nopp.so jampgamei386.so
fi
echo "***** Done! *****"
cd /opt/openjk/
sleep 4

j2 /config/server_config.cfg.j2 >/opt/openjk/MBII/server_config.cfg
## Start Server
until (
   sleep 1
   ./$GAME_ENGINE +set dedicated 2 +set net_port "${SERVER_PORT}" +set fs_game MBII +exec "server_config.cfg"
); do
   echo "Dedicated Server crashed with exit code $?. Restarting..." >&2
done
