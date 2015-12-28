FROM debian:jessie
MAINTAINER xjdr/devbox
 
# ===== install/setup prerequisites =====
RUN apt-get update
 
# Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive

# ===== Install sudo  =====
RUN apt-get -y install sudo 
 
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
RUN apt-get -y install bash-completion git-core build-essential vim-nox tmux
    
ENV HOME /home/xjdr
ENV USER xjdr
ENV TERM xterm-256color
ENV LANG C
USER xjdr

RUN cd ${HOME} && git clone https://github.com/xjdr/dotfiles && cd dotfiles && ./bootstrap.sh
RUN cd ${HOME} && git clone http://github.com/xjdr/vim ${HOME}/.vim




