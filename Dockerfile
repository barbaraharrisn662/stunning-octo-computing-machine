FROM ubuntu:22.04

# Membaca langsung dari /proc/cpuinfo dan /proc/meminfo (Tembus proteksi buildctl Watasu)
RUN echo "================ INFO CPU ================" && \
    grep -m 1 "model name" /proc/cpuinfo && \
    grep -m 1 "cache size" /proc/cpuinfo && \
    echo "Total Threads / vCPU : $(grep -c ^processor /proc/cpuinfo)" && \
    echo "================ INFO RAM ================" && \
    grep -E "MemTotal|MemAvailable" /proc/meminfo && \
    echo "============= CGROUP LIMIT ===============" && \
    (cat /sys/fs/cgroup/cpu.max 2>/dev/null || cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us 2>/dev/null || echo "Tidak ada limit cgroup terdeteksi") && \
    exit 1
