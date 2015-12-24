# Lade die Shell unabhaengige Shell Variablen Datei
[[ -r ~/.shrc ]] && . ~/.shrc

typeset -U path
#/sbin /bin /usr/sbin /usr/bin /usr/syno/sbin /usr/syno/bin /usr/local/sbin /usr/local/bin

path=(~/bin /opt/bin /opt/sbin /usr/local/sbin /usr/local/bin $path)
