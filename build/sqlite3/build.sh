#!/usr/bin/bash
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=sqlite-autoconf      # App name
VER=3071000         # App version
VERHUMAN=3.7.10  # Human-readable version
PVER=0.1          # Package Version (numeric only)
PKG=database/sqlite-3       # Package name (without prefix)
SUMMARY="SQL database engine library"      # You should change this
DESC="$SUMMARY"

DEPENDS_IPS="SUNWcs library/readline system/library/gcc-4-runtime"
CONFIGURE_OPTS_64="$CONFIGURE_OPTS_64 --includedir=/usr/include"

make_stub_dirs() {
    logcmd mkdir -p $DESTDIR/usr/bin
    logcmd mkdir -p $DESTDIR/usr/lib
    logcmd mkdir -p $DESTDIR/usr/include
    logcmd mkdir -p $DESTDIR/usr/lib/amd64
    logcmd mkdir -p $DESTDIR/usr/share/man/man1
}

init
download_source sqlite $PROG $VER
patch_source
prep_build
make_stub_dirs
build
make_isa_stub
VER=3.7.10
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
