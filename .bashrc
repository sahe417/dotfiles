# ----------------------------------------
# .bashrc 1.00 Last-Updated 2018/07/12
# ----------------------------------------

# Source global definitions
if [ -f /etc/bashrc ]; then
       . /etc/bashrc
fi

# User specific aliases and functions

if [ "$PS1" ]; then
       PS1='[\u@\h${ORACLE_SID+\[\033[34m\]$ORACLE_SID\[\033[0m\]}]\$ '
       cd() { command cd "$@"; pwd 1>&2; }
fi

HISTSIZE=10000
HISTCONTROL=ignoredups

alias 'h=history 1000'
alias 'l=echo "$PWD"; ls -aFl'
alias 'p=ps -fju "${LOGNAME:?}"'
alias 'vi=vim -X'
alias 'view=vim -RX'

# Oracle Database 12.2.0
alias 'cdb=cd "$ORACLE_BASE"'
alias 'cdo=cd "$ORACLE_HOME"'
alias 'cda=cd "｀alert.sh -p｀"'
alias 'cdu=cd "｀alert.sh -u｀"'

alias 'sp=sqlplus'
alias 'spn=sqlplus /nolog'
alias 'sps=sqlplus '\''/ as sysdba'\'''
