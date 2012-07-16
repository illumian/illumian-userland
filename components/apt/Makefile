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
# Copyright 2012 Nexenta Systems, Inc. All rights reserved.
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME         = apt
COMPONENT_VERSION      = 0.9.5.1
COMPONENT_SRC          = $(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_PROJECT_URL  = http://debian.org
COMPONENT_BZR_REV      = $(COMPONENT_VERSION)
COMPONENT_BZR_URL      = http://bzr.debian.org/apt/debian-sid/

# Only builds with gcc
COMPILER = gcc
GCC_ROOT = /usr/gcc/4.4

include $(WS_TOP)/make-rules/bzr.mk
include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/configure.mk
include $(WS_TOP)/make-rules/ips.mk

PATH=$(dir $(CC)):$(GNUBIN):/usr/bin:$(dir $(PERL))

CXXFLAGS += -D_FILE_OFFSET_BITS=64
CPPFLAGS += -D_REENTRANT -D_POSIX_PTHREAD_SEMANTICS -DSOLARIS
CPPFLAGS.i386 += -DBYTE_ORDER=LITTLE_ENDIAN
CPPFLAGS.sparc += -DBYTE_ORDER=BIG_ENDIAN
CPPFLAGS += $(CPPFLAGS.$(MACH))
CPPFLAGS += -D__USE_GNU
CPPFLAGS += -DSHA2_USE_INTTYPES_H

CONFIGURE_OPTIONS += CXXFLAGS="$(CXXFLAGS)"
CONFIGURE_OPTIONS += CPPFLAGS="$(CPPFLAGS)"
CONFIGURE_OPTIONS += --libexecdir=/usr/lib/apt/methods
CONFIGURE_OPTIONS += --with-libiconv-prefix=/usr/gnu

COMPONENT_PREP_ACTION += \
	($(CP) /usr/share/libtool/config.{sub,guess} $(SOURCE_DIR)/buildlib)

# APT cleverly does not define an install target so we have to do it ourselves
$(BUILD_DIR_32)/.installed: $(BUILD_DIR_32)/.built
	$(MKDIR) $(PROTO_DIR)/usr/bin $(PROTO_DIR)/usr/lib
	$(CP) $(BUILD_DIR_32)/bin/apt-* $(PROTO_DIR)/usr/bin/
	$(CP) $(BUILD_DIR_32)/bin/libapt-pkg.so.4.12.0 $(PROTO_DIR)/usr/lib/
	$(CP) $(BUILD_DIR_32)/bin/libapt-inst.so.1.5.0 $(PROTO_DIR)/usr/lib/
	$(MKDIR) $(PROTO_DIR)/usr/lib/apt/methods
	$(CP) $(BUILD_DIR_32)/bin/methods/* $(PROTO_DIR)/usr/lib/apt/methods/
	$(RM) $(PROTO_DIR)/usr/lib/apt/methods/bzip2
	$(RM) $(PROTO_DIR)/usr/lib/apt/methods/lzma
	$(RM) $(PROTO_DIR)/usr/lib/apt/methods/ssh
	$(RM) $(PROTO_DIR)/usr/lib/apt/methods/xz
	$(MKDIR) $(PROTO_DIR)/usr/lib/dpkg/methods/apt
	$(CP) $(BUILD_DIR_32)/scripts/dselect/* $(PROTO_DIR)/usr/lib/dpkg/methods/apt/
	$(MKDIR) $(PROTO_DIR)/usr/share
	$(CP) -r $(BUILD_DIR_32)/locale $(PROTO_DIR)/usr/share/
	$(MKDIR) $(PROTO_DIR)/etc/logrotate.d
	$(CP) $(SOURCE_DIR)/debian/apt.logrotate $(PROTO_DIR)/etc/logrotate.d/apt
	$(MKDIR) $(PROTO_DIR)/etc/cron.daily
	$(CP) $(SOURCE_DIR)/debian/apt.cron.daily $(PROTO_DIR)/etc/cron.daily/apt
	$(MKDIR) $(PROTO_DIR)/etc/apt/apt.conf.d
	$(CP) $(SOURCE_DIR)/debian/apt.conf.autoremove $(PROTO_DIR)/etc/apt/apt.conf.d/01autoremove
	$(MKDIR) $(PROTO_DIR)/usr/share/doc/apt/examples
	$(CP) $(SOURCE_DIR)/doc/examples/* $(PROTO_DIR)/usr/share/doc/apt/examples/
	$(MKDIR) $(PROTO_DIR)/usr/share/man/man8
	$(MKDIR) $(PROTO_DIR)/usr/share/man/man5
	$(MKDIR) $(PROTO_DIR)/usr/share/man/man1
	$(CP) $(SOURCE_DIR)/doc/*.8 $(PROTO_DIR)/usr/share/man/man8/
	$(CP) $(SOURCE_DIR)/doc/*.5 $(PROTO_DIR)/usr/share/man/man5/
	$(CP) $(SOURCE_DIR)/doc/*.1 $(PROTO_DIR)/usr/share/man/man1/
	$(MKDIR) $(PROTO_DIR)/usr/include
	$(CP) -r $(BUILD_DIR_32)/include/apt-pkg $(PROTO_DIR)/usr/include/
	$(TOUCH) $@

# Override default build target to avoid toxic COMPONENT_BUILD_{ENV,ARGS}
$(BUILD_DIR_32)/.built: $(BUILD_DIR_32)/.configured
	$(MAKE) -C $(BUILD_DIR_32) PATH="$(PATH)"
	$(TOUCH) $@

# common targets
build:		$(BUILD_32)

install:	$(INSTALL_32)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

test:		$(TEST_32)

include ../../make-rules/depend.mk
