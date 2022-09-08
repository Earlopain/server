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

# crontab
yay cronie
sudo systemctl enable cronie
sudo systemctl start cronie
sudo sh -c 'echo "0 0 * * * earlopain docker-compose -f /home/earlopain/server/nginx.compose.yml run --rm certbot && docker exec -it server_nginx nginx -s reload" >> /etc/crontab'

# ssl certs initial setup
echo -n "ACME email: "
read acme_email
docker-compose -f /home/earlopain/server/nginx.compose.yml run --rm certbot certonly --non-interactive --dns-cloudflare --agree-tos --dns-cloudflare-credentials /etc/letsencrypt/secrets.ini --email $acme_email -d earlopain.dev -d *.earlopain.dev --server https://acme-v02.api.letsencrypt.org/directory
