Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA88720714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQSPIwrT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GoPOJ+jJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgH3SEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgH3SEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:04:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5DFC061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:04:03 -0700 (PDT)
Date:   Sun, 30 Aug 2020 18:03:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598810641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=J/AbQGSLM4DW+8xAbazmgbb8xlIxdfVSO24gjB8EDpY=;
        b=zQSPIwrT6Z1GS62dHzPRhU3ZX8wYwbOQYCyh4KxispxDilvAOCVB2+kw6WfYKySCdGQqXZ
        xdx754wRik7Q03L7lAfkG6+rJN/9+5WgO2CcPW95MdMawrld7A5IoCWkgaROM/+Buj9CK6
        vhcZ9g3qZmJbLuV38nmZz99tm8uwMm/60+wFH0gHcynNiTxBamBD+iZlGH5VihDOQrhr6b
        z2Q7w0T3YPrB+UScO3xN4MSR/ROFwFzenHIDni41nAGYeq1v1VKVvYROrW28Fu1CZ5+Bwh
        xjMfxpSlZZJfafzJJ6aPx2T5qtVf9raTw099TYrLthYqlSS2FOKb1Rg7idVLAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598810641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=J/AbQGSLM4DW+8xAbazmgbb8xlIxdfVSO24gjB8EDpY=;
        b=GoPOJ+jJ6wFkThd9tIvYCxiw4PyBnWIMohu4LF3cDI1C98PDlkphT2B1M8oDgpI5NwC/h+
        D7ZdVvw2fBo8O3CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.9-rc2
References: <159881061564.27993.11909051048930389391.tglx@nanos>
Message-ID: <159881061684.27993.2189953397609628514.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-30

up to:  eb1f00237aca: lockdep,trace: Expose tracepoints


A set of fixes for lockdep, tracing and RCU:

  - Prevent recursion by using raw_cpu_* operations

  - Fixup the interrupt state in the cpu idle code to be consistent

  - Push rcu_idle_enter/exit() invocations deeper into the idle path so
    that the lock operations are inside the RCU watching sections

  - Move trace_cpu_idle() into generic code so it's called before RCU goes
    idle.

  - Handle raw_local_irq* vs. local_irq* operations correctly

  - Move the tracepoints out from under the lockdep recursion handling
    which turned out to be fragile and inconsistent.

Thanks,

	tglx

------------------>
Nicholas Piggin (1):
      lockdep: Only trace IRQ edges

Peter Zijlstra (11):
      lockdep: Use raw_cpu_*() for per-cpu variables
      cpuidle: Fixup IRQ state
      sched,idle,rcu: Push rcu_idle deeper into the idle path
      cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic
      cpuidle: Move trace_cpu_idle() into generic code
      x86/entry: Remove unused THUNKs
      locking/lockdep: Cleanup
      nds32: Implement arch_irqs_disabled()
      arm64: Implement arch_irqs_disabled()
      mips: Implement arch_irqs_disabled()
      lockdep,trace: Expose tracepoints


 arch/arm/mach-omap2/pm34xx.c      |  4 ---
 arch/arm64/include/asm/irqflags.h |  5 +++
 arch/arm64/kernel/process.c       |  2 --
 arch/mips/include/asm/irqflags.h  |  5 +++
 arch/nds32/include/asm/irqflags.h |  5 +++
 arch/powerpc/include/asm/hw_irq.h | 11 +++---
 arch/s390/kernel/idle.c           |  3 +-
 arch/x86/entry/thunk_32.S         |  5 ---
 arch/x86/include/asm/mmu.h        |  1 +
 arch/x86/kernel/process.c         |  4 ---
 arch/x86/mm/tlb.c                 | 13 ++-----
 drivers/cpuidle/cpuidle.c         | 19 +++++++---
 drivers/idle/intel_idle.c         | 16 ---------
 include/linux/cpuidle.h           | 13 +++----
 include/linux/irqflags.h          | 73 +++++++++++++++++++++------------------
 include/linux/lockdep.h           | 18 +++++++---
 include/linux/mmu_context.h       |  5 +++
 kernel/locking/lockdep.c          | 18 ++++++----
 kernel/sched/idle.c               | 25 ++++++--------
 19 files changed, 123 insertions(+), 122 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6df395fff971..f5dfddf492e2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -298,11 +298,7 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
-
 	omap_sram_idle();
-
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index aa4b6521ef14..ff328e5bbb75 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -95,6 +95,11 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return res;
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b63ce4c54cfe..f1804496b935 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -123,10 +123,8 @@ void arch_cpu_idle(void)
 	 * This should do all the clock switching and wait for interrupt
 	 * tricks
 	 */
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	cpu_do_idle();
 	local_irq_enable();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 47a8ffc0b413..f5b8300f4573 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -137,6 +137,11 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return !(flags & 1);
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 #endif /* #ifndef __ASSEMBLY__ */
 
 /*
diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
index fb45ec46bb1b..51ef800bb301 100644
--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -34,3 +34,8 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return !flags;
 }
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b0b46e..35060be09073 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
 #define powerpc_local_irq_pmu_save(flags)			\
 	 do {							\
 		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
+		if (!raw_irqs_disabled_flags(flags))		\
+			trace_hardirqs_off();			\
 	} while(0)
 #define powerpc_local_irq_pmu_restore(flags)			\
 	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
+		if (!raw_irqs_disabled_flags(flags))		\
 			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
+		raw_local_irq_pmu_restore(flags);		\
 	} while(0)
 #else
 #define powerpc_local_irq_pmu_save(flags)			\
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 88bb42ca5008..c73f50649e7e 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -33,14 +33,13 @@ void enabled_wait(void)
 		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 	clear_cpu_flag(CIF_NOHZ_DELAY);
 
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	local_irq_save(flags);
 	/* Call the assembler magic in entry.S */
 	psw_idle(idle, psw_mask);
 	local_irq_restore(flags);
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
+	/* XXX seqcount has tracepoints that require RCU */
 	write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 3a07ce3ec70b..f1f96d4d8cd6 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,11 +29,6 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0a301ad0b02f..9257667d13c5 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,5 +59,6 @@ typedef struct {
 	}
 
 void leave_mm(int cpu);
+#define leave_mm leave_mm
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 994d8393f2f7..13ce616cc7af 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -684,9 +684,7 @@ void arch_cpu_idle(void)
  */
 void __cpuidle default_idle(void)
 {
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	safe_halt();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -792,7 +790,6 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 static __cpuidle void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
-		trace_cpu_idle_rcuidle(1, smp_processor_id());
 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
 			mb(); /* quirk */
 			clflush((void *)&current_thread_info()->flags);
@@ -804,7 +801,6 @@ static __cpuidle void mwait_idle(void)
 			__sti_mwait(0, 0);
 		else
 			local_irq_enable();
-		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	} else {
 		local_irq_enable();
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1a3569b43aa5..0951b47e64c1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -555,21 +555,12 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, true);
 
-		/*
-		 * NB: This gets called via leave_mm() in the idle path
-		 * where RCU functions differently.  Tracing normally
-		 * uses RCU, so we need to use the _rcuidle variant.
-		 *
-		 * (There is no good reason for this.  The idle code should
-		 *  be rearranged to call this before rcu_idle_enter().)
-		 */
-		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
 		load_new_mm_cr3(next->pgd, new_asid, false);
 
-		/* See above wrt _rcuidle. */
-		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
 	/* Make sure we write CR3 before loaded_mm. */
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 87197319ab06..04becd70cc41 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/tick.h>
+#include <linux/mmu_context.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -145,21 +146,24 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 * executing it contains RCU usage regarded as invalid in the idle
 	 * context, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_freeze());
+	tick_freeze();
 	/*
 	 * The state used here cannot be a "coupled" one, because the "coupled"
 	 * cpuidle mechanism enables interrupts and doing that with timekeeping
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
+	rcu_idle_enter();
 	drv->states[index].enter_s2idle(dev, drv, index);
-	WARN_ON(!irqs_disabled());
+	if (WARN_ON_ONCE(!irqs_disabled()))
+		local_irq_disable();
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
 	 * first CPU executing it calls functions containing RCU read-side
 	 * critical sections, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_unfreeze());
+	rcu_idle_exit();
+	tick_unfreeze();
 	start_critical_timings();
 
 	time_end = ns_to_ktime(local_clock());
@@ -225,19 +229,24 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		broadcast = false;
 	}
 
+	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
+		leave_mm(dev->cpu);
+
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
-	trace_cpu_idle_rcuidle(index, dev->cpu);
+	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
 	stop_critical_timings();
+	rcu_idle_enter();
 	entered_state = target_state->enter(dev, drv, index);
+	rcu_idle_exit();
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
 	time_end = ns_to_ktime(local_clock());
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8e0fb1a5bdbd..9a810e4a7946 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -89,14 +89,6 @@ static unsigned int mwait_substates __initdata;
  */
 #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
 
