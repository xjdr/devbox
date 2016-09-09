## -*- docker-image-name: "xjdr/devbox" -*-
FROM debian:jessie
MAINTAINER Jeff Rose <jeff.rose12@gmail.com>
 
# ===== install/setup prerequisites =====
RUN apt-get update
 
# Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

# ===== Install sudo  =====
RUN apt-get -y install sudo locales

# ==== Set locales and Timezones and whatnot =====
RUN sudo echo "America/Chicago" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata
RUN sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN sudo echo 'LANG="en_US.UTF-8"'>/etc/default/locale
RUN sudo dpkg-reconfigure --frontend=noninteractive locales
RUN sudo update-locale LANG=en_US.UTF-8

# ===== create user/setup environment =====
# Replace 1000 with your user/group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/xjdr && \
    echo "xjdr:x:${uid}:${gid}:xjdr,,,:/home/xjdr:/bin/bash" >> /etc/passwd && \
    echo "xjdr:x:${uid}:" >> /etc/group && \
    echo "xjdr ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/xjdr && \
    chmod 0440 /etc/sudoers.d/xjdr && \
    chown ${uid}:${gid} -R /home/xjdr
 
# ===== Install additional packages =====
RUN apt-get -y install bash-completion git-core build-essential vim-nox tmux curl libncurses5-dev python-dev python-pip
    
ENV HOME /home/xjdr
ENV USER xjdr
ENV TERM xterm-256color
ENV LANG C
USER xjdr

# ===== Install dotfiles =====
RUN cd ${HOME} && git clone https://github.com/xjdr/dotfiles && cd dotfiles && ./bootstrap.sh
RUN cd ${HOME} && git clone http://github.com/xjdr/vim ${HOME}/.vim

# ===== Install Python and Java
RUN cd ${HOME} && git clone https://github.com/xjdr/bootstrap-dev && cd bootstrap-dev && ./bootstrap_java.sh

# ===== Configure shitz =====
RUN sudo pip install readline
RUN sudo pip install ansible






