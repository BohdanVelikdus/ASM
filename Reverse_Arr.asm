  arr db 6, 3, 12, 5, 9
  len db 5

section .text
  global _start

_start:
  xor rcx, rcx
  mov rcx, [len]
  lea rdx, [arr]

; push all elements to stack
.loopPushStack:
  push qword [rdx]
  inc rdx
  loop .loopPushStack


  lea rdx, [arr]
  mov rcx, [len]
.loopChange:
  pop qword rax
  mov [rdx], al
  inc rdx
  loop .loopChange

  xor rbx, rbx
  mov rax, 60
  syscall
