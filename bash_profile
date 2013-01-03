[ -r .profile ] && . .profile
PATH=$PATH:/sbin:/usr/sbin:/usr/local/bin
export PATH
PS1='\u@\h:\w\$ '
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups
command_oriented_history=yes
MAILPATH=$HOME/Mail/INBOX?"New mail in INBOX":$HOME/Mail/SPAM?"You've got SPAM"
LSCOLORS="gxfxcxdxbxegedabagacad"
[ -r $HOME/.aliases ] && . $HOME/.aliases
