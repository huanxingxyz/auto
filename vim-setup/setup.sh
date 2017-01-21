#!/bin/bash

function installBrewOnMacOSX() {
    which brew
    if [ $? -eq 0 ] ; then
        echo "brew already installed!"
    else
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

function installVimOnMacOSX() {
    which vim
    if [ $? -eq 0 ] ; then
        echo "vim already installed!"
    else
        brew install vim
    fi
}

function installCurlOnMacOSX() {
    which curl
    if [ $? -eq 0 ] ; then
        echo "curl already installed!"
    else
        brew install curl
    fi
}

function installOnUbuntu() {
    sudo apt-get install curl
    sudo apt-get install vim
    sudo apt-get install exuberant-ctags
}

function installOnCentOS() {
    sudo yum install curl
    sudo yum install vim
    sudo yum install ctags-etags
}

function updateVimrc() {
    if [ -f '~/.vimrc' ] ; then
        mv ~/.vimrc ~/.vimrc.bak
    fi
    cp vimrc-user ~/.vimrc

    echo "---------------------------------------------------"
    echo "~/.vimrc config file is updated! "
    echo "your ~/.vimrc config file is bak to ~/.vimrc.bak"
    echo "open vim and use :BundleInstall to install plugins!"
    echo "---------------------------------------------------"
}

function main() {
    osType=`uname -s`
    echo "osType=$osType"

    if [ $osType = "Darwin" ] ; then
        installBrewOnMacOSX
        installVimOnMacOSX
        installCurlOnMacOSX
    elif [ $osType = "Linux" ] ; then
        if [ -f '/etc/lsb-release' ] ; then
            installOnUbuntu
        elif [ -f '/etc/redhat-release' ] ; then
            installOnCentOS
        fi
    fi

    if [ -f 'vimrc-user' ] ; then
        updateVimrc
    else
        curl -O https://raw.githubusercontent.com/leleliu008/auto/master/vim-setup/vimrc-user
        if [ $? -eq 0 ] ; then
            updateVimrc
        fi
    fi
}

main