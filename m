Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EE42065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHSInCv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFENWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFENWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:22:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53381C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:22:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so9722290wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cq5fX+bpLSy6uSSoDVV3qE07g/yYDJmAmlVeivVCrbg=;
        b=tHSInCv5tmCFl7C+FnF0hUzspzSSZSZrWDsVSUq206gZxw7YgZ2NBZIf6oCRVum1SG
         JW8bRAorhwLFDzhc7ZfmRsk4NBrxhrgb0/cMFdQ8Ik2dU933gTZknQ24Vwn4kJCX5LoI
         Anznf+o/JC/qoT7xZpdMv8Ky0agesGgWYBDLuRVVS5vofYoTUiTee8PZelDWuzTSYrRD
         pLOSTu9VAPK1eSVX5Di98VQEM1p7LLQmM2/wYMhDDFn6oCs41NrRR9WXAM9+eOa+iWNa
         VdUVKestQGLO24NWBCUTLbYS6UGLr7hXbu00iOCixNhhtqUNmvtBUC+gt2F+CHUSyh84
         dJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cq5fX+bpLSy6uSSoDVV3qE07g/yYDJmAmlVeivVCrbg=;
        b=oNsn2N6NDVVzYnQ+7C9AOtOwK2MGKLJWe9sGHX9bZDjJ0jZcBBCEi2BYPq7MVtUq1C
         ieG7bafckbxiHPReuxPdPbqey1RiPPTPWEPPvciSDEfRdxhSOMo2WfNI+W58/XpyPhrt
         KU9xOAJxj8VGZldYKNZbxptFRXjcc7XKZIJCDIurzXCqESgdTtOoIO+hvROr2uVUvJ1F
         PYRJJMFxpm8PaI+z1oYkNGc4Kww3RdRSmCMe9xWEtcSeDc+j3lZBn+/MmlDzxi453ALw
         Tj8lJ4I+WygHHFtma4wSDrq2MX469ERa363c27fUnxWJr0N8umhvixi/00SpaYCznqvn
         PP6A==
X-Gm-Message-State: AOAM532fBkHQcaDgqVn5vNSjpBXsLUfFzBFK28v5M5j5C+rBPOWRID3T
        ytcD/ZCB0rFpcIuXTj+6PRAaOg==
X-Google-Smtp-Source: ABdhPJzpzmNBSznJzF4dI3nAVtneyx7UG1IfG6ZseiC1LlZ025y+KhMI3JPHyGeY5C25gn2owk9Bww==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr9453793wrw.404.1591363347628;
        Fri, 05 Jun 2020 06:22:27 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 1sm11419211wmz.13.2020.06.05.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:22:27 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [RFC PATCH 4/4] kprobes: Allow the kprobes blacklist to be compiled independently
Date:   Fri,  5 Jun 2020 14:21:30 +0100
Message-Id: <20200605132130.1411255-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200605132130.1411255-1-daniel.thompson@linaro.org>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMPORTANT:

  As menitoned in the covering letter, this series in an RFC and this
  patch, in particular, is acknowledged as needing more work. In
  particular I haven't trimmed uneccessary #includes after splitting
  out the code and may also have missed some places where an an
  architecture overrides one of the weak symbols used for blacklist
  checking.

  If I don't get objections to the general approach taken to splitting
  out this code then  I will do the final clean up and detailed review.

The kprobes blacklist is useful for other tools that set breakpoints
such as kgdb or kdb. Currently the blacklist is only available on
platforms where CONFIG_KPROBES is set (when kprobes is not set then
the blacklist essentially covers the entire kernel).

