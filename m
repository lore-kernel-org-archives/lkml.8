Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D632424682
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgA1AGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgA1AGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:41 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwEOq-00034G-A1; Tue, 28 Jan 2020 01:06:37 +0100
Date:   Mon, 27 Jan 2020 23:49:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
Message-ID: <158016896589.31887.13016639707269883122.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-01-28

up to:  cb923159bbb8: smp: Remove allocation mask from on_each_cpu_cond.*()


A small set of SMP core code changes:

 - Rework the smp function call core code to avoid the allocation of an
   additional cpumask.

 - Remove the not longer required GFP argument from on_each_cpu_cond() and
   on_each_cpu_cond_mask() and fixup the callers.

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (3):
      smp: Use smp_cond_func_t as type for the conditional function
      smp: Add a smp_cond_func_t argument to smp_call_function_many()
      smp: Remove allocation mask from on_each_cpu_cond.*()


 arch/x86/mm/tlb.c   |  2 +-
 fs/buffer.c         |  2 +-
 include/linux/smp.h | 11 +++---
 kernel/smp.c        | 99 +++++++++++++++++++++++------------------------------
 kernel/up.c         | 12 +++----
 mm/slub.c           |  2 +-
 6 files changed, 56 insertions(+), 72 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc5baaf..66f96f21a7b6 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -708,7 +708,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 			       (void *)info, 1);
 	else
 		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
-				(void *)info, 1, GFP_ATOMIC, cpumask);
+				(void *)info, 1, cpumask);
 }
 
 /*
diff --git a/fs/buffer.c b/fs/buffer.c
index 18a87ec8a465..b8d28370cfd7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1433,7 +1433,7 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1, GFP_KERNEL);
+	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c9eda5..cbc9162689d0 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -15,6 +15,7 @@
 #include <linux/llist.h>
 
 typedef void (*smp_call_func_t)(void *info);
+typedef bool (*smp_cond_func_t)(int cpu, void *info);
 struct __call_single_data {
 	struct llist_node llist;
 	smp_call_func_t func;
@@ -49,13 +50,11 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
  * cond_func returns a positive value. This may include the local
  * processor.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags);
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait);
 
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags, const struct cpumask *mask);
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask);
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..3b7bedc97af3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -395,22 +395,9 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
-/**
- * smp_call_function_many(): Run a function on a set of other CPUs.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler. Preemption
- * must be disabled when calling this function.
- */
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait)
+static void smp_call_function_many_cond(const struct cpumask *mask,
+					smp_call_func_t func, void *info,
+					bool wait, smp_cond_func_t cond_func)
 {
 	struct call_function_data *cfd;
 	int cpu, next_cpu, this_cpu = smp_processor_id();
@@ -448,7 +435,8 @@ void smp_call_function_many(const struct cpumask *mask,
 
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >= nr_cpu_ids) {
-		smp_call_function_single(cpu, func, info, wait);
+		if (!cond_func || (cond_func && cond_func(cpu, info)))
+			smp_call_function_single(cpu, func, info, wait);
 		return;
 	}
 
@@ -465,6 +453,9 @@ void smp_call_function_many(const struct cpumask *mask,
 	for_each_cpu(cpu, cfd->cpumask) {
 		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
+		if (cond_func && !cond_func(cpu, info))
+			continue;
+
 		csd_lock(csd);
 		if (wait)
 			csd->flags |= CSD_FLAG_SYNCHRONOUS;
@@ -486,6 +477,26 @@ void smp_call_function_many(const struct cpumask *mask,
 		}
 	}
 }
+
+/**
+ * smp_call_function_many(): Run a function on a set of other CPUs.
+ * @mask: The set of cpus to run on (only runs on online subset).
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
+ *
+ * If @wait is true, then returns once @func has returned.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler. Preemption
+ * must be disabled when calling this function.
+ */
+void smp_call_function_many(const struct cpumask *mask,
+			    smp_call_func_t func, void *info, bool wait)
+{
+	smp_call_function_many_cond(mask, func, info, wait, NULL);
+}
 EXPORT_SYMBOL(smp_call_function_many);
 
 /**
@@ -668,11 +679,6 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * @info:	An arbitrary pointer to pass to both functions.
  * @wait:	If true, wait (atomically) until function has
  *		completed on other CPUs.
- * @gfp_flags:	GFP flags to use when allocating the cpumask
- *		used internally by the function.
- *
- * The function might sleep if the GFP flags indicates a non
- * atomic allocation is allowed.
  *
  * Preemption is disabled to protect against CPUs going offline but not online.
  * CPUs going online during the call will not be seen or sent an IPI.
@@ -680,46 +686,27 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags, const struct cpumask *mask)
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask)
 {
-	cpumask_var_t cpus;
-	int cpu, ret;
-
-	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
-
-	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
-		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info))
-				__cpumask_set_cpu(cpu, cpus);
-		on_each_cpu_mask(cpus, func, info, wait);
-		preempt_enable();
-		free_cpumask_var(cpus);
-	} else {
-		/*
-		 * No free cpumask, bother. No matter, we'll
-		 * just have to IPI them one by one.
-		 */
-		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info)) {
-				ret = smp_call_function_single(cpu, func,
-								info, wait);
-				WARN_ON_ONCE(ret);
-			}
-		preempt_enable();
+	int cpu = get_cpu();
+
+	smp_call_function_many_cond(mask, func, info, wait, cond_func);
+	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
 	}
+	put_cpu();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
-				cpu_online_mask);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
diff --git a/kernel/up.c b/kernel/up.c
index 862b460ab97a..53144d056252 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -68,9 +68,8 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * Preemption is disabled here to make sure the cond_func is called under the
  * same condtions in UP and SMP.
  */
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-			   smp_call_func_t func, void *info, bool wait,
-			   gfp_t gfp_flags, const struct cpumask *mask)
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask)
 {
 	unsigned long flags;
 
@@ -84,11 +83,10 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		      smp_call_func_t func, void *info, bool wait,
-		      gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, NULL);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
diff --git a/mm/slub.c b/mm/slub.c
index 8eafccf75940..2e1a57723f8e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2341,7 +2341,7 @@ static bool has_cpu_slab(int cpu, void *info)
 
 static void flush_all(struct kmem_cache *s)
 {
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1, GFP_ATOMIC);
+	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
 }
 
 /*

