#!/bin/bash

VPN_CONFIG_PATH="/etc/openvpn/nyc.ovpn"
LOG_FILE="$(pwd)/logs/vpn.log"

sudo tee /etc/systemd/system/vpnspoof.service > /dev/null <<EOF
[Unit]
Description=VPN Spoof Service
After=network.target

[Service]
ExecStart=/usr/sbin/openvpn --config $VPN_CONFIG_PATH
Restart=always
RestartSec=5
StandardOutput=append:$LOG_FILE
StandardError=append:$LOG_FILE

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable vpnspoof
sudo systemctl start vpnspoof

echo "[+] VPN spoof service started and enabled on boot."
