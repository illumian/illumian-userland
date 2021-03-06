#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
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
# Copyright (c) 2012 Nexenta Systems, Inc.  All rights reserved.
# Copyright (c) 2011, Oracle and/or its affiliates. All rights reserved.
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		lighttpd
COMPONENT_VERSION=	1.4.23
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	sha1:37f8b4827d7a1f69812d8185fcecf72277020876
COMPONENT_ARCHIVE_URL=	http://www.lighttpd.net/download/$(COMPONENT_ARCHIVE)

LIGHTTPD_INSTALLDIR=/usr/lighttpd/1.4

include ../../make-rules/prep.mk
include ../../make-rules/configure.mk
include ../../make-rules/ips.mk

PATCH_LEVEL=0

# libtool passes -z defs when linking which is a bit severe in this case,
# we drop it in favor of -z text.
COMPONENT_PREP_ACTION = ( cd $(@D) ; \
	sed -i "s/no_undefined_flag=' -z defs'/no_undefined_flag=' -z text'/g" configure)

# lighttpd is logging using __FILE__ macro. Cloning will make this happen
# using just source file names (without full absolute paths).
COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))

CONFIGURE_PREFIX= /usr/lighttpd/1.4
CONFIGURE_MANDIR= $(CONFIGURE_PREFIX)/man

CONFIGURE_OPTIONS +=	--with-pic
CONFIGURE_OPTIONS +=	--with-lua
CONFIGURE_OPTIONS +=	--with-openssl
CONFIGURE_OPTIONS +=	--with-pcre
CONFIGURE_OPTIONS +=	--with-mysql=/usr/mysql/bin/mysql_config
CONFIGURE_OPTIONS +=	CFLAGS="$(CFLAGS)"

# common targets
build:		$(BUILD_32)

install:	$(INSTALL_32)

test:		$(TEST_32)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include ../../make-rules/depend.mk