Separate out the blacklist handling logic from the rest of kprobes to
allow it to be compiled independently.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/Kconfig                            |   6 +-
 arch/arm/probes/kprobes/Makefile        |   1 +
 arch/arm/probes/kprobes/blacklist.c     |  37 ++++
 arch/arm/probes/kprobes/core.c          |  10 -
 arch/powerpc/kernel/Makefile            |   1 +
 arch/powerpc/kernel/kprobes-blacklist.c |  34 ++++
 arch/powerpc/kernel/kprobes.c           |   8 -
 include/asm-generic/kprobes.h           |   2 +-
 include/asm-generic/vmlinux.lds.h       |   2 +-
 include/linux/kprobes.h                 |  29 ++-
 kernel/Makefile                         |   1 +
 kernel/kprobes.c                        | 204 +------------------
 kernel/kprobes_blacklist.c              | 260 ++++++++++++++++++++++++
 lib/Kconfig.kgdb                        |   1 +
 14 files changed, 367 insertions(+), 229 deletions(-)
 create mode 100644 arch/arm/probes/kprobes/blacklist.c
 create mode 100644 arch/powerpc/kernel/kprobes-blacklist.c
 create mode 100644 kernel/kprobes_blacklist.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 786a85d4ad40..dd1d709bd195 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -63,7 +63,7 @@ config KPROBES
 	bool "Kprobes"
 	depends on MODULES
 	depends on HAVE_KPROBES
-	select KALLSYMS
+	select KPROBES_BLACKLIST
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
@@ -71,6 +71,10 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config KPROBES_BLACKLIST
+	bool
+	select KALLSYMS
+
 config JUMP_LABEL
 	bool "Optimize very unlikely/likely branches"
 	depends on HAVE_ARCH_JUMP_LABEL
diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
index 14db56f49f0a..8b7ede9fb335 100644
--- a/arch/arm/probes/kprobes/Makefile
+++ b/arch/arm/probes/kprobes/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= core.o actions-common.o checkers-common.o
+obj-$(CONFIG_KPROBES_BLACKLIST)	+= blacklist.o
 obj-$(CONFIG_ARM_KPROBES_TEST)	+= test-kprobes.o
 test-kprobes-objs		:= test-core.o
 
diff --git a/arch/arm/probes/kprobes/blacklist.c b/arch/arm/probes/kprobes/blacklist.c
new file mode 100644
index 000000000000..c3b37f0b59d0
--- /dev/null
+++ b/arch/arm/probes/kprobes/blacklist.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch/arm/kernel/kprobe/blacklist.c
+ *
+ * Kprobes on ARM
+ *
+ * Abhishek Sagar <sagar.abhishek@gmail.com>
+ * Copyright (C) 2006, 2007 Motorola Inc.
+ *
+ * Nicolas Pitre <nico@marvell.com>
+ * Copyright (C) 2007 Marvell Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/stop_machine.h>
+#include <linux/sched/debug.h>
+#include <linux/stringify.h>
+#include <asm/traps.h>
+#include <asm/opcodes.h>
+#include <asm/cacheflush.h>
+#include <linux/percpu.h>
+#include <linux/bug.h>
+#include <asm/patch.h>
+#include <asm/sections.h>
+
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	void *a = (void *)addr;
+
+	return __in_irqentry_text(addr) ||
+	       in_entry_text(addr) ||
+	       in_idmap_text(addr) ||
+	       memory_contains(__kprobes_text_start, __kprobes_text_end, a, 1);
+}
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 90b5bc723c83..dce82761f83a 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -545,13 +545,3 @@ int __init arch_init_kprobes()
 #endif
 	return 0;
 }
-
-bool arch_within_kprobe_blacklist(unsigned long addr)
-{
-	void *a = (void *)addr;
-
-	return __in_irqentry_text(addr) ||
-	       in_entry_text(addr) ||
-	       in_idmap_text(addr) ||
-	       memory_contains(__kprobes_text_start, __kprobes_text_end, a, 1);
-}
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1c4385852d3d..fd912afbb6f1 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KPROBES_BLACKLIST)	+= kprobes-blacklist.o
 obj-$(CONFIG_OPTPROBES)		+= optprobes.o optprobes_head.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= kprobes-ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
