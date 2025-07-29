#!/bin/bash
# Setup cron job for daily namespace backup
# Run this script to schedule the daily backup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DAILY_SCRIPT="$SCRIPT_DIR/daily-backup.sh"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Add cron job to run daily at 2 AM
(crontab -l 2>/dev/null; echo "0 2 * * * cd $REPO_DIR && $DAILY_SCRIPT >> /var/log/balance-fit-prd-backup.log 2>&1") | crontab -

echo "Cron job added successfully!"
echo "Daily backup will run at 2:00 AM"
echo "Logs will be written to: /var/log/balance-fit-prd-backup.log"
echo ""
echo "To check cron jobs: crontab -l"
echo "To remove cron job: crontab -e (then delete the line)"
