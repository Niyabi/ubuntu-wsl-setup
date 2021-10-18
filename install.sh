#!/bin/bash

apt update && apt upgrade -y

# Install exa from source
apt install libgit2-dev rustc git
apt-mark auto rustc
git clone https://github.com/ogham/exa --depth=1
cd exa
cargo build --release && cargo test
install target/release/exa /usr/local/bin/exa
cd ..
rm -rf exa
apt purge --autoremove

# Install fish shell
apt-add-repository ppa:fish-shell/release-3
apt update
sudo apt install fish
chsh -s /usr/bin/fish

# Install fisher, fish plugin manager
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Install fish Node Version Manager
fisher install jorgebucaran/nvm.fish

# Install peco for fish
fisher takashabe/fish-peco

# Install z for fish
fisher install jethrokuan/z

# Install Silversearcher
apt install -y silversearcher-ag

# Install Tide theme for fish
fisher install IlanCosman/tide@v5

# Write fish settings to config.fish
cd ~/.config/fish/
cat <<EOF > config.fish
if status is-interactive
    # Commands to run in interactive sessions can go here

  set fish_greeting ""
  alias inst "sudo apt install -y"
  alias dc "docker-compose"
  alias dcb "dc exec fpm bash"
  alias ci "code-insiders ."
  alias vsc "code ."

  if type -q exa
    alias ll "exa -l -g --icons"
    alias lla "ll -a"
  end

end
EOF
