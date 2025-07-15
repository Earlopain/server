#!/usr/bin/env sh

set -euxo pipefail

sudo cryptsetup luksOpen /dev/disk/by-uuid/026e8027-ce43-4520-8eda-7b193d26c8cd ssd-crypt
sudo mount /dev/mapper/ssd-crypt /mnt/ssd

BASEDIR=$(dirname "$0")
docker compose -f ${BASEDIR}/jellyfin/docker-compose.yml up -d
docker compose -f ${BASEDIR}/karakeep/docker-compose.yml up -d
