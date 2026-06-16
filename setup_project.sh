#!/bin/bash


cleanup() {
    echo ""
    echo "Interrupt or error detected! Cleaning up..."

    if [[ -n "${PROJECT_DIR:-}" && -d "$PROJECT_DIR" ]]; then
        tar -czf "${PROJECT_DIR}_archive_$(date +%Y%m%d_%H%M%S).tar.gz" "$PROJECT_DIR"
        rm -rf "$PROJECT_DIR"
        echo "📦 Archived and removed: $PROJECT_DIR"
    fi

    exit 1
}

trap cleanup INT TERM


read -rp "Enter a name for your project: " input

if [[ -z "$input" ]]; then
    echo "Project name cannot be empty"
    exit 1
fi

PROJECT_DIR="${PROJECT_PREFIX}_${input}"


if [[ -d "$PROJECT_DIR" ]]; then
    echo "Error: '$PROJECT_DIR' already exists. Aborting."
    exit 1
fi

for file in attendance_checker.py assets.csv config.json reports.log; do
    if [[ ! -f "$file" ]]; then
        echo "Missing required file: $file"
        exit 1
    fi
done


echo "📁 Creating project structure..."

