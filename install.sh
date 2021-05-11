#!/bin/bash
# Upgrade pip3
sudo pip3 install --upgrade pip
# Enable ssh
sudo systemsetup -setremotelogin on
# Install Homebrew, but only if needed
brew --help || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Activate Homebrew
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm' >> ~/.zshrc
echo '[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zhsrc
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile default --default-toolchain nightly -y
# Activate Rust
echo 'export PATH="$HOME/.cargo/bin:$PATH"' | sudo tee -a /var/root/.zshrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' | tee -a ~/.zshrc
export PATH="$HOME/.cargo/bin:$PATH"
# Install core utilities from Homebrew
brew install wget dockutil
# Install Ansible and other tools
sudo -H pip3 install ansible molecule wget
# Generate a pubkey
# Create an SSH key if one does not exist
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N '' -t rsa -C ''
# Add our pubkey so we can SSH to our own machine
ssh-copy-id wings@localhost
# Scan the local key to trust it
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
# Grab the Ansible collections and roles
ansible-galaxy install -r roles/requirements.yml
# Install some final utilities via cask
brew install --cask cyberduck microsoft-edge dbeaver-community \
slack iterm2 signal \
element discord steam \
alfred quassel telegram \
skype vlc
# Install normal utils via normal packages
brew install nmap docker-compose nano \
mas shivammathur/php/php@8.0 nvm
# Install via tap
brew tap shivammathur/php
# Install Bitwarden
mas install 1352778147
# Add the icons we do like
dockutil --add iTerm
# If necessary, prepare to delete launchpad icons we do not want
#sqlite3 "/private/var/folders/yr/r3xnqxgn6ng34m_h1pz668xw0000gn/0/com.apple.dock.launchpad/db/db" "SELECT * FROM apps;"# Delete the Dock icons that we don't like
# Remove all of the Dock icons we don't want, thanks Apple.
for icon in Mail Messages Maps \
Photos FaceTime Calendar \
Contacts Reminders Notes TV \
Music Podcasts News Keynote \
Numbers Pages "App Store" \
"System Preferences"; do
echo dockutil --remove $icon
done
