FROM alpine:3.19.1

LABEL AboutImage="no-vnc-pulse-audio-chrome-image"
LABEL Maintainer="Alperen GÜNEŞ <alperengunes921@gmail.com>"

#VNC Server Password
ENV VNC_PASS="CHANGE_IT" \
    VNC_TITLE="Chromium" \
    VNC_RESOLUTION="1280x720" \
    VNC_SHARED=true \
    DISPLAY=:0 \
    NOVNC_PORT=$PORT \
    PORT=8080 \
    NO_SLEEP=false \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ="Asia/Kolkata"

COPY assets/ /

# Break the process into smaller steps
RUN apk update

RUN apk add --no-cache \
    tzdata \
    ca-certificates \
    supervisor \
    curl \
    wget \
    openssl \
    bash \
    python3 \
    py3-requests \
    python3-dev \
    sed \
    unzip \
    xvfb \
    x11vnc \
    websockify \
    openbox \
    chromium \
    nss \
    alsa-lib \
    font-noto \
    font-noto-cjk \
    sudo \
    git \
    xfce4 \
    faenza-icon-theme \
    tigervnc \
    xfce4-terminal \
    firefox \
    cmake \
    pulseaudio \
    xfce4-pulseaudio-plugin \
    pavucontrol \
    pulseaudio-alsa \
    alsa-plugins-pulse \
    alsa-lib-dev \
    nodejs \
    npm \
    build-base \
    libtool

# SSL certificate generation
RUN openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=IN/O=Dis/CN=www.google.com" -keyout /etc/ssl/novnc.key -out /etc/ssl/novnc.cert > /dev/null 2>&1

# Set timezone
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install npm packages
RUN npm install --prefix /opt/novnc/js ws
RUN npm install --prefix /opt/novnc/js audify

# Clean up
RUN apk del build-base python3-dev libtool curl wget unzip tzdata openssl && rm -rf /var/cache/apk/* /tmp/*


RUN echo '\
#!/bin/bash \
/usr/bin/pulseaudio 2>&1 | sed  "s/^/[pulseaudio] /" & \
sleep 1 & \
/usr/bin/node /opt/novnc/js/audify.js 2>&1 | sed "s/^/[audify    ] /"'\
>/entry.sh

ENTRYPOINT ["supervisord", "-l", "/var/log/supervisord.log", "-c"]

CMD ["/config/supervisord.conf"]
