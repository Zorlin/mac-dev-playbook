#!/bin/bash
# Install utilities from Homebrew
brew install wget
# Install Ansible and other tools
sudo -H pip3 install ansible molecule wget
# Download mitogen
sudo wget -nc -c "https://github.com/mitogen-hq/mitogen/archive/v0.3.0-rc.0.zip" -O /opt/v0.3.0-rc.0.zip
mkdir -p /opt/mitogen
sudo bsdtar --strip-components=1 -xvf /opt/v0.3.0-rc.0.zip -C /opt/mitogen
# Scan the local key
sudo ssh-keyscan -H localhost >> ~/.ssh/known_hosts
# Grab the Ansible collections and roles
ansible-galaxy install -r roles/requirements.yml
