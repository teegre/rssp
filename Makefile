PROGNAME  ?= rssp
PREFIX    ?= /usr
BINDIR    ?= $(PREFIX)/bin
SHAREDIR  ?= $(PREFIX)/share

.PHONY: install
install: $(PROGNAME).sh
	install -d $(BINDIR)
	install -m755 $(PROGNAME).sh $(BINDIR)/$(PROGNAME)
	install -Dm644 LICENSE -t $(SHAREDIR)/licenses/$(PROGNAME)

.PHONY: uninstall
uninstall:
	rm $(BINDIR)/$(PROGNAME)
	rm -rf $(SHAREDIR)/licenses/$(PROGNAME)
