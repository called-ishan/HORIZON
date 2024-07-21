#!/bin/bash

# Installing yay
sudo pacman -S --noconfirm git
git clone https://aur.archlinux.org/yay.git && cd yay
yes | makepkg -si

#Copying configs for later use
cd /home/$USER/Downloads/
mkdir configs
cd configs
curl -o .bashrc https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/bashrc
curl -o 90210.theme.sh https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/90210.theme.sh
curl -o .nanorc https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/nanorc
curl -o user.js https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/firefox.user.js

sudo chmod +x /home/$USER/Downloads/postinstall-part2.sh

#Editing pacman.conf
sudo sed -i '/Color/s/^#//g' /etc/pacman.conf
sudo sed -i '/ParallelDownloads/s/^#/ILoveCandy\n/g' /etc/pacman.conf
sudo sed -i '/VerbosePkgLists/s/^#//g' /etc/pacman.conf

#Configuring ohmybash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
cp /home/$USER/Downloads/configs/90210.theme.sh /home/$USER/.oh-my-bash/themes/90210/

# Configuring bash
cp /home/$USER/Downloads/configs/.bashrc /home/$USER

# Configuring nano
cp /home/$USER/Downloads/configs/.nanorc /home/$USER

# Saving user.js for firefox
cp /home/$USER/Downloads/configs/user.js /home/$USER/Downloads

# Removing temp files
rm -rf /home/$USER/Downloads/configs
rm -rf /home/$USER/Downloads/yay


# Installing softwares
yes | yay
yay -S --noconfirm archlinux-tweak-tool-git
yay -S --noconfirm gnome-disk-utility
yay -S --noconfirm firefox
yay -S --noconfirm thorium-browser-bin
yay -S --noconfirm youtube-music-bin

# DE post-installation
echo "Want to run DE post installation(y/n)"
read ans
if [[ $ans == "y" ]]; then
    echo "Choose your desktop:
    1: Gnome
    2: KDE Plasma
    3: xfce"
    read de
    cd /home/$USER/Downloads/ && mkdir DE-setups && cd DE-setups
    if [[ $de == 1 ]]; then
        echo "Still working on gnome setup"
    elif [[ $de == 2 ]]; then
        curl -o plasma.sh https://raw.githubusercontent.com/called-Ishan/HORIZON/main/SCRIPTS/plasma.sh
        chmod +x plasma.sh
        ./plasma.sh
    elif [[ $de == 3 ]]; then
        echo "Still working on xfce setup"
    fi


else
    echo "Thanks for using"
fi
