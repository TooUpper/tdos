# tdos

## 环境配置
## win11 开启 WSL2

1. `win`后键入`启用或关闭 windows 功能`在弹窗中分别勾选`Hyper-V`、`适用于 Linux 的 windows 子系统`、`虚拟机平台`点击`确认`；等待重启后启用。
2. 安装 WSL [内核升级包](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)；傻瓜下一步就好了。
3. 设置 WSL2；在 终端中键入`wsl --set-default-version 2`
4. 这里建议再次更新一下`WSL2`以防后面出现不必要的错误；键入`wsl.exe --update`。

##  wsl2 并安装 arch

1. 在商店(`Microsoft Store`)中下载Linux子系统，我这里用的是`ArchLinux`；直接在商店中搜索`arch`下载。
2. 下载完成后不要直接打开；`win`后搜索`arch`然后点击`以管理员身份运行`。(这里如果安装的是其他`linux`子系统搜索对应的子系统,以管理员身份打开)
3. 设置`username`和`Password`即可。

## OS环境配置 

### 配置国内镜像

1. 下载文本编辑器`sudo pacman -S neovim`

2. 打开配置文件`sudovim /etc/pacman.conf`

3. 尾部添加

   ```shell
   [archlinuxcn]
   SigLevel = Never
   Server = https://mirrors.ustc.edu.cn/$repo/$arch
   
   # 顺便开启 (找到这两行删掉前面的 # 即可)
   [multilib]
   Include = /etc/pacman.d/mirrorlist
   
   # 检查更新
   sudo pacman -Syyu
   ```

### 安装 Rust 工具链

1. `curl https://sh.rustup.rs -sSf | sh`;提示都默认`1`即可。

2. `rustc --version`确认下是否安装成功

3. 安装 rustc 的 nightly 版本，并把该版本设置为 rustc 的缺省版本

   ```shell
   rustup install nightly
   rustup default nightly
   ```

4. 设置`cargo`国内源；打开（如果没有就新建） `~/.cargo/config` 文件，并把内容修改为：

   ```shell
   [source.crates-io]
   registry = "https://github.com/rust-lang/crates.io-index"
   replace-with = 'ustc'
   [source.ustc]
   registry = "git://mirrors.ustc.edu.cn/crates.io-index"
   ```

5. 安装一些Rust相关的软件包

   ```shell
   rustup target add riscv64gc-unknown-none-elf
   cargo install cargo-binutils
   rustup component add llvm-tools-preview
   rustup component add rust-src
   ```

### 安装 QEMU 模拟器

1. `sudo pacman -S qemu`;第一个提示中提示中选择`3`，第二个提示默认`1`即可

2. 确认 QEMU 的版本

   ```rust
   qemu-system-riscv64 --version
   qemu-riscv64 --version
   ```

3. 在 [GitHub]() 上下载最新的 rustsbi-qemu-bin 文件

### 安装 RISCV 工具集

```shell
git clone https://github.com/riscv/riscv-gnu-toolchain

cd riscv-gnu-toolchain

./configure --prefix=/home/kay/tools/riscv-gnu-toolchain
# '/home/kay/tools/riscv-gnu-toolchain' 是一个安装目录

# riscv-gnu-toolchain 目录下
make

make install

# 添加环境变量
# 编辑 .bashrc 文件，添加：
export PATH=/path/to/installation/directory/bin:$PATH

# 刷新
source ./barshrc
```

### 安装 cargo-binutils  工具集

```rust
cargo install cargo-binutils
rustup component add llvm-tools-preview
```



## QEMU 中运行 rCore

此处安装 classroom 中操作即可

## 解疑

### 网络问题

### make run 之后出错

如图：

![image-rcore2](/image/RISC-V/rcore/rcore2.png)

解决：

下载[rustsbi-qemu](https://github.com/rustsbi/rustsbi-qemu/releases/tag/Unreleased)用压缩包中的`rustsbi-qemu.bin`替换项目bootloader目录下的`rustsbi-qemu.bin`即可。


