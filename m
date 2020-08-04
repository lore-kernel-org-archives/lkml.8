Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B72C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0EE206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tjtrdh+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHDNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHDNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:34:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370EAC06174A;
        Tue,  4 Aug 2020 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TP1yuY+J7KEmkgmTgxCb3upBLyUkHbc2Ou8BpzfNTZM=; b=tjtrdh+EyWiwEBWCkdYds0zxgn
        zJqVMhVaCZrwcNSCeN97hqjzeyE15DtZXwkgpvoWd//FFTu3cXVlPfH9uyQBvV9Q45faQpwjCZJ3e
        u0W9OeqoouYaFAjQdA8pA7RKZSnD2sV2QxzzHB7ZQedK5xKXsfv8l1clCZWO8y9Fv9nA298Y7zyB0
        UXYZdf1v/nZXS0CemnZ41WrIMIpMGeZe9YNe1wnMvaBxVWzkm21zdA/YGOd0wwGvpGzjcpMeP8d0B
        a3SyplAbBknFMeLqZ/ZD0VZVWCygkrX3fUhsLZro54/9+KuwPOGY8EzLhVRx0xF7glrxzGpWrb9hZ
        0FNkuaHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2x5V-0002dO-V9; Tue, 04 Aug 2020 13:34:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63CAB301E02;
        Tue,  4 Aug 2020 15:34:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43FB02B622ED0; Tue,  4 Aug 2020 15:34:38 +0200 (CEST)
Date:   Tue, 4 Aug 2020 15:34:38 +0200
From:   peterz@infradead.org
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to
 build
Message-ID: <20200804133438.GK2674@hirez.programming.kicks-ass.net>
References: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:17:16PM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Linus git master sources:
> 
> $ git desc
> v5.8-2483-gc0842fbc1b18
> 

Ooh, it looks like that series wasn't cut back far enough :/

