FROM centos:latest
MAINTAINER Jeff Rose <jeff.rose12@gmail.com>

RUN yum -y update
RUN yum -y upgrade
RUN yum -y install epel-release
RUN yum -y install git tmux vim-enhanced

RUN cd ${HOME} && git clone https://github.com/xjdr/dotfiles && cd dotfiles && ./bootstrap.sh
RUN cd ${HOME} && git clone http://github.com/xjdr/vim ${HOME}/.vim

RUN echo "net.core.somaxconn=65535" >> /etc/sysctl.conf
RUN echo "*               hard    nofile          65535" >> /etc/security/limits.conf
RUN echo "*               soft    nofile          65535" >> /etc/security/limits.conf
RUN export TERM=xterm-256color


