class FileSystem
{
    mkdir(path)
    {
        path := this.normalizePath(path)
        FileCreateDir, % path

        if (ErrorLevel) {
            throw A_LastError
        }
    }

    concat(path1, path2)
    {
        return RTrim(path1, "/\") "\" LTrim(path2 "/\")
    }

    normalizePath(path)
    {
        return StrReplace(path, "/", "\")
    }
}