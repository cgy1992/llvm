; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefixes=X64

define i32 @pr32690(i32) {
; X86-LABEL: pr32690:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    addl $63, %ecx
; X86-NEXT:    setb %al
; X86-NEXT:    shldl $26, %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: pr32690:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    addq $63, %rax
; X64-NEXT:    shrq $6, %rax
; X64-NEXT:    # kill: def %eax killed %eax killed %rax
; X64-NEXT:    retq
  %2 = zext i32 %0 to i64
  %3 = add nuw nsw i64 %2, 63
  %4 = lshr i64 %3, 6
  %5 = trunc i64 %4 to i32
  ret i32 %5
}