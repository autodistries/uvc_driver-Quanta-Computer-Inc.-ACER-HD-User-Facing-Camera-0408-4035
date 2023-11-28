#! /bin/bash

# the kernel release type actually does nothing here, build with main (linux). Version is important !
pkgver=6.6.2.zen1

_srcname=linux-${pkgver%.*}


workdir=$(pwd)

echo Creating temp file, downloading kernel
mkdir archPatchVideo
cd archPatchVideo
wget  https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.xz

echo uncompressing - please wait
unxz ${_srcname}.tar.xz
tar -xvf  ${_srcname}.tar
chown -R $USER:$USER ${_srcname}
cd ${_srcname}/drivers/media/usb/uvc



# used to be a patch, but in case the upper lines change, it needs to work
patchvalue="	  /* Quanta ACER HD User Facing */
	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
				| USB_DEVICE_ID_MATCH_INT_INFO,
	  .idVendor		= 0x0408,
	  .idProduct		= 0x4035,
	  .bInterfaceClass	= USB_CLASS_VIDEO,
	  .bInterfaceSubClass	= 1,
	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
	  .driver_info		= (kernel_ulong_t)&(const struct uvc_device_info){
		.uvc_version = 0x010a,
	  } },"
echo "$patchvalue" > patchfile
sed -i "/\/\* Generic USB Video Class \*\//r patchfile" uvc_driver.c


make -j4 -C /lib/modules/$(uname -r)/build M=$(pwd) modules  # complie the updated video modules for your kernel version
zstd uvcvideo.ko
echo Finished compiling the driver, it is at $(pwd)/uvcvideo.ko.zst
echo Enter the root password to automatically copy the driver and refresh the module
sudo cp /usr/lib/modules/$(uname -r)/kernel/drivers/media/usb/uvc/uvcvideo.ko.zst  /usr/lib/modules/$(uname -r)/kernel/drivers/media/usb/uvc/uvcvideo.ko.zst.old # backup old version

sudo cp -f uvcvideo.ko.zst /usr/lib/modules/$(uname -r)/kernel/drivers/media/usb/uvc/uvcvideo.ko.zst
sudo rmmod uvcvideo
sudo modprobe uvcvideo trace=0xffffffff
cd $workdir
echo You can clean the archPatchVideo direcory if needed. Try your camera
