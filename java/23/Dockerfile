FROM --platform=$TARGETOS/$TARGETARCH eclipse-temurin:23-jdk

LABEL author="x08xNickelodeon" maintainer="x08xNickelodeon@gmail.com"
LABEL org.opencontainers.image.source="https://github.com/x08xNickelodeon/pterodactyl-yolks"
LABEL org.opencontainers.image.licenses=MIT

# Remove unnecessary disk utilities
RUN rm -rf /usr/bin/dd /usr/bin/fallocate /usr/bin/truncate /usr/bin/xfs_mkfile

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    ca-certificates \
    gnupg \
    jq \
    unzip \
    lsof \
    openssl \
    git \
    tar \
    sqlite3 \
    fontconfig \
    libfreetype6 \
    tzdata \
    iproute2 \
    libstdc++6

# Download and install Node.js 18 manually
RUN curl -fsSL https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz -o node.tar.xz \
    && mkdir -p /usr/local/lib/nodejs \
    && tar -xJf node.tar.xz -C /usr/local/lib/nodejs \
    && rm node.tar.xz

# Set environment variables for Node.js
ENV PATH=/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin:$PATH

# Install mc-monitor globally using npm
RUN npm install -g mc-monitor

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
