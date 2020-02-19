FROM ubuntu:bionic

RUN apt-get update \
    && apt-get -y upgrade\
    && apt-get install -y \
    curl \
    git \
    gnupg \
    maven \
    openjdk-8-jdk \
    vim \
    wget \
    && curl -sL https://ibm.biz/idt-installer | /bin/bash \
    && curl -sSL https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-x64.tar.xz | tar -C /usr --strip-components=1 --wildcards -xJf- \*/bin \*/share \*/include \*/lib \
    && apt-get -y autoremove \
    && apt-get -y autoclean
