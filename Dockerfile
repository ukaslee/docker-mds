FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN echo "dash dash/sh boolean false" | debconf-set-selections && dpkg-reconfigure dash

RUN apt-get update && \
    apt-get install -y software-properties-common 

RUN apt-get install -y python2.7 python-subversion python-svn python-numpy python-apt python-pip && \
    pip install --upgrade pip

RUN apt-get install -y vim

RUN add-apt-repository ppa:webupd8team/java -y && apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

RUN echo tzdata tzdata/Zones/Etc select UTC | /usr/bin/debconf-set-selections && \
    apt-get install -y tzdata

RUN apt-get install -y libxext-dev libxrender-dev libxtst-dev dbus-x11

RUN apt-get install -y gcc-multilib mtd-utils subversion patch patchutils \
    bison libc6-dev libxml-dom-perl zlib1g zlib1g-dev libcurl4-openssl-dev \
    libncurses5 doxygen dmsetup libpcre3-dev netpbm ssh-askpass cppcheck bc

RUN apt-get install -y php7.0-cli 

RUN apt-get install -y luajit 

RUN apt-get install -y nodejs && \
    ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get install -y npm && \
    npm i -gq grunt-cli bower coveralls

RUN apt-get install -y libgtk-3-0 libcanberra-gtk-module

#RUN mkdir -p /home/mds && \
#    echo "mds:x:1000:1000:Mds,,,:/home/mds:/bin/bash" >> /etc/passwd && \
#    echo "mds:x:1000:" >> /etc/group && \
#    echo "mds ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
#    chmod 0440 /etc/sudoers.d/developer && \
#    chown mds:mds -R /home/mds

RUN mkdir -p /tmp/mds_install && \
    mkdir -p /home/mds/projects

COPY MDS_12_0_0/release/Linux /tmp/mds_install/

RUN /tmp/mds_install/mds-12.0.0-deb-x86_64.run

RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#USER mds
ENV HOME /home/mds


