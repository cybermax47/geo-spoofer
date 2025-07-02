#!/bin/bash
set -e

echo "[+] Installing dependencies..."
sudo apt update
sudo apt install -y openvpn nodejs npm systemd libnss3

echo "[+] Installing Puppeteer globally..."
sudo npm install -g puppeteer

echo "[+] Creating log directory..."
mkdir -p logs

echo "[+] Copying systemd service..."
sudo cp geo.service /etc/systemd/system/geo.service

echo "[+] Setting default coords in .env..."
cat <<EOF > .env
SPOOF_LAT=40.7128
SPOOF_LNG=-74.0060
EOF

echo "[+] Enabling systemd spoofing service..."
sudo systemctl daemon-reload
sudo systemctl enable geo
sudo systemctl start geo

echo "[+] Done."
