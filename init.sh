#!/usr/bin/env bash

DISTRO="Ubuntu"
INSTALL="sudo apt install -y"

if [[ -f /etc/redhat-release ]]; then
    DISTRO="Redhat"
    INSTALL="sudo yum install -y"
fi


echo ">>>>> Install YouCompleteMe Deps..."
if [[ $DISTRO == "Ubuntu" ]]; then
    $INSTALL build-essential cmake python-dev
fi

echo ">>>>> Install Autoformat Deps..."
$INSTALL nodejs golang clang

sudo pip install autopep8
sudo npm install -g js-beautify


curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ">>>>> Install Plugins..."
vim +PlugInstall +qall

echo ">>>>> Install Chinese doc..."
cd ~/.vim && tar -xzf vimcdoc-1.9.0.tar.gz
cd vimcdoc-1.9.0 && ./vimcdoc.sh -i
cd .. && rm -rf vimcdoc-1.9.0
