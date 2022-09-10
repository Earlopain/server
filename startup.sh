#!/usr/bin/env sh

sudo cryptsetup luksOpen /dev/disk/by-uuid/026e8027-ce43-4520-8eda-7b193d26c8cd ssd-crypt
sudo mount /dev/mapper/ssd-crypt /mnt/ssd

docker-compose -f $SERVER_PROJECT_DIR/code-server/docker-compose.yml up -d
docker-compose -f $SERVER_PROJECT_DIR/jellyfin/docker-compose.yml up -d
docker-compose -f $SERVER_PROJECT_DIR/samba/docker-compose.yml up -d
