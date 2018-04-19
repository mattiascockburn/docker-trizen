#!/bin/bash
cd /build

mkdir tmp;cd tmp

sudo pacman -Sy


# working around weird PATH/profile issue
. /etc/profile

for pkg in trizen; do
  git clone "https://aur.archlinux.org/${pkg}.git"
  pushd "$pkg"
  makepkg -s --noconfirm; makepkg; sudo pacman -U --noconfirm ${pkg}*xz
  popd
done

cd
rm -rf /build/tmp

sudo rm -f \
  /var/cache/pacman/pkg/* \
  /var/lib/pacman/sync/* \
  /tmpbuild \
  /etc/pacman.d/mirrorlist.pacnew
exit 0
