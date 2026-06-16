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

