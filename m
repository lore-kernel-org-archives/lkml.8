Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E275BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36B4206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgDTMjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:39:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgDTMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:39:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFJfN-1jSSZU1t1d-00Fhgr; Mon, 20 Apr 2020 14:38:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-sh@vger.kernel.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] sh: remove sh5 support
Date:   Mon, 20 Apr 2020 14:38:43 +0200
Message-Id: <20200420123844.3998746-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VGgg35fLez2mAL0IfWaPhNN/+ZnduvnyccpMWPyNajBadUy4hbZ
 LnMXmsfkAIRi+j9mhH/bQGvYHIfX3O/XarFcvdK7hBTl6MbCQ/sbAelN786pAd8ySlLwebr
 tWVwDPjsvPN6ES7CsN1YiOvyS1PrRMBuULzX6xwFkul/dzTFbZ9pXa+KLdKaOSCrGmclXRI
 Eqm/KvaFml/R/HhHURQgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DsTPVT3brbE=:qOkwFFxlZK/AKa48kUPuyI
 wtR4sCL9kxf0bT6HQuu2OH3W591uwUoVhQg9g2Hl7feiTstDKcAvbKqAXwv8h/jh3kH9BaMMz
 tBGn3EoVWCImpV7Nk9qWLxX9wbQ6YrMCmr4NV+FkKgUWcSb8A9PIrEuadsUb82aociFxeTITH
 m+3JXntgQkOhdsWruYslEqyvlHlZGEj2eVbwUiUulyfLZO6ZsXFJluLyLxRTkQL7I+90jaMt1
 k7TVBdNqiwDRAbg9FaveuKMq4ku/oqscNIFsznZYVx0zXtzbR83rHVEUhzqHBHZixBQ51Cmy/
 t2AmWfTLChtFt8vFisAc6VPOtqkHhxmYvmVzUwB8MxddCmKq/DlcdTZgNvJBZ7jMXqmMHqPcI
 JL2umUrnZMUiiYWIrf+3E6RskZ50TUuktJaun0UhkHmbzKRJSHxDuD4xWH6n5aTm0NTTEy0GH
 W1d0v/KXGkKfWjZ6NcQ3RtZCM4miJVYYT52AgECH2q8pBQZkmYya7KB+WdoSLAIRjoZLJV09S
 q20clQIFIuvLLWpJx4gMISib7sASDy1tnZ6NulCcJyw/uWLzLEpa5qvz+WUeLn5JJJP6SHgAQ
 wsLbPvUb3waRjP4X1ZV/g7BjkqPpFcr/JWgBlb8R197gPBqKOwSbjpqR2+WBxtZg+ohkdhMvQ
 Lx0wc6oOgvt/aI8ZRspj0LzBzepjNHESzZ+frw1yRzxuy7g1pmUFIOBu3L+n1+3mdvY0/d7CQ
 ekfP09sq5/dgFgSNr2mqnDGv+p8wYgnQ64uPUI/lZpL8EMRVYNfKjfDEVY/UhmTA+Nbah0x9M
 0q0SIrgfjBylR2ZoyJy20SC+l+e9Fk5Ii2QdJ7snM0mLdag5kI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sh5 never became a product and has probably never really worked.

Remove it by recursively deleting all associated Kconfig options
and all corresponding files.

