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

PROG=nginx
VER=1.4.1
VERHUMAN=$VER
PKG=service/network/nginx
SUMMARY="Nginx, http server and reverse proxy"
DESC="Nginx (pronounced engine-x) is a free, open-source, high-performance HTTP server and reverse proxy, as well as an IMAP/POP3 proxy server."

BUILDARCH=32

CONFIGURE_OPTS_32=""
CONFIGURE_OPTS="
    --prefix=$PREFIX
    --sbin-path=$PREFIX/sbin/$PROG
    --conf-path=/etc/$PROG/nginx.conf
    --error-log-path=/var/log/$PROG/error.log
    --http-log-path=/var/log/$PROG/access.log
    --pid-path=/var/$PROG/nginx.pid
    --lock-path=/var/$PROG/nginx.lock
    --user=webservd
    --group=webservd
    --with-ipv6
    --with-http_ssl_module
    --with-http_addition_module 
    --with-http_xslt_module
    --with-http_flv_module
    --with-http_gzip_static_module
    --with-http_mp4_module
    --with-http_random_index_module
    --with-http_realip_module
    --with-http_secure_link_module
    --with-http_stub_status_module
    --with-http_sub_module
    --with-http_dav_module
    --with-mail
    --with-mail_ssl_module
"
#    --with-google_perftools_module ; requires google perftools library

service_configs() {
    logmsg "Installing SMF"
    logcmd mkdir -p $DESTDIR/lib/svc/manifest/network
    logcmd cp $SRCDIR/files/manifest-http-nginx.xml \
        $DESTDIR/lib/svc/manifest/network/http-nginx.xml
    logcmd mkdir -p $DESTDIR/lib/svc/method
    logcmd cp $SRCDIR/files/http-nginx \
        $DESTDIR/lib/svc/method/http-nginx
    logcmd chmod 555 $DESTDIR/lib/svc/method/http-nginx
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
service_configs
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et: