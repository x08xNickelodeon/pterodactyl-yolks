FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:23-jdk

LABEL       author="x08xNickelodeon" maintainer="x08xNickelodeon@gmail.com"
LABEL       org.opencontainers.image.source="https://github.com/x08xNickelodeon/pterodactyl-yolks"
LABEL       org.opencontainers.image.licenses=MIT

# Remove unnecessary disk utilities
RUN rm -rf /usr/bin/dd /usr/bin/fallocate /usr/bin/truncate /usr/bin/xfs_mkfile

# Install dependencies and Node.js 18 manually
RUN apt-get update && apt-get install -y \
    curl bash ca-certificates gnupg software-properties-common \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g mc-monitor \
    && apt-get install -y jq unzip lsof openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6

# Download AntiMalware tool
RUN curl -sSL https://github.com/OpticFusion1/MCAntiMalware/releases/latest/download/MCAntiMalware.jar \
    -o /MCAntiMalware.jar

# Create the container user
RUN useradd -d /home/container -m container

# Copy and set up scripts
COPY ./../entrypoint.sh /entrypoint.sh
COPY ./../idle_shutdown.sh /idle_shutdown.sh
RUN chmod +x /entrypoint.sh /idle_shutdown.sh

# Use container user and working directory
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Start script
CMD ["/bin/bash", "/entrypoint.sh"]
