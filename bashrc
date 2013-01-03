# .bashrc
#alias cm='grep From: ~/mbox'
alias cm='cat ~/mbox | formail -X From: -X Subject: -s sort'
alias r='fc -s'

function ch {
   mtr `url --host $*`
}
alias hex="printf '%x\n'"

alias mmutt="TERM=xterm-mono mutt"

function eg {
 elinks -eval 'set protocol.file.allow_special_files = 1' -eval 'set mime.default_type = "text/html"' <(
	echo "<html><head><title>$*</title></head><body>";
	grep "$@" | sort -k2 -u -f;
	echo "</body></html>"
	)
}

function ef {
 elinks -eval 'set protocol.file.allow_special_files = 1' -eval 'set mime.default_type = "text/html"' <(
	echo "<html><head><title>$*</title></head><body>";
	../fpw "$@"
	echo "</body></html>"
	)
}

alias zspace="zfs list -o space"
alias em="/usr/bin/env ALTERNATE_EDITOR='' emacsclient -c"
