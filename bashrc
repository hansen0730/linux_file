# TODO

# some more ls aliases
alias ls='ls --color=always'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

alias gsw='git show'
alias gss='git status'
alias gck='git checkout'
alias gdf='git diff'

export LANG="zh_CN.UTF-8"
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

#export JAVA_HOME=~/android/jdk1.7.0_25
#export JRE_HOME=~/android/jdk1.7.0_25/jre
export JAVA_HOME=~/android/jdk1.6.0_45
export JRE_HOME=~/android/jdk1.6.0_45/jre
export CLASSPATH=.:${CLASSPATH}:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:${PATH}

#export PATH=$PATH:~/soft/arm_4_3_3/bin
#export PATH=$PATH:/usr/unicore/gnu-toolchain-unicore/uc4-1.0-beta-soft-RHELAS4/bin
#export PATH=$PATH:/home/hansen/cross_tool/gcc-linaro-arm-linux-gnueabihf-4.8-2013.08_linux/bin
#export PATH=$PATH:/home/hansen/cross_tool/gcc-linaro-arm-linux-gnueabi-2012.01-20120125_linux/bin
#export PATH=$PATH:/home/hansen/cross_tool/arm-2010q1/bin

# TODO

