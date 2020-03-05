FROM ubuntu:bionic

RUN apt-get update \
    && apt-get install -y \
    curl \
    git \
    gnupg \
    jq \
    maven \
    openjdk-8-jdk \
    python3 \
    python3-pip \
    unzip \
    vim \
    wget \
    #
    # Install ibmcloud cli, helm, kubectl
    #
    && curl -sL https://ibm.biz/idt-installer | /bin/bash \
    && bx plugin install doi \
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
    && rm -rf vault_1.3.2_linux_amd64.zip \
    #
    # Install helm 3
    #
    && wget https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz \
    && mkdir -p /opt/helm3 \
    && tar -zxvf helm-v3.0.2-linux-amd64.tar.gz -C /opt/helm3 \
    && chmod -R 777 /opt/helm3 \
    && mv /opt/helm3/linux-amd64/helm /opt/helm3/linux-amd64/helm3 \
    && ln -s /opt/helm3/linux-amd64/helm3 /usr/local/bin \
    && rm -rf helm-v3.0.2-linux-amd64.tar.gz \
    #
    # Maven installs Java 11 but we want java 8
    #
    && apt-get purge -y openjdk-11-jre-headless \
    #
    # Install python library for yaml
    #
    && pip3 install pyyaml \
    #
    # Install yq for parsing yaml
    #
    && pip3 install yq \
    #
    # Clean up to reduce image size
    #
    && apt-get -y autoremove \
    && apt-get -y autoclean

# Pre-populate the maven cache to speed up the
# java builds.
ADD m2-repository.tgz /root/


