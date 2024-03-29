FROM ubuntu
LABEL MAINTAINER="Fedello Kirfed <fedellokirfed@gmail.com>"


# 32bit Arch
RUN dpkg --add-architecture i386

# Install dependencies.
RUN apt-get update 
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
RUN apt-get install -y curl:i386 
RUN apt-get install -y python-setuptools python2-dev 
RUN apt-get install -y wget unzip
RUN apt-get install -y dotnet-sdk-6.0
# Install Python  dependencies
RUN apt-get install -y pip && pip install j2cli[yaml]

# LIB FILES
COPY server/libcxa.so.1 /usr/lib/
RUN chmod a+r /usr/lib/libcxa.so.1

# Set the working directory to where the Jedi Academy data files will be
# mounted at, so that linuxjampded finds them.

# Server Files
COPY server/* /opt/openjk/
COPY base/* /opt/openjk/base/
COPY config/* /config/

WORKDIR /opt/openjk

# Start the server.
RUN chmod +x /opt/openjk/linuxjampded
RUN chmod +x /opt/openjk/entrypoint.sh

# Expose a range of possible Jedi Academy ports.
EXPOSE 29070/udp

ENTRYPOINT ["/opt/openjk/entrypoint.sh"]
#CMD ["/opt/openjk/entrypoint.sh"]


# jinja defaults ENVVARS:
ENV \ 
   GAME_ENGINE="linuxjampded"             \
   ENABLE_RTVRTM="true"                   \
   sv_hostname="Mb2 Docker Server by pvillaverde"               \
   g_motd="Customize this message with envvar g_motd"                    \
   discord=""                             \
   rconpassword="rcon"                    \
   sv_privatePassword=""                  \
   sv_privateClients=""                   \
   sv_floodProtect="1"                    \
   g_smodAdminPassword_1=""               \
   g_smodConfig_1="0"                     \
   g_smodAdminPassword_2=""               \
   g_smodConfig_2="0"                     \
   g_smodAdminPassword_3=""               \
   g_smodConfig_3="0"                     \
   g_smodAdminPassword_4=""               \
   g_smodConfig_4="0"                     \
   g_smodAdminPassword_5=""               \
   g_smodConfig_5="0"                     \
   g_smodAdminPassword_6=""               \
   g_smodConfig_6="0"                     \
   g_smodAdminPassword_7=""               \
   g_smodConfig_7="0"                     \
   g_smodAdminPassword_8=""               \
   g_smodConfig_8="0"                     \
   g_smodAdminPassword_9=""               \
   g_smodConfig_9="0"                     \
   g_smodAdminPassword_10=""              \
   g_smodConfig_10="0"                    \
   g_smodAdminPassword_11=""              \
   g_smodConfig_11="0"                    \
   g_smodAdminPassword_12=""              \
   g_smodConfig_12="0"                    \
   g_smodAdminPassword_13=""              \
   g_smodConfig_13="0"                    \
   g_smodAdminPassword_14=""              \
   g_smodConfig_14="0"                    \
   g_smodAdminPassword_15=""              \
   g_smodConfig_15="0"                    \
   g_smodAdminPassword_16=""              \
   g_smodConfig_16="0"                    \
   g_balance="-1"                         \
   g_competitive="0"                      \
   g_password=""                          \
   # SD=Soldier TP=Trooper CM=Commander ET=EliteTrooper ST=Sith JD=Jedi BH=BountyHunter
   # HO=Hero SB=SBD WK=Wookiee DD=Droideka CT=CloneTrooper MD=Mandalorian AT=ARCTrooper
   # SD TP CM ET ST JD BH HO SB WK DD CT MD AT
   g_classlimits="50-50-50-50-02-02-50-50-50-50-50-50-50-50"                    \
   g_classlimitsCTF="50-50-50-50-02-02-50-50-50-50-50-50-50-50"                 \
   SERVER_PORT="29070"