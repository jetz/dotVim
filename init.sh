#!/usr/bin/env bash

echo ">>>>> Install YouCompleteMe Deps..."
sudo apt-get install build-essential cmake python-dev

echo ">>>>> Install Autoformat Deps..."
sudo apt-get install golang-go
sudo apt-get install clang-format
sudo apt-get install python-autopep8

sudo apt-get install nodejs
sudo npm install -g js-beautify
sudo npm install -g css-beautify
sudo npm install -g html-beautify

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ">>>>> Install Plugins..."
vim +PlugInstall +qall

echo ">>>>> Install Chinese doc..."
cd ~/.vim && tar -xzf vimcdoc-1.9.0.tar.gz
cd vimcdoc-1.9.0 && sudo ./vimcdoc.sh -i
cd .. && rm -rf vimcdoc-1.9.0
