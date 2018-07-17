#!/bin/sh

LANG=C
export LANG

usage()
{
  exec >&2
  echo "usage: `basename \"$0\"` [ -bfhpu ]"
  echo '    -b Display drc.log (Data Guard Broker) instead of alert.log.'
  echo '    -f Set pager to `tail -f'\''.'
  echo '    -h Print option help.'
  echo '    -p Display path to background_dump_dest instead of content of alert.log.'
  echo '    -u Display path to user_dump_dest instead content of alert.log.' 
  exit "${1-127}"
}

echo()
{
  printf '%s\n' "$*"
}

unset OPTB OPTF OPTP OPTU; OPTIND=1
while getopts bfhpu OPT; do
  case $OPT in
  b) OPTB=1 ;;
  f) OPTF=1 ;;
  h) usage 0 ;;
  p) OPTP=1 ;;
  u) OPTU=1 ;;
  \?) usage ;;
  esac
done
shift `expr "$OPTIND" - 1`

test x${OPTF+set} = xset && PAGER='tail -f'
test x${OPTU+set} = xset && OPTP=1
test "x${ORACLE_SID+set}" = xset || exit $?

SQLPLUS=`dirname "$0"`/sqlplus.sh
test -x "$SQLPLUS" || unset SQLPLUS

BDUMP=`(
    if test x${OPTU+set} = xset; then
      echo 'SELECT value FROM v\$parameter WHERE name = '\\''user_dump_dest'\\'';'
    else
      echo 'SELECT value FROM v\$parameter WHERE name = '\\''background_dump_dest'\\'';'
    fi
    echo 'EXIT'
  ) | "${SQLPLUS-sqlplus}" '/ AS SYSDBA' | sed -ne '/^--*\$/,/^\$/p' | sed -e '1d;\$d'`

DDEST=`(
    echo 'SELECT value FROM v\$parameter WHERE name = '\\''user_dump_dest'\\'';'
    echo 'EXIT'
  ) | "${SQLPLUS-sqlplus}" '/ AS SYSDBA' | sed -ne '/^--*\$/,/^\$/p' | sed -e '1d;\$d'`

if test "x$BDUMP" != x && { test "x$DDEST" = x || test "x$BDUMP" != "x$ORACLE_HOME/rdbms/log"; } &&
   cd "$BDUMP" 2>/dev/null; then
  :
else
  test -f "$ORACLE_HOME/dbs/init$ORACLE_SID.ora" || exit $?

  DBNAME=`sed -ne 's/^\\([^=\\.]*\\.\\)\\{0,1\\}db_name *= *//ip' "$ORACLE_HOME/dbs/init$ORACLE_SID.ora"`
  DUNAME=`sed -ne 's/^\\([^=\\.]*\\.\\)\\{0,1\\}db_unique_name *= *//ip' "$ORACLE_HOME/dbs/init$ORACLE_SID.ora"`
  ISNAME=`sed -ne 's/^\\([^=\\.]*\\.\\)\\{0,1\\}instance_name *= *//ip' "$ORACLE_HOME/dbs/init$ORACLE_SID.ora"`

  if test "x$DBNAME" != x; then
    case $DBNAME in
    \"*\") DBNAME=`echo "$DBNAME" | sed -e 's/^"\\(.*\\)"$/\\1/'` ;;
    \'*\') DBNAME=`echo "$DBNAME" | sed -e 's/^'\\''\\(.*\\)'\\''$/\\1/'` ;;
    esac
  else
    DBNAME=$ORACLE_SID
  fi

  if test "x$DUNAME" != x; then
    case $DUNAME in
    \"*\") DUNAME=`echo "$DUNAME" | sed -e 's/^"\\(.*\\)"$/\\1/'` ;;
    \'*\') DUNAME=`echo "$DUNAME" | sed -e 's/^'\\''\\(.*\\)'\\''$/\\1/'` ;;
    esac
  else
    DUNAME=$DBNAME
  fi

  LDBNAME=`echo "$DBNAME" | tr A-Z a-z`
  UDUNAME=`echo "$DUNAME" | tr '[:lower:]' '[:upper:]'`
  LDUNAME=`echo "$DUNAME" | tr A-Z a-z`

  cd "$ORACLE_BASE/diag/rdbms/$LDUNAME/$ORACLE_SID/trace" 2>/dev/null ||
  if test x${OPTU+set} = xset; then
    cd "$ORACLE_BASE/admin/$LDBNAME/udump" 2>/dev/null || exit $?
  else
    cd "$ORACLE_BASE/admin/$LDBNAME/bdump" 2>/dev/null || exit $?
  fi
fi

if test x${OPTP+set} = xset; then
  pwd
elif test x${OPTB+set} = xset; then
  ${PAGER-more} "drc$ORACLE_SID.log" || exit $?
else
  ${PAGER-more} "alert_$ORACLE_SID.log" || exit $?
fi

exit 0
