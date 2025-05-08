FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:23-jdk

LABEL       author="x08xNickelodeon" maintainer="x08xNickelodeon@gmail.com"
LABEL       org.opencontainers.image.source="https://github.com/x08xNickelodeon/pterodactyl-yolks"
LABEL       org.opencontainers.image.licenses=MIT

# Remove unused disk utilities
RUN rm -rf /usr/bin/dd /usr/bin/fallocate /usr/bin/truncate /usr/bin/xfs_mkfile

# Install base tools, Node.js (via NodeSource), and mc-monitor
RUN apt-get update -y \
    && apt-get install -y curl bash ca-certificates gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs jq unzip lsof openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
    && npm install -g mc-monitor

# Download malware scanner
RUN curl -sSL https://github.com/OpticFusion1/MCAntiMalware/releases/latest/download/MCAntiMalware.jar \
    -o /MCAntiMalware.jar

# Create container user
RUN useradd -d /home/container -m container

# Copy scripts and make them executable
COPY ./../entrypoint.sh /entrypoint.sh
COPY ./../idle_shutdown.sh /idle_shutdown.sh
RUN chmod +x /entrypoint.sh /idle_shutdown.sh

# Set user and working directory
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Set entrypoint
CMD ["/bin/bash", "/entrypoint.sh"]
