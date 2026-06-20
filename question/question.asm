;=====================================================================
;
;Pascal LEVALLOIS 2026-06-20
;
; LGPL LICENCE  3.0
;
;===================================================================== 


section .data
    question db "Quel est votre prénom ? ", 0
    question_len equ $ - question

    display db "Vous avez répondu : ", 0
    display_len equ $ - display

    crlf db 10

section .bss
    reponse resb 50  ; reserves 50 bytes for the response

section .text
    global _start

_start:
    ; Display question
    mov rax, 1          	; sys_write (numéro 1)
    mov rdi, 1          	; file descriptor : stdout (1)
    mov rsi, question   	; string address to be displayed
    mov rdx, question_len 	; string length
    syscall

    ; Read user response
    mov rax, 0          	; sys_read (numéro 0)
    mov rdi, 0          	; file descriptor : stdin (0)
    mov rsi, reponse    	; memory address to store the string
    mov rdx, 50         	; maximum number of bytes to read
    syscall

    ; Display "Vous avez répondu : "
    mov rax, 1          	; sys_write
    mov rdi, 1          	; stdout
    mov rsi, display    	; string addresss to be displayed
    mov rdx, display_len 	; string length
    syscall

    ; Display response
    mov rax, 1          	; sys_write
    mov rdi, 1          	; stdout
    mov rsi, reponse    	; response address
    mov rdx, 50         	; max number of bytes to read
    syscall

    ; Display crlf
    mov rax, 1          	; sys_write
    mov rdi, 1          	; stdout
    mov rsi, crlf 		; crlf address
    mov rdx, 1          	; crlf length
    syscall

    ; End pgm
    mov rax, 60         	; sys_exit (numéro 60)
    xor rdi, rdi        	; exit code 0
    syscall

