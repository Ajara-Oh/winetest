#!/bin/bash
set -e

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
chmod 600 ~/.vnc/passwd

# Start VNC + noVNC automatically
cat << 'EOF' > ~/.start-desktop.sh
#!/bin/bash
tightvncserver :1 -geometry 1280x800 -depth 24
websockify --web=/usr/share/novnc/ 6080 localhost:5901
EOF

chmod +x ~/.start-desktop.sh
