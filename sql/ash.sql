-- set option
set pages 20000
set lines 10000
set trims on
set feed off
set echo off
set colsep ','


-- NLS_DATE_FORMAT
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/mm/dd hh24:mi:ss';


-- input timestamp
ACCEPT s_report_date CHAR PROMPT 'Enter report date (yyyy-mm-dd): '
ACCEPT s_stt CHAR PROMPT 'Enter start time (HH24:MI): '
ACCEPT s_edt CHAR PROMPT 'Enter end time (HH24:MI): '


-- v$active_session_history
spool v_ash_&s_report_date
SELECT * FROM v$active_session_history
WHERE sample_time >= TO_DATE('&s_report_date' || ' ' || '&s_stt' || ':00', 'yyyy-mm-dd HH24:MI:SS')
AND sample_time < TO_DATE('&s_report_date' || ' ' || '&s_edt' || ':00', 'yyyy-mm-dd HH24:MI:SS')
ORDER BY sample_time, session_id, session_serial#;
spool off


-- dba_hist_active_sess_history
spool d_ash_&s_report_date
SELECT * FROM dba_hist_active_sess_history
WHERE sample_time >= TO_DATE('&s_report_date' || ' ' || '&s_stt' || ':00', 'yyyy-mm-dd HH24:MI:SS')
AND sample_time < TO_DATE('&s_report_date' || ' ' || '&s_edt' || ':00', 'yyyy-mm-dd HH24:MI:SS')
ORDER BY sample_time, session_id, session_serial#;
spool off


-- undefine
undefine s_report_date
undefine s_stt
undefine s_edt
