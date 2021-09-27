PREFIX ?= /usr

all:
	@echo Run \'make install\' to install twitter-randimg-bot.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p tweet-randimg $(DESTDIR)$(PREFIX)/bin/tweet-randimg
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/tweet-randimg
	@mkdir -p $(DESTDIR)$(PREFIX)/lib/systemd/system
	@cp -p tweet-randimg.service $(DESTDIR)$(PREFIX)/lib/systemd/system/tweet-randimg.service
	@cp -p tweet-randimg.timer $(DESTDIR)$(PREFIX)/lib/systemd/system/tweet-randimg.timer

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/tweet-randimg
	@rm -rf $(DESTDIR)$(PREFIX)/lib/systemd/system/tweet-randimg.service
	@rm -rf $(DESTDIR)$(PREFIX)/lib/systemd/system/tweet-randimg.timer