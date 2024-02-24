section .data
  year dw 1024
  resTrue db "The year is leap",0
  lenTrue equ $ - resTrue
  resFalse db "The year is NOT leap", 0
  lenFalse equ $ - resFalse

section .text
  global _start

_start:
  mov ax, word [year]
  mov bx, 4
  xor dx, dx
  div bx
  cmp dx, 0
  jne _falseC

  xor rax, rax
  xor rdx, rdx
  xor rbx, rbx

  mov ax, word [year]
  mov bx, 100
  xor dx, dx
  div bx
  cmp dx, 0
  je _falseC

  xor rax, rax
  xor rdi, rdi
  xor rsi, rsi
  xor rdx, rdx

  mov rax, 1
  mov rdi, 1
  mov rsi, resTrue
  mov rdx, lenTrue
  syscall

  xor rax, rax
  xor rbx, rbx

  mov rax, 60
  syscall

global _falseC
_falseC:
  xor rax, rax
  xor rdi, rdi
  xor rsi, rsi
  xor rdx, rdx

  mov rax, 1
  mov rdi, 1
  mov rsi, resFalse
  mov rdx, lenFalse
  syscall

  xor rax, rax
  xor rbx, rbx

  mov rax, 60
  syscall
