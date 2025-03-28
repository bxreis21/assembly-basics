section .data
    EXIT_SUCCESS equ 0
    SYS_exit equ 60
    pergunta db "Como vc se chama?",10 ;10 é o quebra de linha
    tamPerg EQU $-pergunta ;salva o tamnho da string

    ola db "ola, "
    tamOla EQU $-ola
    tamNome EQU 10

section .bss
    nome resb tamNome ;aloca um vetor chamado nome com 10 bytes para o nome que sera lido 
section .text
global _start
_start:

    ;imprimir mensagem como voce se chama
    mov rax,1
    mov rdi,1
    mov rsi, pergunta
    mov rdx, tamPerg
    syscall

    ;ler o nome do usuario
    mov rax, 0
    mov rdi, 0
    mov rsi, nome ;definido como vetor vazio
    mov rdx, tamNome
    syscall

    ;imprimir mensagem ola
    mov rax,1
    mov rdi,1
    mov rsi, ola
    mov rdx, tamOla
    syscall

    ;imprimir mensagem com o nome
    mov rax,1
    mov rdi,1
    mov rsi, nome
    mov rdx, tamNome
    syscall
last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall