# reflasher for the boxes

! Note this is very very very very custom and will murder your SD card.


## Procedure for re-flashing

* Prepare `boot.scr`
	* go to boot/
	* edit `boot.cmd` to set the dhcp server IP
	* run `mage -T script -A arm -d boot.cmd boot.scr`
	* copy `boot.scr` to the boot partition of the box, currently `/mnt/boot`

* Prepare tftp setup
	* run `install.sh /path/to/tftproot`

* Copy the image
	* find the sdcard image
	* copy the image in some way to the SSD drive (`/mnt/ssd`) on the box
	* the image *must* be named `FLASH.IMG`

* Reboot the box
	* The reflash takes ~20 minutes

* Pray

## How was this prepared

* get the latest d-i from `https://d-i.debian.org/daily-images/armhf/daily/netboot/`
* unpack `initrd.gz`
* install some extra udebs in it (available in `udebs/`)
	* vfat (if you want to touch the boot partition)
	* ext4 (for the ssd)
	* sata modules (for the ssd)
* rewrite `init` to do crap
	* load modules
	* wait for the devices to show
	* mount the ssd
	* dd FLASH.IMG from the ssd to the card
	* sync, sync, sync
	* echo b > /proc/sysrq-trigger
* rebuild initrd, boot it
