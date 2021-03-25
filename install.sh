#!/bin/bash
# Install utilities from Homebrew
brew install wget
# Install Ansible and other tools
sudo -H pip3 install ansible molecule wget
# Download mitogen
sudo wget -nc -c "https://github.com/mitogen-hq/mitogen/archive/v0.3.0-rc.0.zip" -O /opt/v0.3.0-rc.0.zip
sudo mkdir -p /opt/mitogen
sudo bsdtar --strip-components=1 -xvf /opt/v0.3.0-rc.0.zip -C /opt/mitogen
# Generate a pubkey
echo TODO - keypair
# Add our pubkey
ssh-add wings@localhost
# Scan the local key
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
# Grab the Ansible collections and roles
ansible-galaxy install -r roles/requirements.yml
