:: Save and clear the prompt (better clarity for echoing)
@set OLDPROMPT=%PROMPT%
@PROMPT $G$S

:: Kill existing processes that will affect builds
tasklist /fi "imagename eq tmp.exe" |find ":" > nul
if errorlevel 1 taskkill /f /im "tmp.exe"

"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ".\tmp.ahk" /out ".\tmp.exe" 

:: Reset the prompt
@PROMPT %OLDPROMPT%