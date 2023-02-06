#Include <CmdProcess>

class CmdProcessTests
{

    Before()
    {
        this.worker := new CmdProcess("UTF-8")
        this.worker.setOutputHandler(ObjBindMethod(OutputHandlerTestClass, "testMethod"))
    }

    InitializationSetsEncoding()
    {
        expectedValue := "UTF-8"
        actualValue := this.worker.encoding
        YUnit.assert(expectedValue == actualValue, "worker.encoding should be " expectedValue ", but found " actualValue)
    }

    SetOutputHandlerSetsOutputHandler()
    {
        expectedValue := ObjBindMethod(OutputHandlerTestClass, "testMethod")
        actualValue := this.worker.outputHandler
        YUnit.assert(expectedValue == actualValue, "worker.outputHandler should be " expectedValue ", but found " actualValue)
    }

    RunProperlyOutputsMessage()
    {
        expectedValue := "Austin"

        this.worker.run("echo Austin")

        YUnit.assert(expectedValue == actualValue, "Output from run should be " expectedValue ", but found " actualValue)
    }

}

class OutputHandlerTestClass
{
    static testOutput := ""

    testMethod(message)
    {
        this.testOutput .= message
    }
}
