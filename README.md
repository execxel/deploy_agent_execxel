# Student Attendance Tracker

A Bash automation tool that generates a complete Student Attendance Tracker workspace from scratch.  
It sets up the project structure, validates dependencies, manages configuration updates, and ensures safe cleanup through signal handling.

---

## Video Explanation

Watch the full walkthrough here:  


---

## ⚡ Quick Start

### Clone the repository

git clone https://github.com/execxel/deploy_agent_execxel.git
cd deploy_agent_nissi15

---

### Run the setup script

chmod +x setup_project.sh
./setup_project.sh

---

## What the Script Does

When executed, the script automatically:

- Checks if Python 3 is installed
- Prompts for a project directory name
- Creates a structured workspace from templates
- Copies required project files into correct folders
- Allows interactive updates to attendance thresholds
- Validates required dependencies before setup continues
- Ensures safe cleanup if the process is interrupted

---



## Interactive Configuration

Update attendance thresholds:

Do you want to update attendance thresholds? (y/n)

If yes:
- Warning threshold (default: 75)
- Failure threshold (default: 50)

These values are written into:

Helpers/config.json

---

## Safety & Signal Handling

If interrupted (Ctrl+C):

- Script catches SIGINT
- Archives project:
  attendance_tracker_<name>_archive.tar.gz
- Removes incomplete directory
- Exits cleanly

---

## Python Environment Check

- Python 3 detected → shows version
- Missing Python 3 → warning displayed

---

## Requirements

- Bash shell (Linux / macOS / WSL)
- Python 3 recommended

Required files:
- attendance_checker.py
- assets.csv
- config.json
- reports.log

---

## Purpose

- Automate project setup
- Ensure consistent structure
- Reduce manual errors
- Provide reusable project factory
- Safe interruption handling

---

## 👨‍💻 Author

Built with passion by @execxel
