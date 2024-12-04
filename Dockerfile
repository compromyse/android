FROM ubuntu:jammy

ARG userid=1000
ARG groupid=100
ARG username=compromyse
ARG http_proxy

RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get upgrade -y

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y apt-utils sudo

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev lib32ncurses5-dev libncurses5 libncurses5-dev

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo
RUN chmod a+x /usr/local/bin/repo

RUN useradd -m -s /bin/bash -u $userid -g $groupid $username
RUN echo "compromyse ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/$username
USER $username

ENV USER=$username

RUN git config --global user.email "raghus2247@gmail.com"
RUN git config --global user.name "Raghuram Subramani"
RUN git lfs install
