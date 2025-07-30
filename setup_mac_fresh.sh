#!/bin/sh

# Dotfile for installing all necessary application on a fresh mac
# What is it?
# --------------------------------------------
# Run this script on any new mac to set up development enviiironment
# Install software, clones github repo, links application specific
# dotfiles such as .zshrc etc. and configures system settings
# This is the only script that needs to be run on a fresh machine,
# this script cals all other necessary dotfiles
# NOTE: DO NOT RUN ON A MACHINE THAT IS ALREADY SETUP - can cause duplication issues


# Chaitanya Anand
# --------------------------------------------
# First created: January 29, 2025
# Last update: January 29, 2025
# Adapted from driesvints
# https://github.com/driesvints/dotfiles/blob/main/fresh.sh
# Found through https://dotfiles.github.io/inspiration/
# Tried to separate settings from installation (this script should be used only for changing setttings)

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

# font "12pt Meslo LG S DZ Regular" required for agnoster theme in oh-my-zsh to work properly
# This will be installed as a part of the powerline fonts
# iterm2 and terminal.app both still need to be configured to select this font (through UI for now)
git clone https://github.com/powerline/fonts
cd fonts
./install.sh 
rm -rf fonts

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Set default MySQL root password and auth type
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Create a projects directories
mkdir $HOME/Code
mkdir $HOME/Code/learning
# mkdir $HOME/Herd

# Create Code subdirectories
# mkdir $HOME/Code/blade-ui-kit
# mkdir $HOME/Code/laravel

# Clone Github repositories
$HOME/Documents/.dotfiles/clone.sh

# Symlink the Mackup config file to the home directory
# ln -s ./.mackup.cfg $HOME/.mackup.cfg

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brew bundle for using brewfiles (Having to run this manually after as terminal needs to be restarted first for Brew to be a command)
# Tap depricated. No longer needed command
# brew tap Homebrew/bundle

# Install softwares as per brewfile
brew bundle --file=$HOME/Documents/.dotfiles/Brewfile.txt



# Set macOS preferences - we will run this last because this will reload the shell
source $HOME/Documents/.dotfiles/.macos



# Steps to get my prefered terminal on a mac
# -------------------------------------------------------------------------------------------
# 1. iterm2 (installed through brewfile)
# 2. solarised dark theme (seems to be built in to iterm2)
# 3. powerline fonts (installed above in this script)
# 4. change iterm color scheme to solarised and select the font as mentioned below
# 5. install oh-my-zsh from https://ohmyz.sh/ (TO DO: add it to this script after brewfile)
# 5. change the oh-my-zsh theme to agnoster as described below
# -------------------------------------------------------------------------------------------
# add this line to .zshrc file located in the home directory
# ZSH_THEME="agnoster"
# Agnoster theme for oh-my-zsh is best with the solarised dark theme
# https://github.com/altercation/solarized/
# Anoster theme file that needs to be edited to customise prompt
# ~/.oh-my-zsh/themes/agnoster.zsh-theme
