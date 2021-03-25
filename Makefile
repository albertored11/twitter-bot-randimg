PREFIX ?= /usr

all:
	@echo Run \'make install\' to install twitter-randimg-bot.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p tweet-randimg $(DESTDIR)$(PREFIX)/bin/tweet-randimg
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/tweet-randimg

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/tweet-randimg