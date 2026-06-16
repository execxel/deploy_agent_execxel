#!/bin/bash


cleanup() {
    echo ""
    echo "Interrupt or error detected! Cleaning up..."

    if [[ -n "${PROJECT_DIR:-}" && -d "$PROJECT_DIR" ]]; then
        tar -czf "${PROJECT_DIR}_archive_$(date +%Y%m%d_%H%M%S).tar.gz" "$PROJECT_DIR"
        rm -rf "$PROJECT_DIR"
        echo "Archived and removed: $PROJECT_DIR"
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


echo "Creating project structure..."

mkdir -p "$PROJECT_DIR/Helpers"
mkdir -p "$PROJECT_DIR/reports"

cp attendance_checker.py "$PROJECT_DIR/"
cp assets.csv "$PROJECT_DIR/Helpers/"
cp config.json "$PROJECT_DIR/Helpers/"
cp reports.log "$PROJECT_DIR/reports/"

echo "Files copied successfully"


read -rp "Do you want to update attendance thresholds? (y/n): " answer

if [ "$answer" = "y" ]; then
    read -p "Enter Warning threshold (default 75): " warning
    read -p "Enter Failure threshold (default 50): " failure

    if [[ "$warning" =~ ^[0-9]+$ ]] && [[ "$failure" =~ ^[0-9]+$ ]]; then
        sed -i 's/"warning: 75/"warning": $warning/' "$PROJECT_DIR/Helpers/config.json"
        sed -i 's/"failure": 50/"failure": $failure/' "$PROJECT_DIR/Helpers/config.json"
        echo "Config updated."
    else
        echo "Invalid input — thresholds must be numbers. Keeping defaults."
    fi
fi


echo "Running environment health check..."

if command -v python3 >/dev/null 2>&1; then
    echo "Python detected: $(python3 --version)"
else
    echo "Python V3 not found on this system."
fi


echo "Setup complete!"
echo "Project created at: $PROJECT_DIR"