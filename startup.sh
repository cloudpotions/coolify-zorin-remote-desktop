#!/bin/bash

# Start X virtual framebuffer
Xvfb :1 -screen 0 1920x1080x24 &

# Start XFCE (Zorin Lite is XFCE-based)
su - zorin -c 'startxfce4 &'  

# Start VNC
x11vnc -display :1 -usepw -forever -shared -rfbport 5900 &

# Start noVNC
/opt/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080
