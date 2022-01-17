FROM scottyhardy/docker-wine:latest

RUN apt-get update \
    && apt-get install -y innoextract ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /gorilla && cd /gorilla \
    && wget https://monket.net/dancing-monkeys/DancingGorilla-1.1.4-1.06.zip \
    && unzip DancingGorilla-1.1.4-1.06.zip \
    && rm -rf DancingGorilla-1.1.4-1.06.zip \
    && innoextract -e DancingGorilla-1.1.4-1.06.exe

# Override the one from scottyhardy
COPY entrypoint.sh /usr/bin/entrypoint
RUN chmod 755 /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