859247d39fb0 ("seqlock: lockdep assert non-preemptibility on seqcount_t
write") does indeed also introduce problems.

I've been working on untangling the header mess for the full series and
the below patch is what I currently have.

---
Subject: seqlock,headers: Untangle the spaghetti monster
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jul 30 13:20:47 CEST 2020

By using lockdep_assert_*() from seqlock.h, the spaghetti monster
attacked.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/ia64/include/asm/smp.h          |   35 --------------------------
 arch/ia64/include/asm/xtp.h          |   46 +++++++++++++++++++++++++++++++++++
 arch/ia64/kernel/iosapic.c           |    1 
 arch/ia64/kernel/irq.c               |    1 
 arch/ia64/kernel/process.c           |    1 
 arch/ia64/kernel/sal.c               |    1 
 arch/ia64/kernel/setup.c             |    1 
 arch/ia64/kernel/smp.c               |    1 
 arch/parisc/include/asm/timex.h      |    1 
 arch/sh/include/asm/io.h             |    1 
 arch/sh/kernel/machvec.c             |    1 
 arch/sparc/include/asm/timer_64.h    |    1 
 arch/sparc/include/asm/vvar.h        |    3 +-
 arch/sparc/kernel/vdso.c             |    1 
 arch/x86/include/asm/fixmap.h        |    2 -
 arch/x86/kernel/apic/apic_noop.c     |    1 
 arch/x86/kernel/apic/hw_nmi.c        |    1 
 arch/x86/kernel/apic/probe_64.c      |    1 
 arch/x86/kernel/cpu/amd.c            |    1 
 arch/x86/kernel/cpu/common.c         |    1 
 arch/x86/kernel/cpu/hygon.c          |    1 
 arch/x86/kernel/cpu/intel.c          |    1 
 arch/x86/kernel/jailhouse.c          |    1 
 arch/x86/kernel/tsc_msr.c            |    1 
 arch/x86/mm/init_32.c                |    1 
 arch/x86/xen/apic.c                  |    1 
 arch/x86/xen/smp_hvm.c               |    1 
 arch/x86/xen/suspend_pv.c            |    4 +--
 include/linux/dynamic_queue_limits.h |    2 +
 include/linux/hrtimer.h              |    1 
 include/linux/ktime.h                |    1 
 include/linux/lockdep.h              |    1 
 include/linux/mutex.h                |   11 ++++++++
 include/linux/sched.h                |    1 
 include/linux/seqlock.h              |    1 
 include/linux/time.h                 |    1 
 include/linux/videodev2.h            |    1 
 include/linux/ww_mutex.h             |    8 ------
 38 files changed, 91 insertions(+), 50 deletions(-)

--- a/arch/ia64/include/asm/smp.h
+++ b/arch/ia64/include/asm/smp.h
@@ -18,7 +18,6 @@
 #include <linux/bitops.h>
 #include <linux/irqreturn.h>
 
-#include <asm/io.h>
 #include <asm/param.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -44,11 +43,6 @@ ia64_get_lid (void)
 
 #ifdef CONFIG_SMP
 
-#define XTP_OFFSET		0x1e0008
-
-#define SMP_IRQ_REDIRECTION	(1 << 0)
-#define SMP_IPI_REDIRECTION	(1 << 1)
-
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 extern struct smp_boot_data {
@@ -62,7 +56,6 @@ extern cpumask_t cpu_core_map[NR_CPUS];
 DECLARE_PER_CPU_SHARED_ALIGNED(cpumask_t, cpu_sibling_map);
 extern int smp_num_siblings;
 extern void __iomem *ipi_base_addr;
-extern unsigned char smp_int_redirect;
 
 extern volatile int ia64_cpu_to_sapicid[];
 #define cpu_physical_id(i)	ia64_cpu_to_sapicid[i]
@@ -84,34 +77,6 @@ cpu_logical_id (int cpuid)
 	return i;
 }
 
-/*
- * XTP control functions:
- *	min_xtp   : route all interrupts to this CPU
- *	normal_xtp: nominal XTP value
- *	max_xtp   : never deliver interrupts to this CPU.
- */
-
-static inline void
-min_xtp (void)
-{
-	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
-		writeb(0x00, ipi_base_addr + XTP_OFFSET); /* XTP to min */
-}
-
-static inline void
-normal_xtp (void)
-{
-	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
-		writeb(0x08, ipi_base_addr + XTP_OFFSET); /* XTP normal */
-}
-
-static inline void
-max_xtp (void)
-{
-	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
-		writeb(0x0f, ipi_base_addr + XTP_OFFSET); /* Set XTP to max */
-}
-
 /* Upping and downing of CPUs */
 extern int __cpu_disable (void);
 extern void __cpu_die (unsigned int cpu);
--- /dev/null
+++ b/arch/ia64/include/asm/xtp.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_IA64_XTP_H
+#define _ASM_IA64_XTP_H
+
+#include <asm/io.h>
+
+#ifdef CONFIG_SMP
+
+#define XTP_OFFSET		0x1e0008
+
+#define SMP_IRQ_REDIRECTION	(1 << 0)
+#define SMP_IPI_REDIRECTION	(1 << 1)
+
+extern unsigned char smp_int_redirect;
+
+/*
+ * XTP control functions:
+ *	min_xtp   : route all interrupts to this CPU
+ *	normal_xtp: nominal XTP value
+ *	max_xtp   : never deliver interrupts to this CPU.
+ */
+
+static inline void
+min_xtp (void)
+{
+	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
+		writeb(0x00, ipi_base_addr + XTP_OFFSET); /* XTP to min */
+}
+
+static inline void
+normal_xtp (void)
+{
+	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
+		writeb(0x08, ipi_base_addr + XTP_OFFSET); /* XTP normal */
+}
+
+static inline void
+max_xtp (void)
+{
+	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
+		writeb(0x0f, ipi_base_addr + XTP_OFFSET); /* Set XTP to max */
+}
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_IA64_XTP_Hy */
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -95,6 +95,7 @@
 #include <asm/iosapic.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include <asm/xtp.h>
 
 #undef DEBUG_INTERRUPT_ROUTING
 
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 
 #include <asm/mca.h>
+#include <asm/xtp.h>
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -48,6 +48,7 @@
 #include <linux/uaccess.h>
 #include <asm/unwind.h>
 #include <asm/user.h>
+#include <asm/xtp.h>
 
 #include "entry.h"
 
--- a/arch/ia64/kernel/sal.c
+++ b/arch/ia64/kernel/sal.c
@@ -18,6 +18,7 @@
 #include <asm/page.h>
 #include <asm/sal.h>
 #include <asm/pal.h>
+#include <asm/xtp.h>
 
  __cacheline_aligned DEFINE_SPINLOCK(sal_lock);
 unsigned long sal_platform_features;
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -65,6 +65,7 @@
 #include <asm/tlbflush.h>
 #include <asm/unistd.h>
 #include <asm/uv/uv.h>
+#include <asm/xtp.h>
 
 #if defined(CONFIG_SMP) && (IA64_CPU_SIZE > PAGE_SIZE)
 # error "struct cpuinfo_ia64 too big!"
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -46,6 +46,7 @@
 #include <asm/tlbflush.h>
 #include <asm/unistd.h>
 #include <asm/mca.h>
+#include <asm/xtp.h>
 
 /*
  * Note: alignment of 4 entries/cacheline was empirically determined
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -7,6 +7,7 @@
 #ifndef _ASMPARISC_TIMEX_H
 #define _ASMPARISC_TIMEX_H
 
+#include <asm/special_insns.h>
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
 
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -17,6 +17,7 @@
 #include <asm/cache.h>
 #include <asm/addrspace.h>
 #include <asm/machvec.h>
+#include <asm/page.h>
 #include <linux/pgtable.h>
 #include <asm-generic/iomap.h>
 
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/processor.h>
 
 #define MV_NAME_SIZE 32
 
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -7,6 +7,7 @@
 #ifndef _SPARC64_TIMER_H
 #define _SPARC64_TIMER_H
 
+#include <uapi/asm/asi.h>
 #include <linux/types.h>
 #include <linux/init.h>
 
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
 
--- a/arch/sparc/kernel/vdso.c
+++ b/arch/sparc/kernel/vdso.c
@@ -7,7 +7,6 @@
  *  a different vsyscall implementation for Linux/IA32 and for the name.
  */
 
-#include <linux/seqlock.h>
 #include <linux/time.h>
 #include <linux/timekeeper_internal.h>
 
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
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -10,6 +10,7 @@
  * like self-ipi, etc...
  */
 #include <linux/cpumask.h>
+#include <linux/thread_info.h>
 
 #include <asm/apic.h>
 
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -9,6 +9,7 @@
  *  Bits copied from original nmi.c file
  *
  */
+#include <linux/thread_info.h>
 #include <asm/apic.h>
 #include <asm/nmi.h>
 
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -8,6 +8,7 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
+#include <linux/thread_info.h>
 #include <asm/apic.h>
 
 #include "local.h"
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
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/cpu.h>
 #include <asm/smp.h>
+#include <asm/numa.h>
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -23,6 +23,7 @@
 #include <asm/cmdline.h>
 #include <asm/traps.h>
 #include <asm/resctrl.h>
+#include <asm/numa.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -13,6 +13,7 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 #include <asm/apic.h>
+#include <asm/acpi.h>
 #include <asm/cpu.h>
 #include <asm/hypervisor.h>
 #include <asm/i8259.h>
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/thread_info.h>
 
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -52,6 +52,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/init.h>
 #include <asm/pgtable_areas.h>
+#include <asm/numa.h>
 
 #include "mm_internal.h"
 
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/thread_info.h>
 
 #include <asm/x86_init.h>
 #include <asm/apic.h>
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/thread_info.h>
 #include <asm/smp.h>
 
 #include <xen/events.h>
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
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -38,6 +38,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/bug.h>
+
 struct dql {
 	/* Fields accessed in enqueue path (dql_queued) */
 	unsigned int	num_queued;		/* Total ever queued */
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu.h>
+#include <linux/seqlock.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
 
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -23,6 +23,7 @@
 
 #include <linux/time.h>
 #include <linux/jiffies.h>
+#include <asm/bug.h>
 
 /* Nanosecond scalar representation for kernel time values */
 typedef s64	ktime_t;
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_H
 
 #include <linux/lockdep_types.h>
+#include <linux/smp.h>
 #include <asm/percpu.h>
 
 struct task_struct;
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
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
+#include <linux/seqlock.h>
 #include <linux/kcsan.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -19,7 +19,6 @@
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
-#include <linux/ww_mutex.h>
 
 #include <asm/processor.h>
 
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -3,7 +3,6 @@
 #define _LINUX_TIME_H
 
 # include <linux/cache.h>
-# include <linux/seqlock.h>
 # include <linux/math64.h>
 # include <linux/time64.h>
 
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -57,6 +57,7 @@
 #define __LINUX_VIDEODEV2_H
 
 #include <linux/time.h>     /* need struct timeval */
+#include <linux/kernel.h>
 #include <uapi/linux/videodev2.h>
 
 #endif /* __LINUX_VIDEODEV2_H */
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