For review purposes, this leaves out the files that can now be
removed, in particular

 arch/sh/drivers/pci/*-sh5.c
 arch/sh/include/asm/*_64.h
 arch/sh/include/uapi/asm/*_64.h
 arch/sh/include/cpu-sh5/*
 arch/sh/kernel/cpu/sh5/*
 arch/sh/lib64/*
 arch/sh/mm/*-sh5.c

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/Kconfig                       | 50 +++-------------------
 arch/sh/Kconfig.cpu                   |  9 ----
 arch/sh/Kconfig.debug                 | 13 ++----
 arch/sh/Makefile                      | 24 +++--------
 arch/sh/boot/compressed/Makefile      |  5 +--
 arch/sh/boot/compressed/misc.c        |  8 ----
 arch/sh/drivers/pci/Makefile          |  1 -
 arch/sh/include/asm/barrier.h         |  4 +-
 arch/sh/include/asm/bitops.h          | 26 ------------
 arch/sh/include/asm/bugs.h            |  4 --
 arch/sh/include/asm/extable.h         |  4 --
 arch/sh/include/asm/fixmap.h          |  4 --
 arch/sh/include/asm/io.h              |  4 --
 arch/sh/include/asm/irq.h             |  3 --
 arch/sh/include/asm/mmu_context.h     | 12 ------
 arch/sh/include/asm/module.h          |  4 --
 arch/sh/include/asm/page.h            | 21 +--------
 arch/sh/include/asm/pgtable.h         | 17 --------
 arch/sh/include/asm/posix_types.h     |  6 +--
 arch/sh/include/asm/processor.h       | 14 +-----
 arch/sh/include/asm/string.h          |  6 +--
 arch/sh/include/asm/switch_to.h       | 11 +----
 arch/sh/include/asm/syscall.h         |  6 +--
 arch/sh/include/asm/syscalls.h        |  9 +---
 arch/sh/include/asm/thread_info.h     |  4 +-
 arch/sh/include/asm/tlb.h             |  6 +--
 arch/sh/include/asm/traps.h           |  4 --
 arch/sh/include/asm/types.h           |  5 ---
 arch/sh/include/asm/uaccess.h         |  4 --
 arch/sh/include/asm/unistd.h          |  6 +--
 arch/sh/include/asm/user.h            |  7 ---
 arch/sh/include/asm/vmlinux.lds.h     |  6 ---
 arch/sh/include/uapi/asm/ptrace.h     |  5 ---
 arch/sh/include/uapi/asm/sigcontext.h | 13 ------
 arch/sh/include/uapi/asm/stat.h       | 61 ---------------------------
 arch/sh/kernel/Makefile               | 16 +++----
 arch/sh/kernel/cpu/Makefile           |  1 -
 arch/sh/kernel/cpu/init.c             |  2 +-
 arch/sh/kernel/cpu/irq/Makefile       |  3 +-
 arch/sh/kernel/cpu/proc.c             |  1 -
 arch/sh/kernel/module.c               |  9 ----
 arch/sh/kernel/process.c              |  2 -
 arch/sh/kernel/reboot.c               |  6 ---
 arch/sh/kernel/vmlinux.lds.S          | 18 +++-----
 arch/sh/mm/Kconfig                    | 16 +++----
 arch/sh/mm/Makefile                   |  2 -
 arch/sh/mm/cache.c                    |  6 ---
 drivers/rtc/Kconfig                   |  2 +-
 fs/Kconfig.binfmt                     |  2 +-
 scripts/headers_install.sh            |  3 --
 50 files changed, 51 insertions(+), 424 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b4f0e37b83eb..eef0245af1b5 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -62,7 +62,7 @@ config SUPERH
 	  <http://www.linux-sh.org/>.
 
 config SUPERH32
-	def_bool "$(ARCH)" = "sh"
+	def_bool y
 	select ARCH_32BIT_OFF_T
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
 	select HAVE_KPROBES
@@ -82,18 +82,9 @@ config SUPERH32
 	select SPARSE_IRQ
 	select HAVE_STACKPROTECTOR
 
-config SUPERH64
-	def_bool "$(ARCH)" = "sh64"
-	select HAVE_EXIT_THREAD
-	select KALLSYMS
-
 config GENERIC_BUG
 	def_bool y
-	depends on BUG && SUPERH32
-
-config GENERIC_CSUM
-	def_bool y
-	depends on SUPERH64
+	depends on BUG
 
 config GENERIC_HWEIGHT
 	def_bool y
@@ -203,12 +194,6 @@ config CPU_SH4AL_DSP
 	select CPU_SH4A
 	select CPU_HAS_DSP
 
-config CPU_SH5
-	bool
-	select CPU_HAS_FPU
-	select SYS_SUPPORTS_SH_TMU
-	select SYS_SUPPORTS_HUGETLBFS if MMU
-
 config CPU_SHX2
 	bool
 
@@ -228,8 +213,6 @@ config CPU_HAS_PMU
        default y
        bool
 
-if SUPERH32
-
 choice
 	prompt "Processor sub-type selection"
 
@@ -518,27 +501,6 @@ config CPU_SUBTYPE_SH7366
 
 endchoice
 
-endif
-
-if SUPERH64
-
-choice
-	prompt "Processor sub-type selection"
-
-# SH-5 Processor Support
-
-config CPU_SUBTYPE_SH5_101
-	bool "Support SH5-101 processor"
-	select CPU_SH5
-
-config CPU_SUBTYPE_SH5_103
-	bool "Support SH5-103 processor"
-	select CPU_SH5
-
-endchoice
-
-endif
-
 source "arch/sh/mm/Kconfig"
  
 source "arch/sh/Kconfig.cpu"
@@ -592,7 +554,7 @@ source "kernel/Kconfig.hz"
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on SUPERH32 && MMU
+	depends on MMU
 	select KEXEC_CORE
 	help
 	  kexec is a system call that implements the ability to shutdown your
@@ -610,7 +572,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "kernel crash dumps (EXPERIMENTAL)"
-	depends on SUPERH32 && BROKEN_ON_SMP
+	depends on BROKEN_ON_SMP
 	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
@@ -624,7 +586,7 @@ config CRASH_DUMP
 
 config KEXEC_JUMP
 	bool "kexec jump (EXPERIMENTAL)"
-	depends on SUPERH32 && KEXEC && HIBERNATION
+	depends on KEXEC && HIBERNATION
 	help
 	  Jump between original kernel and kexeced kernel and invoke
 	  code via KEXEC
@@ -701,7 +663,7 @@ config HOTPLUG_CPU
 
 config GUSA
 	def_bool y
-	depends on !SMP && SUPERH32
+	depends on !SMP
 	help
 	  This enables support for gUSA (general UserSpace Atomicity).
 	  This is the default implementation for both UP and non-ll/sc
diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index 4a4edc7e03d4..97ca35f2cd37 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -13,7 +13,6 @@ config CPU_LITTLE_ENDIAN
 
 config CPU_BIG_ENDIAN
 	bool "Big Endian"
-	depends on !CPU_SH5
 
 endchoice
 
@@ -27,10 +26,6 @@ config SH_FPU
 
 	  This option must be set in order to enable the FPU.
 
-config SH64_FPU_DENORM_FLUSH
-	bool "Flush floating point denorms to zero"
-	depends on SH_FPU && SUPERH64
-
 config SH_FPU_EMU
 	def_bool n
 	prompt "FPU emulation support"
@@ -77,10 +72,6 @@ config SPECULATIVE_EXECUTION
 
 	  If unsure, say N.
 
-config SH64_ID2815_WORKAROUND
-	bool "Include workaround for SH5-101 cut2 silicon defect ID2815"
-	depends on CPU_SUBTYPE_SH5_101
-
 config CPU_HAS_INTEVT
 	bool
 
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 010b6c33bbba..28a43d63bde1 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -5,7 +5,6 @@ config TRACE_IRQFLAGS_SUPPORT
 
 config SH_STANDARD_BIOS
 	bool "Use LinuxSH standard BIOS"
-	depends on SUPERH32
 	help
 	  Say Y here if your target has the gdb-sh-stub
 	  package from www.m17n.org (or any conforming standard LinuxSH BIOS)
@@ -19,7 +18,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL && SUPERH32
+	depends on DEBUG_KERNEL
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to
@@ -38,7 +37,7 @@ config 4KSTACKS
 
 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
-	depends on DEBUG_KERNEL && SUPERH32 && BROKEN
+	depends on DEBUG_KERNEL && BROKEN
 	help
 	  If you say Y here the kernel will use separate kernel stacks
 	  for handling hard and soft interrupts.  This can help avoid
@@ -46,7 +45,7 @@ config IRQSTACKS
 
 config DUMP_CODE
 	bool "Show disassembly of nearby code in register dumps"
-	depends on DEBUG_KERNEL && SUPERH32
+	depends on DEBUG_KERNEL
 	default y if DEBUG_BUGVERBOSE
 	default n
 	help
@@ -59,7 +58,6 @@ config DUMP_CODE
 config DWARF_UNWINDER
 	bool "Enable the DWARF unwinder for stacktraces"
 	select FRAME_POINTER
-	depends on SUPERH32
 	default n
 	help
 	  Enabling this option will make stacktraces more accurate, at
@@ -77,11 +75,6 @@ config SH_NO_BSS_INIT
 	  For all other cases, say N. If this option seems perplexing, or
 	  you aren't sure, say N.
 
-config SH64_SR_WATCH
-	bool "Debug: set SR.WATCH to enable hardware watchpoints and trace"
-	depends on SUPERH64
-
 config MCOUNT
 	def_bool y
-	depends on SUPERH32
 	depends on STACK_DEBUG || FUNCTION_TRACER
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index b4a86f27e048..4ad046a0284a 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -11,7 +11,7 @@
 #
 ifneq ($(SUBARCH),$(ARCH))
   ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, $(UTS_MACHINE)-linux-  $(UTS_MACHINE)-linux-gnu-  $(UTS_MACHINE)-unknown-linux-gnu-)
+    CROSS_COMPILE := $(call cc-cross-prefix, sh-linux- sh-linux-gnu- sh-unknown-linux-gnu-)
   endif
 endif
 
@@ -29,12 +29,9 @@ isa-$(CONFIG_CPU_SH3)			:= sh3
 isa-$(CONFIG_CPU_SH4)			:= sh4
 isa-$(CONFIG_CPU_SH4A)			:= sh4a
 isa-$(CONFIG_CPU_SH4AL_DSP)		:= sh4al
-isa-$(CONFIG_CPU_SH5)			:= shmedia
 
-ifeq ($(CONFIG_SUPERH32),y)
 isa-$(CONFIG_SH_DSP)			:= $(isa-y)-dsp
 isa-y					:= $(isa-y)-up
-endif
 
 cflags-$(CONFIG_CPU_SH2)		:= $(call cc-option,-m2,)
 cflags-$(CONFIG_CPU_J2)			+= $(call cc-option,-mj2,)
@@ -47,7 +44,6 @@ cflags-$(CONFIG_CPU_SH4)		:= $(call cc-option,-m4,) \
 cflags-$(CONFIG_CPU_SH4A)		+= $(call cc-option,-m4a,) \
 					   $(call cc-option,-m4a-nofpu,)
 cflags-$(CONFIG_CPU_SH4AL_DSP)		+= $(call cc-option,-m4al,)
-cflags-$(CONFIG_CPU_SH5)		:= $(call cc-option,-m5-32media-nofpu,)
 
 ifeq ($(cflags-y),)
 #
@@ -88,7 +84,7 @@ OBJCOPYFLAGS	:= -O binary -R .note -R .note.gnu.build-id -R .comment \
 		   -R .stab -R .stabstr -S
 
 # Give the various platforms the opportunity to set default image types
-defaultimage-$(CONFIG_SUPERH32)			:= zImage
+defaultimage-y					:= zImage
 defaultimage-$(CONFIG_SH_SH7785LCR)		:= uImage
 defaultimage-$(CONFIG_SH_RSK)			:= uImage
 defaultimage-$(CONFIG_SH_URQUELL)		:= uImage
@@ -107,24 +103,16 @@ KBUILD_IMAGE		:= $(boot)/$(defaultimage-y)
 # Choosing incompatible machines durings configuration will result in
 # error messages during linking.
 #
-ifdef CONFIG_SUPERH32
 UTS_MACHINE		:= sh
 BITS			:= 32
 LDFLAGS_vmlinux		+= -e _stext
-else
-UTS_MACHINE		:= sh64
-BITS			:= 64
-LDFLAGS_vmlinux		+= --defsym phys_stext=_stext-$(CONFIG_PAGE_OFFSET) \
-			   --defsym phys_stext_shmedia=phys_stext+1 \
-			   -e phys_stext_shmedia
-endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-ld-bfd			:= elf32-$(UTS_MACHINE)-linux
+ld-bfd			:= elf32-sh-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64 --oformat $(ld-bfd)
 KBUILD_LDFLAGS		+= -EL
 else
-ld-bfd			:= elf32-$(UTS_MACHINE)big-linux
+ld-bfd			:= elf32-shbig-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64+4 --oformat $(ld-bfd)
 KBUILD_LDFLAGS		+= -EB
 endif
@@ -185,7 +173,6 @@ cpuincdir-$(CONFIG_CPU_SH2)	+= cpu-sh2
 cpuincdir-$(CONFIG_CPU_SH3)	+= cpu-sh3
 cpuincdir-$(CONFIG_CPU_SH4A)	+= cpu-sh4a
 cpuincdir-$(CONFIG_CPU_SH4)	+= cpu-sh4
-cpuincdir-$(CONFIG_CPU_SH5)	+= cpu-sh5
 cpuincdir-y			+= cpu-common	# Must be last
 
 drivers-y			+= arch/sh/drivers/
@@ -206,8 +193,7 @@ ifeq ($(CONFIG_DWARF_UNWINDER),y)
   KBUILD_CFLAGS += -fasynchronous-unwind-tables
 endif
 
-libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/	$(libs-y)
-libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
+libs-y			:= arch/sh/lib/	$(libs-y)
 
 BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.xz uImage.lzo \
 	       uImage.srec uImage.bin zImage vmlinux.bin vmlinux.srec \
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index f5e1bd779789..a893481dfdd2 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -39,9 +39,8 @@ LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
 #
 # Pull in the necessary libgcc bits from the in-kernel implementation.
 #
-lib1funcs-$(CONFIG_SUPERH32)	:= ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S \
-				   lshrsi3.S
-lib1funcs-obj			:= \
+lib1funcs-y	:= ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S lshrsi3.S
+lib1funcs-obj   := \
 	$(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y))))
 
 lib1funcs-dir		:= $(srctree)/arch/$(SRCARCH)/lib
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index e69ec12cbbe6..a03b6680a9d9 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -116,11 +116,7 @@ void ftrace_stub(void)
 {
 }
 
-#ifdef CONFIG_SUPERH64
-#define stackalign	8
-#else
 #define stackalign	4
-#endif
 
 #define STACK_SIZE (4096)
 long __attribute__ ((aligned(stackalign))) user_stack[STACK_SIZE];
@@ -130,13 +126,9 @@ void decompress_kernel(void)
 {
 	unsigned long output_addr;
 
-#ifdef CONFIG_SUPERH64
-	output_addr = (CONFIG_MEMORY_START + 0x2000);
-#else
 	output_addr = __pa((unsigned long)&_text+PAGE_SIZE);
 #if defined(CONFIG_29BIT)
 	output_addr |= P2SEG;
-#endif
 #endif
 
 	output = (unsigned char *)output_addr;
diff --git a/arch/sh/drivers/pci/Makefile b/arch/sh/drivers/pci/Makefile
index 947bfe8bb0a7..a5c1e9066f83 100644
--- a/arch/sh/drivers/pci/Makefile
+++ b/arch/sh/drivers/pci/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_CPU_SUBTYPE_SH7763)	+= pci-sh7780.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7780)	+= pci-sh7780.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7785)	+= pci-sh7780.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7786)	+= pcie-sh7786.o ops-sh7786.o
-obj-$(CONFIG_CPU_SH5)			+= pci-sh5.o ops-sh5.o
 
 obj-$(CONFIG_SH_DREAMCAST)		+= ops-dreamcast.o fixups-dreamcast.o \
 					   pci-dreamcast.o
diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
index 66faae19d254..0d58a0159aa6 100644
--- a/arch/sh/include/asm/barrier.h
+++ b/arch/sh/include/asm/barrier.h
@@ -6,7 +6,7 @@
 #ifndef __ASM_SH_BARRIER_H
 #define __ASM_SH_BARRIER_H
 
-#if defined(CONFIG_CPU_SH4A) || defined(CONFIG_CPU_SH5)
+#if defined(CONFIG_CPU_SH4A)
 #include <asm/cache_insns.h>
 #endif
 
@@ -24,7 +24,7 @@
  * Historically we have only done this type of barrier for the MMUCR, but
  * it's also necessary for the CCR, so we make it generic here instead.
  */
