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

COMPONENT_NAME=		fakeroot
COMPONENT_VERSION=	1.18.4-2
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_GIT_URL=	git://anonscm.debian.org/users/clint/fakeroot.git
COMPONENT_GIT_REV=	c87d227fc68fd5d8b9495a3024ca024f1b38e661
COMPONENT_PROJECT_URL=	http://fakeroot.alioth.debian.org

IPS_PKG_NAME=		security/$(COMPONENT_NAME)
IPS_COMPONENT_VERSION=	$(subst -,.,$(COMPONENT_VERSION))

include ../../make-rules/git.mk
include ../../make-rules/prep.mk
include ../../make-rules/configure.mk
include ../../make-rules/ips.mk

COMPONENT_PREP_ACTION = ( cd $(@D) && $(MKDIR) build-aux )

# This should be added by default!
$(BUILD_32):COMPONENT_BUILD_ARGS += CC="$(CC) -m32"
$(BUILD_64):COMPONENT_BUILD_ARGS += CC="$(CC) -m64"

PKG_MACROS += IPS_PKG_NAME=$(IPS_PKG_NAME)

# common targets
build:		$(BUILD_32) $(BUILD_64)

install:	$(INSTALL_32) $(INSTALL_64)

test:		$(TEST_32) $(TEST_64)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include ../../make-rules/depend.mk
