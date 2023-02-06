;@Ahk2Exe-ConsoleApp
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include <CmdProcess>
#Include <JSONFile>
#Include <IOStream>
#Include <FileSystem>

terminal := new IOStream()

worker := new CmdProcess()

worker.setOutputHandler(ObjBindMethod(terminal.stdout, "write"))

;FileSystem.mkdir("Lib\sadmachine\DBA-Automation-Tools\0.9.0")
worker.run("echo Hello", ObjBindMethod(terminal.stdout, "close"))
;worker.run("git clone --depth 1 --branch 0.9.0 git@github.com:sadmachine/DBA-Automation-Tools.git .\Lib\sadmachine\DBA-Automation-Tools\0.9.0", ObjBindMethod(terminal.stdout, "close"))
