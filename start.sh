#!/bin/bash

# Install rclone static binary
wget -q https://downloads.rclone.org/v1.61.1/rclone-v1.61.1-linux-amd64.zip
unzip -q rclone-v1.61.1-linux-amd64.zip
export PATH=$PWD/rclone-v1.61.1-linux-amd64:$PATH
echo "Rclone installed successfully"

# setup rclone.conf file
if [[ -n $RCLONE_CONFIG_BASE64 ]]; then
	echo "Rclone config detected"
	echo "[DRIVE]" > rclone.conf
    mkdir -p /app/.config/rclone/
	echo "$(echo $RCLONE_CONFIG_BASE64|base64 -d)" >> /app/.config/rclone/rclone.conf
        echo "Rclone config placed in position"
fi

if [[ -n $BOT_TOKEN && -n $OWNER_ID ]]; then
	echo "Bot token and owner ID detected"
	cd TelegramShellBot-Rclone
        python3 config.py
fi

echo "SETUP COMPLETED"

rclone serve webdav /app --addr localhost:9090 --user "meshpotato" --pass "strong-fest-rat-Nest6" &
echo "rclone serving webdav /app on localhost:9090 --user '"meshpotato"' -pass '"strong-fest-rat-Nest6"'"
# start boy
npm start
