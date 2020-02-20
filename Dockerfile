FROM ubuntu:bionic

RUN apt-get update \
    && apt-get install -y \
    curl \
    git \
    gnupg \
    maven \
    openjdk-8-jdk \
    unzip \
    vim \
    wget \
    #
    # Install ibmcloud cli, helm, kubectl
    #
    && curl -sL https://ibm.biz/idt-installer | /bin/bash \
    #
    # Install node and npm
    #
    && curl -sSL https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-x64.tar.xz | tar -C /usr --strip-components=1 --wildcards -xJf- \*/bin \*/share \*/include \*/lib \
    #
    # Install vault cli
    #
    && wget https://releases.hashicorp.com/vault/1.3.2/vault_1.3.2_linux_amd64.zip \
    && unzip vault_1.3.2_linux_amd64.zip \
    && chmod 777 vault \
    && mv vault /usr/local/bin \
    #
    # Clean up to reduce image size
    #
    && rm -rf vault_1.3.2_linux_amd64.zip \
    && apt-get -y autoremove \
    && apt-get -y autoclean

