FROM ubuntu
LABEL MAINTAINER="Fedello Kirfed <fedellokirfed@gmail.com>"

# Expose a range of possible Jedi Academy ports.
EXPOSE 29060-29062/udp 29070-29081/udp

# 32bit Arch
RUN dpkg --add-architecture i386

# Install dependencies.
RUN apt-get update 
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
RUN apt-get install -y curl:i386 
RUN apt-get install -y python-setuptools python2-dev 
RUN apt-get install -y wget unzip
RUN apt-get install -y dotnet-sdk-6.0

# Server Files
COPY server/* /opt/openjk/

# LIB FILES
COPY server/libcxa.so.1 /usr/lib/
RUN chmod a+r /usr/lib/libcxa.so.1

# Set the working directory to where the Jedi Academy data files will be
# mounted at, so that linuxjampded finds them.

WORKDIR /opt/openjk

# Start the server.
RUN chmod +x /opt/openjk/linuxjampded
RUN chmod +x /opt/openjk/start.sh

CMD ["/opt/openjk/start.sh"]