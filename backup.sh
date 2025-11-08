
LOGFILE="$HOME/bash-maintenance-suite/maintenance.log"
SRC="$HOME/Documents"
DEST="$HOME/Backups/backup_$(date +%F_%T).tar.gz"
if [ ! -f "$LOGFILE" ]; then
    echo "Creating log file at $LOGFILE"
    touch "$LOGFILE"
fi

echo "$(date '+%F %T') - [INFO] Running backup.sh" >> "$LOGFILE"

mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Backups"

echo "DEBUG: SRC = $SRC"
echo "DEBUG: DEST = $DEST"

if [ ! -f "$SRC/test.txt" ]; then
    echo "Sample data for testing" > "$SRC/test.txt"
fi

tar -czf "$DEST" "$SRC" 2>/dev/null
STATUS=$?

if [ $STATUS -eq 0 ]; then
    echo " Backup created successfully at $DEST"
    echo "$(date '+%F %T') - [SUCCESS] Backup created: $DEST" >> "$LOGFILE"
else
    echo " Backup failed!"
    echo "$(date '+%F %T') - [ERROR] Backup failed with exit code $STATUS" >> "$LOGFILE"
fi

echo "$(date '+%F %T') - [INFO] Backup script completed" >> "$LOGFILE"

