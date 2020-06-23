Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ADF206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgFWHTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgFWHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:19:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32002C061573;
        Tue, 23 Jun 2020 00:19:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jndDb-0003Bo-Ne; Tue, 23 Jun 2020 09:19:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D3D91C0475;
        Tue, 23 Jun 2020 09:19:42 +0200 (CEST)
Date:   Tue, 23 Jun 2020 07:19:41 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix ttwu() race
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200622125649.GC576871@hirez.programming.kicks-ass.net>
References: <20200622125649.GC576871@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159289678197.16989.8028009202152262279.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dcb623b51fb9d424471da9acbd2cfa618ecf9a09
Gitweb:        https://git.kernel.org/tip/dcb623b51fb9d424471da9acbd2cfa618ecf9a09
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Jun 2020 12:01:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Jun 2020 20:51:06 +02:00

sched: Fix ttwu() race

Paul reported rcutorture occasionally hitting a NULL deref:

  sched_ttwu_pending()
    ttwu_do_wakeup()
      check_preempt_curr() := check_preempt_wakeup()
        find_matching_se()
          is_same_group()
            if (se->cfs_rq == pse->cfs_rq) <-- *BOOM*

Debugging showed that this only appears to happen when we take the new
code-path from commit:

  2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")

and only when @cpu == smp_processor_id(). Something which should not
be possible, because p->on_cpu can only be true for remote tasks.
Similarly, without the new code-path from commit:

  c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")

this would've unconditionally hit:

  smp_cond_load_acquire(&p->on_cpu, !VAL);

and if: 'cpu == smp_processor_id() && p->on_cpu' is possible, this
would result in an instant live-lock (with IRQs disabled), something
that hasn't been reported.

The NULL deref can be explained however if the task_cpu(p) load at the
beginning of try_to_wake_up() returns an old value, and this old value
happens to be smp_processor_id(). Further assume that the p->on_cpu
load accurately returns 1, it really is still running, just not here.

Then, when we enqueue the task locally, we can crash in exactly the
observed manner because p->se.cfs_rq != rq->cfs_rq, because p's cfs_rq
is from the wrong CPU, therefore we'll iterate into the non-existant
parents and NULL deref.

The closest semi-plausible scenario I've managed to contrive is
somewhat elaborate (then again, actual reproduction takes many CPU
hours of rcutorture, so it can't be anything obvious):

					X->cpu = 1
					rq(1)->curr = X

	CPU0				CPU1				CPU2

					// switch away from X
					LOCK rq(1)->lock
					smp_mb__after_spinlock
					dequeue_task(X)
					  X->on_rq = 9
					switch_to(Z)
					  X->on_cpu = 0
					UNLOCK rq(1)->lock

									// migrate X to cpu 0
									LOCK rq(1)->lock
									dequeue_task(X)
									set_task_cpu(X, 0)
									  X->cpu = 0
									UNLOCK rq(1)->lock

									LOCK rq(0)->lock
									enqueue_task(X)
									  X->on_rq = 1
									UNLOCK rq(0)->lock

	// switch to X
	LOCK rq(0)->lock
	smp_mb__after_spinlock
	switch_to(X)
	  X->on_cpu = 1
	UNLOCK rq(0)->lock

	// X goes sleep
	X->state = TASK_UNINTERRUPTIBLE
	smp_mb();			// wake X
					ttwu()
					  LOCK X->pi_lock
					  smp_mb__after_spinlock

					  if (p->state)

					  cpu = X->cpu; // =? 1

					  smp_rmb()

	// X calls schedule()
	LOCK rq(0)->lock
	smp_mb__after_spinlock
	dequeue_task(X)
	  X->on_rq = 0

					  if (p->on_rq)

					  smp_rmb();

					  if (p->on_cpu && ttwu_queue_wakelist(..)) [*]

					  smp_cond_load_acquire(&p->on_cpu, !VAL)

					  cpu = select_task_rq(X, X->wake_cpu, ...)
					  if (X->cpu != cpu)
	switch_to(Y)
	  X->on_cpu = 0
	UNLOCK rq(0)->lock

However I'm having trouble convincing myself that's actually possible
on x86_64 -- after all, every LOCK implies an smp_mb there, so if ttwu
observes ->state != RUNNING, it must also observe ->cpu != 1.

(Most of the previous ttwu() races were found on very large PowerPC)

Nevertheless, this fully explains the observed failure case.

Fix it by ordering the task_cpu(p) load after the p->on_cpu load,
which is easy since nothing actually uses @cpu before this.

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20200622125649.GC576871@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f79d76..3328c29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2293,8 +2293,15 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry)
+	llist_for_each_entry_safe(p, t, llist, wake_entry) {
+		if (WARN_ON_ONCE(p->on_cpu))
+			smp_cond_load_acquire(&p->on_cpu, !VAL);
+
+		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
+			set_task_cpu(p, cpu_of(rq));
+
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+	}
 
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -2378,6 +2385,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
+		if (WARN_ON_ONCE(cpu == smp_processor_id()))
+			return false;
+
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
@@ -2528,7 +2538,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		success = 1;
-		cpu = task_cpu(p);
 		trace_sched_waking(p);
 		p->state = TASK_RUNNING;
 		trace_sched_wakeup(p);
@@ -2550,7 +2559,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/* We're going to change ->state: */
 	success = 1;
-	cpu = task_cpu(p);
 
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
@@ -2614,8 +2622,21 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * which potentially sends an IPI instead of spinning on p->on_cpu to
 	 * let the waker make forward progress. This is safe because IRQs are
 	 * disabled and the IPI will deliver after on_cpu is cleared.
+	 *
+	 * Ensure we load task_cpu(p) after p->on_cpu:
+	 *
+	 * set_task_cpu(p, cpu);
+	 *   STORE p->cpu = @cpu
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock
+	 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
+	 *   STORE p->on_cpu = 1		LOAD p->cpu
+	 *
+	 * to ensure we observe the correct CPU on which the task is currently
+	 * scheduling.
 	 */
-	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
+	if (smp_load_acquire(&p->on_cpu) &&
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_RQ))
 		goto unlock;
 
 	/*
@@ -2635,6 +2656,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
 	}
+#else
+	cpu = task_cpu(p);
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);
@@ -2642,7 +2665,7 @@ unlock:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 out:
 	if (success)
-		ttwu_stat(p, cpu, wake_flags);
+		ttwu_stat(p, task_cpu(p), wake_flags);
 	preempt_enable();
 
 	return success;
