#!/usr/bin/env bash

function cecho() {
    echo -e "\e[32m"$1"\e[0m"
}

cecho ">>>>> Install Plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cecho ">>>>> Install Plugins..."
vim +PlugInstall +qall

cecho ">>>>> Install Chinese doc..."
cd ~/.vim/vimcdoc && ./vimcdoc.sh -i
