(!WARNING!): This code currently doesn't work, this warning will be removed when it's fixed

Before Compilation: Make sure to install nasm before typing to compile it. 

Compilation and running:
1) Move the calculator.asm file to wherever you want.
2) Go to that directory in your terminal.
3) Use the command "nasm -f elf64 -g -o calculator.o calculator.asm".
4) Then use teh command "ld -o calculator calculator.o". 
5) Then to run the calculator you can then just type "./calculator" in the same directory you compiled the program inside. 
