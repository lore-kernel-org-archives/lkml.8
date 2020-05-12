Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67503C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB5A206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgELPNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgELPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:13:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C3C061A0E;
        Tue, 12 May 2020 08:13:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYWb1-00074I-Kk; Tue, 12 May 2020 17:13:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 34C3F1C0475;
        Tue, 12 May 2020 17:13:27 +0200 (CEST)
Date:   Tue, 12 May 2020 15:13:27 -0000
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up scheduler_ipi()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134058.361859938@linutronix.de>
References: <20200505134058.361859938@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929640713.390.10558251425748115488.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     90b5363acd4739769c3f38c1aff16171bd133e8c
Gitweb:        https://git.kernel.org/tip/90b5363acd4739769c3f38c1aff16171bd133e8c
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Fri, 27 Mar 2020 11:44:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 17:10:48 +02:00

sched: Clean up scheduler_ipi()

The scheduler IPI has grown weird and wonderful over the years, time
for spring cleaning.

Move all the non-trivial stuff out of it and into a regular smp function
call IPI. This then reduces the schedule_ipi() to most of it's former NOP
glory and ensures to keep the interrupt vector lean and mean.

Aside of that avoiding the full irq_enter() in the x86 IPI implementation
is incorrect as scheduler_ipi() can be instrumented. To work around that
scheduler_ipi() had an irq_enter/exit() hack when heavy work was
pending. This is gone now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134058.361859938@linutronix.de
---
 kernel/sched/core.c  | 64 ++++++++++++++++++++-----------------------
 kernel/sched/fair.c  |  5 +--
 kernel/sched/sched.h |  6 ++--
 3 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b58efb1..cd2070d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -219,6 +219,13 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
+static inline void
+rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
+{
+	csd->flags = 0;
+	csd->func = func;
+	csd->info = rq;
+}
 
 #ifdef CONFIG_SCHED_HRTICK
 /*
@@ -314,16 +321,14 @@ void hrtick_start(struct rq *rq, u64 delay)
 	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
 		      HRTIMER_MODE_REL_PINNED_HARD);
 }
+
 #endif /* CONFIG_SMP */
 
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq->hrtick_csd.flags = 0;
-	rq->hrtick_csd.func = __hrtick_start;
-	rq->hrtick_csd.info = rq;
+	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
 #endif
-
 	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
 }
@@ -650,6 +655,16 @@ static inline bool got_nohz_idle_kick(void)
 	return false;
 }
 
+static void nohz_csd_func(void *info)
+{
+	struct rq *rq = info;
+
+	if (got_nohz_idle_kick()) {
+		rq->idle_balance = 1;
+		raise_softirq_irqoff(SCHED_SOFTIRQ);
+	}
+}
+
 #else /* CONFIG_NO_HZ_COMMON */
 
 static inline bool got_nohz_idle_kick(void)
@@ -2292,6 +2307,11 @@ void sched_ttwu_pending(void)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
+static void wake_csd_func(void *info)
+{
+	sched_ttwu_pending();
+}
+
 void scheduler_ipi(void)
 {
 	/*
@@ -2300,34 +2320,6 @@ void scheduler_ipi(void)
 	 * this IPI.
 	 */
 	preempt_fold_need_resched();
-
-	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
-		return;
-
-	/*
-	 * Not all reschedule IPI handlers call irq_enter/irq_exit, since
-	 * traditionally all their work was done from the interrupt return
-	 * path. Now that we actually do some work, we need to make sure
-	 * we do call them.
-	 *
-	 * Some archs already do call them, luckily irq_enter/exit nest
-	 * properly.
-	 *
-	 * Arguably we should visit all archs and update all handlers,
-	 * however a fair share of IPIs are still resched only so this would
-	 * somewhat pessimize the simple resched case.
-	 */
-	irq_enter();
-	sched_ttwu_pending();
-
-	/*
-	 * Check if someone kicked us for doing the nohz idle load balance.
-	 */
-	if (unlikely(got_nohz_idle_kick())) {
-		this_rq()->idle_balance = 1;
-		raise_softirq_irqoff(SCHED_SOFTIRQ);
-	}
-	irq_exit();
 }
 
 static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
@@ -2336,9 +2328,9 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
-	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
+	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
-			smp_send_reschedule(cpu);
+			smp_call_function_single_async(cpu, &rq->wake_csd);
 		else
 			trace_sched_wake_idle_without_ipi(cpu);
 	}
@@ -6693,12 +6685,16 @@ void __init sched_init(void)
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
+		rq_csd_init(rq, &rq->wake_csd, wake_csd_func);
+
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
+
+		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46b7bd4..6b7f147 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10000,12 +10000,11 @@ static void kick_ilb(unsigned int flags)
 		return;
 
 	/*
-	 * Use smp_send_reschedule() instead of resched_cpu().
-	 * This way we generate a sched IPI on the target CPU which
+	 * This way we generate an IPI on the target CPU which
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_send_reschedule(ilb_cpu);
+	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 978c6fa..21416b3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -889,9 +889,10 @@ struct rq {
 #ifdef CONFIG_SMP
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
+	call_single_data_t	nohz_csd;
 #endif /* CONFIG_SMP */
 	unsigned int		nohz_tick_stopped;
-	atomic_t nohz_flags;
+	atomic_t		nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
 	unsigned long		nr_load_updates;
@@ -978,7 +979,7 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
-#endif
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
@@ -1020,6 +1021,7 @@ struct rq {
 #endif
 
 #ifdef CONFIG_SMP
+	call_single_data_t	wake_csd;
 	struct llist_head	wake_list;
 #endif
 
