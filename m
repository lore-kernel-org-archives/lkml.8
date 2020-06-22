Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C50FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC320675
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/pBJiZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFVKPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgFVKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:15:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED7BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=d1cpm3OGS5BqyKzzGJVk/Yi66wiChVYCtssYe+4SXXM=; b=i/pBJiZd3cMTC5K3eLwxJHC4RR
        Fhh8FdEwExa4N4yb2pSg+0iWMs4aA6ZoTJg1mjaYD+sEL8qjeqfuzL3y0MsXrktlkWDDdEU3jY1b3
        uZg4ynN0WBj/b8RYA/ybUvFPQtWVDuJM+v5qx+tBdDC+6xAPlvC1wvu2jsncR5+VdpZ6rmVjIqLkP
        dSVeFi+N7X7Bt4bsIgG7LmGHWxavukTC8mDzOzQBhShgOFz79J83p6WdI7og+4mHRfsFL62JyscB1
        /lMX+REn014at2vvFUpvQRVkVpaK1/WD2uigr+WhAmGWZ2MrYiLRqzWLJaD5WVZPjkO88tb5oWjsZ
        91cbHy6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnJTl-0008JO-HX; Mon, 22 Jun 2020 10:15:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65F35304A59;
        Mon, 22 Jun 2020 12:15:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 28F6C29994FCA; Mon, 22 Jun 2020 12:15:02 +0200 (CEST)
Message-ID: <20200622100825.726200103@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Jun 2020 12:01:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hch@lst.de
Subject: [PATCH -v2 1/5] sched: Fix ttwu() race
References: <20200622100122.477087977@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/core.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2293,8 +2293,15 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry)
+	llist_for_each_entry_safe(p, t, llist, wake_entry) {
+		if (WARN_ON_ONCE(p->on_cpu))
+			smp_cond_load_acquire(p->on_cpu, !VAL);
+
+		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
+			set_task_cpu(p, cpu_of(rq));
+
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+	}
 
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -2378,6 +2385,9 @@ static inline bool ttwu_queue_cond(int c
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
+		if (WARN_ON_ONCE(cpu == smp_processor_id()))
+			return false;
+
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
@@ -2550,7 +2560,6 @@ try_to_wake_up(struct task_struct *p, un
 
 	/* We're going to change ->state: */
 	success = 1;
-	cpu = task_cpu(p);
 
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
@@ -2614,8 +2623,21 @@ try_to_wake_up(struct task_struct *p, un
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
@@ -2635,6 +2657,8 @@ try_to_wake_up(struct task_struct *p, un
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
 	}
+#else
+	cpu = task_cpu(p);
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);


