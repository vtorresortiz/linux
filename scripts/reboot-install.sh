#!/bin/sh

SERVICE_NAME="reboot"
SYSTEMD_BASE_FOLDER="/etc/systemd/system"
SYSTEMD_PREFIX_FILE="$SYSTEMD_BASE_FOLDER/$SERVICE_NAME"
SERVICE_FILE="$SYSTEMD_PREFIX_FILE.service"
TIMER_FILE="$SYSTEMD_PREFIX_FILE.timer"

#echo $SERVICE_FILE
#echo $TIMER_FILE

/bin/cat <<EOF | sudo tee $SERVICE_FILE
[Unit]
Description=Scheduled Reboot
[Service]
Type=oneshot
ExecStart=/usr/bin/systemctl reboot
EOF

/bin/cat <<EOF | sudo tee $TIMER_FILE
[Timer]
OnCalendar=*-*-* 03:00:00 America/Santiago
[Install]
WantedBy=timers.target
EOF

sudo systemctl enable --now $SERVICE_NAME.timer
systemctl list-timers | grep $SERVICE_NAME