-#if defined(CONFIG_CPU_SH4A) || defined(CONFIG_CPU_SH5)
+#if defined(CONFIG_CPU_SH4A)
 #define mb()		__asm__ __volatile__ ("synco": : :"memory")
 #define rmb()		mb()
 #define wmb()		mb()
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 8c3578288db5..445dd14c448a 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -26,7 +26,6 @@
 #include <asm-generic/bitops/non-atomic.h>
 #endif
 
-#ifdef CONFIG_SUPERH32
 static inline unsigned long ffz(unsigned long word)
 {
 	unsigned long result;
@@ -60,31 +59,6 @@ static inline unsigned long __ffs(unsigned long word)
 		: "t");
 	return result;
 }
-#else
-static inline unsigned long ffz(unsigned long word)
-{
-	unsigned long result, __d2, __d3;
-
-        __asm__("gettr  tr0, %2\n\t"
-                "pta    $+32, tr0\n\t"
-                "andi   %1, 1, %3\n\t"
-                "beq    %3, r63, tr0\n\t"
-                "pta    $+4, tr0\n"
-                "0:\n\t"
-                "shlri.l        %1, 1, %1\n\t"
-                "addi   %0, 1, %0\n\t"
-                "andi   %1, 1, %3\n\t"
-                "beqi   %3, 1, tr0\n"
-                "1:\n\t"
-                "ptabs  %2, tr0\n\t"
-                : "=r" (result), "=r" (word), "=r" (__d2), "=r" (__d3)
-                : "0" (0L), "1" (word));
-
-	return result;
-}
-
-#include <asm-generic/bitops/__ffs.h>
-#endif
 
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
diff --git a/arch/sh/include/asm/bugs.h b/arch/sh/include/asm/bugs.h
index 030df56bfdb2..fe52abb69cea 100644
--- a/arch/sh/include/asm/bugs.h
+++ b/arch/sh/include/asm/bugs.h
@@ -53,10 +53,6 @@ static void __init check_bugs(void)
 		*p++ = 's';
 		*p++ = 'p';
 		break;
