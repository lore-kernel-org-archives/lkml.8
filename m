Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A4CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B776C2078B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591556272;
	bh=n3h79ZdU1+AjdfZc0BaILYCwUvEmnluPenX4aYgT158=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2SRrc0JrLqEDRJ/4HA9m5pVkumc87hayqwJVUoYlLO0w49AO35G6iIjt9OfmjHcWo
	 b4C2OUazeseX4lClShYz1txwQI/fDdtxrQb4hskur0x88fDah7NOuNZnd1msTkg+bP
	 yth7my4VKS+vtbNW502+ZvH/UlzW5u43kidJfMR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFGS5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgFGS5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:57:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299132073B;
        Sun,  7 Jun 2020 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591556253;
        bh=n3h79ZdU1+AjdfZc0BaILYCwUvEmnluPenX4aYgT158=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SfekSHdsJTGYDzZxvrdgh1Yk52oUFJ8H9+gR5CBg6UsT3s4rw3/9h8efcvTZgQlkm
         EatwxsuUP15B7s5Pr1k1Yx3+bq9JGSFZoAxmryKqs5mz4GtQrxEGaJf9p4+72uaGQN
         30+pqANpcxLZWKpq2UGHFcGG3sxXAoQ7ZKpL5+Rs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 08D6935228C7; Sun,  7 Jun 2020 11:57:33 -0700 (PDT)
Date:   Sun, 7 Jun 2020 11:57:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200607185732.GA18906@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605131451.GE2750@hirez.programming.kicks-ass.net>
 <20200605141607.GB4455@paulmck-ThinkPad-P72>
 <20200605184159.GA4062@paulmck-ThinkPad-P72>
 <20200606005126.GA21507@paulmck-ThinkPad-P72>
 <20200606172942.GA30594@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606172942.GA30594@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 10:29:42AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 05, 2020 at 05:51:26PM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 05, 2020 at 11:41:59AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jun 05, 2020 at 07:16:07AM -0700, Paul E. McKenney wrote:
> > > 
> > > And in case it is helpful, here is the output of "git bisect view",
> > > which lists rather more commits than "git bisect run" claims, but there
> > > are only a few scheduler commits below.  I don't see anything that
> > > I can prove can cause this problem, but there are some that are at
> > > least related to this code path.
> > > 
> > > Is there anything that is actually relevant?
> > 
> > And the run with the WARN and tracing did hit two failures, and the
> > corresponding console logs are in the attached tarball.  Both of them
> > triggered a warning as well as the failure.
> 
> And the current state of the bisection, for whatever it is worth.

The bisection finished, finally!

90b5363acd47 ("sched: Clean up scheduler_ipi()")

I don't see anything immediately obvious, but then again, I do not
claim to understand this code.  If you have additional diagnostics,
please let me know.

						Thanx, Paul

------------------------------------------------------------------------

commit 90b5363acd4739769c3f38c1aff16171bd133e8c
Author: Peter Zijlstra (Intel) <peterz@infradead.org>
Date:   Fri Mar 27 11:44:56 2020 +0100

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
 
