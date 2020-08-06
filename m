Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D672F2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYGAeFMY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6gWuqTVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHFXik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHFXij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56C6C061574;
        Thu,  6 Aug 2020 16:38:38 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dh878ulTm58j52vB2t8SDG3bvxlQZveC80F1dZ6R2E=;
        b=MYGAeFMYosluD7w5a9vE7HGkv8qeKKWv4pKOvlZKmT2l/9fPH5B+52eubByMu5ltimc594
        BrrpdoLQeENyWOvx8qjQdiSf64aEASZfbage1gJBRMhQbhrrPX4+ikFm9vjvG1vb8hoIW/
        zhimPvhIXN9SYZhAkfPUWGUkl69VhZXdzI0AjxbacDFTnBJONEjob6lFaQ1b8xsHiNhapw
        xq8jcSWYyqgo2qhnFaZXx16LkRbx20eqLR5MEIwHrzpbRaetzB3HSPn1/EhGFYQBeJM1n7
        p+1uWB0xiqPQA4onRza+3+i5CfoJIq/2ixljDkaIqldwhegiglLmhN+WeXyV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dh878ulTm58j52vB2t8SDG3bvxlQZveC80F1dZ6R2E=;
        b=6gWuqTVIBhH4G5EpmHxOvGWmdQpN2ExZkzFYp1otcZD4mQMfyX/P+jnZ6U3IvIo/VhA/z9
        YhBrVsupQO5X8lAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/seqlock, headers: Untangle the
 spaghetti monster
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804133438.GK2674@hirez.programming.kicks-ass.net>
References: <20200804133438.GK2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159675711517.3192.14692354707303315043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     0cd39f4600ed4de859383018eb10f0f724900e1b
Gitweb:        https://git.kernel.org/tip/0cd39f4600ed4de859383018eb10f0f724900e1b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 Aug 2020 14:35:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 16:13:13 +02:00

locking/seqlock, headers: Untangle the spaghetti monster

By using lockdep_assert_*() from seqlock.h, the spaghetti monster
attacked.

Attack back by reducing seqlock.h dependencies from two key high level headers:

 - <linux/seqlock.h>:               -Remove <linux/ww_mutex.h>
 - <linux/time.h>:                  -Remove <linux/seqlock.h>
 - <linux/sched.h>:                 +Add    <linux/seqlock.h>

The price was to add it to sched.h ...

Core header fallout, we add direct header dependencies instead of gaining them
parasitically from higher level headers:

 - <linux/dynamic_queue_limits.h>:  +Add <asm/bug.h>
 - <linux/hrtimer.h>:               +Add <linux/seqlock.h>
 - <linux/ktime.h>:                 +Add <asm/bug.h>
 - <linux/lockdep.h>:               +Add <linux/smp.h>
 - <linux/sched.h>:                 +Add <linux/seqlock.h>
 - <linux/videodev2.h>:             +Add <linux/kernel.h>

Arch headers fallout:

 - PARISC: <asm/timex.h>:           +Add <asm/special_insns.h>
 - SH:     <asm/io.h>:              +Add <asm/page.h>
 - SPARC:  <asm/timer_64.h>:        +Add <uapi/asm/asi.h>
 - SPARC:  <asm/vvar.h>:            +Add <asm/processor.h>, <asm/barrier.h>
                                    -Remove <linux/seqlock.h>
 - X86:    <asm/fixmap.h>:          +Add <asm/pgtable_types.h>
                                    -Remove <asm/acpi.h>

There's also a bunch of parasitic header dependency fallout in .c files, not listed
separately.

[ mingo: Extended the changelog, split up & fixed the original patch. ]

