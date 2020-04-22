Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1758BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66E42087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgDVMwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:52:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:14544 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgDVMwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:52:09 -0400
IronPort-SDR: qF6TRgyjzOgeltMuNLlriR6h1aggkk4cNiqKlP2pDwvQsC5Ty1IldQ6TK+ZxuNgP2oGm5RhfEP
 KK9oJCoMZCBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 05:52:09 -0700
IronPort-SDR: XVfy5RVeVikMWBN9wW4aU8hHFd6TBhcaIz4OwSlXwIKp6JH3urB/5okv8Ps2mQRTLHk0iw62Dm
 cVyhuI2+Rv3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="245966348"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2020 05:52:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1D618D4; Wed, 22 Apr 2020 15:52:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 6/7] kernel.h: Split out panic and oops helpers
Date:   Wed, 22 Apr 2020 15:52:00 +0300
Message-Id: <20200422125201.37618-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out panic and
oops helpers.

At the same time convert users in header and lib folder to use new header.
Though for time being include new header back to kernel.h to avoid twisted
indirected includes for existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch
 arch/x86/include/asm/desc.h    |  1 +
 arch/x86/kernel/setup.c        |  1 +
 include/asm-generic/bug.h      |  3 +-
 include/linux/kernel.h         | 67 +-----------------------------
 include/linux/ktime.h          |  2 +
 include/linux/panic.h          | 75 ++++++++++++++++++++++++++++++++++
 include/linux/panic_notifier.h | 12 ++++++
 include/linux/thread_info.h    |  1 +
 kernel/kexec_core.c            |  1 +
 kernel/panic.c                 |  1 +
 kernel/rcu/tree.c              |  2 +
 kernel/trace/trace.c           |  1 +
 lib/errseq.c                   |  1 +
 13 files changed, 101 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/panic.h
 create mode 100644 include/linux/panic_notifier.h

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 68a99d2a5f335..ac3878ac07091 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -9,6 +9,7 @@
 #include <asm/irq_vectors.h>
 #include <asm/cpu_entry_area.h>
 
+#include <linux/debug_locks.h>
 #include <linux/smp.h>
 #include <linux/percpu.h>
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758c..821960a2b412d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -13,6 +13,7 @@
 #include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
 #include <linux/memblock.h>
+#include <linux/panic_notifier.h>
 #include <linux/pci.h>
 #include <linux/root_dev.h>
 #include <linux/sfi.h>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 384b5c835ced3..d3ae3e5b3643e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -16,7 +16,8 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#include <linux/kernel.h>
+#include <linux/panic.h>
+#include <linux/printk.h>
 
 #ifdef CONFIG_BUG
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8a0e5ed1b905a..cd83a57c1b244 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,7 @@
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
+#include <linux/panic.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
 
@@ -76,7 +77,6 @@
 #define lower_32_bits(n) ((u32)(n))
 
 struct completion;
-struct pt_regs;
 struct user;
 
 #ifdef CONFIG_PREEMPT_VOLUNTARY
@@ -159,15 +159,6 @@ void __might_fault(const char *file, int line);
 static inline void might_fault(void) { }
 #endif
 
-extern struct atomic_notifier_head panic_notifier_list;
-extern long (*panic_blink)(int state);
-__printf(1, 2)
-void panic(const char *fmt, ...) __noreturn __cold;
-void nmi_panic(struct pt_regs *regs, const char *msg);
-extern void oops_enter(void);
-extern void oops_exit(void);
-void print_oops_end_marker(void);
-extern int oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
@@ -360,34 +351,7 @@ extern unsigned int sysctl_oops_all_cpu_backtrace;
 #endif /* CONFIG_SMP */
 
 extern void bust_spinlocks(int yes);
-extern int panic_timeout;
-extern unsigned long panic_print;
-extern int panic_on_oops;
-extern int panic_on_unrecovered_nmi;
-extern int panic_on_io_nmi;
-extern int panic_on_warn;
-extern int sysctl_panic_on_rcu_stall;
-extern int sysctl_panic_on_stackoverflow;
 
