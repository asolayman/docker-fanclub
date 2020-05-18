#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt update
apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common git bash dialog
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add -
apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
apt update
apt install -y docker-ce python3-pip virtualbox-5.2
pip3 install docker-compose
curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | bash
curl -fsSL "https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-$(uname -s)-$(uname -m)" -o /tmp/docker-machine 
install /tmp/docker-machine /usr/local/bin/docker-machine && rm /tmp/docker-machine
systemctl stop ntp && /lib/systemd/systemd-sysv-install disable ntp