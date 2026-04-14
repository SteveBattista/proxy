#!/bin/bash

# Script to add testlaboratory.cc entries to /etc/hosts
# Usage: sudo ./setup-hosts.sh

set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run with sudo"
    echo "Usage: sudo ./setup-hosts.sh"
    exit 1
fi

# Define the websites
WEBSITES=(
    "shopping"
    "social-media"
    "news"
    "email"
    "forum"
)

DOMAIN="testlaboratory.cc"
HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.backup.$(date +%Y%m%d_%H%M%S)"

# Create backup
echo "Creating backup: $BACKUP_FILE"
cp "$HOSTS_FILE" "$BACKUP_FILE"

# Marker comments for our entries
MARKER_START="# BEGIN testlaboratory.cc entries"
MARKER_END="# END testlaboratory.cc entries"

# Remove old entries if they exist
if grep -q "$MARKER_START" "$HOSTS_FILE"; then
    echo "Removing old testlaboratory.cc entries..."
    sed -i "/$MARKER_START/,/$MARKER_END/d" "$HOSTS_FILE"
fi

# Add new entries
echo "Adding testlaboratory.cc entries to $HOSTS_FILE..."
{
    echo ""
    echo "$MARKER_START"
    for website in "${WEBSITES[@]}"; do
        echo "127.0.0.1    ${website}.${DOMAIN}"
    done
    echo "$MARKER_END"
} >> "$HOSTS_FILE"

echo ""
echo "✓ Successfully updated $HOSTS_FILE"
echo ""
echo "Added entries:"
for website in "${WEBSITES[@]}"; do
    echo "  - ${website}.${DOMAIN} -> 127.0.0.1"
done
echo ""
echo "Backup saved to: $BACKUP_FILE"
