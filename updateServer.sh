#!/usr/bin/env bash

# Run script to update your server to the current version (use argument "openjk" if using OpenJK engine).
# Customize variables below as necessary.

# directory where base and MBII folder reside (AKA GameData on clients)
basedir="/opt/openjk"

read -p "Update MBII?" -n 1 -r
echo # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then

   # download newer files
   cd $basedir
   dotnet MBII_CommandLine_Update_XPlatform.dll

   read -p "Is your engine OpenJK based?" -n 1 -r
   if [[ $REPLY =~ ^[Yy]$ ]]; then
      cd $basedir/MBII
      mv -f jampgamei386.so jampgamei386.jamp.so
      cp jampgamei386.nopp.so jampgamei386.so
   fi

   echo "***** Done! *****"
else
   echo "Aborting"
fi
