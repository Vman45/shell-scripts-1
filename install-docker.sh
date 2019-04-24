#!/bin/bash
installed_docker_version=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;

if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
echo ">>     Install Docker CE"
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
fi
