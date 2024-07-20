#!/bin/bash


# Installing yay
sudo pacman -S --noconfirm git
git clone https://aur.archlinux.org/yay.git && cd yay
yes | makepkg -si
clear
echo"yay is Installed"

#Copying my configs for later use

#Editing pacman.conf
sudo sed -i '/Color/s/^#//g' /etc/pacman.conf
sudo sed -i '/ParallelDownloads/s/^#/ILoveCandy\n/g' /etc/pacman.conf
sudo sed -i '/VerbosePkgLists/s/^#//g' /etc/pacman.conf
clear
echo"pacman configured"

#Configuring ohmybash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
clear
echo"ohmybash installed"

#
