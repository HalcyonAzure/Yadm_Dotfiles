# Yadm Dotfiles

## 使用说明

该仓库的主要用途为使用`yadm`作为管理工具，通过`Github`来同步自己的`Dotfiles`

1. 先在自己当前环境下安装`yadm`，具体安装说明参照[Installation](https://yadm.io/docs/install)

2. 通过`Fork`或者下载源码的方式，创建并上传到自己的一个仓库中，最好是`Private`类型

3. 在本身没有经过配置`Dotfiles`的环境下（或提前备份好自己的`Dotfiles`）输入以下指令拉取模板到本地进行管理

   ```shell
   yadm clone https://github.com/<your id>/<your repository> --bootstrap
   ```

4. 在附带`--boostrap`的情况下执行完毕上述指令以后将会按默认模板文件使用`git`来对自己的`Dotfiles`进行管理

---

## 模板介绍

### Bootstrap

在`clone`仓库的时候如果附带了`bootstrap`将会自动执行以下三件事

* 在以 `apt/yum/pacman` 作为包管理器的情况下安装`zsh vim tmux curl wget openssl`
* 安装 `oh-my-zsh`，并以`p10k`为主题。安装`zsh-autosuggestions`,`zsh-syntax-highlighting`和`zsh-proxy`三个插件
* 切换 `zsh` 为当前用户的默认终端

### 配置文件

#### .ssh/config

* 取消了域名指纹检查，不需要输入yes同意首次链接

#### .zshrc

* 配置了`rust`国内镜像
* 添加了[transfer](https://transfer.sh/)用于分享文件
* 使用`pws`作为`powershell.exe`的`alias`，便于`wsl`环境下使用`powershell`
* 启用了`vi`的normal模式，在输入命令的时候按`Esc`即可

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
