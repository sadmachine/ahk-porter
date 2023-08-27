class CmdProcess
{
    outputHandler := ""
    encoding := "UTF-8"

    __New(encoding := "UTF-8")
    {
        this.encoding := encoding
    }

    setOutputHandler(outputHandler)
    {
        this.outputHandler := outputHandler
    }

    Run(command, finishedCallback := "")
    {
        static HANDLE_FLAG_INHERIT := 0x00000001, flags := HANDLE_FLAG_INHERIT
            , STARTF_USESTDHANDLES := 0x100, CREATE_NO_WINDOW := 0x08000000
        DllCall("CreatePipe", "PtrP", hPipeRead, "PtrP", hPipeWrite, "Ptr", 0, "UInt", 0)
        DllCall("SetHandleInformation", "Ptr", hPipeWrite, "UInt", flags, "UInt", HANDLE_FLAG_INHERIT)

        VarSetCapacity(STARTUPINFO , siSize := A_PtrSize*4 + 4*8 + A_PtrSize*5, 0)
        NumPut(siSize , STARTUPINFO)
        NumPut(STARTF_USESTDHANDLES, STARTUPINFO, A_PtrSize*4 + 4*7)
        NumPut(hPipeWrite , STARTUPINFO, A_PtrSize*4 + 4*8 + A_PtrSize*3)
        NumPut(hPipeWrite , STARTUPINFO, A_PtrSize*4 + 4*8 + A_PtrSize*4)

        VarSetCapacity(PROCESS_INFORMATION, A_PtrSize*2 + 4*2, 0)

        createProcess := "CreateProcess"
        if (A_IsUnicode) {
            createProcess := "CreateProcessW"
        }

        if (DllCall(createProcess, "Ptr", 0, "Str", ComSpec " /c " command, "Ptr", 0, "Ptr", 0, "UInt", true, "UInt", CREATE_NO_WINDOW
            , "Ptr", 0, "Ptr", 0, "Ptr", &STARTUPINFO, "Ptr", &PROCESS_INFORMATION) <= 0)
        {
            DllCall("CloseHandle", "Ptr", hPipeRead)
            DllCall("CloseHandle", "Ptr", hPipeWrite)
            throw Exception("CreateProcess is failed, " A_LastError)
        }
        DllCall("CloseHandle", "Ptr", hPipeWrite)
        VarSetCapacity(sTemp, 4096), nSize := 0
        while DllCall("ReadFile", "Ptr", hPipeRead, "Ptr", &sTemp, "UInt", 4096, "UIntP", nSize, "UInt", 0) {
            sOutput .= stdOut := StrGet(&sTemp, nSize, this.encoding)
            ( this.outputHandler && this.outputHandler.Call(stdOut) )
        }
        DllCall("CloseHandle", "Ptr", NumGet(PROCESS_INFORMATION))
        DllCall("CloseHandle", "Ptr", NumGet(PROCESS_INFORMATION, A_PtrSize))
        DllCall("CloseHandle", "Ptr", hPipeRead)

        (finishedCallback && finishedCallback.Call())
        Return sOutput
    }
}