-	case CPU_FAMILY_SH5:
-		*p++ = '6';
-		*p++ = '4';
-		break;
 	case CPU_FAMILY_UNKNOWN:
 		/*
 		 * Specifically use CPU_FAMILY_UNKNOWN rather than
diff --git a/arch/sh/include/asm/extable.h b/arch/sh/include/asm/extable.h
index ed46f8bebb9f..5658d2bae372 100644
--- a/arch/sh/include/asm/extable.h
+++ b/arch/sh/include/asm/extable.h
@@ -4,8 +4,4 @@
 
 #include <asm-generic/extable.h>
 
-#if defined(CONFIG_SUPERH64) && defined(CONFIG_MMU)
-#define ARCH_HAS_SEARCH_EXTABLE
-#endif
-
 #endif
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index e30348c58073..f38adc189b83 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -83,11 +83,7 @@ extern void __clear_fixmap(enum fixed_addresses idx, pgprot_t flags);
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
-#ifdef CONFIG_SUPERH32
 #define FIXADDR_TOP	(P4SEG - PAGE_SIZE)
-#else
-#define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
-#endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 39c9ead489e5..a5bcc87c7eb9 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -115,12 +115,8 @@ static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
 __BUILD_MEMORY_STRING(__raw_, b, u8)
 __BUILD_MEMORY_STRING(__raw_, w, u16)
 
-#ifdef CONFIG_SUPERH32
 void __raw_writesl(void __iomem *addr, const void *data, int longlen);
 void __raw_readsl(const void __iomem *addr, void *data, int longlen);
-#else
-__BUILD_MEMORY_STRING(__raw_, l, u32)
-#endif
 
 __BUILD_MEMORY_STRING(__raw_, q, u64)
 
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 8065a3222e19..6d44c32ef047 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -66,8 +66,5 @@ extern void irq_finish(unsigned int irq);
 #endif
 
 #include <asm-generic/irq.h>
-#ifdef CONFIG_CPU_SH5
-#include <cpu/irq.h>
-#endif
 
 #endif /* __ASM_SH_IRQ_H */
diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 2d09650093c7..48e67d544d53 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -48,11 +48,7 @@
  */
 #define MMU_VPN_MASK	0xfffff000
 
-#if defined(CONFIG_SUPERH32)
 #include <asm/mmu_context_32.h>
-#else
-#include <asm/mmu_context_64.h>
-#endif
 
 /*
  * Get MMU context if needed.
@@ -74,14 +70,6 @@ static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
 		 */
 		local_flush_tlb_all();
 
-#ifdef CONFIG_SUPERH64
-		/*
-		 * The SH-5 cache uses the ASIDs, requiring both the I and D
-		 * cache to be flushed when the ASID is exhausted. Weak.
-		 */
-		flush_cache_all();
-#endif
-
 		/*
 		 * Fix version; Note that we avoid version #0
 		 * to distinguish NO_CONTEXT.
diff --git a/arch/sh/include/asm/module.h b/arch/sh/include/asm/module.h
index 9f38fb35fe96..2e29ee60c2b8 100644
--- a/arch/sh/include/asm/module.h
+++ b/arch/sh/include/asm/module.h
@@ -18,8 +18,6 @@ struct mod_arch_specific {
 #  define MODULE_PROC_FAMILY "SH3LE "
 # elif defined  CONFIG_CPU_SH4
 #  define MODULE_PROC_FAMILY "SH4LE "
-# elif defined  CONFIG_CPU_SH5
-#  define MODULE_PROC_FAMILY "SH5LE "
 # else
 #  error unknown processor family
 # endif
@@ -30,8 +28,6 @@ struct mod_arch_specific {
 #  define MODULE_PROC_FAMILY "SH3BE "
 # elif defined  CONFIG_CPU_SH4
 #  define MODULE_PROC_FAMILY "SH4BE "
-# elif defined  CONFIG_CPU_SH5
-#  define MODULE_PROC_FAMILY "SH5BE "
 # else
 #  error unknown processor family
 # endif
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index ea8d68f58e39..eca5daa43b93 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -35,8 +35,6 @@
 #define HPAGE_SHIFT	22
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_64MB)
 #define HPAGE_SHIFT	26
-#elif defined(CONFIG_HUGETLB_PAGE_SIZE_512MB)
-#define HPAGE_SHIFT	29
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -82,18 +80,12 @@ typedef struct { unsigned long long pgd; } pgd_t;
 	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define __pte(x) \
 	({ pte_t __pte = {(x), ((unsigned long long)(x)) >> 32}; __pte; })
-#elif defined(CONFIG_SUPERH32)
+#else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
 #define __pte(x)	((pte_t) { (x) } )
-#else
-typedef struct { unsigned long long pte_low; } pte_t;
-typedef struct { unsigned long long pgprot; } pgprot_t;
-typedef struct { unsigned long pgd; } pgd_t;
-#define pte_val(x)	((x).pte_low)
-#define __pte(x)	((pte_t) { (x) } )
 #endif
 
 #define pgd_val(x)	((x).pgd)
@@ -191,15 +183,4 @@ typedef struct page *pgtable_t;
  */
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 
-#ifdef CONFIG_SUPERH64
-/*
- * While BYTES_PER_WORD == 4 on the current sh64 ABI, GCC will still
- * happily generate {ld/st}.q pairs, requiring us to have 8-byte
- * alignment to avoid traps. The kmalloc alignment is guaranteed by
- * virtue of L1_CACHE_BYTES, requiring this to only be special cased
- * for slab caches.
- */
-#define ARCH_SLAB_MINALIGN	8
-#endif
-
 #endif /* __ASM_SH_PAGE_H */
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index cbd0f3c55a0c..02d936406c6e 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -76,18 +76,10 @@ static inline unsigned long phys_addr_mask(void)
 #define PTE_PHYS_MASK		(phys_addr_mask() & PAGE_MASK)
 #define PTE_FLAGS_MASK		(~(PTE_PHYS_MASK) << PAGE_SHIFT)
 
