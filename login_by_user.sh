if [ -x /usr/local/sbin/sysinfo ]; then
        /usr/local/sbin/sysinfo 2> /dev/null
fi

export LC_TIME=en_US.utf8
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias inf='/usr/local/sbin/sysinfo'
alias sysinfo='/usr/local/sbin/sysinfo'
alias s='tail -f /var/log/secure'
alias m='tail -f /var/log/messages'

while [[ -z "$y" || "$y" = "root" || "${y/[^@-_.0-9a-zA-Z]/}" != "$y" ]]
do
        echo "Please input your login name:"
        echo -n ">"
        read y
done
if [ "$y" = "exit" ]; then
        exit
fi
export USER="$y"
y="$SSH_CLIENT"
if [ -x /sbin/consoletype ]; then
        if [ "`/sbin/consoletype`" != "pty" ]; then
                y="console"
        fi
fi
echo "$USER login: from: $y on: `date`" >> /var/log/login
export PS1='$USER@\h:\w\$ '
export LOGNAME="$USER"
export HOME="/root/.login/$USER"
if [ ! -d "$HOME" ]; then
        mkdir -p "$HOME" -m 0600
fi
export HISTFILE="$HOME/.bash_history"
unset y
cd "$HOME"
trap - 2
trap 'y="$USER logout: `date`";echo "$y" >> /var/log/login;echo "$y"' EXIT
