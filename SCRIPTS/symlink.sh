#!/bin/bash

# Define the directory where your dotfiles are stored
DOTFILES_DIR=/home/$USER/Documents/Github/HORIZON/CONFIGS/

# Define a mapping of original dotfiles to their symlink paths
declare -A DOTFILES_MAP
DOTFILES_MAP=(
    ["bashrc"]="~/.bashrc"
    ["nanorc"]="~/.nanorc"
    ["firefox.user.js"]="~/.mozilla/firefox/user.js"
    ["90210.theme.sh"]="~/.oh-my-bash/themes/90210/90210.theme.sh"
)


# Function to create symlinks with custom locations
create_symlinks() {
    for original_file in "${!DOTFILES_MAP[@]}"; do
        # Resolve ~ to the home directory for symlink paths
        symlink_path=$(eval echo ${DOTFILES_MAP[$original_file]})

        # Check if the symlink already exists
        if [ -L "$symlink_path" ]; then
            echo "Symlink for $symlink_path already exists. Skipping..."
        else
            # Remove the existing file or symlink if it exists
            if [ -e "$symlink_path" ]; then
                rm -rf "$symlink_path"
                echo "Removed existing $symlink_path"
            fi

            # Create the directory for the symlink if it doesn't exist
            mkdir -p "$(dirname "$symlink_path")"

            # Create the new symlink
            ln -s "$DOTFILES_DIR/$original_file" "$symlink_path"
            echo "Created symlink for $original_file as $symlink_path"
        fi
    done
}

# Run the function
create_symlinks

echo "Symlinking completed."
