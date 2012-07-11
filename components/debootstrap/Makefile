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
# Copyright (c) 2012 Nexenta Systems, Inc. All rights reserved.
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME		= debootstrap
COMPONENT_VERSION	= 1.0.40
COMPONENT_SRC		= $(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_PROJECT_URL	= http://debian.org
COMPONENT_GIT_URL	= git://git.debian.org/d-i/debootstrap.git
COMPONENT_GIT_REV	= 7e809162cdaa4d98b23610221a20640f742e53dc

include $(WS_TOP)/make-rules/git.mk
include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/justmake.mk
include $(WS_TOP)/make-rules/ips.mk

# make install requires gnu cp
PATH=$(dir $(CC)):/usr/gnu/bin:/usr/bin:/bin

build:		$(BUILD_32) 

install:	$(INSTALL_32)

tests:		$(NO_TESTS)

include $(WS_TOP)/make-rules/depend.mk
