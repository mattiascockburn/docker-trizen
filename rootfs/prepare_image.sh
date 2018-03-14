#!/bin/bash
cd /build

mkdir tmp;cd tmp

sudo pacman -Sy


gpg --recv-keys 0x1EB2638FF56C0C53 # cower

for pkg in cower pacaur; do
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
