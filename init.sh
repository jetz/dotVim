#!/usr/bin/env bash

oldpath=$(pwd)

if [ ! -d bundle ]; then
    cd ~/.vim
    mkdir -p bundle
fi

git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle

echo ">>>>> Install Plugins..."
vim +PluginInstall +qall

echo ">>>>> Install Chinese doc..."
cd ~/.vim/misc
tar -xvf vimcdoc-1.9.0.tar.gz
cd vimcdoc-1.9.0
sudo ./vimcdoc.sh -i
rm -rf ../vimcdoc-1.9.0

echo ">>>>> Config Autoformat..."
# for xhtml&xml
sudo apt-get install tidy
# for js&css&html(js-beautify)
sudo apt-get install nodejs
# for c&c++&c#
sudo apt-get install astyle 

echo ">>>>> Config YouCompleteMe..."
sudo apt-get install build-essential cmake
sudo apt-get install python-dev

curpath=$(pwd)
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
cd $oldpath