-extern bool crash_kexec_post_notifiers;
-
-/*
- * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
- * holds a CPU number which is executing panic() currently. A value of
- * PANIC_CPU_INVALID means no CPU has entered panic() or crash_kexec().
- */
-extern atomic_t panic_cpu;
-#define PANIC_CPU_INVALID	-1
-
-/*
- * Only to be used by arch init code. If the user over-wrote the default
- * CONFIG_PANIC_TIMEOUT, honor it.
- */
-static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
-{
-	if (panic_timeout == arch_default_timeout)
-		panic_timeout = timeout;
-}
 extern const char *print_tainted(void);
 enum lockdep_ok {
 	LOCKDEP_STILL_OK,
@@ -414,35 +378,6 @@ extern enum system_states {
 	SYSTEM_SUSPEND,
 } system_state;
 
-/* This cannot be an enum because some may be used in assembly source. */
-#define TAINT_PROPRIETARY_MODULE	0
-#define TAINT_FORCED_MODULE		1
-#define TAINT_CPU_OUT_OF_SPEC		2
-#define TAINT_FORCED_RMMOD		3
-#define TAINT_MACHINE_CHECK		4
-#define TAINT_BAD_PAGE			5
-#define TAINT_USER			6
-#define TAINT_DIE			7
-#define TAINT_OVERRIDDEN_ACPI_TABLE	8
-#define TAINT_WARN			9
-#define TAINT_CRAP			10
-#define TAINT_FIRMWARE_WORKAROUND	11
-#define TAINT_OOT_MODULE		12
-#define TAINT_UNSIGNED_MODULE		13
-#define TAINT_SOFTLOCKUP		14
-#define TAINT_LIVEPATCH			15
-#define TAINT_AUX			16
-#define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
-
-struct taint_flag {
-	char c_true;	/* character printed when tainted */
-	char c_false;	/* character printed when not tainted */
-	bool module;	/* also show as a per-module taint flag */
-};
-
-extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
-
 extern const char hex_asc[];
 #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
 #define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 42d2e6ac35f29..c7aa465a85f77 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -24,6 +24,8 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 
+#include <asm/bug.h>
+
 /* Nanosecond scalar representation for kernel time values */
 typedef s64	ktime_t;
 
diff --git a/include/linux/panic.h b/include/linux/panic.h
new file mode 100644
index 0000000000000..a06e775a5c37f
--- /dev/null
+++ b/include/linux/panic.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PANIC_H
+#define _LINUX_PANIC_H
+
+#include <linux/types.h>
+
+struct pt_regs;
+
+extern long (*panic_blink)(int state);
+__printf(1, 2)
+void panic(const char *fmt, ...) __noreturn __cold;
+void nmi_panic(struct pt_regs *regs, const char *msg);
+extern void oops_enter(void);
+extern void oops_exit(void);
+void print_oops_end_marker(void);
+extern int oops_may_print(void);
+
+extern int panic_timeout;
+extern unsigned long panic_print;
+extern int panic_on_oops;
+extern int panic_on_unrecovered_nmi;
+extern int panic_on_io_nmi;
+extern int panic_on_warn;
+
+extern int sysctl_panic_on_rcu_stall;
+extern int sysctl_panic_on_stackoverflow;
+
+/*
+ * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
+ * holds a CPU number which is executing panic() currently. A value of
+ * PANIC_CPU_INVALID means no CPU has entered panic() or crash_kexec().
+ */
+extern atomic_t panic_cpu;
+#define PANIC_CPU_INVALID	-1
+
+/*
+ * Only to be used by arch init code. If the user over-wrote the default
+ * CONFIG_PANIC_TIMEOUT, honor it.
+ */
+static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
+{
+	if (panic_timeout == arch_default_timeout)
+		panic_timeout = timeout;
+}
+
+/* This cannot be an enum because some may be used in assembly source. */
+#define TAINT_PROPRIETARY_MODULE	0
+#define TAINT_FORCED_MODULE		1
+#define TAINT_CPU_OUT_OF_SPEC		2
+#define TAINT_FORCED_RMMOD		3
+#define TAINT_MACHINE_CHECK		4
+#define TAINT_BAD_PAGE			5
+#define TAINT_USER			6
+#define TAINT_DIE			7
+#define TAINT_OVERRIDDEN_ACPI_TABLE	8
+#define TAINT_WARN			9
+#define TAINT_CRAP			10
+#define TAINT_FIRMWARE_WORKAROUND	11
+#define TAINT_OOT_MODULE		12
+#define TAINT_UNSIGNED_MODULE		13
+#define TAINT_SOFTLOCKUP		14
+#define TAINT_LIVEPATCH			15
+#define TAINT_AUX			16
+#define TAINT_RANDSTRUCT		17
+#define TAINT_FLAGS_COUNT		18
+
+struct taint_flag {
+	char c_true;	/* character printed when tainted */
+	char c_false;	/* character printed when not tainted */
+	bool module;	/* also show as a per-module taint flag */
+};
+
+extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
+
+#endif	/* _LINUX_PANIC_H */
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
new file mode 100644
index 0000000000000..41e32483d7a7b
--- /dev/null
+++ b/include/linux/panic_notifier.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PANIC_NOTIFIERS_H
+#define _LINUX_PANIC_NOTIFIERS_H
+
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+extern struct atomic_notifier_head panic_notifier_list;
+
+extern bool crash_kexec_post_notifiers;
+
+#endif	/* _LINUX_PANIC_NOTIFIERS_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249a4e9bf..7a3033aef28cd 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -35,6 +35,7 @@ enum {
 	GOOD_STACK,
 };
 
+#include <asm/bug.h>
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ba1d91e868ca7..077fcf31d5ce9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/device.h>
 #include <linux/freezer.h>
+#include <linux/panic_notifier.h>
 #include <linux/pfn.h>
 #include <linux/pm.h>
 #include <linux/cpu.h>
diff --git a/kernel/panic.c b/kernel/panic.c
index ec6d7d788ce75..f28a7478e0161 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -23,6 +23,7 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/kexec.h>
+#include <linux/panic_notifier.h>
 #include <linux/sched.h>
 #include <linux/sysrq.h>
 #include <linux/init.h>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6d39485f7f517..8611f400acd91 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -32,6 +32,8 @@
 #include <linux/export.h>
 #include <linux/completion.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
+#include <linux/panic_notifier.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d2b988126250..f23b6ae084b5c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/panic_notifier.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e72..93e9b94358dc6 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -3,6 +3,7 @@
 #include <linux/bug.h>
 #include <linux/atomic.h>
 #include <linux/errseq.h>
+#include <linux/log2.h>
 
 /*
  * An errseq_t is a way of recording errors in one place, and allowing any
-- 
2.26.1

