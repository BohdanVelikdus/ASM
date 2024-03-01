section .data
  msg db "Not equal", 0
  len equ $ - msg
  msg2 db "Equal", 0
  len2 db $ - msg2
  ts dd 0.1
  zero dd 0.0
  one dd 1.0


section .text
  global _start

_start:
  movss xmm0,  [zero]
  mov rcx, 10
.loop:
  addss xmm0, [ts]
  loop .loop

  movss xmm1, [one]

  ucomiss xmm0, xmm1
  jne .not
  je .yes

.not:
  xor rax, 1
  mov rdi, 1
  mov rdx, len
  mov rsi, msg
  syscall
  jmp _end

.yes:
  xor rax, 1
  mov rdi, 1
  mov rdx, len2
  mov rsi, msg2
  syscall
  jmp _end

global _end
_end:
  mov rax, 60
  xor rbx, rbx
  syscall
