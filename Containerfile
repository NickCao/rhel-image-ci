FROM registry.redhat.io/rhel9/rhel-bootc:9.4-1730828483

RUN curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
    sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo && \
    curl -s -L https://repo.download.nvidia.com/jetson/rhel-9.4/jp6.1/nvidia-l4t.repo | \
    sudo tee /etc/yum.repos.d/nvidia-l4t.repo && \
    sudo dnf -y install \
      nvidia-jetpack-kmod \
      nvidia-jetpack-all \
      nvidia-container-toolkit && \
    sudo dnf clean all

RUN curl -fsSL https://ollama.com/install.sh | sh

RUN mkdir -p /usr/lib/bootc/kargs.d && \
cat <<EOF >> /usr/lib/bootc/kargs.d/custom.toml
kargs = ["enforcing=0", "console=ttyTCU0,115200"]
EOF
