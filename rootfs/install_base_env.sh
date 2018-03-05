#!/bin/bash

echo "Server = ${MIRROR_URL}" > /etc/pacman.d/mirrorlist

sudo pacman -Syu --noconfirm \
       bzr \
       git \
       mercurial \
       namcap \
       svn

useradd -Um -d /build build
