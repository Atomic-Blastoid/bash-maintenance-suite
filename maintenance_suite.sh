LOGFILE="$HOME/bash-maintenance-suite/maintenance.log"
SCRIPT_DIR="$HOME/bash-maintenance-suite"


if [ ! -f "$LOGFILE" ]; then
    touch "$LOGFILE"
fi
show_menu() {
    clear
    echo "=============================================="
    echo "      Linux Maintenance Suite - Main Menu    "
    echo "=============================================="
    echo "1 Run Backup Script"
    echo "2 Run Update & Cleanup Script"
    echo "3 Run Log Monitor Script"
    echo "4 Exit"
    echo "----------------------------------------------"
    read -p "Choose an option [1-4]: " choice
}

while true; do
    show_menu
    case $choice in
        1)
            echo "$(date '+%F %T') - [INFO] User selected Backup" >> "$LOGFILE"
            bash "$SCRIPT_DIR/backup.sh"
            read -p "Press Enter to continue..."
            ;;
        2)
            echo "$(date '+%F %T') - [INFO] User selected Update & Cleanup" >> "$LOGFILE"
            bash "$SCRIPT_DIR/update_cleanup.sh"
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "$(date '+%F %T') - [INFO] User selected Log Monitor" >> "$LOGFILE"
            bash "$SCRIPT_DIR/log_monitor.sh"
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "$(date '+%F %T') - [INFO] Exiting Maintenance Suite" >> "$LOGFILE"
            echo "Goodbye "
            exit 0
            ;;
        *)
            echo " Invalid choice! Please select 1–5."
            read -p "Press Enter to try again..."
            ;;
    esac
done
