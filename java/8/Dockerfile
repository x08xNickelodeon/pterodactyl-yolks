FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:8u312-b07-jdk-focal

LABEL       author="x08xNickelodeon" maintainer="x08xNickelodeon@gmail.com"

LABEL       org.opencontainers.image.source="https://github.com/x08xNickelodeon/pterodactyl-yolks"
LABEL       org.opencontainers.image.licenses=MIT

RUN         rm -rf /usr/bin/dd \
						&& rm -rf /usr/bin/fallocate \
						&& rm -rf /usr/bin/truncate \
						&& rm -rf /usr/bin/xfs_mkfile

						RUN 				apt-get update -y \
						&& apt-get install -y jq unzip lsof ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
						&& useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
