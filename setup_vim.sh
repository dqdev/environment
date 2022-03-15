#!/bin/bash

# Get dein
cd ~ && \
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins via dein
vim +"PlugInstall" +qall!

rm installer.sh
