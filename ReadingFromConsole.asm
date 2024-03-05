section .data
  ; define the necessary constant
  LF equ 10
  NULL equ 0
  TRUE equ 1
  FALSE equ 0
  ; for rbx register
  EXIT_SUCCESS equ 0

  ; -----------------------------
  ; for syscall reading frome the console:
  ; mov rax, 0
  ; mov rdi, 0 (file descriptor for reading from console)
  ; mov rsi, buff
  ; mov rdx, len (count of characters)
  STDIN equ 0

  ; -----------------------------
  ; for syscall for writing to the console:
  ; mov rax, 1
  ; mov rdi, 1 (file descriptor for writing into console)
  ; mov rsi, buff
  ; mov rdx, len (count of characters)
  STDOUT equ 1
  ; ~~~
  SRDERR equ 2

  SYS_read equ 0
  SYS_write equ 1
  SYS_open equ 2
  SYS_close equ 3
  SYS_fork equ 57
  SYS_exit equ 60
  SYS_create equ 85
  SYS_time equ 201
  ; how much chars we have to read
  STRLEN equ 50

  pmpt db "Enter Text: ", NULL
  newLine db LF, NULL

section .bss
  ; hold a space for char in memory
  chr resb 1

  ; reserve buffer for a read string (50 + 2)
  inLine resb STRLEN+2

section .text
  global _start
_start:
  ; display prompt
  mov rdi, pmpt
  call printString

  ; read char from user( one at time)

  ; we move a address of inLine into the rbx
  mov rbx, inLine
  mov r12, 0
readCharacters:
  ; syscall for reading char is stored inside the [chr] memory index
  mov rax, SYS_read
  mov rdi, STDIN
  lea rsi, byte [chr]
  mov rdx, 1
  syscall
  ; check if we get the "enter" key pressed. If pressed, we end reading
  mov al, byte [chr]
  cmp al, LF
  je readDone

  ; incrementing r12 and compare if we already read a 50 chars
  inc r12
  cmp r12, STRLEN
  jae readCharacters

  ; write inside the memory char, and move to another cell of memory
  mov byte [rbx], al
  inc rbx

  jmp readCharacters
readDone:
  ; make the string null-terminated
  mov byte [rbx], NULL

  ; make a syscall to write our string to buffer
  mov rdi, inLine
  call printString

;---------------------------------------------
; syscall for ending
exampleDone:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall

; ----------------------------------------------
; global function to write to a console
global printString
printString:
  ; save internals of the rbx register
  push rbx

  ; example of finding out the length of a given string inside rbx
  mov rbx, rdi
  mov rdx, 0
strCountLoop:
  cmp byte [rbx], NULL
  je strCountDone
  inc rdx
  inc rbx
  jmp strCountLoop
strCountDone:
  cmp rdx, 0
  je prtDone

  mov rax, SYS_write
  mov rsi, rdi
  mov rdi, STDOUT
  syscall

; returning frome the function
; restoring the register`s insides
prtDone:
  pop rbx
  ret
