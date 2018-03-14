#!/bin/bash

echo "Server = ${MIRROR_URL}" > /etc/pacman.d/mirrorlist
cat <<EOF >>/etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
pacman -Syu --noprogressbar --noconfirm \
       bzr \
       git \
       mercurial \
       namcap \
       svn \
       rust

sudo rm -f \
  /var/cache/pacman/pkg/* \
  /var/lib/pacman/sync/* \
  /tmpbuild \
  /etc/pacman.d/mirrorlist.pacnew

useradd -Um -d /build build
