
apt update ; \
apt install -y wget ; \
hash -r ; \
wget -qO- https://github.com/alexs77/termux-config/raw/master/scripts/setup.sh | busybox ash -x
