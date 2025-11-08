

# Define log file path
LOGFILE="$HOME/bash-maintenance-suite/maintenance.log"

# Create log file if missing
if [ ! -f "$LOGFILE" ]; then
    echo "Creating log file at $LOGFILE"
    touch "$LOGFILE"
fi

#  Start logging
echo "$(date '+%F %T') - [INFO] Running log_monitor.sh" >> "$LOGFILE"

# hoose system log file (works in Ubuntu/WSL)
SYSLOG="/var/log/syslog"
if [ ! -f "$SYSLOG" ]; then
    # Fallback for systems without syslog
    SYSLOG="/var/log/dmesg"
fi

# Search for errors and warnings (case-insensitive)
echo "Scanning $SYSLOG for issues..."
grep -iE "error|fail|critical|warn" "$SYSLOG" | tail -n 20 > /tmp/logscan.txt

#  Count number of findings
COUNT=$(wc -l < /tmp/logscan.txt)

# Log results
if [ "$COUNT" -gt 0 ]; then
    echo "⚠️ Found $COUNT potential issues in system logs."
    echo "$(date '+%F %T') - [WARNING] $COUNT issues found in $SYSLOG" >> "$LOGFILE"
    echo "---- Recent Log Issues ----" >> "$LOGFILE"
    cat /tmp/logscan.txt >> "$LOGFILE"
    echo "----------------------------" >> "$LOGFILE"
else
    echo " No major issues found."
    echo "$(date '+%F %T') - [INFO] No new issues in $SYSLOG" >> "$LOGFILE"
fi

# Cleanup temp file
rm -f /tmp/logscan.txt

# Completion log
echo "$(date '+%F %T') - [INFO] log_monitor.sh completed" >> "$LOGFILE"
