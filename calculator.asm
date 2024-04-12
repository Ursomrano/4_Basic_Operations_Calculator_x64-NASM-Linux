; macro that prints a message given the message and it's length
%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; macro that asks and gets input from the user given the variable the input will be assigned to,
; the message being printed, it's length and the register where the input will be stored
%macro get_val 4
    print %2,%3
    mov rax, 0
    mov rdi, 0
    mov rsi,%1
    mov rdx, 8
    syscall

    mov %4,[%1]

    ; clears the registers
    xor rax,rax
    xor rdi,rdi
    xor rsi,rsi
    xor rdx,rdx
%endmacro

; macro that converts a string to an integer given the register where the string is stored 
; (which is also where the resulting integer will be saved to)
%macro str_int 1
    xor rax,rax
    xor rcx,rcx
    xor r8,r8
    mov rdi,10

    ; removes the new line character
    mov rax,%1
    %%first_loop:
        shl rcx,8
        mov cl,al
        shr rax,8
        cmp al,10
        jne %%first_loop
    
    ; converts the string to an integer
    mov rsi,rcx
    mov rcx,1
    %%second_loop:
        mov al,sil
        sub al,48
        mul cl
        add r8,rax
        mov al,cl
        mul rdi
        mov cl,al
        shr rsi,8
        cmp rsi,0
        jne %%second_loop
    mov %1,r8
    
    ; clears the registers
    xor rax,rax
    xor rcx,rcx
    xor rdi,rdi
    xor rsi,rsi
    xor r8,r8
%endmacro

; macro that converts an integer to a string given the register where the integer is stored 
; (which is also where the resulting string will be stored) 
; and where the strings length will be stored
%macro int_str 2
    xor rax,rax
    xor rcx,rcx
    xor rsi,rsi
    mov rdi,10

    ; converts the integer to a string
    mov rax,%1
    %%loop:
        xor rdx, rdx
        shl rsi,8
        div rdi
        mov sil,dl
        add sil,48
        cmp rax,0
        jne %%loop
    
    ; gets the length of the string
    mov %1,rsi
    xor rdi,rdi
    %%length_loop:
        shr rsi,8
        inc rdi
        cmp rsi,0
        jne %%length_loop

    mov %2,rdi

    ; clears the registers
    xor rax,rax
    xor rcx,rcx
    xor rsi,rsi
    xor rdi,rdi
%endmacro

; delcares the message variables and their lengths
section .data
    intro db "Assembly Calculator", 10
    intro_len equ $-intro
    first_num_msg db "First number",58
    first_num_msg_len equ $-first_num_msg
    second_num_msg db "Second number",58
    second_num_msg_len equ $-second_num_msg
    operator_msg db "Operator (+,-,*,/)",58
    operator_len equ $-operator_msg
    result_msg db "Result",58
    result_len equ $-result_msg

; declares the input variables and their max length
section .bss
    first_num resb 8
    second_num resb 8
    operator resb 1

; starts the program
section .text
    global _start

; the actual code
_start:    
    print intro,intro_len
    get_val first_num,first_num_msg,first_num_msg_len,r9
    str_int r9
    get_val second_num,second_num_msg,second_num_msg_len,r10
    str_int r10
    get_val operator,operator_msg,operator_len,r11

    mov rax,10
    shl rax,8
    mov al,'+'
    cmp r11,rax
    je _add

    mov rax,10
    shl rax,8
    mov al,'-'
    cmp r11,rax
    je _sub

    mov rax,10
    shl rax,8
    mov al,'*'
    cmp r11,rax
    je _mul

    mov rax,10
    shl rax,8
    mov al,'/'
    cmp r11,rax
    je _div

; the function called when addition is the operation
_add:
    add r9, r10
    print result_msg,result_len
    int_str r9,r8
    print r9,r8
    jmp _end

; the function called when subtraction is the operation
_sub:
    sub r9, r10
    print result_msg,result_len
    int_str r9,r8
    print r9,r8
    jmp _end

; the function called when multiplication is the operation
_mul:
    mov rax, r9
    imul r10
    mov r9, rax
    print result_msg,result_len
    int_str r9,r8
    print r9,r8
    jmp _end

; the function called when division is the operation
_div:
    mov rax, r9
    idiv r10
    mov r9, rax
    print result_msg,result_len
    int_str r9,r8
    print r9,r8
    jmp _end

; exits the program
_end:
    mov rax, 60
    mov rdi, 0
    syscall
