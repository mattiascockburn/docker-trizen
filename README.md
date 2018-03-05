# Archlinux pkgbuilder

Build packages inside clean docker environment with pacaur.
This may be used as a base for automatic building of multiple packages
from AUR with AUR dependencies. I use this to feed a custom repository

## Usage

    docker run \
      --rm \
      -v $(pwd)/package:/pkg \
      -e DEP_PKGS="<space-separated list of dependencies>" \
      archimg/archlinux-pkgbuilder

### Optional options

- Add `-e MIRROR_URL='<mirror url>'` with your individual mirror, which fits best.
- Add `-e DEP_PKGS='<space-separated list of dependencies>'`
- Passing options do makepkg can be done easily by appending options to the `docker run` call at the end. E.g: `docker run [......] archimg/archlinux-pkgbuilder --geninteg`

## TODO

- Support for additional pacman-repositories
- Automatic installation of dependencies without the need for `DEP_PKGS`
- support for individual `makepkg.conf`
