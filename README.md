Before Compilation: 
Make sure to install nasm before typing to compile it. So for example, in Ubuntu you just have to type "sudo apt-get install nasm" into your terminal

Downloading, Compilation and Running (if you wish to compile yourself):
1) Download and move the calculator.asm file to wherever you want.
2) Go to that directory in your terminal.
3) Use the command "nasm -f elf64 -g -o calculator.o calculator.asm".
4) Then use teh command "ld -o calculator calculator.o".
6) Then to run the calculator you can then just type "./calculator" in the same directory you compiled the program inside.

Download and Running (If you don't care to compile it):
1) Download the "calulator" file in this repository.
2) Move that file to wherever you want.
3) Then run it with "./calulator" in the terminal while in the directory you moved the "calulator" file to.
