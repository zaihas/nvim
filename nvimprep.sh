#!/bin/sh

# prepare neovim config to be used
# --------------------------------------------

# copy vim config
if [ ! -f "$HOME/.config/nvim/init.vim" ] || [ "$1" == "-f" ] ; then
    echo "copy my cfg file"
    cp ./init.vim $HOME/.config/nvim/init.vim
fi

#copy clang + cscope file generator
mkdir -p $HOME/bin
cp -R ./exec/* $HOME/bin

# prepare vim plug - later all the plugin will be install using this
sudo curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# change ownership
sudo chown -R $(whoami):$(whoami) $HOME/.local/share/nvim
sudo chown -R $(whoami):$(whoami) $HOME/bin

# from here run PlugInstall in nvim

