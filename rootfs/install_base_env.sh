#!/bin/bash

echo "Server = ${MIRROR_URL}" > /etc/pacman.d/mirrorlist
cat <<EOF >>/etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
pacman -Syu --noconfirm \
       bzr \
       git \
       mercurial \
       namcap \
       svn

useradd -Um -d /build build
