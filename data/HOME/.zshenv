# Load shell independent variables
[[ -r ~/.shrc ]] && . ~/.shrc

typeset -U path
path=(~/bin /opt/bin /opt/sbin /usr/local/sbin /usr/local/bin $path)

# EOF
