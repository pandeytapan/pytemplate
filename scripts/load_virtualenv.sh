#!/bin/bash

# Function to load pyenv

load_pyenv() {
    local pyenv_name="$1"
    if ! pyenv versions | grep -q "$pyenv_name"; then
        echo "Creating pyenv environment '$pyenv_name'..."
        pyenv virtualenv "$pyenv_name"
    fi
    eval "$(pyenv init --path)"
    pyenv local "$pyenv_name"
    if [ $? -eq 0 ]; then
        echo "Pyenv '$pyenv_name' loaded successfully."
    else
        echo "Error: Failed to load pyenv '$pyenv_name'."
    fi
}

# Function to read pyenv name from config/.project file
read_pyenv_from_project_file() {
    local project_file="config/.project"
    if [ -f "$project_file" ]; then
        pyenv_name=$(grep -oP '(?<=pyenv: ).*' "$project_file")
        if [ -n "$pyenv_name" ]; then
            load_pyenv "$pyenv_name"
            return 0
        fi
    fi
    return 1
}

# Function to prompt user for pyenv name and save it
prompt_and_save_pyenv() {
    read -p "Enter pyenv name: " pyenv_name
    echo "pyenv: $pyenv_name" > config/local
    load_pyenv "$pyenv_name"
}

# Main function
main() {
    read_pyenv_from_project_file
    if [ $? -ne 0 ]; then
        echo "Pyenv name not found in '$project_file'."
        prompt_and_save_pyenv
    fi
}

main

