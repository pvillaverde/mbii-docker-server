#!/usr/bin/env bash

######### VARIABLES (If Undefined)
: "${GAME_ENGINE:=linuxjampded}"
: "${SERVER_CONFIG:=server_config_default.cfg}"
: "${SERVER_PORT:=29070}"
: "${RTVRTM_CONFIG:=}"

######### Colors
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
BLUE='\033[00;34m'

echo-green() {
	dt=$(date '+%d/%m/%Y %H:%M:%S')
	echo -e "${dt}: ${GREEN}${1}${RESTORE}"
}

echo-red() {
	dt=$(date '+%d/%m/%Y %H:%M:%S')
	echo -e "${dt}: ${RED}${1}${RESTORE}"
}

echo-blue() {
	dt=$(date '+%d/%m/%Y_%H:%M:%S')
	echo -e "${dt}: ${BLUE}${1}${RESTORE}"
}
######### Download / Update RTVRTM
mkdir /opt/rtvrtm/ &>/dev/null
wget -O /opt/rtvrtm/RTVRTM.zip https://www.moviebattles.org/download/RTVRTM.zip
unzip /opt/rtvrtm/RTVRTM.zip "Linux/*" -d "/opt/rtvrtm/" && mv /opt/rtvrtm/Linux/* /opt/rtvrtm/ && rmdir /opt/rtvrtm/Linux

# If an rtvrtm configuration file has been defined and it exists, start rtvrtm.

if [ -f "/opt/openjk/MBII/${RTVRTM_CONFIG}" ]; then
	echo-green "Found RTV RTM Config at /opt/openjk/MBII/${RTVRTM_CONFIG}"

	cp /opt/openjk/MBII/*.txt /opt/rtvrtm
	cp "/opt/openjk/MBII/${RTVRTM_CONFIG}" /opt/rtvrtm/rtvrtm.cfg

	echo-green "Starting RTV RTM Service"

	until (
		sleep 10
		python2 /opt/rtvrtm/rtvrtm.py -c /opt/rtvrtm/rtvrtm.cfg --noupdate
	); do
		echo "RTVRTM crashed with exit code $?. Restarting..." >&2
	done &
else
	echo-red "Unable to find RTV RTM Config at /opt/openjk/MBII/${RTVRTM_CONFIG}"
fi

#########
# Run script to update your server to the current version (use argument "openjk" if using OpenJK engine).
# Customize variables below as necessary.

### Check for Updates on MBII on startup
echo-blue "**** Checking MBII Updates ****"
cd /opt/openjk/MBII
wget --inet4-only --execute="robots = off" -r -l 1 -nd -nH -N -A pk3,so,cfg,txt,mb2c,mbcr https://update.moviebattles.org/files/MBII/
if [ "$GAME_ENGINE" == "openjk" ]
then
	mv -f jampgamei386.so jampgamei386.jamp.so
	cp jampgamei386.nopp.so jampgamei386.so
fi
echo-green "***** Done! *****"
cd /opt/openjk/
sleep 4
## Start Server
until (sleep 1; ./$GAME_ENGINE +set dedicated 2 +set net_port "${SERVER_PORT}" +set fs_game MBII +exec "${SERVER_CONFIG}"); do
    echo-red "Dedicated Server crashed with exit code $?. Restarting..." >&2
done