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
# Copyright (c) 2012 Nexenta Systems, Inc.  All rights reserved.
#

ifndef _DEB_MK_
_DEB_MK_ = deb.mk

include $(WS_TOP)/make-rules/ips.mk

DEBMAKER = $(WS_TOOLS)/debmaker
DEBVERSION ?= $(BUILD_NUM).1

# Where to find binaries
# (like debian/tmp):
PROTO_DIRS = $(PKG_PROTO_DIRS:%=-d %)

# See in make-rules/ips.mk
# Do not use PKG_OPTIONS here cause it may not be limited to '-D's
DEFINES = $(PKG_MACROS:%=-D %)

# Where to create package contents
# and debs (like debian/pkg-name)
DEBS_DIR = $(PROTO_DIR)/debs

# but pkgdepend resolve does not work:
deb: build install $(MANGLED)
	rm -rf $(DEBS_DIR)
	$(MKDIR) $(DEBS_DIR)
	$(DEBMAKER) \
		-S $(COMPONENT_NAME) \
		-N $(CONSOLIDATION) \
		-V $(DEBVERSION) \
		-O $(DEBS_DIR) \
		$(PROTO_DIRS) \
		$(DEFINES) \
		$(MANGLED)

clean::
	$(RM) -r $(DEBS_DIR)

endif
