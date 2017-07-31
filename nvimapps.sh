#!/bin/sh

# prepare software for neovim
# --------------------------------------------

# get basic apps 
sudo apt-get -y install software-properties-common python-pip python-setuptools cscope clang llvm ruby-dev

# set ppa to neo-vim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim

# python
sudo pip install --upgrade pip
sudo pip2 install neovim

# ruby
sudo gem install neovim

# clang/llvm - soft link to correct name
sudo ln -s /usr/lib/llvm-3.8/lib/libclang.so.1 /usr/lib/llvm-3.8/lib/libclang.so


