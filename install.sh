#!/bin/bash
# Install Homebrew, but only if needed
brew --help || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Activate Homebrew
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile default --default-toolchain stable -y
# Activate Rust
echo 'export PATH="$HOME/.cargo/bin:$PATH"' | sudo tee -a /var/root/.bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' | sudo tee -a /var/root/.zshrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' | tee -a ~/.bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' | tee -a ~/.zshrc
export PATH="$HOME/.cargo/bin:$PATH"
# Install utilities from Homebrew
brew install wget dockutil
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
# Remove Dock icons
#dockutil --remove
# List Launchpad apps (not dock!)
#sqlite3 "/private/var/folders/yr/r3xnqxgn6ng34m_h1pz668xw0000gn/0/com.apple.dock.launchpad/db/db" "SELECT * FROM apps;"
# Delete the Dock icons that we don't like
dockutil --remove Launchpad
dockutil --remove Messages
dockutil --remove Maps
dockutil --remove Photos
dockutil --remove FaceTime
dockutil --remove Calendar
dockutil --remove Contacts
dockutil --remove Reminders
dockutil --remove Notes
dockutil --remove TV
dockutil --remove Music
dockutil --remove Podcasts
dockutil --remove News
dockutil --remove Keynote
dockutil --remove Numbers
dockutil --remove Pages
dockutil --remove "App Store"
dockutil --remove "System Preferences"
# Add the icons we do like
dockutil --add Terminal
