#!/bin/bash

## Based on nvie/vimrc

set -xeu

INSTALL_TO=~/projects

warn() { echo "$*" >&2; }
die() { warn "$*" && exit 1; }

install_vimrc() {
  for E in "$INSTALL_TO/vimrc" "~/.vim" "~/.vimrc"; do
    [ -e "$E" ] && die "$E already exists";
  done
  
  cd "$INSTALL_TO"
  git clone https://github.com/fbreitwieser/vimrc.git
  cd vimrc
  
  # Download vim plugin bundles
  git submodule init
  git submodule update
  
  # Symlink ~/.vim and ~/.vimrc
  cd ~
  ln -s "$INSTALL_TO/vimrc/vimrc" .vimrc
  ln -s "$INSTALL_TO/vimrc/vim" .vim
  touch ~/.vim/user.vim
  
  echo "Installed and configured ~/.vim, have fun."
}

install_vimrc
