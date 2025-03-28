section .data
    penul dw 1
    ultim dw 1
    n dw 5
section .text
global _start

_start:
    mov cx, word[n]
    sub cx, 2

enquanto:
    mov ax, word[ultim]
    add ax, word[penul]
    mov word[penul], ax 
    mov word[ultim], ax

    loop enquanto

last:
    mov rax, 60
    mov rdi, 0
    syscall
