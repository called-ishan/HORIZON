#!/bin/bash

# Define the directory where your dotfiles are stored
DOTFILES_DIR=/home/$USER/Documents/Github/HORIZON/CONFIGS/

# Define a mapping of original dotfiles to their symlink names
declare -A DOTFILES_MAP
DOTFILES_MAP=(
    ["bashrc"]=".bashrc"
    ["nanorc"]=".nanorc"


)

# Function to create symlinks with custom names
create_symlinks() {
    for original_file in "${!DOTFILES_MAP[@]}"; do
        symlink_name="${DOTFILES_MAP[$original_file]}"

        # Check if the symlink already exists
        if [ -L ~/"$symlink_name" ]; then
            echo "Symlink for $symlink_name already exists. Skipping..."
        # Check if a regular file exists
        elif [ -e ~/"$symlink_name" ]; then
            echo "$symlink_name already exists. Backing up and replacing with symlink..."
            mv ~/"$symlink_name" ~/"$symlink_name.backup"
            ln -s "$DOTFILES_DIR/$original_file" ~/"$symlink_name"
            echo "Created symlink for $original_file as $symlink_name, original backed up as $symlink_name.backup"
        else
            ln -s "$DOTFILES_DIR/$original_file" ~/"$symlink_name"
            echo "Created symlink for $original_file as $symlink_name"
        fi
    done
}

# Run the function
create_symlinks

echo "Symlinking completed."
