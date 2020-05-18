#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

mkdir -pv /srv/docker_fanclub
curl -so /srv/docker_fanclub/.env https://forge.univ-lyon1.fr/marwan/docker-fanclub-public-repo/raw/master/.env
curl -so /srv/docker_fanclub/docker-compose.yml https://forge.univ-lyon1.fr/marwan/docker-fanclub-public-repo/raw/master/docker-compose.yml

DOMAIN=$(dialog --title "Docker Fanclub - Setup" --clear --no-collapse --backtitle "Docker Fanclub Automtic Install" --inputbox "Enter your TLD (domain.com)" --output-fd 1 8 60)
EMAIL=$(dialog --title "Docker Fanclub - Setup" --clear --no-collapse --backtitle "Docker Fanclub Automtic Install" --inputbox "Enter ACME Mail for Let's Encrypt" --output-fd 1 8 60)
PASS=$(dialog --title "Docker Fanclub - Setup" --clear --no-collapse --backtitle "Docker Fanclub Automtic Install" --inputbox "Enter IPA Password" --output-fd 1 8 60)
sed -i "s/marwan.pro/$DOMAIN/g" /srv/docker_fanclub/.env
sed -i "s/marwan69120@live.fr/$EMAIL/g" /srv/docker_fanclub/.env
sed -i "s/testpass/$PASS/g" /srv/docker_fanclub/.env
cd /srv/docker_fanclub

if dialog --stdout --clear --no-collapse --title "Start the stack?" --backtitle "Docker Fanclub Automtic Install" --yesno "\n\nYes: Start Docker-Compose\nNo: Exit" 8 60; then
    clear
    docker-compose up
fi
clear
exit 0