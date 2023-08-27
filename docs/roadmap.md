# Project Roadmap

The plan is to make something similar in function to PHP's Composer package/dependency manager.

Planned features:
- [  ] ahk stdlib autoloading
- [  ] build a new standard for autoloading/building class namespaces (`asr-0`?)
- [  ] clumping all loaded libraries into a single file for including (`Vendor\All`?)
- [  ] creating autoload "groups" or "categories" from included packages (`Vendor\FileLibraries`, `Vendor\Models`, etc?)
- [  ] multilevel version checking of packages and dependencies


## Development Steps

1. Setup everything for testing
2. Build a filesystem package for conveniently creating/caching packages
3. Build a command package for running commands and outputting to stdout
4. Define basic structure for porter.json files
5. Build a package for parsing and working with porter.json files
6. Come up with methodology for importing into `Lib` folder


## Process Steps

```batch
: If not exist %A_MyDocuments%\AutoHotKey\Lib\Porter
mkdir %A_MyDocuments%\AutoHotKey\

: If not exist %A_MyDocuments%\AutoHotKey\Lib\Porter
mkdir %A_MyDocuments%\AutoHotKey\Lib

: If not exist %A_MyDocuments%\AutoHotKey\Lib\Porter
mkdir %A_MyDocuments%\AutoHotKey\Lib\Porter

: If not exist %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%
mkdir %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%

: If not exist %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%\%packagename%
mkdir %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%\%packagename%

: If not exist %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%\%packagename%\%version%
mkdir %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%\%packagename%\%version%

: Clone our repo, version, into created path
git clone --depth 1 --branch "0.1.0" git@github.com:sadmachine/crank.git "%A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%\%packagename%\%version%\"

: Delete the .git directory so it doesn't show up as a repo and cannot be edited
rmdir %A_MyDocuments%\AutoHotKey\Lib\Porter\%vendorname%\%packagename%\%version%\.git

```

Once the above is done, we need to read the *entrypoint* from the %repo%/porter.json file, and create a local include for it. 
Right now, that will go in a location like vendor/autoload.ahk

Pseudo code for this below

```
porterConfig := Json(repoPath "/porter.json")

if (FileExist("vendor") != "D") {
  DirCreate("vendor")
}

includePath := 

autoloadFile := FileOpen("vendor/autload.ahk", "a")
autoloadFile.writeLine("#Include " A_MyDocuments "/Lib/Porter/" repoPath "/" porterConfig["entrypoint"]) 
```