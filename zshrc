#!/bin/zsh
#
# .zshenv
# for zsh 3.1.6 and newer (may work OK with earlier versions)
#
# by Adam Spiers <adam@spiers.net>
#
# Best viewed in emacs folding mode (folding.el).
# (That's what all the # {{{ and # }}} are for.)
#
# This gets run even for non-interactive shells;
# keep it as fast as possible.
# 
# N.B. This is for zsh-specific environment stuff.  Put generic,
# portable environment settings in .shared_env instead, so that they
# take effect for bash and ksh.

# {{{ What version are we running?

if [[ $ZSH_VERSION == 3.0.<->* ]]; then ZSH_STABLE_VERSION=yes; fi
if [[ $ZSH_VERSION == 3.1.<->* ]]; then ZSH_DEVEL_VERSION=yes;  fi

ZSH_VERSION_TYPE=old
if [[ $ZSH_VERSION == 3.1.<6->* ||
      $ZSH_VERSION == 3.<2->.<->*  ||
      $ZSH_VERSION == 4.<->*  ||
      $ZSH_VERSION == 5.<->*
      ]]
then
  ZSH_VERSION_TYPE=new
fi

# }}}

# {{{ zdotdir

zdotdir=${ZDOTDIR:-$HOME}
export ZDOTDIR="$zdotdir"
if [[ "$ZDOTDIR" == "$HOME" ]]; then
  zdotdirpath=( $ZDOTDIR )
else
  zdotdirpath=( $ZDOTDIR $HOME )
  export OTHER_USER=1
fi

# }}}

[[ -e $zdotdir/.shared_env ]] && . $zdotdir/.shared_env

setopt extended_glob

# {{{ path

typeset -U path # No duplicates

# notice nasty hack for old zsh
path=( $path /usr/local/bin /usr/local/sbin /usr/sbin /sbin /[u]sr/X11R6/bin(N) )
path=( $zdotdir/{[l]ocal/bin,[p]ackbin,[b]in,[b]in/{backgrounds,palm,shortcuts}}(N) $path )

# }}}
# {{{ manpath

typeset -U manpath # No duplicates

# }}}
# {{{ fpath/autoloads

fpath=(
       $zdotdir/{.[z]sh/*.zwc,{.[z]sh,[l]ib/zsh}/{functions,scripts}}(N) 

       $fpath

       # very old versions
       /usr/doc/zsh*/[F]unctions(N)
      )

# Autoload shell functions from all directories in $fpath.  Restrict
# functions from $zdotdir/.zsh to ones that have the executable bit
# on.  (The executable bit is not necessary, but gives you an easy way
# to stop the autoloading of a particular shell function).
#
# The ':t' is a history modifier to produce the tail of the file only,
# i.e. dropping the directory path.  The 'x' glob qualifier means
# executable by the owner (which might not be the same as the current
# user).

for dirname in $fpath; do
  case "$dirname" in
    $zdotdir/.zsh*) fns=( $dirname/*~*~(N.x:t) ) ;;
                 *) fns=( $dirname/*~*~(N.:t)  ) ;;
  esac
  (( $#fns )) && autoload "$fns[@]"
done

#[[ "$ZSH_VERSION_TYPE" == 'new' ]] || typeset -gU fpath

# }}}

# {{{ Specific to hosts

run_local_hooks .zshenv

# }}}
