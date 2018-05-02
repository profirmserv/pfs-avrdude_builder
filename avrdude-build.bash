#!/bin/bash

# Only set variable if it's not already set.
# This allows the caller to easily override these values using env vars.
maybe_set () { eval "[ -z \${$1+set} ] && $1=$2"; }

maybe_set basedir "/home/vagrant/avrdude-build"
maybe_set debdir "/vagrant/debian"
maybe_set destdir "/vagrant/releases"
maybe_set pfsver "1pfs+$(git describe --dirty=+ | tr - .)"
maybe_set svnrev 1426
maybe_set svnurl "http://svn.savannah.nongnu.org/svn/avrdude/trunk/avrdude"

################################################################################
# 
# This script will build an AVRDude Debian package from a given revision of the
# AVRDude SVN repository.
# 
# It has been tested only with revision 1426 but it's possible that it would
# work with other revisions.
# 
# It has only been tested on 64-bit Ubuntu, but it's possible that it would work
# on 32-bit Ubuntu as well.
# 
# Written by Sam Hathaway <sam@sam-hathaway.com>. To the extent possible under
# law, I waive all copyright and related or neighboring rights to this work.
# https://creativecommons.org/publicdomain/zero/1.0/
# 
################################################################################

mkdir -p "$basedir"
cd "$basedir"

svn checkout --revision "$svnrev" "$svnurl"
cd avrdude

cp -a "$debdir" .

oldver=$(dpkg-parsechangelog --count 1 | awk '/^Version:/{print$2}')
newver="$oldver+svn$svnrev-$pfsver"

export DEBFULLNAME="Sam Hathaway"
export DEBEMAIL="sam@sam-hathaway.com"
debchange "Build from SVN r$svnrev." --nmu
debchange "" --newversion "$newver"

dpkg-buildpackage -b

mv ../*.deb "$destdir"
