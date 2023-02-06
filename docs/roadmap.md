# Project Roadmap

The plan is to make something similar in function to PHP's Composer package/dependency manager.

Planned features:
- [  ] ahk stdlib autoloading
- [  ] build a new standard for autoloading/building class namespaces (`asr-0`?)
- [  ] clumping all loaded libraries into a single file for including (`@\All`?)
- [  ] creating autoload "groups" or "categories" from included packages (`@\FileLibraries`, `@\Models`, etc?)
- [  ] multilevel version checking of packages and dependencies


## Development Steps

1. Setup everything for testing
2. Build a filesystem package for conveniently creating/caching packages
3. Build a command package for running commands and outputting to stdout
4. Define basic structure for porter.json files
5. Build a package for parsing and working with porter.json files
6. Come up with methodology for importing into `Lib` folder