-#ifdef CONFIG_SUPERH32
 #define VMALLOC_START	(P3SEG)
-#else
-#define VMALLOC_START	(0xf0000000)
-#endif
 #define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 
-#if defined(CONFIG_SUPERH32)
 #include <asm/pgtable_32.h>
-#else
-#include <asm/pgtable_64.h>
-#endif
 
 /*
  * SH-X and lower (legacy) SuperH parts (SH-3, SH-4, some SH-4A) can't do page
@@ -159,15 +151,6 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 		prot |= _PAGE_EXT(_PAGE_EXT_KERN_WRITE | _PAGE_EXT_USER_WRITE);
 	return __pte_access_permitted(pte, prot);
 }
-#elif defined(CONFIG_SUPERH64)
-static inline bool pte_access_permitted(pte_t pte, bool write)
-{
-	u64 prot = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
-
-	if (write)
-		prot |= _PAGE_WRITE;
-	return __pte_access_permitted(pte, prot);
-}
 #else
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
diff --git a/arch/sh/include/asm/posix_types.h b/arch/sh/include/asm/posix_types.h
index 0d670fd94fe7..f8982b757c33 100644
--- a/arch/sh/include/asm/posix_types.h
+++ b/arch/sh/include/asm/posix_types.h
@@ -1,6 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-# ifdef CONFIG_SUPERH32
-#  include <asm/posix_types_32.h>
-# else
-#  include <asm/posix_types_64.h>
-# endif
+#include <asm/posix_types_32.h>
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 6fbf8c80e498..3820d698846e 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -39,9 +39,6 @@ enum cpu_type {
 	/* SH4AL-DSP types */
 	CPU_SH7343, CPU_SH7722, CPU_SH7366, CPU_SH7372,
 
-	/* SH-5 types */
-        CPU_SH5_101, CPU_SH5_103,
-
 	/* Unknown subtype */
 	CPU_SH_NONE
 };
@@ -53,7 +50,6 @@ enum cpu_family {
 	CPU_FAMILY_SH4,
 	CPU_FAMILY_SH4A,
 	CPU_FAMILY_SH4AL_DSP,
-	CPU_FAMILY_SH5,
 	CPU_FAMILY_UNKNOWN,
 };
 
@@ -167,18 +163,12 @@ int vsyscall_init(void);
  */
 #ifdef CONFIG_CPU_SH2A
 extern unsigned int instruction_size(unsigned int insn);
-#elif defined(CONFIG_SUPERH32)
-#define instruction_size(insn)	(2)
 #else
-#define instruction_size(insn)	(4)
+#define instruction_size(insn)	(2)
 #endif
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_SUPERH32
-# include <asm/processor_32.h>
-#else
-# include <asm/processor_64.h>
-#endif
+#include <asm/processor_32.h>
 
 #endif /* __ASM_SH_PROCESSOR_H */
diff --git a/arch/sh/include/asm/string.h b/arch/sh/include/asm/string.h
index 84fc5ed9c5b3..0f6331ec28ed 100644
--- a/arch/sh/include/asm/string.h
+++ b/arch/sh/include/asm/string.h
@@ -1,6 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifdef CONFIG_SUPERH32
-# include <asm/string_32.h>
-#else
-# include <asm/string_64.h>
-#endif
+#include <asm/string_32.h>
diff --git a/arch/sh/include/asm/switch_to.h b/arch/sh/include/asm/switch_to.h
index 9eec80ab5aa2..bd139bcdeec1 100644
--- a/arch/sh/include/asm/switch_to.h
+++ b/arch/sh/include/asm/switch_to.h
@@ -4,13 +4,4 @@
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
  */
-#ifndef __ASM_SH_SWITCH_TO_H
-#define __ASM_SH_SWITCH_TO_H
-
-#ifdef CONFIG_SUPERH32
-# include <asm/switch_to_32.h>
-#else
-# include <asm/switch_to_64.h>
-#endif
-
-#endif /* __ASM_SH_SWITCH_TO_H */
+#include <asm/switch_to_32.h>
diff --git a/arch/sh/include/asm/syscall.h b/arch/sh/include/asm/syscall.h
index 90ba00002626..570699eb0e58 100644
--- a/arch/sh/include/asm/syscall.h
+++ b/arch/sh/include/asm/syscall.h
@@ -4,10 +4,6 @@
 
 extern const unsigned long sys_call_table[];
 
-#ifdef CONFIG_SUPERH32
-# include <asm/syscall_32.h>
-#else
-# include <asm/syscall_64.h>
-#endif
+#include <asm/syscall_32.h>
 
 #endif /* __ASM_SH_SYSCALL_H */
diff --git a/arch/sh/include/asm/syscalls.h b/arch/sh/include/asm/syscalls.h
index 995ef046232c..387105316d28 100644
--- a/arch/sh/include/asm/syscalls.h
+++ b/arch/sh/include/asm/syscalls.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_SYSCALLS_H
 #define __ASM_SH_SYSCALLS_H
 
-#ifdef __KERNEL__
-
 asmlinkage int old_mmap(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			int fd, unsigned long off);
@@ -11,11 +9,6 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 			  unsigned long prot, unsigned long flags,
 			  unsigned long fd, unsigned long pgoff);
 
-#ifdef CONFIG_SUPERH32
-# include <asm/syscalls_32.h>
-#else
-# include <asm/syscalls_64.h>
-#endif
+#include <asm/syscalls_32.h>
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_SYSCALLS_H */
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index cf5c792bf70b..6404be69d5fa 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -70,9 +70,7 @@ register unsigned long current_stack_pointer asm("r15") __used;
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
-#if defined(CONFIG_SUPERH64)
-	__asm__ __volatile__ ("getcon	cr17, %0" : "=r" (ti));
-#elif defined(CONFIG_CPU_HAS_SR_RB)
+#if defined(CONFIG_CPU_HAS_SR_RB)
 	__asm__ __volatile__ ("stc	r7_bank, %0" : "=r" (ti));
 #else
 	unsigned long __dummy;
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index bc77f3dd4261..360f713d009b 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -2,10 +2,6 @@
 #ifndef __ASM_SH_TLB_H
 #define __ASM_SH_TLB_H
 
