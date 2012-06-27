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
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		debianutils
COMPONENT_VERSION=	4.3.1
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_GIT_URL=	git://anonscm.debian.org/users/clint/debianutils.git
COMPONENT_GIT_REV=	2b7e7d2c582786bb6f84d9164d4390947c995545
COMPONENT_PROJECT_URL=	http://anonscm.debian.org/gitweb/?p=users/clint/debianutils.git

IPS_PKG_NAME=		system-management/$(COMPONENT_NAME)

include ../../make-rules/git.mk
include ../../make-rules/prep.mk
include ../../make-rules/configure.mk
include ../../make-rules/ips.mk

PKG_MACROS += IPS_PKG_NAME=$(IPS_PKG_NAME)

# common targets
build:		$(BUILD_32)

install:	$(INSTALL_32)

test:		$(TEST_32)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include ../../make-rules/depend.mk
