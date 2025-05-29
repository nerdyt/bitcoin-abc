# Use the official Ubuntu 20.04 base image
FROM ubuntu:20.04

# Update package lists and install necessary packages
RUN apt-get update -y && \
    apt-get install -y wget build-essential gcc && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /opt/

# Download and extract Bitcoin ABC
RUN wget https://github.com/Bitcoin-ABC/bitcoin-abc/releases/download/v0.31.5/bitcoin-abc-0.31.5-x86_64-linux-gnu.tar.gz && \
    tar zxvf bitcoin-abc-0.31.5-x86_64-linux-gnu.tar.gz && \
    mv bitcoin-abc-0.31.5/bin/* /usr/bin/ && \
    rm -rf bitcoin-abc-0.31.5 bitcoin-abc-0.31.5-x86_64-linux-gnu.tar.gz

# Download the blocknotify script
RUN wget https://raw.githubusercontent.com/TheRetroMike/rmt-nomp/master/scripts/blocknotify.c

# Compile the blocknotify script
RUN gcc blocknotify.c -o /usr/bin/blocknotify && \
    rm blocknotify.c

# Set the command to run when the container starts
CMD ["/usr/bin/bitcoind", "-printtoconsole"]
