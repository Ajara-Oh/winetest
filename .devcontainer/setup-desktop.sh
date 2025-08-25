#!/bin/bash
set -e

# --- Wait for apt/dpkg lock to be released ---
echo "⏳ Waiting for apt lock..."
while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
   sleep 5
done

sudo apt-get update -y

# Install XFCE + VNC + noVNC
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  xfce4 xfce4-goodies tightvncserver novnc websockify \
  xvfb x11-utils x11-xserver-utils

# Install Wine
sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y wine64 wine32 winetricks

# Set VNC password
mkdir -p ~/.vnc
echo "1234" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/pa
