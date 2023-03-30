NERDCTL_VERSION=1.0.0 # see https://github.com/containerd/nerdctl/releases for the latest release

archType="amd64"
if test "$(uname -m)" = "aarch64"
then
    archType="arm64"
fi

wget -q "https://github.com/containerd/nerdctl/releases/download/v${NERDCTL_VERSION}/nerdctl-full-${NERDCTL_VERSION}-linux-${archType}.tar.gz" -O /tmp/nerdctl.tar.gz
mkdir -p ~/.local/bin
tar -C ~/.local/bin/ -xzf /tmp/nerdctl.tar.gz --strip-components 1 bin/nerdctl

echo -e '\nexport PATH="${PATH}:~/.local/bin"' >> ~/.bashrc
source ~/.bashrc

sudo chown root "$(which nerdctl)"
sudo chmod +s "$(which nerdctl)"

sudo echo -n ; sudo containerd &
sudo chgrp "$(id -gn)" /run/containerd/containerd.sock

nerdctl --version
nerdctl images
