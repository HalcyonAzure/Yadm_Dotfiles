# Yadm Dotfiles

## 使用说明

该仓库的主要用途为使用`yadm`作为管理工具，通过`Github`来同步自己的`Dotfiles`

1. 先在自己当前环境下安装`yadm`，具体安装说明参照[Installation](https://yadm.io/docs/install)

2. 通过`Use this template`或者下载源码的方式，创建并上传到自己的一个仓库中，最好是`Private`类型

3. 在本身没有经过配置`Dotfiles`的环境下（或提前备份好自己的`Dotfiles`）输入以下指令拉取模板到本地进行管理

   ```shell
   yadm clone https://github.com/<your id>/<your repository> --bootstrap
   ```

4. 在附带`--boostrap`的情况下执行完毕上述指令以后将会按默认模板文件使用`git`来对自己的`Dotfiles`进行管理

---

## 模板介绍

### Bootstrap

在`clone`仓库的时候如果附带了`bootstrap`将会自动执行以下三件事

* 安装以下应用
   * `zsh`: 作为默认终端
   * `tldr`: 用于快速查看命令的使用方法
   * `vim`: 作为默认编辑器
   * `tmux`: 用于多窗口管理
   * `curl, wget`: 用于网络请求
   * `openssl`: 用于加密
   * `build-essential, gdb`: 用于编译
   * `python3, python3-pip`: 用于python开发

* 切换 `zsh` 为当前用户的默认终端

* 安装 `oh-my-zsh`，以`p10k`为主题，并启用了以下插件：

   * `direnv`: 用于自动加载`.envrc`文件
   * `z`: 用于快速跳转到指定目录
   * `git`: 用于显示当前git仓库的状态
   * `tmux`: 用于在tmux中显示当前会话的状态
   * `sudo`: 用于在命令前自动添加sudo
   * `colorize`: 用于显示颜色
   * `extract`: 用于解压缩文件
   * `docker`: 用于docker的指令缩写
   * `docker-compose`: 用于docker-compose的指令缩写
   * `command-not-found`: 用于提示未安装的命令
   * `zsh-proxy`: 用于代理设置
   * `zsh-autosuggestions`: 用于补全历史命令
   * `zsh-autocomplete`: 用于提示命令
   * `zsh-syntax-highlighting`: 用于高亮命令

### 配置文件

#### .ssh/config

* 取消了域名指纹检查，不需要输入yes同意首次链接

#### .zshrc

* 配置了`rust`国内镜像
* 添加了[transfer](https://transfer.sh/)用于分享文件
* 使用`pws`作为`powershell.exe`的`alias`，便于`wsl`环境下使用`powershell`

#### .vimrc

* 参考[missing-semster](https://missing-semester-cn.github.io/2020/editors/)
* 为了便于作为`wsl`环境使用，在`Windows Terminal`下复制粘贴，关闭了鼠标功能

#### .cargo

* 配置好了`cargo`镜像库

### gitconfig

* 配置默认使用`~/.gitignore作为全局`ignore`文件
* 在使用`https`时的验证交由`.git-credentials`文件纯文本保存密码（有风险，可加密）

### 加密使用

对于类似`.ssh/id_rsa`或者`.git-credentials`文件可以通过`yadm`自带的`encrypt`工具进行加密，使用步骤如下

1. 在`.config/yadm/encrypt`文件内写入需要加密的文件路径，支持正则匹配

2. 假设在`.ssh/`目录下所有文件(例如`config, id_rsa`)都需要进行加密，则在`.config/yadm/encrypt`写入`.ssh/*`后输入以下指令(安装openssl为前提)

   ```shell
   yadm encrypt
   ```

   则会要求输入一个密码来进行加密

3. 加密完则会在`.local/share/yadm`目录下产生一个`archive`作为加密打包后的文件，将该文件添加并上传到`Github`
   > 虽然加密文件本身有一定安全性，但为了保险起见还是推荐使用`Private`仓库来存储自己的`Dotfiles`

   ```shell
   yadm add ~/.local/share/yadm/archive
   yadm commit -m "add encrypt archive"
   yadm push
   ```

   原本的文件此时将会依旧本地存在于(例如`config, id_rsa`)，但不需要上传到`Github`当中

4. 在下次重装系统/更换环境的时候，如果需要通过`yadm`对环境进行复原并解密加密文件，则只需要输入以下指令

   ```shell
   yadm decrypt
   ```

   就会将加密打包的文件解密到对应的文件目录，保证一定的安全性
