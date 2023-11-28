# uvc_driver-Quanta-Computer-Inc.-ACER-HD-User-Facing-Camera-0408-4035
a script to compile an uvc driver for Quanta Camera

This is a simple script I did to automatically build and apply a working uvc driver for my ID 0408:4035 Quanta Computer, Inc. ACER HD User Facing camera.
It was done relatively quickly; **you should probably read** what it runs so that you get how it (is supposed to) works
**I am not responsible to what you do to your system** (I barely even bear the reponsibility of what I do to my system) (but things should go fine. maybe)

This script works on my machine, running Garuda Linux (arch) with 6.6.2-zen1-1-zen kernel
I am pretty sure it will work on other kernels (the build script does not rely on which kernel you are on; it will default to global linux kernel)
The script will **build for 6.6.2 kernel by default**, you can edit the pkgver at the beginning of the script to change target kernel (you can see yours with `uname -r`)

As long as your admin password is not asked, no modification is made to your system.
At the end of the execution, **the module is compressed** before being copied. I am not sure if every gnu/linux flavor likes compressed drivers. If not, you will have to copy the newly-built driver manually (it is not hard)



Here are my sources and pages that reference issues for these types of cameras: 
- https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2000947 (not active)
- https://github.com/Giuliano69/uvc_driver-for-Quanta-HD-User-Facing-0x0408-0x4035- (Ubuntu 22-04 only, out of date because not a patch)
- https://forum.manjaro.org/t/my-internal-camera-is-not-working/142809/12
- https://patchwork.kernel.org/project/linux-media/patch/20230115205210.20077-1-laurent.pinchart@ideasonboard.com/#25163877 (Archived, probably unsolved)

I hope one day we will get in-kernel support