Co-developed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200804133438.GK2674@hirez.programming.kicks-ass.net
---
 arch/sh/include/asm/io.h             |  1 +
 arch/sh/kernel/machvec.c             |  1 +
 arch/sparc/include/asm/timer_64.h    |  1 +
 arch/sparc/include/asm/vvar.h        |  3 ++-
 arch/sparc/kernel/vdso.c             |  1 -
 arch/x86/include/asm/fixmap.h        |  2 +-
 arch/x86/kernel/apic/apic_noop.c     |  1 +
 arch/x86/kernel/apic/hw_nmi.c        |  1 +
 arch/x86/kernel/apic/probe_64.c      |  1 +
 arch/x86/kernel/cpu/amd.c            |  1 +
 arch/x86/kernel/cpu/common.c         |  1 +
 arch/x86/kernel/cpu/hygon.c          |  1 +
 arch/x86/kernel/cpu/intel.c          |  1 +
 arch/x86/kernel/jailhouse.c          |  1 +
 arch/x86/kernel/tsc_msr.c            |  1 +
 arch/x86/mm/init_32.c                |  1 +
 arch/x86/xen/apic.c                  |  1 +
 arch/x86/xen/smp_hvm.c               |  1 +
 arch/x86/xen/suspend_pv.c            |  4 ++--
 include/linux/dynamic_queue_limits.h |  2 ++
 include/linux/hrtimer.h              |  1 +
 include/linux/ktime.h                |  1 +
 include/linux/lockdep.h              |  1 +
 include/linux/mutex.h                | 11 +++++++++++
 include/linux/sched.h                |  1 +
 include/linux/seqlock.h              |  1 -
 include/linux/time.h                 |  1 -
 include/linux/videodev2.h            |  1 +
 include/linux/ww_mutex.h             |  8 --------
 29 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 26f0f9b..ec587b5 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -17,6 +17,7 @@
 #include <asm/cache.h>
 #include <asm/addrspace.h>
 #include <asm/machvec.h>
+#include <asm/page.h>
 #include <linux/pgtable.h>
 #include <asm-generic/iomap.h>
 
diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index beadbbd..76bd895 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/processor.h>
 
 #define MV_NAME_SIZE 32
 
diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index c7e4fb6..dcfad46 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -7,6 +7,7 @@
 #ifndef _SPARC64_TIMER_H
 #define _SPARC64_TIMER_H
 
+#include <uapi/asm/asi.h>
 #include <linux/types.h>
 #include <linux/init.h>
 
diff --git a/arch/sparc/include/asm/vvar.h b/arch/sparc/include/asm/vvar.h
index 0289503..6eaf5cf 100644
--- a/arch/sparc/include/asm/vvar.h
+++ b/arch/sparc/include/asm/vvar.h
@@ -6,7 +6,8 @@
 #define _ASM_SPARC_VVAR_DATA_H
 
 #include <asm/clocksource.h>
-#include <linux/seqlock.h>
+#include <asm/processor.h>
+#include <asm/barrier.h>
 #include <linux/time.h>
 #include <linux/types.h>
 
diff --git a/arch/sparc/kernel/vdso.c b/arch/sparc/kernel/vdso.c
index 5888066..0e27437 100644
--- a/arch/sparc/kernel/vdso.c
+++ b/arch/sparc/kernel/vdso.c
@@ -7,7 +7,6 @@
  *  a different vsyscall implementation for Linux/IA32 and for the name.
  */
 
-#include <linux/seqlock.h>
 #include <linux/time.h>
 #include <linux/timekeeper_internal.h>
 
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index b9527a5..0f0dd64 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -26,9 +26,9 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
-#include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
+#include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 98c9bb7..780c702 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -10,6 +10,7 @@
  * like self-ipi, etc...
  */
 #include <linux/cpumask.h>
+#include <linux/thread_info.h>
 
 #include <asm/apic.h>
 
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index d1fc62a..34a992e 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -9,6 +9,7 @@
  *  Bits copied from original nmi.c file
  *
  */
+#include <linux/thread_info.h>
 #include <asm/apic.h>
 #include <asm/nmi.h>
 
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index 29f0e09..bd3835d 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -8,6 +8,7 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
+#include <linux/thread_info.h>
 #include <asm/apic.h>
 
 #include "local.h"
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d4806ea..dcc3d94 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,6 +15,7 @@
 #include <asm/cpu.h>
 #include <asm/spec-ctrl.h>
 #include <asm/smp.h>
