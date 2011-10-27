APP = DzienDobry

TARGET = iPad.local

CC = arm-apple-darwin10-gcc

override CFLAGS += -std=c99
override CFLAGS += -miphoneos-version-min=3.2

override LDFLAGS += -lobjc
override LDFLAGS += -framework UIKit
override LDFLAGS += -framework Foundation
override LDFLAGS += -framework CoreFoundation

OBJS = $(shell find -name '*.[cm]' |sed 's/..$$/.o/')
RES = Icon.png Icon-72.png Default.png Info.plist

all: $(APP)

# Build

$(APP): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

# Bundle

install: $(APP) $(RES)
	mkdir -p $(APP).app
	cp -au $(APP) $(RES) $(APP).app/

deploy: install
	rsync -ar --delete $(APP).app/. root@$(TARGET):/Applications/$(APP).app
	-ssh mobile@$(TARGET) killall $(APP)
	ssh mobile@$(TARGET) uicache

# Utility

%.o: %.m
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

clean:
	-rm -r $(APP).app $(APP)
	-find -name '*.o' -delete
