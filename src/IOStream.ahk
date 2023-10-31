class IOStream
{
    stdout := ""
    stdin := ""
    stderr := ""

    __New()
    {
        this.stdout := FileOpen("*", "w `n")
        this.stdin := FileOpen("*", "r `n")
        this.stderr := FileOpen("**", "w `n")
    }

    __Delete()
    {
        this.stdout.close()
        this.stdin.close()
        this.stderr.close()
    }
}