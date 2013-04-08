**Join** README file
							
									       __      _          __
									      / /___  (_)___     / /
									 __  / / __ \/ / __ \   / / 
									/ /_/ / /_/ / / / / /  /_/  
									\____/\____/_/_/ /_/  (_)  
									
								        -Do better Join in vim

##Join

**Join** is an extended `:Join` command, to provide more powerful line join features then the build-in `:join`.

##Features

Except for all features provided by the build-in `:join` command, **Join** can:

- **Join** lines on a given string as separator
- **Join** with negative Count
- **Join** lines reversely
- **Join** lines and keep joined lines (without removing)
- **Join** lines with any combination of above options

##Installation
todo

##Usage

**Join** plugin defined two commands: `:J` and `:Join`.  They do exactly same job. `:J` is just a short form of command `:Join`
so the command format is:

		:[range]Join[!] [separator] [count] [flags]
		
some short explanation: (detailed command description please check `:h Join`)

- all arguments are optional. If one argument was not given, the default value will be used:
(default value table TODO )
- range follows Vim's range definition
- separator must be the 1st argument, and could be any string. It must be quoted by `"` or `''`, depends on if an escaped special character is required. (todo <tab> example)
- the order of last two argument: count and flags are free
- Count could be negative 
- flags there are two flags:
 
		r : join lines reversely
		k : don't move joined line after join

##Screencasts
todo


 vim:ft=markdown:ts=2:sw=2:ts=2:fdm=marker:expandtab
