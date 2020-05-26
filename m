Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DE02073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8WlZm4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbgEZQYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:24:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35184 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgEZQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=26SE+W2cwU3W0QznSmQufpFD1u4LTIE70328DJ+l0ag=; b=m8WlZm4DeKN1GxpcZBh2M3A6Aq
        bqcgbpZsrFrLNTY5aXjI30MpuQtdnNgIAdMTD86aOVOhJp+gPYcGvviw9WTtYpgsBjatX41erai8f
        0gcPZNrHgXmaRSQzN/iisxj9H5J5iJlFhTbJLfRARjdTouiTh+XlGNNx0EYO0/f4Vqfb4PL6TjSWt
        4RhayENNdN8dq/6S0KcxS2U9UaGPIusIrDn0MDI66Sw8Y0V2KqhDwemd4IbuB5aoD1zASC+YHfGYl
        O5tCFN9RuZIjHHoN52TvV0dUguGiqwfpY0Zk1KzAKjDKLcDr7bXrkQvs3QKjYT0oHvzGlOpmcL1hz
        DrIRC0oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIv-0005Td-8K; Tue, 26 May 2020 16:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C864A307197;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 64E1220FF793F; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161908.129371594@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:11:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 7/7] sched: Replace rq::wake_list
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
got smp_call_function_single_async() subtly wrong. Even though it will
return -EBUSY when trying to re-use a csd, that condition is not
atomic and still requires external serialization.

The change in ttwu_queue_remote() got this wrong.

While on first reading ttwu_queue_remote() has an atomic test-and-set
that appears to serialize the use, the matching 'release' is not in
the right place to actually guarantee this serialization.

The actual race is vs the sched_ttwu_pending() call in the idle loop;
that can run the wakeup-list without consuming the CSD.

