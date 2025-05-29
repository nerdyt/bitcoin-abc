FROM ubuntu:20.04
RUN apt-get update -y
RUN apt-get install wget build-essential -y
WORKDIR /opt/
RUN wget https://github.com/Bitcoin-ABC/bitcoin-abc/releases/download/v0.31.5/bitcoin-abc-0.31.5-x86_64-linux-gnu.tar.gz
RUN tar zxvf bitcoin-abc-0.31.5-x86_64-linux-gnu.tar.gz
RUN mv bitcoin-abc-0.31.5/bin/* /usr/bin/
RUN wget https://raw.githubusercontent.com/TheRetroMike/rmt-nomp/master/scripts/blocknotify.c
RUN gcc blocknotify.c -o /usr/bin/blocknotify
CMD /usr/bin/bitcoind -printtoconsole