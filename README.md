# Archlinux pkgbuilder

Build packages inside clean docker environment with trizen.
This may be used as a base for automatic building of multiple packages
from AUR with AUR dependencies. I use this to feed a custom repository

## Usage

    docker run \
      -ti
      --rm \
      -v ${pwd}:/build \
      trizen:latest -S mypackage

## Example script

I use a variation of this script for an automatic aur package builder:

```
#!/bin/bash
. /etc/sysconfig/aurpkgbuilder
IMAGE='trizen:latest'
logdir=/data/archlinux-build/published/logs
mkdir -p "$logdir"
for pkg in ${AUR_PACKAGES[@]};do
  opt_depends="$( awk -F, '{ print $2 }' <<<"$pkg" | tr ',' ' ' )"
  p=$(echo $pkg | cut -f1 -d,)
  echo Building $p
  docker run --name "build_$pkg" -t --rm \
    -v /data/archlinux-build/:/build "$IMAGE" \
    -Sy --noedit --noinstall --noconfirm --movepkg \
    --movepkg-dir=/build/published --devel $opt_depends $pkg &>"$logdir/$pkg.log"
done
docker run \
  -t \
  --rm \
  -v /data/archlinux-build/:/build base/archlinux:latest \
  bash -c 'mkdir -p /build/published; cd /build/published/; repo-add -n aur.db.tar.xz *pkg*xz'
```

`/etc/sysconfig/aurpkgbuilder` declares the AUR_PACKAGES array:

```
declare -a AUR_PACKAGES=(
trizen
libpurple-carbons-git
profanity-git
libmesode-git
profanity-omemo-plugin-git
bitlbee-libpurple-git
...
)
```

### Optional options

- Add `-e MIRROR_URL='<mirror url>'` with your individual mirror, which fits best.
- Passing options to trizen can be done easily by appending options to the `docker run` call at the end. E.g: `docker run [......] trizen:latest -S foobar-pkg-git`

## TODO

- Support for additional pacman-repositories
