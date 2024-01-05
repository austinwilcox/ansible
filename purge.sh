#!/usr/bin/env bash
rm ~/.bashrc
rm ~/.tmux.conf
rm -rf ~/.dotfiles
rm ~/.config/alacritty/alacritty.yml
rm ~/.config/nvim/init.lua
rm -rf ~/.config/nvim/lua
rm ~/.config/compton.conf
rm -rf ~/ZettelkastenV2
rm ~/.ssh/github_rsa.pub
rm ~/.ssh/github_rsa
rm -rf ~/.deno

sudo apt purge curl vim git ufw tmux fzf gimp xclip screenkey tldr ripgrep unzip -y
sudo apt autoremove -y
