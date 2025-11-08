
LOGFILE="$HOME/bash-maintenance-suite/maintenance.log"

if [ ! -f "$LOGFILE" ]; then
    echo "Creating log file at $LOGFILE"
    touch "$LOGFILE"
fi

echo "$(date '+%F %T') - [INFO] Running log_monitor.sh" >> "$LOGFILE"

SYSLOG="/var/log/syslog"
if [ ! -f "$SYSLOG" ]; then

    SYSLOG="/var/log/dmesg"
fi

echo "Scanning $SYSLOG for issues..."
grep -iE "error|fail|critical|warn" "$SYSLOG" | tail -n 20 > /tmp/logscan.txt

COUNT=$(wc -l < /tmp/logscan.txt)

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

rm -f /tmp/logscan.txt

echo "$(date '+%F %T') - [INFO] log_monitor.sh completed" >> "$LOGFILE"
