Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270FA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1t2R4u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgAOS2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:28:24 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45583 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAOS2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:28:23 -0500
Received: by mail-pf1-f202.google.com with SMTP id x21so11402867pfp.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9RQh/5QKLq1tjl9ikRbjGdu2IL7r2jcXxm8Y8M/x+EI=;
        b=q1t2R4u2EbEyQyaRr+ZXEXMVpBNqUXeLgvznKQKLGMrYCaeoqIzEAwRqa0yu4ieOCe
         t69Iu7FvTI7CgrRz1bb5PwtA7WZRl1a0+WCmGoIkzCbD2K3xlqdltqNWwKPEQ5rduXVK
         3FxXtVkrz8DR67ipmfGDinlCN0aEh2DAREpzpIoGZHmoEQtUqYhUat/Jl8Taz0XxT+BX
         7YjNDk3qeZITv8b7MT9L7TJP/j5O1nsKJQzpxa+i5OMWvpcyvavAd2Q5o3575KMJMCCf
         56nZlN+a7uFoFz2BiGJTn6u35vtXlf8qu/dK5xf4zHU8tT/0sQbRZxSjFmSkWqDFWUP0
         BAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9RQh/5QKLq1tjl9ikRbjGdu2IL7r2jcXxm8Y8M/x+EI=;
        b=bGxNf7ftWHFYlSjHcrih0hhqympeglgbYZ17RUJ5+jXaEcg2tvsMS/AJhiAQ/Bm/u5
         BSJO2SG7x73hRmS1s9stTWvfRXvfJKHndvIneVcRTbQhMPt0Vyru51OMDhmsIGYofpQ6
         V9qpJ0suDSN/isVluQQJ5RRbTAs5DrHtk3KqqWbqM4XLgoZnk5PQsXr3I2V3ozxaGSgT
         7gxJBaE3ehNBhKRk0hywQAckFmPXDthoQRwYMEIi1nmf8U+Kd1o7GMoTzTc2K4FPjTJv
         itlYHEDKKY5kS5yotplpvcgI7+BSbqVi+4Qdu1kI9EhdRWfzc0eHGVyFezQAWvmomAOP
         7FRw==
X-Gm-Message-State: APjAAAUwWEg0NGwQbWaQjk5NIRu8Rt8Lofo1OfrMk9WP1KXurc0gXtlR
        z3r5sIcbNsqkxIMwuJAvHwjKO9UCw9Di2ctBHrY=
X-Google-Smtp-Source: APXvYqx9qpl23OgOwdz8FfuMEkbfDd87zpGiF53YF8Khk02NXeim7hDqIeOXHTDmOhHT9eymaQUzLMryh7w2sHH4CDg=
X-Received: by 2002:a63:941:: with SMTP id 62mr35749169pgj.203.1579112902953;
 Wed, 15 Jan 2020 10:28:22 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:28:16 -0800
Message-Id: <20200115182816.33892-1-trishalfonso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [RFC PATCH] UML: add support for KASAN under x86_64
From:   Patricia Alfonso <trishalfonso@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, davidgow@google.com,
        brendanhiggins@google.com
Cc:     linux-um@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make KASAN run on User Mode Linux on x86_64.

The location of the KASAN shadow memory, starting at
KASAN_SHADOW_OFFSET, can be configured using the
KASAN_SHADOW_OFFSET option. UML uses roughly 18TB of address
space, and KASAN requires 1/8th of this. For this reason, the default
location is 0x100000000000. There is usually enough free space at
this location; however, it is a config option so that it can be
easily changed if needed.

Functions that are used before KASAN is initialized are excluded from
instrumentation. The UML-specific KASAN initializer uses mmap to map
the roughly 2.25TB of shadow memory to the location defined by
KASAN_SHADOW_OFFSET and ensures that the address space used by the
kernel text and the vmalloc region is not poisoned at
initialization.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
---
 arch/um/Kconfig                | 10 ++++++++++
 arch/um/include/asm/dma.h      |  1 +
 arch/um/include/asm/kasan.h    | 32 ++++++++++++++++++++++++++++++++
 arch/um/kernel/Makefile        |  4 ++++
 arch/um/kernel/kasan_init_um.c | 20 ++++++++++++++++++++
 arch/um/kernel/skas/Makefile   |  6 ++++++
 arch/um/kernel/um_arch.c       |  3 +++
 arch/um/os-Linux/mem.c         | 18 ++++++++++++++++++
 arch/um/os-Linux/user_syms.c   |  4 ++--
 arch/x86/um/Makefile           |  3 ++-
 arch/x86/um/vdso/Makefile      |  3 +++
 kernel/Makefile                |  6 ++++++
 lib/Makefile                   | 10 ++++++++++
 13 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/include/asm/kasan.h
 create mode 100644 arch/um/kernel/kasan_init_um.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 6f0edd0c0220..99c68863e7e9 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -8,6 +8,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_UID16
@@ -198,6 +199,15 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config KASAN_SHADOW_OFFSET
+	hex
+	depends on KASAN
+	default 0x100000000000
+	help
+	  This is the offset at which the ~2.25TB of shadow memory is
+	  initialized and used by KASAN for memory debugging. The default
+	  is 0x100000000000.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/include/asm/dma.h b/arch/um/include/asm/dma.h
index fdc53642c718..8aafd60d62bb 100644
--- a/arch/um/include/asm/dma.h
+++ b/arch/um/include/asm/dma.h
@@ -5,6 +5,7 @@
 #include <asm/io.h>
 
 extern unsigned long uml_physmem;