diff --git a/arch/powerpc/kernel/kprobes-blacklist.c b/arch/powerpc/kernel/kprobes-blacklist.c
new file mode 100644
index 000000000000..4410a80e313a
--- /dev/null
+++ b/arch/powerpc/kernel/kprobes-blacklist.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Kernel Probes (KProbes)
+ *
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation ( includes contributions from
+ *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
+ * 2004-Nov	Ananth N Mavinakayanahalli <ananth@in.ibm.com> kprobes port
+ *		for PPC64
+ */
+
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/preempt.h>
+#include <linux/extable.h>
+#include <linux/kdebug.h>
+#include <linux/slab.h>
+#include <asm/code-patching.h>
+#include <asm/cacheflush.h>
+#include <asm/sstep.h>
+#include <asm/sections.h>
+#include <linux/uaccess.h>
+
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	return  (addr >= (unsigned long)__kprobes_text_start &&
+		 addr < (unsigned long)__kprobes_text_end) ||
+		(addr >= (unsigned long)_stext &&
+		 addr < (unsigned long)__head_end);
+}
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 81efb605113e..9e87a7fe3207 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -30,14 +30,6 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
-bool arch_within_kprobe_blacklist(unsigned long addr)
-{
-	return  (addr >= (unsigned long)__kprobes_text_start &&
-		 addr < (unsigned long)__kprobes_text_end) ||
-		(addr >= (unsigned long)_stext &&
-		 addr < (unsigned long)__head_end);
-}
-
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 {
 	kprobe_opcode_t *addr = NULL;
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 4a982089c95c..40800c6ff52f 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -3,7 +3,7 @@
 #define _ASM_GENERIC_KPROBES_H
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
-#ifdef CONFIG_KPROBES
+#ifdef CONFIG_KPROBES_BLACKLIST
 /*
  * Blacklist ganerating macro. Specify functions which is not probed
  * by using this macro.
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 71e387a5fe90..bd8bcadba148 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -176,7 +176,7 @@
 #define BRANCH_PROFILE()
 #endif
 
-#ifdef CONFIG_KPROBES
+#ifdef CONFIG_KPROBES_BLACKLIST
 #define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
 				__start_kprobe_blacklist = .;		      \
 				KEEP(*(_kprobe_blacklist))		      \
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 04bdaf01112c..ef6521e75761 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -234,10 +234,6 @@ extern int arch_populate_kprobe_blacklist(void);
 extern bool arch_kprobe_on_func_entry(unsigned long offset);
 extern bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
-extern bool within_kprobe_blacklist(unsigned long addr);
-extern int kprobe_add_ksym_blacklist(unsigned long entry);
-extern int kprobe_add_area_blacklist(unsigned long start, unsigned long end);
-
 struct kprobe_insn_cache {
 	struct mutex mutex;
 	void *(*alloc)(void);	/* allocate insn page */
@@ -350,12 +346,10 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
-kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
 void unregister_kretprobe(struct kretprobe *rp);
@@ -373,6 +367,9 @@ void dump_kprobe(struct kprobe *kp);
 void *alloc_insn_page(void);
 void free_insn_page(void *page);
 
+int init_kprobes(void);
+void debugfs_kprobe_init(struct dentry *dir);
+
 #else /* !CONFIG_KPROBES: */
 
 static inline int kprobes_built_in(void)
@@ -431,11 +428,29 @@ static inline int enable_kprobe(struct kprobe *kp)
 	return -ENOSYS;
 }
 
+static inline int init_kprobes(void)
+{
+	return 0;
+}
+
+static inline void debugfs_kprobe_init(struct dentry *dir)
+{
+}
+#endif /* CONFIG_KPROBES */
+
+#ifdef CONFIG_KPROBES_BLACKLIST
+extern bool within_kprobe_blacklist(unsigned long addr);
+extern int kprobe_add_ksym_blacklist(unsigned long entry);
+extern int kprobe_add_area_blacklist(unsigned long start, unsigned long end);
+kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
+unsigned long arch_deref_entry_point(void *);
+#else /* CONFIG_KPROBES_BLACKLIST */
 static inline bool within_kprobe_blacklist(unsigned long addr)
 {
 	return true;
 }
