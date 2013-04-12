**Join** README file

		       __      _          __
		      / /___  (_)___     / /
		 __  / / __ \/ / __ \   / / 
		/ /_/ / /_/ / / / / /  /_/  
		\____/\____/_/_/ /_/  (_)  
		
	        -Do better Join in vim

##Join

**Join** provides more powerful line join features than the build-in `:join`.

##Features

Except for all features provided by the build-in `:join` command, **Join** can:

- **Join** lines with separator (string)
- **Join** lines with leading and trailing whitespaces trimmed
- **Join** lines with negative count (backwards join)
- **Join** lines in reverse
- **Join** lines and keep joined lines (without removing)
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


[before]: https://lh3.googleusercontent.com/-IXqp1V2h_HA/UWQCFc4bRAI/AAAAAAAAGxs/mqcm1khN1gU/s352/Join_before.png
[after01]: https://lh4.googleusercontent.com/-DqvfdX6MCiU/UWQCDsP5E7I/AAAAAAAAGxs/2WnuKdgC80M/s352/Join_01after.png
[after02]: https://lh4.googleusercontent.com/-hw8IC-YmIhE/UWQCDgj5wjI/AAAAAAAAGxs/ezX_2JTfIi4/s352/Join_02after.png
[after03]: https://lh3.googleusercontent.com/-7guzDaZG0w8/UWQCDnx04PI/AAAAAAAAGxs/2gf4vfUlgNo/s352/Join_03after.png
[after04]: https://lh4.googleusercontent.com/-1IJjBlWyESs/UWQCDy7cYQI/AAAAAAAAGxs/eySzhoe58SA/s352/Join_04after.png
[after05]: https://lh6.googleusercontent.com/-2Cf0bxmAQTo/UWQCECkBcXI/AAAAAAAAGxs/KtJW73eSvCs/s352/Join_05after.png
[after06]: https://lh4.googleusercontent.com/-x7oZd6beZzw/UWQCELjXSwI/AAAAAAAAGxs/dG7zZmXEUb0/s352/Join_06after.png
[after07]: https://lh3.googleusercontent.com/-72riJu4013M/UWQCErpQAII/AAAAAAAAGxs/TdVE93p6m4I/s352/Join_07after.png
[after08]: https://lh5.googleusercontent.com/-5G5cqY0uOp0/UWQCEmXmtTI/AAAAAAAAGxs/z7bE07FkhcU/s352/Join_08after.png
[after09]: https://lh6.googleusercontent.com/-LLHPh8cdWAI/UWQCEjf_34I/AAAAAAAAGxs/9obzpaHeS7c/s352/Join_09after.png
[after10]: https://lh3.googleusercontent.com/-NVj0xyquocE/UWQCFDTidPI/AAAAAAAAGxs/yesHmMVAfrk/s363/Join_10after.png
[after11]: https://lh4.googleusercontent.com/-xORvSXkcDl4/UWQCFTdqpYI/AAAAAAAAGxs/E_X6z9Ij7O4/s363/Join_11after.png

 vim:ft=markdown:sw=2:ts=2:fdm=marker:expandtab
