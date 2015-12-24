# Termux Configuration

Configuration of the Android [Termux](http://termux.com/) [App](https://play.google.com/store/apps/details?id=com.termux).

To get going, copy the following command and paste it in Termux:


```bash
apt update
apt install -y wget
hash -r
wget -qO- https://bitbucket.org/alexs77/termmux-config/raw/HEAD/scripts/setup.sh | busybox ash -x
```
