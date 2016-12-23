#!/bin/bash

# Other repos
add-apt-repository ppa:linrunner/tlp 
add-apt-repository ppa:no1wantdthisname/ppa # Infinality
add-apt-repository ppa:rjvbertin/infinaltimate
add-apt-repository -y "deb http://dl.google.com/linux/chrome/deb/ stable main"

apt-get -y --force-yes update

apt-get -y install          \
    build-essential         \
    curl                    \
    git                     \
    gitk                    \
    vim-gtk                 \
    python-dev              \
    python-pip              \
    google-chrome-stable    \
    tlp                     \
    tlp-rdw                 \
    tp-smapi-dkms           \
    acpi-call-dkms          \
    tmux                    \
    fontconfig-infinality

apt-get -y --force-yes upgrade

# misc
/etc/fonts/infinality/infctl.sh osx2
tlp start

# dot files
shopt -s dotglob
cp -r .* ~/
rm -rf ~/.git

# install vim plugins
vim +"call dein#install()" +qall!

# other files
cp -r bin ~/

# powerline fonts
cd powerline-fonts && install.sh

echo "Finished, reboot to take effect"
