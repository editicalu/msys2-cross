# vi:et:ts=4 sw=4 sts=4:ft=dockerfile
FROM debian:buster-slim

# Get our base dependencies
RUN set -ex && \
    apt-get update && \
    apt-get install -y wget xz-utils gnupg2 bsdtar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

COPY sync/ /var/lib/pacman/sync/
COPY etc/ /etc/
COPY bin/ /usr/local/bin/
COPY keyrings/ /usr/share/pacman/keyrings/

# Install pacman-static
RUN set -ex && \
    wget -O /usr/local/bin/pacman https://pkgbuild.com/~eschwartz/repo/x86_64-extracted/pacman-static && \
    chmod +x /usr/local/bin/pacman

# setup pacman-key
RUN set -ex && \
    pacman-key --init && \
    pacman-key --populate msys2

# setup our cross root
RUN set -ex && \
    mkdir -p /windows/etc /windows/var/lib/pacman /windows/var/log /windows/tmp && \
    pacman-cross -Syu && \
    pacman-cross -Syy --noconfirm msys/pacman

