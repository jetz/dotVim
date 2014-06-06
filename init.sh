#!/usr/bin/env bash

git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle

echo ">>>>> Install Plugins..."
vim +PluginInstall +qall

echo ">>>>> Install Chinese doc..."
curpath=$(pwd)
cd ~/.vim/misc
tar -xvf vimcdoc-1.9.0.tar.gz
cd vimcdoc-1.9.0
sudo ./vimcdoc.sh -i
rm -rf ../vimcdoc-1.9.0
cd $curpath

echo ">>>>> Config YouCompleteMe..."
sudo apt-get install build-essential cmake
sudo apt-get install python-dev

curpath=$(pwd)
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
cd $curpath
