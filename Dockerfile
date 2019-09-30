# vi:et:ts=4 sw=4 sts=4:ft=dockerfile
FROM debian:bullseye-slim

# manually usrmerge because pacman is expecting it
RUN set -ex && \
    apt-get update && \
    apt-get install -y busybox-static && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    busybox mv /sbin/* /usr/sbin/ && \
    busybox rmdir sbin && \
    busybox ln -s /usr/sbin /sbin && \
    busybox mv /lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu && \
    busybox rmdir /lib/x86_64-linux-gnu && \
    busybox mv /lib/* /usr/lib/ && \
    busybox rmdir /lib && \
    busybox ln -s /usr/lib/ /lib && \
    busybox mkdir /usr/lib64 && \
    busybox mv /lib64/* /usr/lib64/ && \
    busybox rmdir /lib64 && \
    busybox ln -s /usr/lib64 /lib64 && \
    busybox mv /bin/* /usr/bin/ && \
    hash -r && \
    busybox rmdir /bin && \
    busybox ln -s /usr/bin/ /bin

# Get our base dependencies
RUN set -ex && \
    apt-get update && \
    apt-get install -y wget xz-utils gnupg2 libarchive-tools file && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

COPY sync/ /var/lib/pacman/sync/
COPY etc/ /etc/
COPY bin/ /usr/local/bin/
COPY share/ /usr/share/
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

