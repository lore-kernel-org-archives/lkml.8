Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323BC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D80206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgDLOTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:19:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41453 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgDLOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:19:32 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jNdSK-0001WT-NB; Sun, 12 Apr 2020 16:19:28 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3BE61100E35;
        Sun, 12 Apr 2020 16:19:28 +0200 (CEST)
Date:   Sun, 12 Apr 2020 14:18:40 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.7-rc1
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
Message-ID: <158670112018.20085.16323984475817000231.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-04-12

up to:  96e74ebf8d59: sched/debug: Add task uclamp values to SCHED_DEBUG procfs


Scheduler fixes/updates:

 - Deduplicate the average computations in the scheduler core and the fair
   class code.

 - Fix a raise between runtime distribution and assignement which can cause
   exceeding the quota by up to 70%.

 - Prevent negative results in the imbalanace calculation

 - Remove a stale warning in the workqueue code which can be triggered
   since the call site was moved out of preempt disabled code. It's a false
   positive.

 - Deduplicate the print macros for procfs

 - Add the ucmap values to the SCHED_DEBUG procfs output for completness

Thanks,

	tglx

------------------>
Aubrey Li (1):
      sched/fair: Fix negative imbalance in imbalance calculation

Huaixin Chang (1):
      sched/fair: Fix race between runtime distribution and assignment

Sebastian Andrzej Siewior (1):
      workqueue: Remove the warning in wq_worker_sleeping()

Valentin Schneider (4):
      sched/fair: Align rq->avg_idle and rq->avg_scan_cost
      sched/debug: Remove redundant macro define
      sched/debug: Factor out printing formats into common macros
      sched/debug: Add task uclamp values to SCHED_DEBUG procfs

Vincent Donnefort (1):
      sched/core: Remove unused rq::last_load_update_tick


 kernel/sched/core.c  | 10 ++--------
 kernel/sched/debug.c | 44 ++++++++++++++++++--------------------------
 kernel/sched/fair.c  | 46 +++++++++++++++++++++-------------------------
 kernel/sched/sched.h |  7 ++++++-
 kernel/workqueue.c   |  6 ++++--
 5 files changed, 51 insertions(+), 62 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2694ba82874..3a61a3b8eaa9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2119,12 +2119,6 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	return cpu;
 }
 
-static void update_avg(u64 *avg, u64 sample)
-{
-	s64 diff = sample - *avg;
-	*avg += diff >> 3;
-}
-
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
@@ -4126,7 +4120,8 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * it wants to wake up a task to maintain concurrency.
 	 * As this function is called inside the schedule() context,
 	 * we disable preemption to avoid it calling schedule() again
-	 * in the possible wakeup of a kworker.
+	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
+	 * requires it.
 	 */
 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		preempt_disable();
@@ -6699,7 +6694,6 @@ void __init sched_init(void)
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
-		rq->last_load_update_tick = jiffies;
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 #endif
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8331bc04aea2..a562df57a86e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -816,10 +816,12 @@ static int __init init_sched_debug_procfs(void)
 
 __initcall(init_sched_debug_procfs);
 
-#define __P(F)	SEQ_printf(m, "%-45s:%21Ld\n",	     #F, (long long)F)
-#define   P(F)	SEQ_printf(m, "%-45s:%21Ld\n",	     #F, (long long)p->F)
-#define __PN(F)	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define   PN(F)	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
+#define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
+#define __P(F) __PS(#F, F)
+#define   P(F) __PS(#F, p->F)
+#define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)(F)))
+#define __PN(F) __PSN(#F, F)
+#define   PN(F) __PSN(#F, p->F)
 
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -868,18 +870,9 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	SEQ_printf(m,
 		"---------------------------------------------------------"
 		"----------\n");
-#define __P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)F)
-#define P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)p->F)
-#define P_SCHEDSTAT(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)schedstat_val(p->F))
-#define __PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
-#define PN_SCHEDSTAT(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(p->F)))
+
+#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
+#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
 
 	PN(se.exec_start);
 	PN(se.vruntime);
@@ -939,10 +932,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	}
 
 	__P(nr_switches);
-	SEQ_printf(m, "%-45s:%21Ld\n",
-		   "nr_voluntary_switches", (long long)p->nvcsw);
-	SEQ_printf(m, "%-45s:%21Ld\n",
-		   "nr_involuntary_switches", (long long)p->nivcsw);
+	__PS("nr_voluntary_switches", p->nvcsw);
+	__PS("nr_involuntary_switches", p->nivcsw);
 
 	P(se.load.weight);
 #ifdef CONFIG_SMP
@@ -955,6 +946,12 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
 	P(se.avg.util_est.enqueued);
+#endif
+#ifdef CONFIG_UCLAMP_TASK
+	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
+	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
 	P(policy);
 	P(prio);
