#!/bin/sh

## What is this document
# This script should bootstrap the system to install some packages and tools that I usually use
# Ideally I should put all apt-get installs in one line but I want to keep this a bit modular

# ------------------------------------git------------------------------------
sudo apt-get install git

# ------------------------------------code------------------------------------
sudo apt-get install build-essential 
sudo apt-get install cmake cmake-curses-gui
echo "add clang maybe later..."


# ------------------------------------zsh------------------------------------
# docs at https://github.com/sorin-ionescu/prezto
sudo apt-get install zsh
zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
# setting zsh as default
chsh -s /bin/zsh
# downloading the prompt
wget https://raw.githubusercontent.com/Pouya-moh/config-files/master/prompt_josh_setup -P $HOME/.zprezto/modules/prompt/functions
# zshrc stuff
mv $HOME/.zprezto/runcoms/zpreztorc $HOME/.zprezto/runcoms/zpreztorc_org
wget https://raw.githubusercontent.com/Pouya-moh/config-files/master/zpreztorc -P $HOME/.zprezto/runcoms/
# aliases
wget https://raw.githubusercontent.com/Pouya-moh/config-files/master/zsh_aliases -O $HOME/.zsh_aliases
# change "lc" alias
echo "comment the line in $HOME/.zprezto/modules/utility/init.zsh to remove lc alias"



# ------------------------------------latex------------------------------------
echo "downloading the network installer..."
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -P ~/Downloads
tar -xvzf ~/Downloads/install-tl-unx.tar.gz -C ~/Downloads
# getting the tar folder name
Dir_name=`tar -tzf ~/Downloads/install-tl-unx.tar.gz | head -1 | cut -f1 -d"/"`
cd ~/Downloads/$Dir_name
sudo ./install-tl



# ------------------------------------text stuff------------------------------------
# pandoc (maybe markdown?)
sudo apt-get install pandoc
# pdf-tools
sudo apt-get install libpng-dev zlib1g-dev
sudo apt-get install libpoppler-glib-dev
sudo apt-get install libpoppler-private-dev


# ------------------------------------nerd fonts------------------------------------
mkdir ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Italic/complete/DejaVu%20Sans%20Mono%20Oblique%20Nerd%20Font%20Complete.ttf -P ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Bold/complete/DejaVu%20Sans%20Mono%20Bold%20Nerd%20Font%20Complete.ttf -P ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Bold-Italic/complete/DejaVu%20Sans%20Mono%20Bold%20Oblique%20Nerd%20Font%20Complete.ttf -P ~/.fonts


# ------------------------------------emacs------------------------------------
# emacs 26 untill apt-get officially supports it
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt install emacs26
# personal config files and more
echo "DANGER AHEAD. Deleting original emacs home..."
rm -rfi $HOME/.emacs.d
# getting the repo
git clone https://github.com/Pouya-moh/.emacs.d.git $HOME/.emacs.d
touch $HOME/.emacs.d/custom.el
# getting some pcakges
mkdir -p $HOME/.emacs.d/etc && $HOME/.emacs.d/etc
git clone https://github.com/targzeta/move-lines.git
git clone https://github.com/Pouya-moh/wc-mode.git
git clone https://github.com/Pouya-moh/yamt-theme.git