-#ifdef CONFIG_SUPERH64
-# include <asm/tlb_64.h>
-#endif
-
 #ifndef __ASSEMBLY__
 #include <linux/pagemap.h>
 
@@ -14,7 +10,7 @@
 
 #include <asm-generic/tlb.h>
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_SUPERH64)
+#if defined(CONFIG_CPU_SH4)
 extern void tlb_wire_entry(struct vm_area_struct *, unsigned long, pte_t);
 extern void tlb_unwire_entry(void);
 #else
diff --git a/arch/sh/include/asm/traps.h b/arch/sh/include/asm/traps.h
index 8844ed0c0fde..ba831bc7e08f 100644
--- a/arch/sh/include/asm/traps.h
+++ b/arch/sh/include/asm/traps.h
@@ -4,11 +4,7 @@
 
 #include <linux/compiler.h>
 
-#ifdef CONFIG_SUPERH32
 # include <asm/traps_32.h>
-#else
-# include <asm/traps_64.h>
-#endif
 
 BUILD_TRAP_HANDLER(address_error);
 BUILD_TRAP_HANDLER(debug);
diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
index df96c511bb6e..68eb24ad2013 100644
--- a/arch/sh/include/asm/types.h
+++ b/arch/sh/include/asm/types.h
@@ -9,13 +9,8 @@
  */
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_SUPERH32
 typedef u16 insn_size_t;
 typedef u32 reg_size_t;
-#else
-typedef u32 insn_size_t;
-typedef u64 reg_size_t;
-#endif
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_SH_TYPES_H */
diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index 5fe751ad7582..73f3b48d4a34 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -96,11 +96,7 @@ struct __large_struct { unsigned long buf[100]; };
 	__pu_err;						\
 })
 
-#ifdef CONFIG_SUPERH32
 # include <asm/uaccess_32.h>
-#else
-# include <asm/uaccess_64.h>
-#endif
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index 9c7d9d9999c6..d6e126250136 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -1,9 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-# ifdef CONFIG_SUPERH32
-#  include <asm/unistd_32.h>
-# else
-#  include <asm/unistd_64.h>
-# endif
+#include <asm/unistd_32.h>
 
 #define NR_syscalls	__NR_syscalls
 
diff --git a/arch/sh/include/asm/user.h b/arch/sh/include/asm/user.h
index e97f2efed527..7dfd3f6461e6 100644
--- a/arch/sh/include/asm/user.h
+++ b/arch/sh/include/asm/user.h
@@ -28,19 +28,12 @@
  *	to write an integer number of pages.
  */
 
-#if defined(__SH5__) || defined(CONFIG_CPU_SH5)
-struct user_fpu_struct {
-	unsigned long fp_regs[32];
-	unsigned int fpscr;
-};
-#else
 struct user_fpu_struct {
 	unsigned long fp_regs[16];
 	unsigned long xfp_regs[16];
 	unsigned long fpscr;
 	unsigned long fpul;
 };
