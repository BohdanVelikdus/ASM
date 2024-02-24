section .data
  arr dw 200, 321, 124, 575, 102, 154, 390, 100

section .text
  global _start

_start:
  mov rcx, 7

_loop:
  ; clear registers
  xor rax, rax
  xor r8, r8

  mov ax, word [arr + rcx * 2]
  mov r8, 0
_innerLoop:
  mov dx, word [arr + r8 * 2]

  cmp ax, dx
  ja _anotherIter

  ; swap func
  mov word [arr + rcx * 2], dx
  mov word [arr + r8 * 2], ax
  xor rax, rax
  mov ax, [arr + rcx * 2]

_anotherIter:
  inc r8
  cmp r8, rcx
  jb _innerLoop

; outer loop
  loop _loop

  ;syscall for end
  xor rax, rax
  xor rbx, rbx
  mov rax, 60
  syscall
