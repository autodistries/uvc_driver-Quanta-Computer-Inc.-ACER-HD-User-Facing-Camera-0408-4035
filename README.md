### Starting from kernel v6.11, this patch is already included inside the kernels (search for "quanda" on [this changelog](https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.11)).  
Excerpt from that changelog :  
```
 media: uvcvideo: Force UVC version to 1.0a for 0408:4035
    
    The Quanta ACER HD User Facing camera reports a UVC 1.50 version, but
    implements UVC 1.0a as shown by the UVC probe control being 26 bytes
    long. Force the UVC version for that device.
```
If `uname -r` reports 6.11 or higher, you don't need this patch anymore

# uvc_driver-Quanta-Computer-Inc.-ACER-HD-User-Facing-Camera-0408-4035
a script to compile an uvc driver for Quanta Camera

This is a simple script I did to automatically build, patch and load a working uvc driver for my ID 0408:4035 Quanta Computer, Inc. ACER HD User Facing camera.
It was done relatively quickly; **you should probably read** what it runs so that you get how it (is supposed to) works. The code is not long.  
**I am not responsible to what you do to your system** (It should work tho)

This script works on my machine, running Garuda Linux (arch) with 6.6.2-zen1-1-zen kernel  
I am pretty sure it will work on other kernels (the build script does not rely on which kernel you are on; it will default to global linux kernel)  
The script will **build for 6.6.2 kernel by default**, you can edit the pkgver at the beginning of the script to change target kernel (you can see yours with `uname -r`) (you probably don't need to)  

As long as your admin password is not asked (or you don't run the script with superuser permissions), no modification is made to your system.  
At the end of the execution, **the module is compressed** before being copied. Most gnu/linux flavor accept compressed drivers. If yours do not, you will have to copy the newly-built driver manually (it is not hard, read the code)
# Will it work for my camera ?
Maybe.  Run `lsusb` in your terminal. If you find something similar to ```Bus 003 Device 002: ID 0408:4035 Quanta Computer, Inc. ACER HD User Facing``` it might work.  
If the ID XXXX:XXXX is different, you will have to edit the script to reflect YOUR camera.  
Replace this with your numerical values:
```
+     .idVendor     = 0x0408, #put whatever's the first part of your ID here, do not remove the 0x
+     .idProduct        = 0x4035, # same for the 2nd value
```

# Why does it not work ? 
The camera reports a UVC v1.5, but only supports v1.0a.  
This patch forces that version to be used

# Goal
Expected result is a working camera.


# Sources
Here are my sources and pages that reference issues for these types of cameras: 
- https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2000947 (not active)
- https://github.com/Giuliano69/uvc_driver-for-Quanta-HD-User-Facing-0x0408-0x4035- (Ubuntu 22-04 only, out of date because not a patch)
- https://forum.manjaro.org/t/my-internal-camera-is-not-working/142809/12
- https://patchwork.kernel.org/project/linux-media/patch/20230115205210.20077-1-laurent.pinchart@ideasonboard.com/#25163877 (Archived, probably unsolved)

~~I hope one day we will get in-kernel support~~ it is done


