Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB6020656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b+eiUXYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgG2W01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2W01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:26:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF13C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1mWUpRRtRnpezHlNKGxWxS+GzPW6m8BSxTzeFmSuSGs=; b=b+eiUXYNGrkwqYxOd7RfEEuOxJ
        5zdOIDCBYFiOQjbDgu7TaN00CAX+BiC9CdDIVxHtzuAMWSvtI3EnqjYRXryW1Z5pxLpXdad0fLevS
        CLKPzNYaymZo2vhMHg8KwjoewXAlAv4w1GRpDyN1x2yYhqKpJkO+mH87AZavfoOOwNpKYl2d+gCP7
        ODA8ky1ImPXblFFuuKpY3eiLZszaajLNhfP+HNCboFRR71FCyexDm0TunjHKjG7IJm4p8geFQ3KRq
        eyRoubRHAcl8oLtdG6+75ML/UD1AjpmakK5CM9du1o3SGitboh0cR7cWNjBIWRItD4yMPxk/17+7a
        ghRST8kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0uWS-0001N6-NF; Wed, 29 Jul 2020 22:26:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3022304D58;
        Thu, 30 Jul 2020 00:26:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D5C425E22879; Thu, 30 Jul 2020 00:26:01 +0200 (CEST)
Date:   Thu, 30 Jul 2020 00:26:01 +0200
From:   peterz@infradead.org
To:     kernel test robot <lkp@intel.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:locking/core 9/30] arch/mips/include/asm/smp.h:28:19:
 error: static declaration of 'raw_smp_processor_id' follows non-static
 declaration
Message-ID: <20200729222601.GF2655@hirez.programming.kicks-ass.net>
References: <202007300207.bfb4aRER%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007300207.bfb4aRER%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:05:18AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   b5e6a027bd327daa679ca55182a920659e2cbb90
> commit: 859247d39fb008ea812e8f0c398a58a20c12899e [9/30] seqlock: lockdep assert non-preemptibility on seqcount_t write
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 859247d39fb008ea812e8f0c398a58a20c12899e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/mips/include/asm/bug.h:42,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:12,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/mips/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/seqlock.h:15,
>                     from include/linux/time.h:6,
>                     from include/linux/compat.h:10,
>                     from arch/mips/kernel/asm-offsets.c:12:
>    include/linux/seqlock.h: In function 'write_seqcount_begin_nested':

*sigh*, so I've no idea what happened, I've had these patches in my git
tree for about a week and the worst 0day found was a Sparse bug :/

Anyway, I've got the below hackery, and am now able to build:

 - sparc64
 - mips
 - x86_64
 - arm
 - arm64
 - powerpc64
 - powerpc