+#include <asm/numa.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
 #include <asm/debugreg.h>
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 95c090a..52b5650 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -45,6 +45,7 @@
 #include <asm/mtrr.h>
 #include <asm/hwcap2.h>
 #include <linux/numa.h>
+#include <asm/numa.h>
 #include <asm/asm.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 4e28c1f..ac6c30e 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/cpu.h>
 #include <asm/smp.h>
+#include <asm/numa.h>
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0ab48f1..6eb42d7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -23,6 +23,7 @@
 #include <asm/cmdline.h>
 #include <asm/traps.h>
 #include <asm/resctrl.h>
+#include <asm/numa.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 2caf5b9..4eb8f2d 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -14,6 +14,7 @@
 #include <linux/serial_8250.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
+#include <asm/acpi.h>
 #include <asm/cpu.h>
 #include <asm/hypervisor.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3..46c72f2 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/thread_info.h>
 
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 8b4afad..d46a5cf 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -52,6 +52,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/init.h>
 #include <asm/pgtable_areas.h>
+#include <asm/numa.h>
 
 #include "mm_internal.h"
 
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 2df7d08..1aff4ae 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/thread_info.h>
 
 #include <asm/x86_init.h>
 #include <asm/apic.h>
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index f8d3944..f5e7db4 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/thread_info.h>
 #include <asm/smp.h>
 
 #include <xen/events.h>
diff --git a/arch/x86/xen/suspend_pv.c b/arch/x86/xen/suspend_pv.c
index 8303b58..cae9660 100644
--- a/arch/x86/xen/suspend_pv.c
+++ b/arch/x86/xen/suspend_pv.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 
-#include <asm/fixmap.h>
-
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 
+#include <asm/fixmap.h>
+
 #include "xen-ops.h"
 
 void xen_pv_pre_suspend(void)
diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 99fc06f..407c2f2 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -38,6 +38,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/bug.h>
+
 struct dql {
 	/* Fields accessed in enqueue path (dql_queued) */
 	unsigned int	num_queued;		/* Total ever queued */
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 25993b8..107cedd 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu.h>
+#include <linux/seqlock.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
 
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 42d2e6a..a12b552 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -23,6 +23,7 @@
 
 #include <linux/time.h>
 #include <linux/jiffies.h>
+#include <asm/bug.h>
 
 /* Nanosecond scalar representation for kernel time values */
 typedef s64	ktime_t;
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 39a3569..62a382d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_H
 
 #include <linux/lockdep_types.h>
+#include <linux/smp.h>
 #include <asm/percpu.h>
 
 struct task_struct;
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index ae197cc..dcd185c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -65,6 +65,17 @@ struct mutex {
 #endif
 };
 
+struct ww_class;
+struct ww_acquire_ctx;
+
+struct ww_mutex {
+	struct mutex base;
+	struct ww_acquire_ctx *ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	struct ww_class *ww_class;
+#endif
+};
+
 /*
  * This is the control structure for tasks blocked on mutex,
  * which resides on the blocked task's kernel stack:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9a9d826..7c7a949 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -31,6 +31,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
+#include <linux/seqlock.h>
 #include <linux/kcsan.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a076f78..962d976 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -19,7 +19,6 @@
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
-#include <linux/ww_mutex.h>
 
 #include <asm/processor.h>
 
diff --git a/include/linux/time.h b/include/linux/time.h
index 4c325bf..b142cb5 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -3,7 +3,6 @@
 #define _LINUX_TIME_H
 
 # include <linux/cache.h>
-# include <linux/seqlock.h>
 # include <linux/math64.h>
 # include <linux/time64.h>
 
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 16c0ed6..219037f 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -57,6 +57,7 @@
 #define __LINUX_VIDEODEV2_H
 
 #include <linux/time.h>     /* need struct timeval */
+#include <linux/kernel.h>
 #include <uapi/linux/videodev2.h>
 
 #endif /* __LINUX_VIDEODEV2_H */
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index d755425..850424e 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -48,14 +48,6 @@ struct ww_acquire_ctx {
 #endif
 };
 
-struct ww_mutex {
-	struct mutex base;
-	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	struct ww_class *ww_class;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class) \
 		, .ww_class = class
