CFLAGS = -c                                 \
         -fno-stack-protector               \
         -fpic                              \
         -fshort-wchar                      \
         -mno-red-zone                      \
	 -Wall       			    \
	 -O2			            \
         -I /usr/include/efi                \
         -I /usr/include/efi/x86_64         \
         -DEFI_FUNCTION_WRAPPER 

LINKERFLAGS= /usr/lib/crt0-efi-x86_64.o     \
             -nostdlib                      \
             -znocombreloc                  \
             -T /usr/lib/elf_x86_64_efi.lds \
             -shared                        \
             -Bsymbolic                     \
             -L /usr/lib                    \
	     -l:libefi.a                    \
	     -l:libgnuefi.a                 
        
OBJCPYFLAGS= -j .text                \
             -j .sdata               \
             -j .data                \
             -j .dynamic             \
             -j .dynsym              \
             -j .rel                 \
             -j .rela                \
             -j .reloc               \
             --target=efi-app-x86_64 
all:
	gcc main.c $(CFLAGS) -o main.o
	ld main.o $(LINKERFLAGS) -o main.so
	objcopy $(OBJCPYFLAGS) main.so bootx64.efi	
