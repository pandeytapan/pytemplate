#!/bin/bash

# Directory where ctags will be generated
CTAGS_DIR="ctags"
# Path to your project directory
PROJECT_DIR="../"

# Ensure ctags directory exists
mkdir -p "$CTAGS_DIR"

# Generate ctags for Python files in the project directory
ctags -R --languages=python --python-kinds=-i -f "$CTAGS_DIR/python_tags" "$PROJECT_DIR"