@@ -963,11 +960,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.deadline);
 	}
 #undef PN_SCHEDSTAT
-#undef PN
-#undef __PN
 #undef P_SCHEDSTAT
-#undef P
-#undef __P
 
 	{
 		unsigned int this_cpu = raw_smp_processor_id();
@@ -975,8 +968,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 		t0 = cpu_clock(this_cpu);
 		t1 = cpu_clock(this_cpu);
-		SEQ_printf(m, "%-45s:%21Ld\n",
-			   "clock-delta", (long long)(t1-t0));
+		__PS("clock-delta", t1-t0);
 	}
 
 	sched_show_numa(p, m);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ea3dddafe69..02f323b85b6d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4836,11 +4836,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		resched_curr(rq);
 }
 
-static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
+static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
 	struct cfs_rq *cfs_rq;
-	u64 runtime;
-	u64 starting_runtime = remaining;
+	u64 runtime, remaining = 1;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -4855,10 +4854,13 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 		/* By the above check, this should never be true */
 		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
 
+		raw_spin_lock(&cfs_b->lock);
 		runtime = -cfs_rq->runtime_remaining + 1;
-		if (runtime > remaining)
-			runtime = remaining;
-		remaining -= runtime;
+		if (runtime > cfs_b->runtime)
+			runtime = cfs_b->runtime;
+		cfs_b->runtime -= runtime;
+		remaining = cfs_b->runtime;
+		raw_spin_unlock(&cfs_b->lock);
 
 		cfs_rq->runtime_remaining += runtime;
 
@@ -4873,8 +4875,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 			break;
 	}
 	rcu_read_unlock();
-
-	return starting_runtime - remaining;
 }
 
 /*
@@ -4885,7 +4885,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
-	u64 runtime;
 	int throttled;
 
 	/* no need to continue the timer with no bandwidth constraint */
@@ -4914,24 +4913,17 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	cfs_b->nr_throttled += overrun;
 
 	/*
-	 * This check is repeated as we are holding onto the new bandwidth while
-	 * we unthrottle. This can potentially race with an unthrottled group
-	 * trying to acquire new bandwidth from the global pool. This can result
-	 * in us over-using our runtime if it is all used during this loop, but
-	 * only by limited amounts in that extreme case.
+	 * This check is repeated as we release cfs_b->lock while we unthrottle.
 	 */
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
-		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
-		runtime = distribute_cfs_runtime(cfs_b, runtime);
+		distribute_cfs_runtime(cfs_b);
 		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
-
-		lsub_positive(&cfs_b->runtime, runtime);
 	}
 
 	/*
@@ -5065,10 +5057,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (!runtime)
 		return;
 
-	runtime = distribute_cfs_runtime(cfs_b, runtime);
+	distribute_cfs_runtime(cfs_b);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
@@ -6080,8 +6071,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
-	u64 time, cost;
-	s64 delta;
+	u64 time;
 	int this = smp_processor_id();
 	int cpu, nr = INT_MAX;
 
@@ -6119,9 +6109,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	time = cpu_clock(this) - time;
-	cost = this_sd->avg_scan_cost;
-	delta = (s64)(time - cost) / 8;
-	this_sd->avg_scan_cost += delta;
+	update_avg(&this_sd->avg_scan_cost, time);
 
 	return cpu;
 }
@@ -9048,6 +9036,14 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
 				sds->total_capacity;
+		/*
+		 * If the local group is more loaded than the selected
+		 * busiest group don't try to pull any tasks.
+		 */
+		if (local->avg_load >= busiest->avg_load) {
+			env->imbalance = 0;
+			return;
+		}
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0f616bf7bce3..db3a57675ccf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -195,6 +195,12 @@ static inline int task_has_dl_policy(struct task_struct *p)
 
 #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
 
+static inline void update_avg(u64 *avg, u64 sample)
+{
+	s64 diff = sample - *avg;
+	*avg += diff / 8;
+}
+
 /*
  * !! For sched_setattr_nocheck() (kernel) only !!
  *
@@ -882,7 +888,6 @@ struct rq {
 #endif
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
-	unsigned long		last_load_update_tick;
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
 #endif /* CONFIG_SMP */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3816a18c251e..891ccad5f271 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -858,7 +858,8 @@ void wq_worker_running(struct task_struct *task)
  * @task: task going to sleep
  *
  * This function is called from schedule() when a busy worker is
- * going to sleep.
+ * going to sleep. Preemption needs to be disabled to protect ->sleeping
+ * assignment.
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
@@ -875,7 +876,8 @@ void wq_worker_sleeping(struct task_struct *task)
 
 	pool = worker->pool;
 
-	if (WARN_ON_ONCE(worker->sleeping))
+	/* Return if preempted before wq_worker_running() was reached */
+	if (worker->sleeping)
 		return;
 
 	worker->sleeping = 1;

