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
# Copyright (c) 2012, Nexenta Systems, Inc. All rights reserved.
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME         = dpkg
COMPONENT_VERSION      = 1.16.4.3
COMPONENT_SRC          = $(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_PROJECT_URL  = http://debian.org
COMPONENT_GIT_URL      = git://git.debian.org/git/dpkg/dpkg.git
COMPONENT_GIT_REV      = $(COMPONENT_VERSION)

# Only builds with gcc 4
COMPILER = gcc
GCC_ROOT = /usr/gcc/4.4

include $(WS_TOP)/make-rules/git.mk
include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/configure.mk
include $(WS_TOP)/make-rules/ips.mk

# Make sure dpkg uses ncurses (required for 'resizeterm')
CURSES_LIBS = -L/usr/gnu/lib -R/usr/gnu/lib -lncurses

CONFIGURE_OPTIONS += CURSES_LIBS="$(CURSES_LIBS)"
CONFIGURE_OPTIONS += --disable-linker-optimisations
CONFIGURE_OPTIONS += --disable-start-stop-daemon
CONFIGURE_OPTIONS += --localstatedir=/var
CONFIGURE_OPTIONS += --with-zlib
CONFIGURE_OPTIONS += --with-bz2

build:		$(BUILD_32)

install:	$(INSTALL_32)

test:		$(NO_TESTS)

BUILD_PKG_DEPENDENCIES = $(BUILD_TOOLS)

include ../../make-rules/depend.mk