-/*
- * Set this flag for states where the HW flushes the TLB for us
- * and so we don't need cross-calls to keep it consistent.
- * If this flag is set, SW flushes the TLB, so even if the
- * HW doesn't do the flushing, this flag is safe to use.
- */
-#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(16)
-
 /*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
@@ -131,14 +123,6 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
 	bool tick;
-	int cpu = smp_processor_id();
-
-	/*
-	 * leave_mm() to avoid costly and often unnecessary wakeups
-	 * for flushing the user TLB's associated with the active mm.
-	 */
-	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(cpu);
 
 	if (!static_cpu_has(X86_FEATURE_ARAT)) {
 		/*
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index b65909ae4e20..75895e6363b8 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -75,12 +75,13 @@ struct cpuidle_state {
 };
 
 /* Idle State Flags */
-#define CPUIDLE_FLAG_NONE       (0x00)
-#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
-#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
-#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
-#define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
-#define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_NONE       	(0x00)
+#define CPUIDLE_FLAG_POLLING		BIT(0) /* polling state */
+#define CPUIDLE_FLAG_COUPLED		BIT(1) /* state applies to multiple cpus */
+#define CPUIDLE_FLAG_TIMER_STOP 	BIT(2) /* timer is stopped on this state */
+#define CPUIDLE_FLAG_UNUSABLE		BIT(3) /* avoid using this state */
+#define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index bd5c55755447..3ed4e8771b64 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -49,17 +49,18 @@ struct irqtrace_events {
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
-  extern void trace_hardirqs_on_prepare(void);
-  extern void trace_hardirqs_off_finish(void);
-  extern void trace_hardirqs_on(void);
-  extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
+extern void trace_hardirqs_on_prepare(void);
+extern void trace_hardirqs_off_finish(void);
+extern void trace_hardirqs_on(void);
+extern void trace_hardirqs_off(void);
+
+# define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
-	if (this_cpu_inc_return(hardirq_context) == 1)	\
+	if (__this_cpu_inc_return(hardirq_context) == 1)\
 		current->hardirq_threaded = 0;		\
 } while (0)
 # define lockdep_hardirq_threaded()		\
