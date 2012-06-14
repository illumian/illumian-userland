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
# Copyright (c) 2010, 2011, Oracle and/or its affiliates. All rights reserved.
#

ifndef _PREP_MK_
_PREP_MK_ = prep.mk

UNPACK =	$(WS_TOOLS)/userland-unpack
FETCH =		$(WS_TOOLS)/userland-fetch

# Only clean the SOURCE_DIR if there's a COMPONENT_ARCHIVE to recreate it from
ifdef COMPONENT_ARCHIVE
ARCHIVES += $(COMPONENT_ARCHIVE)
CLEAN_PATHS += $(SOURCE_DIR)
endif

# In order to override PATCH_DIR and PATCH_PATTERN in component makefiles, they
# need to be conditionally set here.  This means that the override needs to
# happen prior to including prep.mk.  Otherwise other variables set here which
# are based on those will be expanded too early for the override to take effect.
# You also can't override PATCHES after including prep.mk; if you want to
# append filenames to PATCHES, you'll have to set $(EXTRA_PATCHES) prior to
# inclusion.
PATCH_DIR ?=	patches
PATCH_PATTERN ?=	*.patch
PATCHES =	$(shell find $(PATCH_DIR) -type f -name '$(PATCH_PATTERN)' \
				2>/dev/null | sort) $(EXTRA_PATCHES)
STAMPS =	$(PATCHES:$(PATCH_DIR)/%=$(SOURCE_DIR)/.%ed)

$(SOURCE_DIR)/.%ed:	$(PATCH_DIR)/%
	$(GPATCH) -d $(@D) $(GPATCH_FLAGS) < $<
	$(TOUCH) $@

# template for download rules. add new rules with $(call download-rule, suffix)
define download-rule
ARCHIVES += $$(COMPONENT_ARCHIVE$(1))
CLOBBER_PATHS += $$(COMPONENT_ARCHIVE$(1))
$$(USERLAND_ARCHIVES)$$(COMPONENT_ARCHIVE$(1)):	Makefile
	$$(FETCH) --file $$@ \
		$$(COMPONENT_ARCHIVE_URL$(1):%=--url %) \
		$$(COMPONENT_ARCHIVE_HASH$(1):%=--hash %)
	$$(TOUCH) $$@
endef

# Generate the download rules from the above template
NUM_ARCHIVES =	1 2 3 4 5 6 7
$(eval $(call download-rule,))
$(foreach suffix,$(NUM_ARCHIVES),$(eval $(call download-rule,_$(suffix))))

# Allow overriding by alternative source delivery methods
UNPACK_STAMP	?= $(SOURCE_DIR)/.unpacked
PATCH_STAMP	?= $(SOURCE_DIR)/.patched
DOWNLOAD_STAMP	?= $(ARCHIVES:%=$(USERLAND_ARCHIVES)%)

$(SOURCE_DIR)/.unpacked:	download Makefile $(PATCHES)
	$(RM) -r $(SOURCE_DIR)
	$(UNPACK) $(UNPACK_ARGS) $(USERLAND_ARCHIVES)$(COMPONENT_ARCHIVE)
	$(TOUCH) $@

$(SOURCE_DIR)/.patched:	$(UNPACK_STAMP) $(STAMPS)
	$(TOUCH) $@

$(SOURCE_DIR)/.prep:	$(PATCH_STAMP)
	$(COMPONENT_PREP_ACTION)
	$(TOUCH) $@

prep::	$(SOURCE_DIR)/.prep

download::	$(DOWNLOAD_STAMP)

clean::
	$(RM) -r $(CLEAN_PATHS)

clobber::	clean
	$(RM) -r $(CLOBBER_PATHS)

endif
