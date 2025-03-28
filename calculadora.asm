section .data
    Primeiro dq 'Digite o primeiro digito:', 10
    TamPrimeiro equ $-Primeiro
    Operacao dq 'Digite a operacao', 10
    TamOperacao equ $-Operacao
    Segundo dq 'Digite o segundo digito', 10
    TamSegundo equ $-Segundo

    QuebraLinha dq '',10
    TamQuebraLinha equ $-QuebraLinha

    Errodiv dq 'Erro: Divisão por zero... Programa Encerrado.',10
    TamErro equ $-Errodiv

    digitoum dq 0
    digitodois dq 0
    digitoope dq '/'
    resultado dq 0
    resultadoparcial dq 0
    dez dq 10

    TamEntrada equ 4
section .bss
    Entrada resb TamEntrada
section .text

global _start

_start:
    ;Pede primeiro
    mov rax, 1
    mov rdi, 1
    mov rsi, Primeiro
    mov rdx, TamPrimeiro
    syscall

    ;Recebe primeiro
    mov rax, 0
    mov rdi, 0
    mov rsi, Entrada
    mov rdx, TamEntrada
    syscall

    ;armazena primeiro
    movzx rax, byte[Entrada]
    sub rax, '0'
    mov qword[digitoum], rax

    ;Pede segundo
    mov rax, 1
    mov rdi, 1
    mov rsi, Segundo
    mov rdx, TamSegundo
    syscall

    ;Recebe segundo
    mov rax, 0
    mov rdi, 0
    mov rsi, Entrada
    mov rdx, TamEntrada
    syscall

    ;armazena segundo
    movzx rax, byte[Entrada]
    sub rax, '0'
    mov qword[digitodois], rax

    ;Pede operacao
    mov rax, 1
    mov rdi, 1
    mov rsi, Operacao
    mov rdx, TamOperacao
    syscall

    ;Recebe operacao
    mov rax, 0
    mov rdi, 0
    mov rsi, Entrada
    mov rdx, TamEntrada
    syscall

    ;armazena operacao
    movzx rax, byte[Entrada]
    mov qword[digitoope], rax

    ;----------------------------------------------------------
    cmp qword[digitoope], '+'
    je soma
    cmp qword[digitoope], '-'
    je subtrai
    cmp qword[digitoope], '*'
    je multiplica
    cmp qword[digitoope], '/'
    je divide
    
    soma:
    mov rax, qword[digitoum]
    add rax, qword[digitodois]
    mov qword[resultado], rax 
    jmp converte

    subtrai:
    mov rax, qword[digitoum]
    sub rax, qword[digitodois]
    mov qword[resultado], rax 
    jmp converte

    multiplica:
    mov rax, qword[digitoum]
    mul qword[digitodois]
    mov qword[resultado], rax 
    jmp converte

    divide:
    cmp qword[digitodois], 0
    je errodivisaozero

    mov rdx, 0
    mov rax, qword[digitoum]
    div rax, qword[digitodois]
    mov qword[resultado], rax
    jmp converte

converte:
    cmp qword[resultado],10
    jge doisdigito

umdigito:
    mov rax, qword[resultado]
    add rax, '0'
    mov qword[resultado], rax

    mov rax, 1
    mov rdi, 1
    mov rsi, resultado
    mov rdx, 1
    syscall

    jmp last

doisdigito:
    mov rdx, 0
    mov rax, qword[resultado]
    div rax, qword[dez]
    add rax, '0'
    mov qword[resultadoparcial], rax

    mov rax, 1
    mov rdi, 1
    mov rsi, resultadoparcial
    mov rdx, 1
    syscall

    mov rax, qword[resultadoparcial]
    sub rax, '0'
    mov qword[resultadoparcial], rax

    mov rax, qword[resultadoparcial]
    mul qword[dez]
    mov qword[resultadoparcial], rax
    mov rax, qword[resultado]
    sub rax, qword[resultadoparcial]
    mov qword[resultado], rax
    jmp umdigito

last:
    mov rax, 1
    mov rdi, 1
    mov rsi, QuebraLinha
    mov rdx, TamQuebraLinha
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall

errodivisaozero:
    mov rax, 1
    mov rdi, 1
    mov rsi, Errodiv
    mov rdx, TamErro
    syscall

    mov rax, 60
    mov rdi, 0
    syscall