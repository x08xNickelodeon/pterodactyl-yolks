FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:23-jdk

LABEL       author="x08xNickelodeon" maintainer="x08xNickelodeon@gmail.com"
LABEL       org.opencontainers.image.source="https://github.com/x08xNickelodeon/pterodactyl-yolks"
LABEL       org.opencontainers.image.licenses=MIT

# Remove unneeded system tools
RUN         rm -rf /usr/bin/dd \
            && rm -rf /usr/bin/fallocate \
            && rm -rf /usr/bin/truncate \
            && rm -rf /usr/bin/xfs_mkfile

# Install basic tools
RUN         apt-get update -y \
            && apt-get install -y curl jq unzip lsof ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6

# Install mc-monitor globally
RUN apt-get install -y nodejs npm \
    && npm install -g mc-monitor

# Download malware scanner
RUN         curl -sSL https://github.com/OpticFusion1/MCAntiMalware/releases/latest/download/MCAntiMalware.jar \
            -o /MCAntiMalware.jar

# Create container user
RUN         useradd -d /home/container -m container

# Copy entrypoint and idle shutdown script, and set permissions (as root)
COPY        ./../entrypoint.sh /entrypoint.sh
COPY        ./../idle_shutdown.sh /idle_shutdown.sh
RUN         chmod +x /entrypoint.sh /idle_shutdown.sh

# Switch to container user
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

# Entrypoint
CMD         [ "/bin/bash", "/entrypoint.sh" ]