@@ -68,7 +69,7 @@ do {						\
 } while (0)
 # define lockdep_hardirq_exit()			\
 do {						\
-	this_cpu_dec(hardirq_context);		\
+	__this_cpu_dec(hardirq_context);	\
 } while (0)
 # define lockdep_softirq_enter()		\
 do {						\
@@ -120,17 +121,17 @@ do {						\
 #else
 # define trace_hardirqs_on_prepare()		do { } while (0)
 # define trace_hardirqs_off_finish()		do { } while (0)
-# define trace_hardirqs_on()		do { } while (0)
-# define trace_hardirqs_off()		do { } while (0)
-# define lockdep_hardirq_context()	0
-# define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled()	0
-# define lockdep_softirqs_enabled(p)	0
-# define lockdep_hardirq_enter()	do { } while (0)
-# define lockdep_hardirq_threaded()	do { } while (0)
-# define lockdep_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
+# define trace_hardirqs_on()			do { } while (0)
+# define trace_hardirqs_off()			do { } while (0)
+# define lockdep_hardirq_context()		0
+# define lockdep_softirq_context(p)		0
+# define lockdep_hardirqs_enabled()		0
+# define lockdep_softirqs_enabled(p)		0
+# define lockdep_hardirq_enter()		do { } while (0)
+# define lockdep_hardirq_threaded()		do { } while (0)
+# define lockdep_hardirq_exit()			do { } while (0)
+# define lockdep_softirq_enter()		do { } while (0)
+# define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
 # define lockdep_hrtimer_exit(__context)	do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
@@ -181,26 +182,33 @@ do {						\
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-#define local_irq_enable() \
-	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
-#define local_irq_disable() \
-	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+
+#define local_irq_enable()				\
+	do {						\
+		trace_hardirqs_on();			\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		bool was_disabled = raw_irqs_disabled();\
+		raw_local_irq_disable();		\
+		if (!was_disabled)			\
+			trace_hardirqs_off();		\
+	} while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
-
 #define local_irq_restore(flags)			\
 	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
+		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+		raw_local_irq_restore(flags);		\
 	} while (0)
 
 #define safe_halt()				\
@@ -214,10 +222,7 @@ do {						\
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
 #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
-#define local_irq_save(flags)					\
-	do {							\
-		raw_local_irq_save(flags);			\
-	} while (0)
+#define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
 #define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
 #define safe_halt()		do { raw_safe_halt(); } while (0)
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 62a382d1845b..6a584b3e5c74 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -535,19 +535,27 @@ do {									\
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
+/*
+ * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
+ * per-cpu variables. This is required because this_cpu_read() will potentially
+ * call into preempt/irq-disable and that obviously isn't right. This is also
+ * correct because when IRQs are enabled, it doesn't matter if we accidentally
+ * read the value from our previous CPU.
+ */
+
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
+	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
@@ -555,7 +563,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     debug_locks			&&		\
 		     (preempt_count() != 0		||		\
-		      !this_cpu_read(hardirqs_enabled)));		\
+		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
@@ -563,7 +571,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     debug_locks			&&		\
 		     (preempt_count() == 0		&&		\
-		      this_cpu_read(hardirqs_enabled)));		\
+		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
 
 #else
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index c51a84132d7c..03dee12d2b61 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -3,10 +3,15 @@
 #define _LINUX_MMU_CONTEXT_H
 
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 
 /* Architectures that care about IRQ state in switch_mm can override this. */
 #ifndef switch_mm_irqs_off
 # define switch_mm_irqs_off switch_mm
 #endif
 
+#ifndef leave_mm
+static inline void leave_mm(int cpu) { }
+#endif
+
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2fad21d345b0..54b74fabf40c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3756,7 +3756,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 
 skip_checks:
 	/* we'll do an OFF -> ON transition: */
-	this_cpu_write(hardirqs_enabled, 1);
+	__this_cpu_write(hardirqs_enabled, 1);
 	trace->hardirq_enable_ip = ip;
 	trace->hardirq_enable_event = ++trace->irq_events;
 	debug_atomic_inc(hardirqs_on_events);
@@ -3795,7 +3795,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
-		this_cpu_write(hardirqs_enabled, 0);
+		__this_cpu_write(hardirqs_enabled, 0);
 		trace->hardirq_disable_ip = ip;
 		trace->hardirq_disable_event = ++trace->irq_events;
 		debug_atomic_inc(hardirqs_off_events);
@@ -4977,6 +4977,8 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 {
 	unsigned long flags;
 
+	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+
 	if (unlikely(current->lockdep_recursion)) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
@@ -5001,7 +5003,6 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	check_flags(flags);
 
 	current->lockdep_recursion++;
-	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5013,13 +5014,15 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	trace_lock_release(lock, ip);
+
 	if (unlikely(current->lockdep_recursion))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
+
 	current->lockdep_recursion++;
-	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5205,8 +5208,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 		hlock->holdtime_stamp = now;
 	}
 
-	trace_lock_acquired(lock, ip);
-
 	stats = get_lock_stats(hlock_class(hlock));
 	if (waittime) {
 		if (hlock->read)
@@ -5225,6 +5226,8 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	trace_lock_acquired(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
@@ -5234,7 +5237,6 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 	current->lockdep_recursion++;
-	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5245,6 +5247,8 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	trace_lock_contended(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6bf34986f45c..f324dc36fc43 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -54,17 +54,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
+	trace_cpu_idle(0, smp_processor_id());
+	stop_critical_timings();
 	rcu_idle_enter();
-	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
-	stop_critical_timings();
 
 	while (!tif_need_resched() &&
-		(cpu_idle_force_poll || tick_check_broadcast_expired()))
+	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
-	start_critical_timings();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
+
 	rcu_idle_exit();
+	start_critical_timings();
+	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 
 	return 1;
 }
@@ -90,9 +91,14 @@ void __cpuidle default_idle_call(void)
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
 	} else {
+
+		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
+		rcu_idle_enter();
 		arch_cpu_idle();
+		rcu_idle_exit();
 		start_critical_timings();
+		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}
 }
 
@@ -158,7 +164,6 @@ static void cpuidle_idle_call(void)
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		default_idle_call();
 		goto exit_idle;
@@ -178,21 +183,17 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
-			rcu_idle_enter();
 
 			entered_state = call_cpuidle_s2idle(drv, dev);
 			if (entered_state > 0)
 				goto exit_idle;
 
-			rcu_idle_exit();
-
 			max_latency_ns = U64_MAX;
 		} else {
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
 
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
@@ -209,8 +210,6 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
-		rcu_idle_enter();
-
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
@@ -226,8 +225,6 @@ static void cpuidle_idle_call(void)
 	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
-
-	rcu_idle_exit();
 }
 
 /*