+extern unsigned long long physmem_size;
 
 #define MAX_DMA_ADDRESS (uml_physmem)
 
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
new file mode 100644
index 000000000000..ca4c43a35d41
--- /dev/null
+++ b/arch/um/include/asm/kasan.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_KASAN_H
+#define __ASM_UM_KASAN_H
+
+#include <linux/init.h>
+#include <linux/const.h>
+
+#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
+#ifdef CONFIG_X86_64
+#define KASAN_SHADOW_SIZE 0x100000000000UL
+#else
+#error "KASAN_SHADOW_SIZE is not defined in this sub-architecture"
+#endif
+
+// used in kasan_mem_to_shadow to divide by 8
+#define KASAN_SHADOW_SCALE_SHIFT 3
+
+#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
+#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
+
+#ifdef CONFIG_KASAN
+void kasan_init(void);
+void kasan_map_shadow(void);
+#else
+static inline void kasan_early_init(void) { }
+static inline void kasan_init(void) { }
+#endif /* CONFIG_KASAN */
+
+void kasan_map_memory(void *start, unsigned long len);
+void kasan_unpoison_shadow(const void *address, size_t size);
+
+#endif /* __ASM_UM_KASAN_H */
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..f783a7dd863c 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -8,6 +8,9 @@
 # kernel.
 KCOV_INSTRUMENT                := n
 
+# Do not instrument on main.o
+KASAN_SANITIZE	:= n
+
 CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_ARCH=$(LDS_ELF_ARCH)	\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
@@ -24,6 +27,7 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-$(CONFIG_KASAN)	+= kasan_init_um.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/kasan_init_um.c b/arch/um/kernel/kasan_init_um.c
new file mode 100644
index 000000000000..2e9a85216fb5
--- /dev/null
+++ b/arch/um/kernel/kasan_init_um.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/kasan.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <asm/dma.h>
+#include <as-layout.h>
+
+void kasan_init(void)
+{
+	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
+
+	// unpoison the kernel text which is form uml_physmem -> uml_reserved
+	kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
+
+	// unpoison the vmalloc region, which is start_vm -> end_vm
+	kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
+
+	init_task.kasan_depth = 0;
+	pr_info("KernelAddressSanitizer initialized\n");
+}
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index f3d494a4fd9b..d68f447274e5 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -5,6 +5,12 @@
 
 obj-y := clone.o mmu.o process.o syscall.o uaccess.o
 
+ifdef CONFIG_UML
+# Do not instrument until after start_uml() because KASAN is not
+# initialized yet
+KASAN_SANITIZE	:= n
+endif
+
 # clone.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
 # disable it
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0f40eccbd759..73cd159d28e8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -14,6 +14,7 @@
 #include <linux/sched/task.h>
 #include <linux/kmsg_dump.h>
 
+#include <asm/kasan.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
@@ -227,6 +228,8 @@ static struct notifier_block panic_exit_notifier = {
 
 void uml_finishsetup(void)
 {
+	kasan_init();
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &panic_exit_notifier);
 
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 3c1b77474d2d..ef282bacc58e 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -17,6 +17,24 @@
 #include <init.h>
 #include <os.h>
 
+/**
+ * kasan_map_memory() - maps memory from @start with a size of @len
+ * @start: the start address of the memory to be mapped
+ * @len: the length of the memory to be mapped
+ *
+ * This function is used to map shadow memory for KASAN in uml
+ */
+void kasan_map_memory(void *start, size_t len)
+{
+	if (mmap(start,
+		 len,
+		 PROT_READ|PROT_WRITE,
+		 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
+		 -1,
+		 0) == MAP_FAILED)
+		os_info("Couldn't allocate shadow memory %s", strerror(errno));
+}
+
 /* Set by make_tempfile() during early boot. */
 static char *tempdir = NULL;
 
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 715594fe5719..cb667c9225ab 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
 #ifndef __x86_64__
 extern void *memcpy(void *, const void *, size_t);
 EXPORT_SYMBOL(memcpy);
-#endif
-
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
+#endif
+
 EXPORT_SYMBOL(printf);
 
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 33c51c064c77..7dbd76c546fe 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -26,7 +26,8 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
+	../lib/memmove_64.o ../lib/memset_64.o
 
 endif
 
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 0caddd6acb22..450efa0fb694 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,6 +3,9 @@
 # Building vDSO images for x86.
 #
 
+# do not instrument on vdso because KASAN is not compatible with user mode
+KASAN_SANITIZE			:= n
+
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT                := n
 
diff --git a/kernel/Makefile b/kernel/Makefile
index f2cc0d118a0b..4fbb72cb253f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -32,6 +32,12 @@ KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
+ifdef CONFIG_UML
+# Do not istrument kasan on panic because it can be called before KASAN
+# is initialized
+KASAN_SANITIZE_panic.o := n
+endif
+
 # cond_syscall is currently not LTO compatible
 CFLAGS_sys_ni.o = $(DISABLE_LTO)
 
diff --git a/lib/Makefile b/lib/Makefile
index 93217d44237f..e28dc5b06ae2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -17,6 +17,16 @@ KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 
+# Don't sanatize vsprintf or string functions in UM because they are used
+# before KASAN is initialized from cmdline parsing cmdline and kstrtox are
+# also called during uml initialization before KASAN is instrumented
+ifdef CONFIG_UML
+KASAN_SANITIZE_vsprintf.o := n
+KASAN_SANITIZE_string.o := n
+KASAN_SANITIZE_cmdline.o := n
+KASAN_SANITIZE_kstrtox.o := n
+endif
+
 # Early boot use of cmdline, don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KASAN_SANITIZE_string.o := n
-- 
2.25.0.rc1.283.g88dfdc4193-goog

