FROM archimg/base-devel
LABEL maintainer "Mattias Giese <mattiasgiese@posteo.net>"

ARG MIRROR_URL="https://mirrors.kernel.org/archlinux/\$repo/os/\$arch"


ADD rootfs /


RUN ["/bin/bash", "/install_base_env.sh"]
USER build
RUN ["/bin/bash", "/prepare_image.sh"]
ENTRYPOINT ["/srv/docker-buildpkg"]