-#endif /* CONFIG_KPROBES */
+#endif /* CONFIG_KPROBES_BLACKLIST */
+
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
 	return disable_kprobe(&rp->kp);
diff --git a/kernel/Makefile b/kernel/Makefile
index 4cb4130ced32..7ce7948575df 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tre
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
 obj-$(CONFIG_KCOV) += kcov.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_KPROBES_BLACKLIST) += kprobes_blacklist.o
 obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..b592316a5d50 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -59,20 +59,11 @@ static struct {
 	raw_spinlock_t lock ____cacheline_aligned_in_smp;
 } kretprobe_table_locks[KPROBE_TABLE_SIZE];
 
-kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
-					unsigned int __unused)
-{
-	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
-}
-
 static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
 {
 	return &(kretprobe_table_locks[hash].lock);
 }
 
-/* Blacklist -- list of struct kprobe_blacklist_entry */
-static LIST_HEAD(kprobe_blacklist);
-
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
  * kprobe->ainsn.insn points to the copy of the instruction to be
@@ -1419,50 +1410,6 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 	return ret;
 }
 
-bool __weak arch_within_kprobe_blacklist(unsigned long addr)
-{
-	/* The __kprobes marked functions and entry code must not be probed */
-	return addr >= (unsigned long)__kprobes_text_start &&
-	       addr < (unsigned long)__kprobes_text_end;
-}
-
-static bool __within_kprobe_blacklist(unsigned long addr)
-{
-	struct kprobe_blacklist_entry *ent;
-
-	if (arch_within_kprobe_blacklist(addr))
-		return true;
-	/*
-	 * If there exists a kprobe_blacklist, verify and
-	 * fail any probe registration in the prohibited area
-	 */
-	list_for_each_entry(ent, &kprobe_blacklist, list) {
-		if (addr >= ent->start_addr && addr < ent->end_addr)
-			return true;
-	}
-	return false;
-}
-
-bool within_kprobe_blacklist(unsigned long addr)
-{
-	char symname[KSYM_NAME_LEN], *p;
-
-	if (__within_kprobe_blacklist(addr))
-		return true;
-
-	/* Check if the address is on a suffixed-symbol */
-	if (!lookup_symbol_name(addr, symname)) {
-		p = strchr(symname, '.');
-		if (!p)
-			return false;
-		*p = '\0';
-		addr = (unsigned long)kprobe_lookup_name(symname, 0);
-		if (addr)
-			return __within_kprobe_blacklist(addr);
-	}
-	return false;
-}
-
 /*
  * If we have a symbol_name argument, look it up and add the offset field
  * to it. This way, we can specify a relative address to a symbol.
@@ -1845,11 +1792,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 	.priority = 0x7fffffff /* we need to be notified first */
 };
 
-unsigned long __weak arch_deref_entry_point(void *entry)
-{
-	return (unsigned long)entry;
-}
-
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -2143,78 +2085,6 @@ void dump_kprobe(struct kprobe *kp)
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
-int kprobe_add_ksym_blacklist(unsigned long entry)
-{
-	struct kprobe_blacklist_entry *ent;
-	unsigned long offset = 0, size = 0;
-
-	if (!kernel_text_address(entry) ||
-	    !kallsyms_lookup_size_offset(entry, &size, &offset))
-		return -EINVAL;
-
-	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
-	if (!ent)
-		return -ENOMEM;
-	ent->start_addr = entry;
-	ent->end_addr = entry + size;
-	INIT_LIST_HEAD(&ent->list);
-	list_add_tail(&ent->list, &kprobe_blacklist);
-
-	return (int)size;
-}
-
-/* Add all symbols in given area into kprobe blacklist */
-int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
-{
-	unsigned long entry;
-	int ret = 0;
-
-	for (entry = start; entry < end; entry += ret) {
-		ret = kprobe_add_ksym_blacklist(entry);
-		if (ret < 0)
-			return ret;
-		if (ret == 0)	/* In case of alias symbol */
-			ret = 1;
-	}
-	return 0;
-}
-
-int __init __weak arch_populate_kprobe_blacklist(void)
-{
-	return 0;
-}
-
-/*
- * Lookup and populate the kprobe_blacklist.
- *
- * Unlike the kretprobe blacklist, we'll need to determine
- * the range of addresses that belong to the said functions,
- * since a kprobe need not necessarily be at the beginning
- * of a function.
- */
-static int __init populate_kprobe_blacklist(unsigned long *start,
-					     unsigned long *end)
-{
-	unsigned long entry;
-	unsigned long *iter;
-	int ret;
-
-	for (iter = start; iter < end; iter++) {
-		entry = arch_deref_entry_point((void *)*iter);
-		ret = kprobe_add_ksym_blacklist(entry);
-		if (ret == -EINVAL)
-			continue;
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Symbols in __kprobes_text are blacklisted */
-	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
-					(unsigned long)__kprobes_text_end);
-
-	return ret ? : arch_populate_kprobe_blacklist();
-}
-
 /* Module notifier call back, checking kprobes on the module */
 static int kprobes_module_callback(struct notifier_block *nb,
 				   unsigned long val, void *data)