Instead of trying to chain the lists, merge them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 +
 include/linux/smp.h   |    1 +
 kernel/sched/core.c   |   25 +++++++------------------
 kernel/sched/idle.c   |    1 -
 kernel/sched/sched.h  |   11 -----------
 kernel/smp.c          |   47 ++++++++++++++++++++++++++++++++++++++++-------
 6 files changed, 49 insertions(+), 37 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -655,6 +655,7 @@ struct task_struct {
 
 #ifdef CONFIG_SMP
 	struct llist_node		wake_entry;
+	unsigned int			wake_entry_type;
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -25,6 +25,7 @@ enum {
 	CSD_TYPE_ASYNC		= 0x00,
 	CSD_TYPE_SYNC		= 0x10,
 	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_TYPE_TTWU		= 0x30,
 	CSD_FLAG_TYPE_MASK	= 0xF0,
 };
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1538,7 +1538,7 @@ static int migration_cpu_stop(void *data
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
-	sched_ttwu_pending();
+	flush_smp_call_function_from_idle();
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
@@ -2272,14 +2272,13 @@ static int ttwu_remote(struct task_struc
 }
 
 #ifdef CONFIG_SMP
-void sched_ttwu_pending(void)
+void sched_ttwu_pending(void *arg)
 {
+	struct llist_node *llist = arg;
 	struct rq *rq = this_rq();
-	struct llist_node *llist;
 	struct task_struct *p, *t;
 	struct rq_flags rf;
 
-	llist = llist_del_all(&rq->wake_list);
 	if (!llist)
 		return;
 
@@ -2299,11 +2298,6 @@ void sched_ttwu_pending(void)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-static void wake_csd_func(void *info)
-{
-	sched_ttwu_pending();
-}
-
 void send_call_function_single_ipi(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -2321,12 +2315,7 @@ static void ttwu_queue_remote(struct tas
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	if (llist_add(&p->wake_entry, &rq->wake_list)) {
-		if (!set_nr_if_polling(rq->idle))
-			smp_call_function_single_async(cpu, &rq->wake_csd);
-		else
-			trace_sched_wake_idle_without_ipi(cpu);
-	}
+	__smp_call_single_queue(cpu, &p->wake_entry);
 }
 
 void wake_up_if_idle(int cpu)
@@ -2735,6 +2724,9 @@ static void __sched_fork(unsigned long c
 	p->capture_control = NULL;
 #endif
 	init_numa_balancing(clone_flags, p);
+#ifdef CONFIG_SMP
+	p->wake_entry_type = CSD_TYPE_TTWU;
+#endif
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6527,7 +6519,6 @@ int sched_cpu_dying(unsigned int cpu)
 	struct rq_flags rf;
 
 	/* Handle pending wakeups and then migrate everything off */
-	sched_ttwu_pending();
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
@@ -6726,8 +6717,6 @@ void __init sched_init(void)
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
-		rq_csd_init(rq, &rq->wake_csd, wake_csd_func);
-
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -290,7 +290,6 @@ static void do_idle(void)
 	smp_mb__after_atomic();
 
 	flush_smp_call_function_from_idle();
-	sched_ttwu_pending();
 	schedule_idle();
 
 	if (unlikely(klp_patch_pending(current)))
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1023,11 +1023,6 @@ struct rq {
 	unsigned int		ttwu_local;
 #endif
 
-#ifdef CONFIG_SMP
-	call_single_data_t	wake_csd;
-	struct llist_head	wake_list;
-#endif
-
 #ifdef CONFIG_CPU_IDLE
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
@@ -1371,8 +1366,6 @@ queue_balance_callback(struct rq *rq,
 	rq->balance_callback = head;
 }
 
-extern void sched_ttwu_pending(void);
-
 #define rcu_dereference_check_sched_domain(p) \
 	rcu_dereference_check((p), \
 			      lockdep_is_held(&sched_domains_mutex))
@@ -1510,10 +1503,6 @@ static inline void unregister_sched_doma
 
 extern void flush_smp_call_function_from_idle(void);
 
-#else
-
-static inline void sched_ttwu_pending(void) { }
-
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -196,6 +196,7 @@ void generic_smp_call_function_single_in
 	flush_smp_call_function_queue(true);
 }
 
+extern void sched_ttwu_pending(void *);
 extern void irq_work_single(void *);
 
 /**
@@ -244,6 +245,10 @@ static void flush_smp_call_function_queu
 					csd->func);
 				break;
 
+			case CSD_TYPE_TTWU:
+				pr_warn("IPI task-wakeup sent to offline CPU\n");
+				break;
+
 			default:
 				pr_warn("IPI callback, unknown type %d, sent to offline CPU\n",
 					CSD_TYPE(csd));
@@ -275,22 +280,43 @@ static void flush_smp_call_function_queu
 		}
 	}
 
+	if (!entry)
+		return;
+
 	/*
 	 * Second; run all !SYNC callbacks.
 	 */
+	prev = NULL;
 	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
 		int type = CSD_TYPE(csd);
 
-		if (type == CSD_TYPE_ASYNC) {
-			smp_call_func_t func = csd->func;
-			void *info = csd->info;
+		if (type != CSD_TYPE_TTWU) {
+			if (prev) {
+				prev->next = &csd_next->llist;
+			} else {
+				entry = &csd_next->llist;
+			}
 
-			csd_unlock(csd);
-			func(info);
-		} else if (type == CSD_TYPE_IRQ_WORK) {
-			irq_work_single(csd);
+			if (type == CSD_TYPE_ASYNC) {
+				smp_call_func_t func = csd->func;
+				void *info = csd->info;
+
+				csd_unlock(csd);
+				func(info);
+			} else if (type == CSD_TYPE_IRQ_WORK) {
+				irq_work_single(csd);
+			}
+
+		} else {
+			prev = &csd->llist;
 		}
 	}
+
+	/*
+	 * Third; only CSD_TYPE_TTWU is left, issue those.
+	 */
+	if (entry)
+		sched_ttwu_pending(entry);
 }
 
 void flush_smp_call_function_from_idle(void)
@@ -659,6 +685,13 @@ void __init smp_init(void)
 	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
 		     offsetof(struct __call_single_data, flags));
 
+	/*
+	 * Assert the CSD_TYPE_TTWU layout is similar enough
+	 * for task_struct to be on the @call_single_queue.
+	 */
+	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
+		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
+
 	idle_threads_init();
 	cpuhp_threads_init();
 


