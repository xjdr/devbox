FROM centos:centos7
MAINTAINER Jeff Rose <jeff.rose12@gmail.com>

RUN yum -y update
RUN yum -y upgrade
RUN yum -y install epel-release
RUN yum -y install git tmux vim-enhanced

RUN yum install -y \
    openssl-devel \
    openssl-libs \
    make \
    zip \
    autoconf \
    libtool \
    gcc-c++ \
    boost-devel \
    boost \
    libevent-devel \
    libevent \
    flex \
    bison \
    scons \
    krb5-devel \
    snappy-devel \
    libgsasl-devel \
    numactl-devel \
    numactl-libs \
    gflags-devel \
    gflags \
    glog-devel \
    glog \
    jemalloc-devel \
    jemalloc

RUN cd && git clone http://github.com/xjdr/dotfiles && ./bootstrap.sh
RUN cd && git clone http://github.com/xjdr/vim ${HOME}/.vim

