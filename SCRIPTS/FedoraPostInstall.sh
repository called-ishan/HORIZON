#Installing codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf install vlc

#enabling hardware acceleration for Intel(old) cpu(fixes horizontal line issues in YouTube browser)
sudo dnf install libva-intel-driver

#Copying configs for later use
cd /home/$USER/Downloads/
mkdir configs
cd configs
curl -o .bashrc https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/bashrc
curl -o 90210.theme.sh https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/90210.theme.sh
curl -o .nanorc https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/nanorc
curl -o user.js https://raw.githubusercontent.com/called-Ishan/HORIZON/main/CONFIGS/firefox.user.js

#Configuring ohmybash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
cp /home/$USER/Downloads/configs/90210.theme.sh /home/$USER/.oh-my-bash/themes/90210/

# Configuring bash
cp /home/$USER/Downloads/configs/.bashrc /home/$USER

# Configuring nano
cp /home/$USER/Downloads/configs/.nanorc /home/$USER

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