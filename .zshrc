# Load Antigen (when antigen is installed using apt-get as the package manager).
# The script for zsh-antigen is located at /usr/share/zsh-antigen/antigen.zsh.
source /usr/share/zsh-antigen/antigen.zsh

# use oh-my-zsh
antigen use oh-my-zsh

# load omz built-in plugins
antigen bundle z
antigen bundle git
antigen bundle sudo
antigen bundle tmux
antigen bundle direnv
antigen bundle extract
antigen bundle colorize
antigen bundle command-not-found
antigen bundle docker-compose

# load extra plugins on github
antigen bundle sukkaw/zsh-proxy
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions

# syntax-highlighting must be the last plugin sourced.
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager
antigen bundle zsh-users/zsh-syntax-highlighting

# set zsh theme
antigen theme af-magic

# apply antigen
antigen apply

# format `time` command
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# Disable do you wish to see all x posibilities
# https://stackoverflow.com/a/69533208/19176002
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:man:*:*' menu select=long search

# set locale
export LC_ALL=C.UTF-8
export LANG=en_US.UTF-8

# rustup mirror
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# alias config
alias j=z

# transfer function
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>" >&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory" >&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip";(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://packets.zip/$file_name"|tee /dev/null;echo;else cat "$file"|curl --progress-bar --upload-file "-" "https://packets.zip/$file_name"|tee /dev/null;echo;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://packets.zip/$file_name"|tee /dev/null;echo;fi;}
