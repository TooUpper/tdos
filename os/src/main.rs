#![feature(panic_info_message)]
#![no_std]  // 移除 std 标准库转而使用核心库 core。
#![no_main] // 移除 main() 函数，取消执行前的初始化工作。
#[macro_use]

// 引用模块。
mod console;
mod lang_items;
mod sbi;


use core::arch::global_asm;
global_asm!(include_str!("entry.asm"));

#[no_mangle]
pub fn rust_main() -> ! {
    clear_bss(); // 对 .bss 段清零
    println!("Hello, world!");
    panic!("Shutdown machine!");
}

fn clear_bss() {
    extern "C" {
        // 由链接脚本 linker.ld 给出，并分别指出需要被清零的 .bss 段的起始和终止地址
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| {
        unsafe { (a as *mut u8).write_volatile(0) } // 将它指向的值修改为 0
    });
}
