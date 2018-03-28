#
# Copyright (c) 1999, 2000
# Intel Corporation.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# 3. All advertising materials mentioning features or use of this software must
#    display the following acknowledgement:
# 
#    This product includes software developed by Intel Corporation and its
#    contributors.
# 
# 4. Neither the name of Intel Corporation or its contributors may be used to
#    endorse or promote products derived from this software without specific
#    prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED.  IN NO EVENT SHALL INTEL CORPORATION OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 

#
# Include sdk.env environment
#

!include $(SDK_INSTALL_DIR)\build\$(SDK_BUILD_ENV)\sdk.env

#
# Set the base output name and entry point
#

BASE_NAME         = CeLoader
IMAGE_ENTRY_POINT = LoaderMain

#
# Globals needed by master.mak
#

TARGET_APP = $(BASE_NAME)
SOURCE_DIR = $(SDK_INSTALL_DIR)\apps\$(BASE_NAME)
BUILD_DIR  = $(SDK_BUILD_DIR)\apps\$(BASE_NAME)

#
# Include paths
#

!include $(SDK_INSTALL_DIR)\include\$(EFI_INC_DIR)\makefile.hdr

#(db)INC = -I $(SDK_INSTALL_DIR)\include\$(EFI_INC_DIR) \
#(db)      -I $(SDK_INSTALL_DIR)\include\$(EFI_INC_DIR)\$(PROCESSOR) $(INC)

INC = -I $(SDK_INSTALL_DIR)\include\$(EFI_INC_DIR) \
      -I D:\EFI\edk2-master\edk2-master\EdkCompatibilityPkg\Foundation\Efi \
      -I D:\EFI\edk2-master\edk2-master\EdkCompatibilityPkg\Foundation\include \
      -I $(SDK_INSTALL_DIR)\include\$(EFI_INC_DIR)\$(PROCESSOR) $(INC)


!include makefile.hdr
INC = -I $(PROCESSOR) $(INC)

INC = -I $(SDK_INSTALL_DIR)\include\bsd $(INC)


#
# Libraries
#

LIBS = $(LIBS) $(SDK_BUILD_DIR)\lib\libefi\libefi.lib \
       $(SDK_BUILD_DIR)\lib\libc\libc.lib \
       $(SDK_BUILD_DIR)\lib\libsocket\libsocket.lib \
       $(SDK_BUILD_DIR)\lib\libm\libm.lib \


#
# Default target
#

all : dirs $(BUILD_DIR)\$(PROCESSOR) $(LIBS) $(OBJECTS)

#
# Program object files
#

OBJECTS = $(OBJECTS) \
    $(BUILD_DIR)\celoader.obj \
    $(BUILD_DIR)\EFIeboot.obj \
    $(BUILD_DIR)\$(PROCESSOR)\jump.obj \

#
# Source file dependencies
#

$(BUILD_DIR)\celoader.obj          : $(*B).c              $(INC_DEPS)
$(BUILD_DIR)\$(PROCESSOR)\jump.obj : $(PROCESSOR)\$(*B).c $(INC_DEPS)

#
# Handoff to master.mak
#

!include $(SDK_INSTALL_DIR)\build\master.mak
