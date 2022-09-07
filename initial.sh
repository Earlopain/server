#!/usr/bin/env sh

echo "This isn't meant to be run."
exit

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

# Git config
git config --global user.signingkey 2B41C3E14D2536AD
git config --global user.name Earlopain
echo -n "Git email: "
read git_email
git config --global user.email $git_email
git config --global init.defaultBranch master
ssh-keygen -t ed25519 -C $git_email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# Copy this into Github
cat ~/.ssh/id_ed25519.pub
