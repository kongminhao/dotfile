#!/bin/bash
# check sys
release=''
systemPackage=''
check_sys(){
    release=''
    systemPackage=''

    if [[ -f /etc/redhat-release ]]; then
        release="centos"
        systemPackage="yum"
    elif grep -Eqi "debian|raspbian" /etc/issue; then
        release="debian"
        systemPackage="apt"
    elif grep -Eqi "ubuntu" /etc/issue; then
        release="ubuntu"
        systemPackage="apt"
    elif grep -Eqi "centos|red hat|redhat" /etc/issue; then
        release="centos"
        systemPackage="yum"
    elif grep -Eqi "debian|raspbian" /proc/version; then
        release="debian"
        systemPackage="apt"
    elif grep -Eqi "ubuntu" /proc/version; then
        release="ubuntu"
        systemPackage="apt"
    elif grep -Eqi "centos|red hat|redhat" /proc/version; then
        release="centos"
        systemPackage="yum"
    fi
}
create_cb_script(){
    if type nc >/dev/null 2>&1; then 
        echo "nc exist"
    else 
        if [[ $release -eq 'centos' ]]; then
            sudo yum install nc -y
        else
            sudo $systemPackage install netcat -y
        fi
    fi
    sudo echo 'nc -q0 localhost 5556' > /usr/bin/cb
    chmod +x /usr/bin/cb
}
check_sys
create_cb_script
echo $release
echo $systemPackage

set_color() {
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"

    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi
}

pre_install(){
    pre_command=$1
    if type $pre_command >/dev/null 2>&1; then 
        return 
    else 
        sudo $systemPackage install $pre_command -y
    fi
}
base_install(){
    sudo $systemPackage update -y
    sudo $systemPackage install curl -y
    sudo $systemPackage install wget -y
    sudo $systemPackage install git -y
    sudo $systemPackage install openssh-server -y
    curl -sL https://getcaddy.com | bash -s personal
}
docker_install(){
    pre_install curl
    curl -fsSL https://get.docker.com -o /tmp/docker.sh
    sudo bash /tmp/docker.sh --mirror Aliyun
    sudo usermod -aG docker $USER
    if [ ! -d /etc/docker]; then
        mkdir /etc/docker
    fi
    sudo echo '{\n"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]\n}' > /etc/docker/daemon.json
    printf "${BLUE} set docker mirror.."
}
tmux_install(){
    if [[ $release -eq 'centos' ]]; then
        sudo $systemPackage install epel-release -y
        sudo $systemPackage update -y 
    fi
    echo "tmux"
    sudo $systemPackage install tmux -y
    curl -fsSL https://raw.githubusercontent.com/kongminhao/dotfile/master/tmux.conf -o ~/.tmux.conf
    echo "tmux done"
}
zsh_install(){
    pre_install git
    pre_install wget
    echo "oh-my-zsh"
    sudo $systemPackage install zsh figlet -y
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/kongminhao/dotfile/master/zshrc -o /tmp/zshrc
    sed -i "s@HOMEDIR@$HOME@g" /tmp/zshrc
    mv /tmp/zshrc ~/.zshrc
    chsh -s /bin/zsh
}
proxychains4_install(){
    pre_install git
    pre_install gcc
    pre_install make
    cd /tmp
    git clone --depth=1 https://github.com/rofl0r/proxychains-ng.git
    cd proxychains-ng
    ./configure --prefix=/usr --sysconfdir=/etc
    make
    sudo make install
    sudo make install-config
    # delete proxychains.conf last 2 line
    sed '$d' -i /etc/proxychains.conf
    sed '$d' -i /etc/proxychains.conf
    echo "socks5 127.0.0.1 1080 " >>/etc/proxychains.conf
    cd
}
vim_install(){
    pre_install git
    sudo $systemPackage install vim -y
    curl -fsSL https://raw.githubusercontent.com/kongminhao/dotfile/master/vimrc -o ~/.vimrc
    vim -c 'PlugInstall' -c 'qa!'
}
pip_install(){
    sudo $systemPackage install python3-pip
    mkdir -p ~/.config/pip/ && echo "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple"> ~/.config/pip/pip.conf
    printf "${BLUE} set pip mirror"
    sudo pip3 install requests docker-compose # I don't use ipython, so go away
}
install_all(){
    base_install
    docker_install
    tmux_install
    zsh_install # zsh install 必须在vim之前
    vim_install
    # pip_install # i think this will be a huge bug, so temp annotation
    proxychains4_install
    env zsh -l
}
# 添加颜色
# set_color
printf "${GREEN} $#\n"
if [ $# -eq 0 ]
then
    printf "${BLUE}base,proxychains4,vim,zsh,tmux,docker,base_pip,all\n"
    exit
fi

for cmd in $@
do
    case $cmd in
    
        "base")
            base_install
            ;;

        "vim")
            vim_install
            ;;

        "zsh")
            zsh_install
            ;;

        "tmux")
            tmux_install
            ;;

        "docker")
            docker_install
            ;;

        "proxychains4")
            proxychains4_install
            ;;

        "pip")
            pip_install
            ;;
        "base_pip")
            sudo pip3 install requests docker-compose ipython jupyter
            ;;
        "all")
            install_all
            ;;

        esac

    done
    echo "All done"
