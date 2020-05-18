#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root" 1>&2
        exit 1
fi

function showDistro() {
        dialog --title "Docker Fanclub - Launcher" \
        --clear \
        --no-collapse \
        --msgbox "Docker-Fanclub will install on: \n $(cat /etc/issue | head)" 0 0
        clear
}

if grep -q 'Debian' /etc/issue; then
        apt install dialog -y -q
        showDistro
        curl -fsLko- "https://forge.univ-lyon1.fr/marwan/docker-fanclub-public-repo/raw/master/stage1-debian.sh" | bash -s
elif grep -q 'Fedora' /etc/issue; then
        dnf install dialog -y -q
        showDistro
        curl -fsLko- "https://forge.univ-lyon1.fr/marwan/docker-fanclub-public-repo/raw/master/stage1-fedora.sh" | bash -s
elif grep -q 'Ubuntu' /etc/issue; then
        pacman -Syy -q dialog
        showDistro
        curl -fsLko- "https://forge.univ-lyon1.fr/marwan/docker-fanclub-public-repo/raw/master/stage1-ubuntu.sh" | bash -s
else
        echo "Your distribution is not offically supported."
        exit 1
fi

curl -fsLko- "https://forge.univ-lyon1.fr/marwan/docker-fanclub-public-repo/raw/master/stage2.sh" | bash -s