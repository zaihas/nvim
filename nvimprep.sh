#!/bin/sh

# prepare neovim config to be used
# --------------------------------------------

# copy vim config
echo "--- copy my cfg file ---"
cp ./init.vim $HOME/.config/nvim/init.vim

#copy clang + cscope file generator
mkdir -p $HOME/bin
echo "--- copy clang + cscope generator ---"
cp -R ./exec/* $HOME/bin

# prepare vim plug - later all the plugin will be install using this
echo "--- copy plug.vim ---"
sudo curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# change ownership
echo "--- change ownership ---"
sudo chown -R $(whoami):$(whoami) $HOME/.local/share/nvim
sudo chown -R $(whoami):$(whoami) $HOME/bin

# from here run PlugInstall in nvim

