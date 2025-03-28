section .data
    Pergunta dq 'Digite um numero de 1 a 9', 10
    TamPerg equ $-Pergunta
    Primo dq 'E primo', 10
    TamPrimo equ $-Primo
    NPrimo dq 'Nao e primo', 10
    TamNaoPrimo equ $-NPrimo

section .bss
    Numero resb 2

section .text
global _start

_start:
    jmp input

naoPrimo:
    mov rax, 1
    mov rdi, 1
    mov rsi, NPrimo
    mov rdx, TamNaoPrimo
    syscall
    jmp last

input:
    ; Exibir mensagem de entrada
    mov rax, 1
    mov rdi, 1
    mov rsi, Pergunta
    mov rdx, TamPerg
    syscall

    ; Ler número do usuário
    mov rax, 0
    mov rdi, 0
    mov rsi, Numero
    mov rdx, 2
    syscall

    ; Converter de ASCII para número
    movzx rcx, byte [Numero]
    sub rcx, 48

enquanto:
    cmp rcx, 1
    je eprimo
    mov rdx, 0
    mov rax, rcx
    div rcx
    cmp rdx, 0
    je naoPrimo
    loop enquanto

eprimo:
    mov rax, 1
    mov rdi, 1
    mov rsi, Primo
    mov rdx, TamPrimo
    syscall

last:
    mov rax, 60
    mov rdi, 0
    syscall