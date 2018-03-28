CELoader is an EFI application that can load and boot to a Windows CE kernel (NK.EXE). 

The code is fairly simple but demonstrates the ability to read and write the console, 
read files and query and configure the graphics system. The loader configures
the BootArgs structure with information needed by the kernel. Finally, the loader
jumps to the entry point of the CE kernel.