-#endif
 
 struct user {
 	struct pt_regs	regs;			/* entire machine state */
diff --git a/arch/sh/include/asm/vmlinux.lds.h b/arch/sh/include/asm/vmlinux.lds.h
index 992955685874..558de31f16ed 100644
--- a/arch/sh/include/asm/vmlinux.lds.h
+++ b/arch/sh/include/asm/vmlinux.lds.h
@@ -15,12 +15,6 @@
 #define DWARF_EH_FRAME
 #endif
 
-#ifdef CONFIG_SUPERH64
-#define EXTRA_TEXT		\
-	*(.text64)		\
-	*(.text..SHmedia32)
-#else
 #define EXTRA_TEXT
-#endif
 
 #endif /* __ASM_SH_VMLINUX_LDS_H */
diff --git a/arch/sh/include/uapi/asm/ptrace.h b/arch/sh/include/uapi/asm/ptrace.h
index 4ec9c2b65fdb..5c88e46b7773 100644
--- a/arch/sh/include/uapi/asm/ptrace.h
+++ b/arch/sh/include/uapi/asm/ptrace.h
@@ -25,11 +25,6 @@
 #define PT_DATA_ADDR		248	/* &(struct user)->start_data */
 #define PT_TEXT_LEN		252
 
-#if defined(__SH5__) || defined(CONFIG_CPU_SH5)
-#include <asm/ptrace_64.h>
-#else
 #include <asm/ptrace_32.h>
-#endif
-
 
 #endif /* _UAPI__ASM_SH_PTRACE_H */
diff --git a/arch/sh/include/uapi/asm/sigcontext.h b/arch/sh/include/uapi/asm/sigcontext.h
index d2b7e4f033c0..a9cc8bad0f36 100644
--- a/arch/sh/include/uapi/asm/sigcontext.h
+++ b/arch/sh/include/uapi/asm/sigcontext.h
@@ -5,18 +5,6 @@
 struct sigcontext {
 	unsigned long	oldmask;
 
-#if defined(__SH5__) || defined(CONFIG_CPU_SH5)
-	/* CPU registers */
-	unsigned long long sc_regs[63];
-	unsigned long long sc_tregs[8];
-	unsigned long long sc_pc;
-	unsigned long long sc_sr;
-
-	/* FPU registers */
-	unsigned long long sc_fpregs[32];
-	unsigned int sc_fpscr;
-	unsigned int sc_fpvalid;
-#else
 	/* CPU registers */
 	unsigned long sc_regs[16];
 	unsigned long sc_pc;
@@ -32,7 +20,6 @@ struct sigcontext {
 	unsigned int sc_fpscr;
 	unsigned int sc_fpul;
 	unsigned int sc_ownedfp;
-#endif
 };
 
 #endif /* __ASM_SH_SIGCONTEXT_H */
diff --git a/arch/sh/include/uapi/asm/stat.h b/arch/sh/include/uapi/asm/stat.h
index 659b87c7c25a..b0ca755ea08d 100644
--- a/arch/sh/include/uapi/asm/stat.h
+++ b/arch/sh/include/uapi/asm/stat.h
@@ -16,66 +16,6 @@ struct __old_kernel_stat {
 	unsigned long  st_ctime;
 };
 
-#if defined(__SH5__) || defined(CONFIG_CPU_SH5)
-struct stat {
-	unsigned short st_dev;
-	unsigned short __pad1;
-	unsigned long st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned short __pad2;
-	unsigned long  st_size;
-	unsigned long  st_blksize;
-	unsigned long  st_blocks;
-	unsigned long  st_atime;
-	unsigned long  st_atime_nsec;
-	unsigned long  st_mtime;
-	unsigned long  st_mtime_nsec;
-	unsigned long  st_ctime;
-	unsigned long  st_ctime_nsec;
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-/* This matches struct stat64 in glibc2.1, hence the absolutely
- * insane amounts of padding around dev_t's.
- */
-struct stat64 {
-	unsigned short	st_dev;
-	unsigned char	__pad0[10];
-
-	unsigned long	st_ino;
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
-
-	unsigned long	st_uid;
-	unsigned long	st_gid;
-
-	unsigned short	st_rdev;
-	unsigned char	__pad3[10];
-
-	long long	st_size;
-	unsigned long	st_blksize;
-
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* future possible st_blocks high bits */
-
-	unsigned long	st_atime;
-	unsigned long	st_atime_nsec;
-
-	unsigned long	st_mtime;
-	unsigned long	st_mtime_nsec;
-
-	unsigned long	st_ctime;
-	unsigned long	st_ctime_nsec;	/* will be high 32 bits of ctime someday */
-
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-#else
 struct stat {
 	unsigned long  st_dev;
 	unsigned long  st_ino;
@@ -134,6 +74,5 @@ struct stat64 {
 };
 
 #define STAT_HAVE_NSEC 1
-#endif
 
 #endif /* __ASM_SH_STAT_H */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 59673f8a3379..b0f5574b6228 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= head_$(BITS).o vmlinux.lds
+extra-y	:= head_32.o vmlinux.lds
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
@@ -13,26 +13,26 @@ endif
 CFLAGS_REMOVE_return_address.o = -pg
 
 obj-y	:= debugtraps.o dumpstack.o 		\
-	   idle.o io.o irq.o irq_$(BITS).o kdebugfs.o			\
+	   idle.o io.o irq.o irq_32.o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
-	   process_$(BITS).o ptrace.o ptrace_$(BITS).o			\
+	   process_32.o ptrace.o ptrace_32.o				\
 	   reboot.o return_address.o					\
-	   setup.o signal_$(BITS).o sys_sh.o 				\
-	   syscalls_$(BITS).o time.o topology.o traps.o			\
-	   traps_$(BITS).o unwinder.o
+	   setup.o signal_32.o sys_sh.o 				\
+	   syscalls_32.o time.o topology.o traps.o			\
+	   traps_32.o unwinder.o
 
 ifndef CONFIG_GENERIC_IOMAP
 obj-y				+= iomap.o
 obj-$(CONFIG_HAS_IOPORT_MAP)	+= ioport.o
 endif
 
-obj-$(CONFIG_SUPERH32)		+= sys_sh32.o
+obj-y				+= sys_sh32.o
 obj-y				+= cpu/
 obj-$(CONFIG_VSYSCALL)		+= vsyscall/
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_MODULES)		+= sh_ksyms_$(BITS).o module.o
+obj-$(CONFIG_MODULES)		+= sh_ksyms_32.o module.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index f7c22ea98b0f..46118236bf04 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_CPU_SH2)		= sh2/
 obj-$(CONFIG_CPU_SH2A)		= sh2a/
 obj-$(CONFIG_CPU_SH3)		= sh3/
 obj-$(CONFIG_CPU_SH4)		= sh4/
-obj-$(CONFIG_CPU_SH5)		= sh5/
 
 # Special cases for family ancestry.
 
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index ce7291e12a30..1d008745877f 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -103,7 +103,7 @@ void __attribute__ ((weak)) l2_cache_init(void)
 /*
  * Generic first-level cache init
  */
-#if defined(CONFIG_SUPERH32) && !defined(CONFIG_CPU_J2)
+#if !defined(CONFIG_CPU_J2)
 static void cache_init(void)
 {
 	unsigned long ccr, flags;
diff --git a/arch/sh/kernel/cpu/irq/Makefile b/arch/sh/kernel/cpu/irq/Makefile
index 8b91cb96411b..e4578cde46ba 100644
--- a/arch/sh/kernel/cpu/irq/Makefile
+++ b/arch/sh/kernel/cpu/irq/Makefile
@@ -2,6 +2,5 @@
 #
 # Makefile for the Linux/SuperH CPU-specific IRQ handlers.
 #
-obj-$(CONFIG_SUPERH32)			+= imask.o
-obj-$(CONFIG_CPU_SH5)			+= intc-sh5.o
+obj-y					+= imask.o
 obj-$(CONFIG_CPU_HAS_IPR_IRQ)		+= ipr.o
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index 85961b4f9c69..a306bcd6b341 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -24,7 +24,6 @@ static const char *cpu_name[] = {
 	[CPU_SH7343]	= "SH7343",	[CPU_SH7785]	= "SH7785",
 	[CPU_SH7786]	= "SH7786",	[CPU_SH7757]	= "SH7757",
 	[CPU_SH7722]	= "SH7722",	[CPU_SHX3]	= "SH-X3",
-	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
 	[CPU_SH7366]	= "SH7366",	[CPU_SH7724]	= "SH7724",
 	[CPU_SH7372]	= "SH7372",	[CPU_SH7734]	= "SH7734",
diff --git a/arch/sh/kernel/module.c b/arch/sh/kernel/module.c
index bbc78d1d618e..b9cee98a754e 100644
--- a/arch/sh/kernel/module.c
+++ b/arch/sh/kernel/module.c
@@ -46,15 +46,6 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			+ ELF32_R_SYM(rel[i].r_info);
 		relocation = sym->st_value + rel[i].r_addend;
 
-#ifdef CONFIG_SUPERH64
-		/* For text addresses, bit2 of the st_other field indicates
-		 * whether the symbol is SHmedia (1) or SHcompact (0).  If
-		 * SHmedia, the LSB of the symbol needs to be asserted
-		 * for the CPU to be in SHmedia mode when it starts executing
-		 * the branch target. */
-		relocation |= !!(sym->st_other & 4);
-#endif
-
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
 		case R_SH_NONE:
 			break;
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index 4d1bfc848dd3..169832fcf21b 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -23,9 +23,7 @@ EXPORT_SYMBOL(__stack_chk_guard);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-#ifdef CONFIG_SUPERH32
 	unlazy_fpu(src, task_pt_regs(src));
-#endif
 	*dst = *src;
 
 	if (src->thread.xstate) {
diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 11001a8a5fe0..5c33f036418b 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -4,9 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/module.h>
-#ifdef CONFIG_SUPERH32
 #include <asm/watchdog.h>
-#endif
 #include <asm/addrspace.h>
 #include <asm/reboot.h>
 #include <asm/tlbflush.h>
@@ -15,13 +13,11 @@
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
-#ifdef CONFIG_SUPERH32
 static void watchdog_trigger_immediate(void)
 {
 	sh_wdt_write_cnt(0xFF);
 	sh_wdt_write_csr(0xC2);
 }
-#endif
 
 static void native_machine_restart(char * __unused)
 {
@@ -33,10 +29,8 @@ static void native_machine_restart(char * __unused)
 	/* Address error with SR.BL=1 first. */
 	trigger_address_error();
 
-#ifdef CONFIG_SUPERH32
 	/* If that fails or is unsupported, go for the watchdog next. */
 	watchdog_trigger_immediate();
-#endif
 
 	/*
 	 * Give up and sleep.
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index c60b19958c35..bde7a6c01aaf 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -3,14 +3,7 @@
  * ld script to make SuperH Linux kernel
  * Written by Niibe Yutaka and Paul Mundt
  */
-#ifdef CONFIG_SUPERH64
-#define LOAD_OFFSET	PAGE_OFFSET
-OUTPUT_ARCH(sh:sh5)
-#else
-#define LOAD_OFFSET	0
 OUTPUT_ARCH(sh)
-#endif
-
 #include <asm/thread_info.h>
 #include <asm/cache.h>
 #include <asm/vmlinux.lds.h>
@@ -28,14 +21,13 @@ SECTIONS
 
 	_text = .;		/* Text and read-only data */
 
-	.empty_zero_page : AT(ADDR(.empty_zero_page) - LOAD_OFFSET) {
+	.empty_zero_page : AT(ADDR(.empty_zero_page)) {
 		*(.empty_zero_page)
 	} = 0
 
-	.text : AT(ADDR(.text) - LOAD_OFFSET) {
+	.text : AT(ADDR(.text)) {
 		HEAD_TEXT
 		TEXT_TEXT
-		EXTRA_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
@@ -62,7 +54,7 @@ SECTIONS
 	INIT_DATA_SECTION(16)
 
 	. = ALIGN(4);
-	.machvec.init : AT(ADDR(.machvec.init) - LOAD_OFFSET) {
+	.machvec.init : AT(ADDR(.machvec.init)) {
 		__machvec_start = .;
 		*(.machvec.init)
 		__machvec_end = .;
@@ -74,8 +66,8 @@ SECTIONS
 	 * .exit.text is discarded at runtime, not link time, to deal with
 	 * references from __bug_table
 	 */
-	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { EXIT_TEXT }
-	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { EXIT_DATA }
+	.exit.text : AT(ADDR(.exit.text)) { EXIT_TEXT }
+	.exit.data : AT(ADDR(.exit.data)) { EXIT_DATA }
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5c8a2ebfc720..6c39d24ad919 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -15,8 +15,7 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default "0x80000000" if MMU && SUPERH32
-	default "0x20000000" if MMU && SUPERH64
+	default "0x80000000" if MMU
 	default "0x00000000"
 
 config FORCE_MAX_ZONEORDER
@@ -72,12 +71,11 @@ config MEMORY_SIZE
 
 config 29BIT
 	def_bool !32BIT
-	depends on SUPERH32
 	select UNCACHED_MAPPING
 
 config 32BIT
 	bool
-	default y if CPU_SH5 || !MMU
+	default !MMU
 
 config PMB
 	bool "Support 32-bit physical addressing through PMB"
@@ -152,7 +150,7 @@ config ARCH_MEMORY_PROBE
 
 config IOREMAP_FIXED
        def_bool y
-       depends on X2TLB || SUPERH64
+       depends on X2TLB
 
 config UNCACHED_MAPPING
 	bool
@@ -184,7 +182,7 @@ config PAGE_SIZE_16KB
 
 config PAGE_SIZE_64KB
 	bool "64kB"
-	depends on !MMU || CPU_SH4 || CPU_SH5
+	depends on !MMU || CPU_SH4
 	help
 	  This enables support for 64kB pages, possible on all SH-4
 	  CPUs and later.
@@ -216,10 +214,6 @@ config HUGETLB_PAGE_SIZE_64MB
 	bool "64MB"
 	depends on X2TLB
 
-config HUGETLB_PAGE_SIZE_512MB
-	bool "512MB"
-	depends on CPU_SH5
-
 endchoice
 
 config SCHED_MC
@@ -242,7 +236,7 @@ config SH7705_CACHE_32KB
 
 choice
 	prompt "Cache mode"
-	default CACHE_WRITEBACK if CPU_SH2A || CPU_SH3 || CPU_SH4 || CPU_SH5
+	default CACHE_WRITEBACK if CPU_SH2A || CPU_SH3 || CPU_SH4
 	default CACHE_WRITETHROUGH if (CPU_SH2 && !CPU_SH2A)
 
 config CACHE_WRITEBACK
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 5051b38fd5b6..33445feb0faa 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -10,7 +10,6 @@ cacheops-$(CONFIG_CPU_SUBTYPE_SH7619)	:= cache-sh2.o
 cacheops-$(CONFIG_CPU_SH2A)		:= cache-sh2a.o
 cacheops-$(CONFIG_CPU_SH3)		:= cache-sh3.o
 cacheops-$(CONFIG_CPU_SH4)		:= cache-sh4.o flush-sh4.o
-cacheops-$(CONFIG_CPU_SH5)		:= cache-sh5.o flush-sh4.o
 cacheops-$(CONFIG_SH7705_CACHE_32KB)	+= cache-sh7705.o
 cacheops-$(CONFIG_CPU_SHX3)		+= cache-shx3.o
 
@@ -31,7 +30,6 @@ ifdef CONFIG_MMU
 debugfs-$(CONFIG_CPU_SH4)	+= tlb-debugfs.o
 tlb-$(CONFIG_CPU_SH3)		:= tlb-sh3.o
 tlb-$(CONFIG_CPU_SH4)		:= tlb-sh4.o tlb-urb.o
-tlb-$(CONFIG_CPU_SH5)		:= tlb-sh5.o
 tlb-$(CONFIG_CPU_HAS_PTEAEX)	:= tlb-pteaex.o tlb-urb.o
 obj-y				+= $(tlb-y)
 endif
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 464f160a9576..3aef78ceb820 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -355,12 +355,6 @@ void __init cpu_cache_init(void)
 		}
 	}
 
-	if (boot_cpu_data.family == CPU_FAMILY_SH5) {
-		extern void __weak sh5_cache_init(void);
-
-		sh5_cache_init();
-	}
-
 skip:
 	emit_cache_params();
 }
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ec873f09c763..527957d9c6ce 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1516,7 +1516,7 @@ config RTC_DRV_GENERIC
 	tristate "Generic RTC support"
 	# Please consider writing a new RTC driver instead of using the generic
 	# RTC abstraction
-	depends on PARISC || M68K || PPC || SUPERH32 || COMPILE_TEST
+	depends on PARISC || M68K || PPC || SUPERH || COMPILE_TEST
 	help
 	  Say Y or M here to enable RTC support on systems using the generic
 	  RTC abstraction. If you do not know what you are doing, you should
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..fb6efe5210e2 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -39,7 +39,7 @@ config ARCH_BINFMT_ELF_STATE
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on (ARM || (SUPERH32 && !MMU) || C6X)
+	depends on (ARM || (SUPERH && !MMU) || C6X)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a5c36b..720f2e6b176a 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -81,9 +81,6 @@ arch/ia64/include/uapi/asm/cmpxchg.h:CONFIG_IA64_DEBUG_CMPXCHG
 arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
-arch/sh/include/uapi/asm/ptrace.h:CONFIG_CPU_SH5
-arch/sh/include/uapi/asm/sigcontext.h:CONFIG_CPU_SH5
-arch/sh/include/uapi/asm/stat.h:CONFIG_CPU_SH5
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
 arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-- 
2.26.0

