
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
		--distribution $(DISTRIBUTION) \
		--parent-distribution $(PARENT_DISTRIBUTION) \
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
		--security false \
		--source true \
		--tasksel apt \
		--updates false \
		--verbose

repo:
	@echo "deb http://deb.i2p2.de/ unstable main" | tee -a config/archives/i2p.list.chroot | tee -a config/archives/i2p.list.binary
	@echo "deb-src http://deb.i2p2.de/ unstable main" | tee -a config/archives/i2p.list.chroot | tee -a config/archives/i2p.list.binary
	wget -O config/archives/i2p.key.chroot https://geti2p.net/_static/i2p-debian-repo.key.asc
	wget -O config/archives/i2p.key.binary https://geti2p.net/_static/i2p-debian-repo.key.asc

pkg:
	@echo lxde | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary
	@echo firefox | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary
	@echo webext-noscript | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary
	@echo webext-umatrix | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary
	@echo i2p | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary
	@echo i2p-router | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary
	#@echo i2p-keyring | tee -a config/package-lists/base.list.chroot | tee config/package-lists/base.list.binary

allsetup: config repo pkg
	@echo ca-certificates | tee -a config/package-lists/live.list.chroot | tee config/package-lists/live.list.binary
	@echo user-setup | tee -a config/package-lists/live.list.chroot | tee config/package-lists/live.list.binary
	@echo sudo | tee -a config/package-lists/live.list.chroot | tee config/package-lists/live.list.binary

all: allsetup
	make build 2>&1 | tee build.log

build:
	sudo lb build
