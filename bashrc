# TODO
alias mygrep="grep -nr --color=auto"

# some more ls aliases
alias ls='ls --color=always'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

alias gs='git status -sb'
alias gss='git status'
alias gsw='git show --stat --oneline '
alias gck='git checkout'
alias gdf='git diff'
alias gdfs='git diff --name-only'

export LANG="en_US.UTF-8"

find_git_branch () 
{
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch=" | ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" | (detached)"
            else
                git_branch=" | (unknow)"
            fi
              return
        fi
        dir="../$dir"
    done
    git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

PS1='@ \[\033[01;33m\]\W\[\033[33m\]\[\033[01;36m\]$git_branch\[\033[36m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[0m\] $ '

export PATH=$PATH:~/bin

proxy_enable() {
    export http_proxy="10.125.4.66:3128"
    export https_proxy="10.125.4.66:3128"
    export all_proxy="socks://10.125.4.66:3128"
}

proxy_disable() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
}

export OLD_PATH=$PATH

toolchain_off() {
	PATH=$OLD_PATH
	export PATH
}
toolchain_arm_androideabi_47() {
	PATH=$OLD_PATH
	PATH=$PATH:/work/toolchain/arm-linux-androideabi-4.7/bin
	export PATH
}

java_on() {
    export JAVA_HOME=~/android/$JDK_VERSION
    export JRE_HOME=$JAVA_HOME/jre
    export ANDROID_JAVA_HOME=$JAVA_HOME
    export CLASSPATH=.:${CLASSPATH}:${JAVA_HOME}/lib:${JRE_HOME}/lib
	export JAVA_PATH=$JAVA_HOME/bin
}
java_off() {
    export JAVA_HOME=
    export JRE_HOME=
    export ANDROID_JAVA_HOME=
    export CLASSPATH=
	export JAVA_PATH=
}
# Please manual set PATH about Java
# export PATH=$JAVA_PATH:$PATH
java_16() {
    JDK_VERSION=jdk1.6.0_45
    java_on;
}
java_17() {
    JDK_VERSION=jdk1.7.0_79
    java_on;
}

# Distcc client
# Must replace gcc with distcc, have same dir of compile tools
export DISTCC_HOSTS="shaunxand04/12:56789 localhost/8"

