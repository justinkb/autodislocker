NAME := autodislocker
PREFIX := /usr/local

install: $(NAME).sh
	install -d $(PREFIX)/sbin
	install -p $(NAME).sh $(PREFIX)/sbin
	install -p un$(NAME).sh $(PREFIX)/sbin

uninstall:
	rm $(PREFIX)/sbin/$(NAME).sh
	rm $(PREFIX)/sbin/un$(NAME).sh