@@ -2264,11 +2134,9 @@ static struct notifier_block kprobe_module_nb = {
 	.priority = 0
 };
 
-/* Markers of _kprobe_blacklist section */
-extern unsigned long __start_kprobe_blacklist[];
-extern unsigned long __stop_kprobe_blacklist[];
 
-static int __init init_kprobes(void)
+
+int __init init_kprobes(void)
 {
 	int i, err = 0;
 
@@ -2280,13 +2148,6 @@ static int __init init_kprobes(void)
 		raw_spin_lock_init(&(kretprobe_table_locks[i].lock));
 	}
 
-	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
-					__stop_kprobe_blacklist);
-	if (err) {
-		pr_err("kprobes: failed to populate blacklist: %d\n", err);
-		pr_err("Please take care of using kprobes.\n");
-	}
-
 	if (kretprobe_blacklist_size) {
 		/* lookup the function address from its name */
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
@@ -2322,7 +2183,6 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
-subsys_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
@@ -2417,54 +2277,6 @@ static const struct file_operations debugfs_kprobes_operations = {
 	.release        = seq_release,
 };
 
-/* kprobes/blacklist -- shows which functions can not be probed */
-static void *kprobe_blacklist_seq_start(struct seq_file *m, loff_t *pos)
-{
-	return seq_list_start(&kprobe_blacklist, *pos);
-}
-
-static void *kprobe_blacklist_seq_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	return seq_list_next(v, &kprobe_blacklist, pos);
-}
-
-static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
-{
-	struct kprobe_blacklist_entry *ent =
-		list_entry(v, struct kprobe_blacklist_entry, list);
-
-	/*
-	 * If /proc/kallsyms is not showing kernel address, we won't
-	 * show them here either.
-	 */
-	if (!kallsyms_show_value())
-		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
-			   (void *)ent->start_addr);
-	else
-		seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
-			   (void *)ent->end_addr, (void *)ent->start_addr);
-	return 0;
-}
-
-static const struct seq_operations kprobe_blacklist_seq_ops = {
-	.start = kprobe_blacklist_seq_start,
-	.next  = kprobe_blacklist_seq_next,
-	.stop  = kprobe_seq_stop,	/* Reuse void function */
-	.show  = kprobe_blacklist_seq_show,
-};
-
-static int kprobe_blacklist_open(struct inode *inode, struct file *filp)
-{
-	return seq_open(filp, &kprobe_blacklist_seq_ops);
-}
-
-static const struct file_operations debugfs_kprobe_blacklist_ops = {
-	.open           = kprobe_blacklist_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = seq_release,
-};
-
 static int arm_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -2615,23 +2427,13 @@ static const struct file_operations fops_kp = {
 	.llseek =	default_llseek,
 };
 
