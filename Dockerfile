FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# Install base packages
RUN apt update && apt install -y \
  sudo wget curl nano unzip git \
  xfce4 xfce4-goodies \
  x11vnc xvfb supervisor net-tools \
  software-properties-common \
  && rm -rf /var/lib/apt/lists/*

# Add Zorin OS repository
RUN add-apt-repository ppa:zorinos/stable && \
    apt update && apt install -y zorin-os-lite-core \
    && rm -rf /var/lib/apt/lists/*

# Create zorin user
RUN useradd -m zorin && echo 'zorin:zorin' | chpasswd && adduser zorin sudo

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify

# Copy startup script
COPY startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

EXPOSE 8080

CMD ["/opt/startup.sh"]

