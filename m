Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E004AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF642071A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gaf/M14I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgFQLEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:04:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fce9GGLEdA/OakCVavFwqqp8+vkoqmpf/aJzeUyqDGI=; b=gaf/M14IOCODn8O/p5OxOMDOG+
        bj7BMnQDUqq6g8jakiEYBGep8CwwtPwcdr53A+gf0OapVrQX9NteRI8l5JnyH3UHL2+YCx90J70AA
        zP8+xOdVBzqrdnJKjNW3eb8QzBHM4C+od+W8aozBLIATJ2o/MBPGDFyTl9ta/9hFRYO119v6vjGR5
        5INbnn/ffuHqXxIKHxBT1zSFoIPY6p64equG/O5QvrJ3ODoflkgf9Sr295QIeka/GfTUbQvHOxWV5
        UUxNdzLTgbcnRpPE0CWrqvrMPp/tnSTGoMfhGfOW5/e5cAaOEA2dLVCqAYEay/Q6lrQXeB2MD80sj
        D7EwBcNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlVrR-0004En-8V; Wed, 17 Jun 2020 11:04:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFC2230018A;
        Wed, 17 Jun 2020 13:04:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9688E203B4EA5; Wed, 17 Jun 2020 13:04:01 +0200 (CEST)
Date:   Wed, 17 Jun 2020 13:04:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        tsbogend@alpha.franken.de, axboe@kernel.dk, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, dchickles@marvell.com,
        davem@davemloft.net, kuba@kernel.org, daniel.thompson@linaro.org,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 6/6] smp: Cleanup smp_call_function*()
Message-ID: <20200617110401.GG2531@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.434079683@infradead.org>
 <20200617082349.GA19894@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617082349.GA19894@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:23:49AM -0700, Christoph Hellwig wrote:

> > @@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(voi
> >  		if (atomic_inc_return(&cpu_data->scheduled) > 1)
> >  			continue;
> >  
> > -		cpu_data->csd.func = zpci_handle_remote_irq;
> > -		cpu_data->csd.info = &cpu_data->scheduled;
> > -		cpu_data->csd.flags = 0;
> > +		cpu_data->csd = CSD_INIT(zpci_handle_remote_irq, &cpu_data->scheduled);
> 
> This looks weird.  I'd much rather see an initialization ala INIT_WORK:
> 
> 		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq,
> 			 &cpu_data->scheduled);


like so then?

---
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -687,7 +687,6 @@ unsigned long arch_align_stack(unsigned
 	return sp & ALMASK;
 }
 
-static DEFINE_PER_CPU(call_single_data_t, backtrace_csd);
 static struct cpumask backtrace_csd_busy;
 
 static void handle_backtrace(void *info)
@@ -696,6 +695,9 @@ static void handle_backtrace(void *info)
 	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
 }
 
+static DEFINE_PER_CPU(call_single_data_t, backtrace_csd) =
+	CSD_INIT(handle_backtrace, NULL);
+
 static void raise_backtrace(cpumask_t *mask)
 {
 	call_single_data_t *csd;
@@ -715,7 +717,6 @@ static void raise_backtrace(cpumask_t *m
 		}
 
 		csd = &per_cpu(backtrace_csd, cpu);
-		csd->func = handle_backtrace;
 		smp_call_function_single_async(cpu, csd);
 	}
 }
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -687,36 +687,23 @@ EXPORT_SYMBOL(flush_tlb_one);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
-static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd);
-
-void tick_broadcast(const struct cpumask *mask)
-{
-	call_single_data_t *csd;
-	int cpu;
-
-	for_each_cpu(cpu, mask) {
-		csd = &per_cpu(tick_broadcast_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
-	}
-}
-
 static void tick_broadcast_callee(void *info)
 {
 	tick_receive_broadcast();
 }
 
-static int __init tick_broadcast_init(void)
+static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd) =
+	CSD_INIT(tick_broadcast_callee, NULL);
+
+void tick_broadcast(const struct cpumask *mask)
 {
 	call_single_data_t *csd;
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_cpu(cpu, mask) {
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-		csd->func = tick_broadcast_callee;
+		smp_call_function_single_async(cpu, csd);
 	}
-
-	return 0;
 }
