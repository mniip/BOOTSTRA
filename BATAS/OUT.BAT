IF %MODE%==CLEAN GOTO :EOF

IF NOT x%1==x GOTO :PORT

CALL RPN! _%IP%_1+
SET IP=%RESULT%
IF %MODE%==COUNT GOTO :EOF
CALL EMITBYTE 238

GOTO :EOF

:PORT
CALL RPN! _%IP%_2+
SET IP=%RESULT%
IF %MODE%==COUNT GOTO :EOF
CALL EMITBYTE 230
CALL EMITBYTE %1

:EOF
