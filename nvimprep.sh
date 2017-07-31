#!/bin/sh

# prepare neovim config to be used
# --------------------------------------------

# create directory
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/nvim/exec
mkdir -p $HOME/.config/nvim/support
mkdir -p $HOME/bin

# copy files config
echo "--- copy cfg + generator + support files ---"
cp ./init.vim $HOME/.config/nvim/init.vim
cp -R ./exec/* $HOME/.config/nvim/exec
cp -R ./support/* $HOME/.config/nvim/support

# now generate soft link
echo "--- generate soft link to scripts ---"
ln -s $HOME/.config/nvim/exec/* $HOME/bin

# prepare vim plug - later all the plugin will be install using this
echo "--- copy vim plug ---"
sudo curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# change ownership
echo "--- change ownership ---"
sudo chown -R $(whoami):$(whoami) $HOME/.local/share/nvim
sudo chown -R $(whoami):$(whoami) $HOME/.config/nvim
sudo chown -R $(whoami):$(whoami) $HOME/bin

# from here run PlugInstall in nvim

