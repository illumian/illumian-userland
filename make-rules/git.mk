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

# Unpack/Download are pretty much the same thing for git
UNPACK_STAMP	= $(SOURCE_DIR)
DOWNLOAD_STAMP	= $(SOURCE_DIR)

COMPONENT_GIT_REV ?= HEAD
COMPONENT_GIT_BRANCH ?= master

$(SOURCE_DIR):
	git clone -b $(COMPONENT_GIT_BRANCH) $(COMPONENT_GIT_URL) $(COMPONENT_SRC)
	if [ $(COMPONENT_GIT_REV) != HEAD ]; then \
		cd $(SOURCE_DIR) && \
		git reset --hard $(COMPONENT_GIT_REV) ; \
	fi

clean::
	if [ -d $(SOURCE_DIR) ]; then \
		cd $(SOURCE_DIR) && git clean -fdx && \
		git reset --hard $(COMPONENT_GIT_REV) ; \
	fi

clobber::
	$(RM) -r $(SOURCE_DIR)

