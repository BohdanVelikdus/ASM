section .data
  NULL equ 0

  num1 dw 0
  num2 dw 1
  iter dw 7
  ; text for printing
  msg db "The result is:", NULL
  len equ $ - msg
  ; buffer for output
  buff db 10 dup(0)


section .text
  global _start

global _fisrt
_first:
  ;syscall for printing
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, len
  syscall

  ; clean registers
  xor rax, rax
  xor rdi, rdi
  xor rcx, rcx

  ; convert a number to a string
  mov cx, 10
  mov ax,  [num1]
  lea rdi, [buff+9]
  mov byte [rdi], 0

_exch:
  xor dx, dx
  div cx
  add dl, '0'
  dec rdi
  mov byte [rdi], dl
  test ax, ax
  jne _exch

  ; clean registers
  xor rax, rax
  xor rdi, rdi
  xor rsi, rsi
  xor rdx, rdx

  ; syscall for printing
  mov rax, 1
  mov rdi, 1
  mov rsi, buff
  mov rdx, 10
  syscall

  ;clear registers
  xor rax, rax
  xor rdi, rdi

  ; exit program
  mov rax, 60
  mov rdi, 0
  syscall

global _second
_second:
  ;syscall for printing
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, len
  syscall

  ; clean registers
  xor rax, rax
  xor rdi, rdi
  xor rcx, rcx

  ; convert a number to a string
  mov cx, 10
  mov ax,  [num2]
  lea rdi, [buff+9]
  mov byte [rdi], 0

_exch1:
  xor dx, dx
  div cx
  add dl, '0'
  dec rdi
  mov byte [rdi], dl
  test ax, ax
  jne _exch1

  ; clean registers
  xor rax, rax
  xor rdi, rdi
  xor rsi, rsi
  xor rdx, rdx

  ; syscall for printing
  mov rax, 1
  mov rdi, 1
  mov rsi, buff
  mov rdx, 10
  syscall

  ;clear registers
  xor rax, rax
  xor rdi, rdi

  ; exit program
  mov rax, 60
  mov rdi, 0
  syscall

_start:
  mov ax, [iter]
  cmp ax, 1
  je _first
  cmp ax, 2
  je _second
  sub ax, 2
  mov cx, ax
  je _loop

global _loop
_loop:
  mov al, [num1]
  mov bl, [num2]
  mov dl, [num2]
  mov byte [num1], dl
  add bl, al
  mov byte [num2], bl
  loop _loop
  ; clear regs
  xor rax, rax
  xor rbx, rbx
  xor rdx,rdx
  jmp _second

