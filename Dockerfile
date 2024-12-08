FROM ubuntu:jammy

ARG userid=1000
ARG groupid=100
ARG username=compromyse
ARG config=vm
ARG http_proxy

RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get upgrade -y

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y apt-utils sudo ssh less

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev lib32ncurses5-dev libncurses5 libncurses5-dev lib32ncurses5-dev libncurses5 libncurses5-dev

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

RUN curl -L https://nixos.org/nix/install -o /tmp/install-nix.sh && \
    sh /tmp/install-nix.sh --no-daemon && \
    rm /tmp/install-nix.sh

ENV PATH="/home/$username/.nix-profile/bin:/home/$username/.nix-profile/sbin:$PATH"

RUN nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
  nix-channel --update

RUN nix-shell "<home-manager>" -A install

RUN git clone https://github.com/compromyse/dotfiles .config/home-manager/dotfiles
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm

RUN rm .config/home-manager/home.nix && \
  ln -s /home/$username/.config/home-manager/dotfiles/machines/vm/home.nix /home/$username/.config/home-manager/home.nix

RUN sudo apt-get purge -y git
RUN sudo apt-get autoremove -y

RUN home-manager build && \
  home-manager switch -b backup && \
  rm $HOME/result

RUN .tmux/plugins/tpm/bin/install_plugins
