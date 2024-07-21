#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error
set -o pipefail  # Prevents errors in a pipeline from being masked

# Define variables
CONFIGS_URL="https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS"
DOWNLOADS_DIR="/home/$USER/Downloads"
CONFIGS_DIR="$DOWNLOADS_DIR/configs"
YAY_REPO_URL="https://aur.archlinux.org/yay.git"
OH_MY_BASH_INSTALL_URL="https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh"
DE_SETUP_DIR="$DOWNLOADS_DIR/DE-setups"

# Function to install yay
install_yay() {
    sudo pacman -S --noconfirm git
    git clone "$YAY_REPO_URL" && cd yay
    yes | makepkg -si
}

# Function to download configs
download_configs() {
    mkdir -p "$CONFIGS_DIR"
    cd "$CONFIGS_DIR"
    curl -O "$CONFIGS_URL/bashrc"
    curl -O "$CONFIGS_URL/90210.theme.sh"
    curl -O "$CONFIGS_URL/nanorc"
    curl -O "$CONFIGS_URL/firefox.user.js"
}

# Function to configure pacman
configure_pacman() {
    sudo sed -i '/Color/s/^#//' /etc/pacman.conf
    sudo sed -i '/ParallelDownloads/s/^#/ILoveCandy\n/' /etc/pacman.conf
    sudo sed -i '/VerbosePkgLists/s/^#//' /etc/pacman.conf
}

# Function to configure Oh My Bash
configure_oh_my_bash() {
    bash -c "$(curl -fsSL $OH_MY_BASH_INSTALL_URL)" --unattended
    cp "$CONFIGS_DIR/90210.theme.sh" "/home/$USER/.oh-my-bash/themes/90210/"
}

# Function to configure bash
configure_bash() {
    cp "$CONFIGS_DIR/bashrc" "/home/$USER/.bashrc"
}

# Function to configure nano
configure_nano() {
    cp "$CONFIGS_DIR/nanorc" "/home/$USER/.nanorc"
}

# Function to save user.js for Firefox
save_user_js() {
    cp "$CONFIGS_DIR/firefox.user.js" "$DOWNLOADS_DIR"
}

# Function to remove temporary files
remove_temp_files() {
    rm -rf "$CONFIGS_DIR"
    rm -rf "$DOWNLOADS_DIR/yay"
}

# Function to install software
install_software() {
    yes | yay
    yay -S --noconfirm archlinux-tweak-tool-git gnome-disk-utility firefox thorium-browser-bin youtube-music-bin
}

# Function to handle DE post-installation
de_post_installation() {
    echo "Want to run DE post installation(y/n)"
    read ans
    if [[ $ans == "y" ]]; then
        echo "Choose your desktop:
        1: Gnome
        2: KDE Plasma
        3: xfce"
        read de
        mkdir -p "$DE_SETUP_DIR" && cd "$DE_SETUP_DIR"
        case $de in
            1)
                echo "Still working on gnome setup"
                ;;
            2)
                curl -O https://raw.githubusercontent.com/called-Ishan/HORIZON/main/SCRIPTS/plasma.sh
                chmod +x plasma.sh
                ./plasma.sh
                ;;
            3)
                echo "Still working on xfce setup"
                ;;
            *)
                echo "Invalid option"
                ;;
        esac
    else
        echo "Thanks for using"
    fi
}

# Main function to call all other functions
main() {
    install_yay
    download_configs
    configure_pacman
    configure_oh_my_bash
    configure_bash
    configure_nano
    save_user_js
    remove_temp_files
    install_software
    de_post_installation
}

# Run main function
main
