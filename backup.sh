
LOGFILE="$HOME/bash-maintenance-suite/maintenance.log"
SRC="$HOME/Documents"
DEST="$HOME/Backups/backup_$(date +%F_%T).tar.gz"

#  Ensure the log file exists
if [ ! -f "$LOGFILE" ]; then
    echo "Creating log file at $LOGFILE"
    touch "$LOGFILE"
fi

#  Log start
echo "$(date '+%F %T') - [INFO] Running backup.sh" >> "$LOGFILE"

#  Ensure required directories exist
mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Backups"

#  Debug info
echo "DEBUG: SRC = $SRC"
echo "DEBUG: DEST = $DEST"

#  Add a dummy file to back up (for testing)
if [ ! -f "$SRC/test.txt" ]; then
    echo "Sample data for testing" > "$SRC/test.txt"
fi

#  Perform backup
tar -czf "$DEST" "$SRC" 2>/dev/null
STATUS=$?

#  Log result based on success/failure
if [ $STATUS -eq 0 ]; then
    echo " Backup created successfully at $DEST"
    echo "$(date '+%F %T') - [SUCCESS] Backup created: $DEST" >> "$LOGFILE"
else
    echo " Backup failed!"
    echo "$(date '+%F %T') - [ERROR] Backup failed with exit code $STATUS" >> "$LOGFILE"
fi

#  Mark completion
echo "$(date '+%F %T') - [INFO] Backup script completed" >> "$LOGFILE"

