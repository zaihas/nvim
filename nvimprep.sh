#!/bin/sh

# prepare neovim config to be used
# --------------------------------------------

# copy vim config
if [ ! -f "$HOME/.config/nvim/init.vim" ] || [ "$1" == "-f" ] ; then
    echo "copy my cfg file"
    cp ./init.vim $HOME/.config/nvim/init.vim
fi

# prepare vim plug - later all the plugin will be install using this
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

