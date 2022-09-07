#!/usr/bin/env sh

# Docker
yay docker
yay docker-compose
sudo usermod -aG docker $USER

# Network
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd
sudo reboot now

# Git signing keys
gpg --homedir /path/to/old/.gnupg --output ~/private.key --armor --export-secret-key 2B41C3E14D2536AD
gpg --homedir /path/to/old/.gnupg --output ~/public.key --armor --export 2B41C3E14D2536AD
gpg --import ~/public.key
gpg --import ~/private.key
gpg --edit-key 2B41C3E14D2536AD
#> trust
#> 5
#> save