-early_initcall(tick_broadcast_init);
 
 #endif /* CONFIG_GENERIC_CLOCKEVENTS_BROADCAST */
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(voi
 		if (atomic_inc_return(&cpu_data->scheduled) > 1)
 			continue;
 
-		cpu_data->csd.func = zpci_handle_remote_irq;
-		cpu_data->csd.info = &cpu_data->scheduled;
-		cpu_data->csd.flags = 0;
+		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq, &cpu_data->scheduled);
 		smp_call_function_single_async(cpu, &cpu_data->csd);
 	}
 }
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -74,10 +74,9 @@ static ssize_t cpuid_read(struct file *f
 
 	init_completion(&cmd.done);
 	for (; count; count -= 16) {
-		call_single_data_t csd = {
-			.func = cpuid_smp_cpuid,
-			.info = &cmd,
-		};
+		call_single_data_t csd;
+
+		INIT_CSD(&csd, cpuid_smp_cpuid, &cmd);
 
 		cmd.regs.eax = pos;
 		cmd.regs.ecx = pos >> 32;
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -169,12 +169,11 @@ static void __wrmsr_safe_on_cpu(void *in
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
 	struct msr_info_completion rv;
-	call_single_data_t csd = {
-		.func	= __rdmsr_safe_on_cpu,
-		.info	= &rv,
-	};
+	call_single_data_t csd;
 	int err;
 
+	INIT_CSD(&csd, __rdmsr_safe_on_cpu, &rv);
+
 	memset(&rv, 0, sizeof(rv));
 	init_completion(&rv.done);
 	rv.msr.msr_no = msr_no;
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -629,9 +629,7 @@ void blk_mq_force_complete_rq(struct req
 		shared = cpus_share_cache(cpu, ctx->cpu);
 
 	if (cpu != ctx->cpu && !shared && cpu_online(ctx->cpu)) {
-		rq->csd.func = __blk_mq_complete_request_remote;
-		rq->csd.info = rq;
-		rq->csd.flags = 0;
+		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
 		smp_call_function_single_async(ctx->cpu, &rq->csd);
 	} else {
 		q->mq_ops->complete(rq);
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -57,13 +57,8 @@ static void trigger_softirq(void *data)
 static int raise_blk_irq(int cpu, struct request *rq)
 {
 	if (cpu_online(cpu)) {
-		call_single_data_t *data = &rq->csd;
-
-		data->func = trigger_softirq;
-		data->info = rq;
-		data->flags = 0;
-
-		smp_call_function_single_async(cpu, data);
+		INIT_CSD(&rq->csd, trigger_softirq, rq);
+		smp_call_function_single_async(cpu, &rq->csd);
 		return 0;
 	}
 
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -674,8 +674,7 @@ int cpuidle_coupled_register_device(stru
 	coupled->refcnt++;
 
 	csd = &per_cpu(cpuidle_coupled_poke_cb, dev->cpu);
-	csd->func = cpuidle_coupled_handle_poke;
-	csd->info = (void *)(unsigned long)dev->cpu;
+	INIT_CSD(csd, cpuidle_coupled_handle_poke, (void *)(unsigned long)dev->cpu);
 
 	return 0;
 }
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -726,13 +726,8 @@ static void liquidio_napi_drv_callback(v
 	    droq->cpu_id == this_cpu) {
 		napi_schedule_irqoff(&droq->napi);
 	} else {
-		call_single_data_t *csd = &droq->csd;
-
-		csd->func = napi_schedule_wrapper;
-		csd->info = &droq->napi;
-		csd->flags = 0;
-
-		smp_call_function_single_async(droq->cpu_id, csd);
+		INIT_CSD(&droq->csd, napi_schedule_wrapper, &droq->napi);
+		smp_call_function_single_async(droq->cpu_id, &droq->csd);
 	}
 }
 
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -21,21 +21,23 @@ typedef bool (*smp_cond_func_t)(int cpu,
  * structure shares (partial) layout with struct irq_work
  */
 struct __call_single_data {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llist;
-			unsigned int flags;
-		};
-	};
+	struct __call_single_node node;
 	smp_call_func_t func;
 	void *info;
 };
 
+#define CSD_INIT(_func, _info) \
+	(struct __call_single_data){ .func = (_func), .info = (_info), }
+
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
 typedef struct __call_single_data call_single_data_t
 	__aligned(sizeof(struct __call_single_data));
 
+#define INIT_CSD(_csd, _func, _info)		\
+do {						\
+	*(_csd) = CSD_INIT((_func), (_info));	\
+while (0)
+
 /*
  * Enqueue a llist_node on the call_single_queue; be very careful, read
  * flush_smp_call_function_queue() in detail.
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -225,8 +225,6 @@ int __weak kgdb_skipexception(int except
  * Default (weak) implementation for kgdb_roundup_cpus
  */
 
-static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
-
 void __weak kgdb_call_nmi_hook(void *ignored)
 {
 	/*
@@ -240,6 +238,9 @@ void __weak kgdb_call_nmi_hook(void *ign
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
+static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
+	CSD_INIT(kgdb_call_nmi_hook, NULL);
+
 void __weak kgdb_roundup_cpus(void)
 {
 	call_single_data_t *csd;
@@ -266,7 +267,6 @@ void __weak kgdb_roundup_cpus(void)
 			continue;
 		kgdb_info[cpu].rounding_up = true;
 
-		csd->func = kgdb_call_nmi_hook;
 		ret = smp_call_function_single_async(cpu, csd);
 		if (ret)
 			kgdb_info[cpu].rounding_up = false;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -221,14 +221,6 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
-static inline void
-rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
-{
-	csd->flags = 0;
-	csd->func = func;
-	csd->info = rq;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 /*
  * Use HR-timers to deliver accurate preemption points.
@@ -329,7 +321,7 @@ void hrtick_start(struct rq *rq, u64 del
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
+	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 #endif
 	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
@@ -6778,7 +6770,7 @@ void __init sched_init(void)
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 
-		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
+		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -24,7 +24,7 @@
 #include "smpboot.h"
 #include "sched/smp.h"
 
-#define CSD_TYPE(_csd)	((_csd)->flags & CSD_FLAG_TYPE_MASK)
+#define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
 struct call_function_data {
 	call_single_data_t	__percpu *csd;
@@ -105,13 +105,13 @@ void __init call_function_init(void)
  */
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
-	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
+	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
-	csd->flags |= CSD_FLAG_LOCK;
+	csd->node.u_flags |= CSD_FLAG_LOCK;
 
 	/*
 	 * prevent CPU from reordering the above assignment
@@ -123,12 +123,12 @@ static __always_inline void csd_lock(cal
 
 static __always_inline void csd_unlock(call_single_data_t *csd)
 {
-	WARN_ON(!(csd->flags & CSD_FLAG_LOCK));
+	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
 	/*
 	 * ensure we're all done before releasing data:
 	 */
-	smp_store_release(&csd->flags, 0);
+	smp_store_release(&csd->node.u_flags, 0);
 }
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
@@ -180,7 +180,7 @@ static int generic_exec_single(int cpu,
 		return -ENXIO;
 	}
 
-	__smp_call_single_queue(cpu, &csd->llist);
+	__smp_call_single_queue(cpu, &csd->node.llist);
 
 	return 0;
 }
@@ -233,7 +233,7 @@ static void flush_smp_call_function_queu
 		 * We don't have to use the _safe() variant here
 		 * because we are not invoking the IPI handlers yet.
 		 */
-		llist_for_each_entry(csd, entry, llist) {
+		llist_for_each_entry(csd, entry, node.llist) {
 			switch (CSD_TYPE(csd)) {
 			case CSD_TYPE_ASYNC:
 			case CSD_TYPE_SYNC:
@@ -258,22 +258,22 @@ static void flush_smp_call_function_queu
 	 * First; run all SYNC callbacks, people are waiting for us.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
 		/* Do we wait until *after* callback? */
 		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
 			smp_call_func_t func = csd->func;
 			void *info = csd->info;
 
 			if (prev) {
-				prev->next = &csd_next->llist;
+				prev->next = &csd_next->node.llist;
 			} else {
-				entry = &csd_next->llist;
+				entry = &csd_next->node.llist;
 			}
 
 			func(info);
 			csd_unlock(csd);
 		} else {
-			prev = &csd->llist;
+			prev = &csd->node.llist;
 		}
 	}
 
@@ -284,14 +284,14 @@ static void flush_smp_call_function_queu
 	 * Second; run all !SYNC callbacks.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
 		int type = CSD_TYPE(csd);
 
 		if (type != CSD_TYPE_TTWU) {
 			if (prev) {
-				prev->next = &csd_next->llist;
+				prev->next = &csd_next->node.llist;
 			} else {
-				entry = &csd_next->llist;
+				entry = &csd_next->node.llist;
 			}
 
 			if (type == CSD_TYPE_ASYNC) {
@@ -305,7 +305,7 @@ static void flush_smp_call_function_queu
 			}
 
 		} else {
-			prev = &csd->llist;
+			prev = &csd->node.llist;
 		}
 	}
 
@@ -341,7 +341,7 @@ int smp_call_function_single(int cpu, sm
 {
 	call_single_data_t *csd;
 	call_single_data_t csd_stack = {
-		.flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC,
+		.node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
 	};
 	int this_cpu;
 	int err;
@@ -416,12 +416,12 @@ int smp_call_function_single_async(int c
 
 	preempt_disable();
 
-	if (csd->flags & CSD_FLAG_LOCK) {
+	if (csd->node.u_flags & CSD_FLAG_LOCK) {
 		err = -EBUSY;
 		goto out;
 	}
 
-	csd->flags = CSD_FLAG_LOCK;
+	csd->node.u_flags = CSD_FLAG_LOCK;
 	smp_wmb();
 
 	err = generic_exec_single(cpu, csd);
@@ -539,10 +539,10 @@ static void smp_call_function_many_cond(
 
 		csd_lock(csd);
 		if (wait)
-			csd->flags |= CSD_TYPE_SYNC;
+			csd->node.u_flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
-		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
 
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10645,8 +10645,7 @@ static int __init net_dev_init(void)
 		INIT_LIST_HEAD(&sd->poll_list);
 		sd->output_queue_tailp = &sd->output_queue;
 #ifdef CONFIG_RPS
-		sd->csd.func = rps_trigger_softirq;
-		sd->csd.info = sd;
+		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 		sd->cpu = i;
 #endif
 
