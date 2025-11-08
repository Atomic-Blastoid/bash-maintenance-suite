#!/bin/bash
# update_cleanup.sh — Update and clean system packages with logging

#  Define log file path
LOGFILE="$HOME/bash-maintenance-suite/maintenance.log"

#  Create log file if missing
if [ ! -f "$LOGFILE" ]; then
    echo "Creating log file at $LOGFILE"
    touch "$LOGFILE"
fi

#  Start log entry
echo "$(date '+%F %T') - [INFO] Running update_cleanup.sh" >> "$LOGFILE"

# Update package list
echo " Updating package list..."
sudo apt update -y &>> "$LOGFILE"
if [ $? -eq 0 ]; then
    echo " System update list fetched successfully."
    echo "$(date '+%F %T') - [SUCCESS] apt update completed" >> "$LOGFILE"
else
    echo " Failed to fetch updates!"
    echo "$(date '+%F %T') - [ERROR] apt update failed" >> "$LOGFILE"
fi

#  Upgrade packages
echo " Upgrading packages..."
sudo apt upgrade -y &>> "$LOGFILE"
if [ $? -eq 0 ]; then
    echo " Packages upgraded successfully."
    echo "$(date '+%F %T') - [SUCCESS] apt upgrade completed" >> "$LOGFILE"
else
    echo " Package upgrade failed!"
    echo "$(date '+%F %T') - [ERROR] apt upgrade failed" >> "$LOGFILE"
fi

# Clean up old packages and cache
echo " Cleaning up old packages and cache..."
sudo apt autoremove -y &>> "$LOGFILE"
sudo apt clean &>> "$LOGFILE"
if [ $? -eq 0 ]; then
    echo " Cleanup completed successfully."
    echo "$(date '+%F %T') - [SUCCESS] apt cleanup completed" >> "$LOGFILE"
else
    echo " Cleanup failed!"
    echo "$(date '+%F %T') - [ERROR] apt cleanup failed" >> "$LOGFILE"
fi

#  Log completion
echo "$(date '+%F %T') - [INFO] update_cleanup.sh completed" >> "$LOGFILE"

