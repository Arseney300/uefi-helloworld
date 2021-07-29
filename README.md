# uefi-hellowowrld
Simple helloworld uefi program. x86-64 arch

# preparation

QEMU:  
apt-get install qemu qemu-kvm ovmf

Create virtual disk image (on 1GB):    
dd if=/dev/zero of=/path/to/uefi.img bs=1M count = 1024 

Create EFI partition and mount it:
gdisk uefi.img  
n -> enter -> enter -> enter -> ef00 -> W(Y)  
partx -a uefi.img  
mkfs.fat /dev/loop0p1  
mkdir efi && mount /dev/loop0p1 efi && cd efi

Compile source code to efi:  
cd directory/with/sourcefile && make (work on debian, in other systems some libs can be find in lib32(64))  

Make directories in efi partition, copy application:  
cd efi  
mkdir EFI && mkdir EFI/Boot  
cp directory/with/sourcefile/bootx64.elf efi/EFI/Boot/  
qemu-

Run emulator:  
qemu-system-x86_64 -enable-kvm -m 2G -bios /usr/share/OVMF/OVMF_CODE.fd  -drive file=uefi.img,format=raw

