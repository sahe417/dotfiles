# ----------------------------------------
# .bash_profile 1.00 Last-Updated 2018/07/12
# ----------------------------------------
umask 0022
ulimit -c unlimited

export EDITOR="vim"
export PAGER="less -ir"
export LESSCHARDEF=utf-8
export PATH=/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export MANPATH=/usr/local/share/man:/usr/share/man

# Perl-5.27.8
unset PERL5LIB
export PERLLIB=`perl -Te 'print "@INC\\n"' | \\
       sed -e 's* *:＊g;s＊'"\`which perl | \\\\
       sed -e 's:\\\\/bin\\\\/perl::; s:\\\\/:\\\\\\\\\\\\/:g'\｀"'*\\/opt\\/perl*g'｀
export PATH=/opt/perl/bin:$PATH
export MANPATH=/opt/perl/man:$MANPATH


# Java (JDK10)
##export JAVA_HOME=/opt/java
##export PATH=$JAVA_HOME/bin:$PATH
##export MANPATH=$JAVA_HOME/man:$MANPATH

# Oracle Database 12.2.0
export ORACLE_BASE=/opt/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.2.0/dbhome
export NLS_LANG=American_America.AL32UTF8
export NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export CLASSPATH=`ls -r $ORACLE_HOME/jdbc/lib/ojdbc[0-9].jar 2>/dev/null | \\
       perl -pe 's/\\n/:/g'`${CLASSPATH:+:$CLASSPATH}
export SQLPATH=$HOME

ulimit -u 16384 -n 65536

# Home
export PATH=$HOME/bin:$PATH
#export MANPATH=$HOME/man:$MANPATH

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
