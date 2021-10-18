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

