:: Save and clear the prompt (better clarity for echoing)
@set OLDPROMPT=%PROMPT%
@PROMPT $G$S

set COMPILER="%AHK_COMPILER%"
set BINFILE="%AHK2_COMPILER_BINFILE%"

:: Kill existing processes that will affect builds
tasklist /fi "imagename eq tmp.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "tmp.exe"

%COMPILER% /base %BINFILE% /in "%CD%\tmp.ahk" /out "%CD%\tmp.exe" 

:: Reset the prompt
@PROMPT %OLDPROMPT%