allmodconfig vmlinux (that is, the vmlinux target of that config, I
didn't power up an EX because the kids are asleep, so building full
allmodconfig's is out).

i386 is broken, but I'm too tired, I've not yet tried any of the other
archs. I'll continue in the morning if Ingo doesn't beat me to it.


---
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
 arch/x86/xen/apic.c                  |  1 +
 arch/x86/xen/smp_hvm.c               |  1 +
 arch/x86/xen/suspend_pv.c            |  4 ++--
 include/asm-generic/fixmap.h         |  4 ++--
 include/linux/dynamic_queue_limits.h |  2 ++
 include/linux/hrtimer.h              |  1 +
 include/linux/ktime.h                |  1 +
 include/linux/lockdep.h              |  1 +
 include/linux/mutex.h                | 11 +++++++++++
 include/linux/sched.h                |  1 +
 include/linux/seqlock.h              |  1 -
 include/linux/time.h                 |  1 -
 include/linux/ww_mutex.h             |  8 --------
 26 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index c7e4fb601a57..dcfad4613e18 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -7,6 +7,7 @@
 #ifndef _SPARC64_TIMER_H
 #define _SPARC64_TIMER_H
 
+#include <uapi/asm/asi.h>
 #include <linux/types.h>
 #include <linux/init.h>
 
diff --git a/arch/sparc/include/asm/vvar.h b/arch/sparc/include/asm/vvar.h
index 0289503d1cb0..6eaf5cfcaae1 100644
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
index 58880662b271..0e27437eb97b 100644
--- a/arch/sparc/kernel/vdso.c
+++ b/arch/sparc/kernel/vdso.c
@@ -7,7 +7,6 @@
  *  a different vsyscall implementation for Linux/IA32 and for the name.
  */
 
-#include <linux/seqlock.h>
 #include <linux/time.h>
 #include <linux/timekeeper_internal.h>
 
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index b9527a54db99..0f0dd645b594 100644
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
index 98c9bb75d185..780c702969b7 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -10,6 +10,7 @@
  * like self-ipi, etc...
  */
 #include <linux/cpumask.h>
+#include <linux/thread_info.h>
 
 #include <asm/apic.h>
 
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index d1fc62a67320..34a992e275ef 100644
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
index 29f0e0984557..bd3835d6b535 100644
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
index d4806eac9325..dcc3d943c68f 100644
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
index 95c090a45b4b..52b565016eb1 100644
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
index 4e28c1fc8749..ac6c30e5801d 100644
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
index 0ab48f1cdf84..6eb42d7a3dfd 100644
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
index 6eb8b50ea07e..2db888cbc2ea 100644
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
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3a1858..46c72f2ec32f 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/thread_info.h>
 
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 5e53bfbe5823..984a26d7ffd7 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/thread_info.h>
 
 #include <asm/x86_init.h>
 #include <asm/apic.h>
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index f8d39440b292..f5e7db4f82ab 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/thread_info.h>
 #include <asm/smp.h>
 
 #include <xen/events.h>
diff --git a/arch/x86/xen/suspend_pv.c b/arch/x86/xen/suspend_pv.c
index 8303b58c79a9..cae9660f4c67 100644
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
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 8cc7b09c1bc7..d798a407b549 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -16,7 +16,7 @@
 #define __ASM_GENERIC_FIXMAP_H
 
 #include <linux/bug.h>
-#include <linux/mm_types.h>
+//#include <linux/mm_types.h>
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
@@ -61,7 +61,7 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #endif
 
 #ifndef set_fixmap
-#define set_fixmap(idx, phys)				\
+#define set_fixmap(idx, phys)			\
 	__set_fixmap(idx, phys, FIXMAP_PAGE_NORMAL)
 #endif
 
diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 99fc06f0afc1..407c2f281b64 100644
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
index 25993b86ac5c..107cedd7019a 100644
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
index 42d2e6ac35f2..a12b5523cc18 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -23,6 +23,7 @@
 
 #include <linux/time.h>
 #include <linux/jiffies.h>
+#include <asm/bug.h>
 
 /* Nanosecond scalar representation for kernel time values */
 typedef s64	ktime_t;
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 39a35699d0d6..62a382d1845b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_H
 
 #include <linux/lockdep_types.h>
+#include <linux/smp.h>
 #include <asm/percpu.h>
 
 struct task_struct;
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index ae197cc00cc8..dcd185cbfe79 100644
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
index 2ede13a080fb..c26c4e857286 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
+#include <linux/seqlock.h>
 #include <linux/kcsan.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a076f783aa36..962d9768945f 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -19,7 +19,6 @@
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
-#include <linux/ww_mutex.h>
 
 #include <asm/processor.h>
 
diff --git a/include/linux/time.h b/include/linux/time.h
index 4c325bf44ce0..b142cb5f5a53 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -3,7 +3,6 @@
 #define _LINUX_TIME_H
 
 # include <linux/cache.h>
-# include <linux/seqlock.h>
 # include <linux/math64.h>
 # include <linux/time64.h>
 
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index d7554252404c..850424e5d030 100644
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
