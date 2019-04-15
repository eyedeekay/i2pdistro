
fake:
	@echo Do not run this unless you are regenerating the whole configuration
	@echo directory!
	@echo
	@echo make config
	@echo

clean:
	sudo lb clean
	rm -rf config

PRESEED_FILE=i2p-preseed.txt

include debian.mk
#INIT_SYSTEM=runit
INIT_SYSTEM=systemd

#		--debootstrap-options "--include=ca-certificates" \

config: clean
	lb config --apt-indices true \
		--apt-options "-y" \
		--apt-source-archives true \
		--binary-images iso-hybrid \
		--checksums sha256 \
		--build-with-chroot true \
		--debconf-frontend noninteractive \
		--debian-installer live \
		--debian-installer-gui true \
		--debian-installer-preseedfile $(PRESEED_FILE) \
		--initsystem $(INIT_SYSTEM) \
		--initramfs-compression gzip \
		--firmware-binary true \
		--mode $(MODE) \
		--parent-distribution $(DISTRIBUTION) \
		--system live \
		--parent-mirror-bootstrap $(MIRROR) \
		--parent-mirror-chroot $(MIRROR) \
	    --parent-mirror-chroot-security $(MIRROR) \
	    --parent-mirror-binary $(MIRROR) \
	    --parent-mirror-binary-security $(MIRROR) \
	    --parent-mirror-debian-installer $(MIRROR) \
	    --mirror-bootstrap $(MIRROR) \
	    --mirror-chroot $(MIRROR) \
	    --mirror-chroot-security $(MIRROR) \
	    --mirror-binary $(MIRROR) \
	    --mirror-binary-security $(MIRROR) \
	    --mirror-debian-installer $(MIRROR) \
		--archive-areas $(ARCHIVE_AREAS) \
		--security true \
		--source true \
		--tasksel apt \
		--updates false \
		--verbose

all: config
	@echo ca-certificates | tee -a config/package-lists/live.list.chroot | tee config/package-lists/live.list.binary
	@echo user-setup | tee -a config/package-lists/live.list.chroot | tee config/package-lists/live.list.binary
	@echo sudo | tee -a config/package-lists/live.list.chroot | tee config/package-lists/live.list.binary
	sudo lb build 2>&1 | tee build.log
