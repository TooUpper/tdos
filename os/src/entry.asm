    .section .text.entry # 定义一个结点 .text 并指定为 entry(标识入口)
    .globl _start # 定义一个全局符号 _start
_start:
    la sp, boot_stack_top
    call main

    .section .bss.stack
    .globl boot_stack_lower_bound
boot_stack_lower_bound:
    .space 4096 * 16
    .globl boot_stack_top
boot_stack_top: