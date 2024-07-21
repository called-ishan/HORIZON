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
        else
            # Remove the existing file or symlink if it exists
            if [ -e ~/"$symlink_name" ]; then
                rm ~/"$symlink_name"
                echo "Removed existing $symlink_name"
            fi

            # Create the new symlink
            ln -s "$DOTFILES_DIR/$original_file" ~/"$symlink_name"
            echo "Created symlink for $original_file as $symlink_name"
        fi
    done
}

# Run the function
create_symlinks

echo "Symlinking completed."
