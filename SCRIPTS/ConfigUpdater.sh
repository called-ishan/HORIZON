#!/bin/bash

echo "Which config would you like to update
1: .bashrc
2: .nanorc
3: firefox user.js
"
read x

if [[ x == 1 ]]; then
    cp ~/.bashrc ~/DocumentsGithub/HORIZON/CONFIGS/bashrc
    cp ~/.bashrc /mnt/sdb3/Backups/bashrc
    echo "bashrc is copied to both github and storage"
fi

if [[ x == 2 ]]; then
    cp ~/.nanorc ~/DocumentsGithub/HORIZON/CONFIGS/nanorc
    cp ~/.nanorc /mnt/sdb3/Backups/nanorc
    echo "nanorc is copied to both github and storage"
fi

if [[ x == 3 ]]; then
    dir=$(find .mozilla/firefox/ -name user.js)
    cp $dir ~/Documents/Github/HORIZON/CONFIGS/firefox.user.js
    cp $dir /mnt/sdb3/Backups/Firefox
    echo "Firefox user.js copied to both github and storage"
if
