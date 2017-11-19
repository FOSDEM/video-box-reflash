# reflasher for the boxes

! Note this is *very very very very* custom and *will murder* your SD card.


## Procedure for re-flashing

* Prepare `boot.scr`
	* Go to boot/
	* Edit `boot.cmd` to set the dhcp server IP
	* Run `image -T script -A arm -d boot.cmd boot.scr`
	* Copy `boot.scr` to the boot partition of the box, currently `/mnt/boot`

* Prepare tftp setup
	* Run `./install.sh /path/to/tftproot`

* Copy the image
	* Find the sdcard image
	* Copy the image in some way to the SSD drive (`/mnt/ssd`) on the box
	* The image *must* be named `FLASH.IMG`

* Reboot the box
	* The reflash takes ~20 minutes

* Pray

## How was this prepared

* Get the latest d-i from `https://d-i.debian.org/daily-images/armhf/daily/netboot/`
* Unpack `initrd.gz`
* Install some extra udebs in it (available in `udebs/`)
	* vfat (if you want to touch the boot partition)
	* ext4 (for the ssd)
	* sata modules (for the ssd)
* Rewrite `init` to do crap
	* Load modules
	* Wait for the devices to show
	* Mount the ssd
	* dd `FLASH.IMG` from the ssd to the card
	* sync, sync, sync
	* echo b > /proc/sysrq-trigger
* Rebuild initrd, boot it
