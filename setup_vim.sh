#!/bin/bash

# Get dein
cd ~ && \
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh ./installer.sh ~/.vim/package_manager

# install vim plugins via dein
vim +"call dein#install()" +qall!

rm installer.sh
