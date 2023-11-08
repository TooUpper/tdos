.section .text.entry                # 进入.text段，这是代码段
    .globl _start                   # 声明全局标号 _start，程序入口点
_start:                             # _start标号
    la sp, boot_stack_top           # 将栈指针(sp)设置为boot_stack_top的地址
    call rust_main                  # 调用rust_main函数

.section .bss.stack                 # 进入.bss.stack段，这是未初始化数据段
    .globl boot_stack_lower_bound   # 声明全局标号 boot_stack_lower_bound
boot_stack_lower_bound:             # boot_stack_lower_bound标号
    .space 4096 * 16                # 分配16个页面大小的栈空间
    .globl boot_stack_top           # 声明全局标号 boot_stack_top
boot_stack_top:                     # boot_stack_top标号