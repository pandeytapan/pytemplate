#!/bin/bash

# Function to create source file
create_source_file() {
    local module_name=$1
    local source_file_name=$2
    local author_name=$3
    local purpose=$4
    local year=$(date +%Y)
    local src_dir="./src"
    local module_dir="$src_dir/$module_name"

    # Create module directory if it doesn't exist
    mkdir -p "$module_dir"

    # Create __init__.py file if it doesn't exist
    touch "$module_dir/__init__.py"

    # Create source file
    local source_path="$module_dir/$source_file_name.py"
    touch "$source_path"

    # Append information as Python comments to the source file
    cat <<EOF > "$source_path"
"""
Purpose: $purpose
Module: $module_name
Author: $author_name
Copyright (C) Cynoteck Software Solutions - $year
"""
EOF

    echo "Source file '$source_file_name.py' created in module '$module_name'."
}

# Main script
read -p "Enter module name (folder name): " module_name
read -p "Enter source file name: " source_file_name
read -p "Enter author name: " author_name
read -p "Enter purpose of source: " purpose

create_source_file "$module_name" "$source_file_name" "$author_name" "$purpose"

