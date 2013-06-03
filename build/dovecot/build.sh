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

PROG=dovecot
VER=2.2.2
VERHUMAN=$VER
PKG=service/network/imap/dovecot
SUMMARY="Dovecot is an open source IMAP and POP3 email server."
DESC="$SUMMARY ($VER)"

BUILDARCH=32
BUILD_DEPENDS_IPS=""
DEPENDS_IPS="system/library/gcc-4-runtime database/bdb library/libpq5"

CONFIGURE_OPTS="--sysconfdir=/etc
    --localstatedir=/var/$PROG
    --mandir=$PREFIX/man
    --enable-static=no
    --with-nnss
    --with-gssapi=plugin
    --with-ldap=plugin
    --with-sql=plugin
    --with-pgsql
    --with-zlib
    --with-bzlib
    --with-libwrap
    --with-ssl=openssl"

#service_configs() {
#    logmsg "Installing SMF"
#    logcmd mkdir -p $DESTDIR/lib/svc/manifest/network/ldap
#    logcmd cp $SRCDIR/files/manifest-slapd.xml \
#        $DESTDIR/lib/svc/manifest/network/ldap/slapd.xml
#    logcmd mkdir -p $DESTDIR/lib/svc/method
#    logcmd cp $SRCDIR/files/slapd \
#        $DESTDIR/lib/svc/method/slapd
#}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
#service_configs
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et: