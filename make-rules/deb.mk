
# shared-macros.mk and ips.mk must be included before

DEBMAKER = $(WS_TOOLS)/debmaker
DEBVERSION ?= $(BUILD_NUM).0

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


