FROM centos:7
MAINTAINER Tobias Germer

ENV TS3_HOME=/ts3 \
    TS3_USER=ts3 \
    TS3_VERSION=3.0.11.3 \
    TS3_PORT_DEFAULT=9987 \
    TS3_PORT_FILETRANSFER=30033 \
    TS3_PORT_QUERY=10011 \
    TS3_PORT_TSDNS=41144

# Update via yum to latest versions
RUN yum update -y

# Add user to run ts3 and create directories for files
RUN useradd -m $TS3_USER && \
    mkdir $TS3_HOME

# Download TS3, extract and delete tarball
RUN wget -P $TS3_HOME \
    http://teamspeak.gameserver.gamed.de/ts3/releases/$TS3_VERSION/teamspeak3-server_linux-amd64-$TS3_VERSION.tar.gz && \
    tar -xvzf $TS3_HOME/teamspeak3-server_linux-amd64-$TS3_VERSION.tar.gz -C $TS3_HOME/ && \
    rm $TS3_HOME/teamspeak3-server_linux-amd64-$TS3_VERSION.tar.gz

EXPOSE  $TS3_PORT_DEFAULT \
        $TS3_PORT_FILETRANSFER \
        $TS3_PORT_QUERY \
        $TS3_PORT_TSDNS

VOLUME $TS3_HOME

CMD $TS3_HOME/ts3server_minimal_runscript.sh >> $TS3_HOME/runscript.log