-static int __init debugfs_kprobe_init(void)
+void __init debugfs_kprobe_init(struct dentry *dir)
 {
-	struct dentry *dir;
 	unsigned int value = 1;
 
-	dir = debugfs_create_dir("kprobes", NULL);
-
 	debugfs_create_file("list", 0400, dir, NULL,
 			    &debugfs_kprobes_operations);
 
 	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
-
-	debugfs_create_file("blacklist", 0400, dir, NULL,
-			    &debugfs_kprobe_blacklist_ops);
-
-	return 0;
 }
-
-late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
diff --git a/kernel/kprobes_blacklist.c b/kernel/kprobes_blacklist.c
new file mode 100644
index 000000000000..ee101dfc8899
--- /dev/null
+++ b/kernel/kprobes_blacklist.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Kernel Probes (KProbes)
+ *  kernel/kprobes_blacklist.c
+ *
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation (includes suggestions from
+ *		Rusty Russell).
+ * 2004-Aug	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> with
+ *		hlists and exceptions notifier as suggested by Andi Kleen.
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
+ * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
+ *		exceptions notifier to be first on the priority list.
+ * 2005-May	Hien Nguyen <hien@us.ibm.com>, Jim Keniston
+ *		<jkenisto@us.ibm.com> and Prasanna S Panchamukhi
+ *		<prasanna@in.ibm.com> added function-return probes.
+ */
+#include <linux/kprobes.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/export.h>
+#include <linux/moduleloader.h>
+#include <linux/kallsyms.h>
+#include <linux/freezer.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/sysctl.h>
+#include <linux/kdebug.h>
+#include <linux/memory.h>
+#include <linux/ftrace.h>
+#include <linux/cpu.h>
+#include <linux/jump_label.h>
+
+#include <asm/sections.h>
+#include <asm/cacheflush.h>
+#include <asm/errno.h>
+#include <linux/uaccess.h>
+
+/* Blacklist -- list of struct kprobe_blacklist_entry */
+static LIST_HEAD(kprobe_blacklist);
+
+kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
+					unsigned int __unused)
+{
+	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
+}
+
+bool __weak arch_within_kprobe_blacklist(unsigned long addr)
+{
+	/* The __kprobes marked functions and entry code must not be probed */
+	return addr >= (unsigned long)__kprobes_text_start &&
+	       addr < (unsigned long)__kprobes_text_end;
+}
+
+unsigned long __weak arch_deref_entry_point(void *entry)
+{
+	return (unsigned long)entry;
+}
+
+static bool __within_kprobe_blacklist(unsigned long addr)
+{
+	struct kprobe_blacklist_entry *ent;
+
+	if (arch_within_kprobe_blacklist(addr))
+		return true;
+	/*
+	 * If there exists a kprobe_blacklist, verify and
+	 * fail any probe registration in the prohibited area
+	 */
+	list_for_each_entry(ent, &kprobe_blacklist, list) {
+		if (addr >= ent->start_addr && addr < ent->end_addr)
+			return true;
+	}
+	return false;
+}
+
+bool within_kprobe_blacklist(unsigned long addr)
+{
+	char symname[KSYM_NAME_LEN], *p;
+
+	if (__within_kprobe_blacklist(addr))
+		return true;
+
+	/* Check if the address is on a suffixed-symbol */
+	if (!lookup_symbol_name(addr, symname)) {
+		p = strchr(symname, '.');
+		if (!p)
+			return false;
+		*p = '\0';
+		addr = (unsigned long)kprobe_lookup_name(symname, 0);
+		if (addr)
+			return __within_kprobe_blacklist(addr);
+	}
+	return false;
+}
+
+int kprobe_add_ksym_blacklist(unsigned long entry)
+{
+	struct kprobe_blacklist_entry *ent;
+	unsigned long offset = 0, size = 0;
+
+	if (!kernel_text_address(entry) ||
+	    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		return -EINVAL;
+
+	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+	ent->start_addr = entry;
+	ent->end_addr = entry + size;
+	INIT_LIST_HEAD(&ent->list);
+	list_add_tail(&ent->list, &kprobe_blacklist);
+
+	return (int)size;
+}
+
+/* Add all symbols in given area into kprobe blacklist */
+int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
+{
+	unsigned long entry;
+	int ret = 0;
+
+	for (entry = start; entry < end; entry += ret) {
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)	/* In case of alias symbol */
+			ret = 1;
+	}
+	return 0;
+}
+
+int __init __weak arch_populate_kprobe_blacklist(void)
+{
+	return 0;
+}
+
+/*
+ * Lookup and populate the kprobe_blacklist.
+ *
+ * Unlike the kretprobe blacklist, we'll need to determine
+ * the range of addresses that belong to the said functions,
+ * since a kprobe need not necessarily be at the beginning
+ * of a function.
+ */
+static int __init populate_kprobe_blacklist(unsigned long *start,
+					    unsigned long *end)
+{
+	unsigned long entry;
+	unsigned long *iter;
+	int ret;
+
+	for (iter = start; iter < end; iter++) {
+		entry = arch_deref_entry_point((void *)*iter);
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret == -EINVAL)
+			continue;
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Symbols in __kprobes_text are blacklisted */
+	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
+					(unsigned long)__kprobes_text_end);
+
+	return ret ? : arch_populate_kprobe_blacklist();
+}
+
+/* Markers of _kprobe_blacklist section */
+extern unsigned long __start_kprobe_blacklist[];
+extern unsigned long __stop_kprobe_blacklist[];
+
+static int __init init_kprobes_blacklist(void)
+{
+	int err;
+
+	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
+					__stop_kprobe_blacklist);
+	if (err) {
+		pr_err("kprobes: failed to populate blacklist: %d\n", err);
+		pr_err("Please take care of using kprobes.\n");
+	}
+
+	return init_kprobes();
+}
+subsys_initcall(init_kprobes_blacklist);
+
+#ifdef CONFIG_DEBUG_FS
+/* kprobes/blacklist -- shows which functions can not be probed */
+static void *kprobe_blacklist_seq_start(struct seq_file *m, loff_t *pos)
+{
+	return seq_list_start(&kprobe_blacklist, *pos);
+}
+
+static void *kprobe_blacklist_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &kprobe_blacklist, pos);
+}
+
+static void kprobe_blacklist_seq_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
+}
+
+static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
+{
+	struct kprobe_blacklist_entry *ent =
+		list_entry(v, struct kprobe_blacklist_entry, list);
+
+	/*
+	 * If /proc/kallsyms is not showing kernel address, we won't
+	 * show them here either.
+	 */
+	if (!kallsyms_show_value())
+		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
+			   (void *)ent->start_addr);
+	else
+		seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
+			   (void *)ent->end_addr, (void *)ent->start_addr);
+	return 0;
+}
+
+static const struct seq_operations kprobe_blacklist_seq_ops = {
+	.start = kprobe_blacklist_seq_start,
+	.next  = kprobe_blacklist_seq_next,
+	.stop  = kprobe_blacklist_seq_stop,
+	.show  = kprobe_blacklist_seq_show,
+};
+
+static int kprobe_blacklist_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &kprobe_blacklist_seq_ops);
+}
+
+static const struct file_operations debugfs_kprobe_blacklist_ops = {
+	.open           = kprobe_blacklist_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
+static int __init debugfs_kprobe_blacklist_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("kprobes", NULL);
+	debugfs_kprobe_init(dir);
+
+	debugfs_create_file("blacklist", 0400, dir, NULL,
+			    &debugfs_kprobe_blacklist_ops);
+
+	return 0;
+}
+late_initcall(debugfs_kprobe_blacklist_init);
+#endif /* CONFIG_DEBUG_FS */
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index ffa7a76de086..da372d335882 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -7,6 +7,7 @@ menuconfig KGDB
 	bool "KGDB: kernel debugger"
 	depends on HAVE_ARCH_KGDB
 	depends on DEBUG_KERNEL
+	select KPROBES_BLACKLIST
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb.  It is recommended but not required, that
-- 
2.25.4

