%macro MacroLenFind 1
  xor al, al
  mov rcx, -1
  mov rdi, %1
  cld
  repnz scasb
  mov r9, -2
  sub r9, rcx
  mov rcx, r9
%endmacro

section .data
  wordP db "ABBA", 0
  tr db "Palindrome", 0
  fl db "NOT Palindrome", 0

section .text
  global _start:
_start:
  MacroLenFind wordP
  ; in rcx now have len

  ; loop to push the string on a stack
  xor rdi, rdi
  mov rdi, wordP
.loopStack:
  mov al, byte [rdi]
  push rax
  inc rdi
  loop .loopStack

  ; now loop to check if word is a palindrome
  xor rdi, rdi
  mov rdi, wordP
  mov rcx, r9

.loopCheck:
  pop rax
  mov r8b, byte [rdi] ; !!!!
  cmp rax, r8
  jne _fls
  inc rdi
  loop .loopCheck
  jmp _true


_true:
  ; find a len of a string
  MacroLenFind tr
  ; syscall for writing into the console
  mov rax, 1
  mov rdi, 1
  mov rsi, tr
  mov rdx, rcx
  syscall
  jmp _end

_fls:
  ; find a length of a string using scasb
  MacroLenFind fl
  ; syscall for writting into the console
  mov rax, 1
  mov rdi, 1
  mov rsi, fl
  mov rdx, rcx
  syscall
  jmp _end


_end:
  ; syscalll for leaving the program
  xor rbx, rbx
  mov rax, 60
  syscall
