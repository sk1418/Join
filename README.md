**Join** README file

		       __      _          __
		      / /___  (_)___     / /
		 __  / / __ \/ / __ \   / / 
		/ /_/ / /_/ / / / / /  /_/  
		\____/\____/_/_/ /_/  (_)  
		
	        -Do better Join in vim

##Join

(http://www.vim.org/scripts/script.php?script_id=4516)

**Join** provides more powerful line join features than the build-in `:join`.

##Features

Except for all features provided by the build-in `:join` command, **Join** can:

- **Join** lines with separator (string)
- **Join** lines with or without trimming the leading/trailing whitespaces
- **Join** lines with negative count (backwards join)
- **Join** lines in reverse
- **Join** lines and keep joined lines (without removing joined lines)
- **Join** lines with any combinations of above options

##Usage

>If you are impatient, move your eyes down to the **Examples and Screenshots** section. :)

**Join** plugin defines only one command: `:Join`.  If there is no other customer command (by other plugins maybe) starts with `J`, `:J` is also available for `:Join`. 

The command format is:

    :[range]Join[!] [separator] [count] [flags]
		
Short explanation: (detailed command description please check `:h Join`)

- all arguments are optional. If one argument was not given, the default value will be used:

        arg      | Default value
        ========================
        range    | current line 
        count    | 1            
        bang     | ""           
        separator| " "          
        flags    | ""           
        ------------------------

- all given arguments must be separated by space
- `range` follows Vim's range definition
- `separator` must be the 1st argument, and could be any string. It must be quoted by `"` or `'`, depends on if an escaped special character is required.
- the order of last two argument: count and flags are free. e.g `:Join 5 rk` and `:Join rk 5`, both are valid.
- `count` could be negative number. In this case **Join** will do backwards join.
- `flags` :
 
		r : (reverse) join lines in reverse
		k : (keep) don't remove joined line after join

- If you don't give `[separator]` and `[flags]` also give only positive `[count]`, the `:Join` works as same as build-in `:join`

##Examples & Screenshots

**For detailed explainations, please check `:h Join`**

Before     |command & description                                                        |After
---        |---                                                                          |---
![][before]|`:J ', ' 3`<br/>Join with:<br/>`sep`<br/>`count`                             |![][after01]
![][before]|`:J '-' 3 r`<br/>Join with:<br/>`sep`<br/>`count`<br/>`reverse`              |![][after02]
![][before]|`:J '-' 3 k`<br/>Join with:<br/>`sep`<br/>`count`<br/>`keep`                 |![][after03]
![][before]|`:J '-' 3 kr`<br/>Join with:<br/>`sep`<br/>`count`<br/>`keep`<br/>`reverse`  |![][after04]
![][before]|`:J  -3`<br/>Join with:<br/>negative `count`                                 |![][after05]
![][before]|`:J -3 r`<br/>Join with:<br/>negative `count`<br/>`reverse`                  |![][after06]
![][before]|`:J -3 kr`<br/>Join with:<br/>negative `count`<br/>`reverse`<br/>`keep`      |![][after07]
![][before]|`:2,5J "'\"\t" k`<br/>Join with:<br/>`range`<br/>special `sep`<br/>`keep`    |![][after08]
![][before]|`:2,5J "# " rk`<br/>Join with:<br/>`range`<br/>`sep`<br/>`keep`<br/>`reverse`|![][after09]
![][before]|`:5,7J 3`<br/>Join with:<br/>`range`<br/>`count`                             |![][after10]
![][before]|`:5,7J -3`<br/>Join with:<br/>`range`<br/>negative `count`                   |![][after11]


[before]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_before.png
[after01]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_01after.png
[after02]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_02after.png
[after03]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_03after.png
[after04]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_04after.png
[after05]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_05after.png
[after06]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_06after.png
[after07]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_07after.png
[after08]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_08after.png
[after09]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_09after.png
[after10]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_10after.png
[after11]: https://raw.github.com/sk1418/sharedResources/master/Join/Join_11after.png

 vim: ft=markdown sw=2 ts=2 fdm=marker expandtab
