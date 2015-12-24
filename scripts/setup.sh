#!/bin/sh

echo "This script sets up the Termux App."

package_file_url="https://bitbucket.org/alexs77/termmux-config/raw/HEAD/data/packages.txt"
package_file="$HOME/tmp/packages.txt"

mkdir -p "$HOME/tmp"

[ "$package_file" ] || wget -O "$package_file" "$package_file_url"

packages="`busybox sed 's, -.*,,' "$package_file"`"

apt install $packages


exit $?

# EOF
