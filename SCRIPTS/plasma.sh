#!/bin/bash

#Installing extras
yes | yay
yay -S --noconfirm kvantum
yay -S --noconfirm konsave
yay -S --noconfirm kwin-effect-rounded-corners-git

#Copying keybindings file
cd /home/$USER/Downloads/
curl -o PlasmaShortcutsX11.kksrc https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/PlasmaShortcutsX11.kksrc
