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

ifndef _BZR_MK_
_BZR_MK_ = bzr.mk

# Unpack/Download are pretty much the same thing for bzr
UNPACK_STAMP	= $(SOURCE_DIR)
DOWNLOAD_STAMP	= $(SOURCE_DIR)

COMPONENT_BZR_REV ?=

$(SOURCE_DIR):
	bzr clone $(COMPONENT_BZR_REV:%=-r%) $(COMPONENT_BZR_URL) $(COMPONENT_SRC)

clean::
	if [ -d $(SOURCE_DIR) ]; then \
		cd $(SOURCE_DIR) && \
		bzr revert $(COMPONENT_BZR_REV:%=-r%) && \
		bzr clean-tree --force --unknown --detritus; \
	fi

clobber::
	$(RM) -r $(SOURCE_DIR)

endif
