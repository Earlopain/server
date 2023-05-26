#!/usr/bin/env sh

echo "This isn't meant to be run."
exit

cp ./files/.bashrc ~/.bashrc
source ~/.bashrc

sudo sh -c 'echo "SERVER_PROJECT_DIR=/home/earlopain/server" >> /etc/environment'
sudo sh -c 'echo "FOLDER_1=/home/earlopain" >> /etc/environment'
sudo sh -c 'echo "FOLDER_2=/mnt/ssd" >> /etc/environment'

# Docker
yay docker
yay docker-compose
sudo usermod -aG docker $USER

# Network
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
sudo cp ./files/resolv.conf /etc/
sudo cp ./files/enp1s0.conf /etc/systemd/network/
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd
sudo reboot now

# Firewall
sudo firewall-cmd --permanent --add-port=53/tcp
sudo firewall-cmd --permanent --add-port=53/udp
sudo firewall-cmd --permanent --add-port=67/tcp
sudo firewall-cmd --permanent --add-port=67/udp
sudo firewall-cmd --reload


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
git config --global commit.gpgSign true
ssh-keygen -t ed25519 -C $git_email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# Copy this into Github
cat ~/.ssh/id_ed25519.pub

# crontab
yay cronie
sudo systemctl enable cronie
sudo systemctl start cronie
sudo sh -c 'echo "0 0 * * * earlopain docker-compose -f \$SERVER_PROJECT_DIR/nginx/docker-compose.yml run --rm certbot && docker exec -it server_nginx nginx -s reload" >> /etc/crontab'

# ssl certs initial setup
echo -n "ACME email: "
read acme_email
docker-compose -f $SERVER_PROJECT_DIR/nginx/docker-compose.yml run --rm certbot certonly --non-interactive --dns-cloudflare --agree-tos --dns-cloudflare-credentials /etc/letsencrypt/secrets.ini --email $acme_email -d earlopain.dev -d *.earlopain.dev --server https://acme-v02.api.letsencrypt.org/directory

# SSH Agent
cp files/ssh-agent.service ~/.config/systemd/user/
echo 'AddKeysToAgent  yes' >> ~/.ssh/config
chmod 600 ~/.ssh/config
systemctl --user enable --now ssh-agent
