Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9226C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F21320771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cUH3K4l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DS+K+d6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgGHJqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgGHJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:46:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5DC08C5DC;
        Wed,  8 Jul 2020 02:46:14 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:46:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaBmz5T0gTeKsycZ4iDh9C9kbwRhpKjXaMiaaTz7aMo=;
        b=2cUH3K4lelhxHTgxALkLotqvSl2FiM8TwUfgRZDxE90MaHpJxbN31hNhs/+0gTHPyDqtqn
        AFLBvTsrlCY23bK175cxSrACttFWNwixziJbeJMWhT+4eMWsaOUUsrzSguhR9ULDc9L9PO
        HX4V9Vqp8dOfXcTUovAWHvT5kO1vwgzg5ElZtsdCtXjnGm0A5pMETEBuBGJQ0WOCognoTH
        42FYuzQ4k1CjEpz/Q7oEnLfjxKA1x3bm0zyfDe32NIfXgpQFq4EZ3ITV1FhIfX/QAG1PS2
        XNcjXYX2OUF9XmFEgT5/M4RgbZDz5kgXuXLwpU0MIpEnCIluJxaXfU2tTzEGsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaBmz5T0gTeKsycZ4iDh9C9kbwRhpKjXaMiaaTz7aMo=;
        b=DS+K+d6eHDxkt4bT+WRyPV36hcegxkfSoXLV7I/jlY+aJmvhJLwWOLe5CqgnnG8MLv6bgM
        E+C9ur43/jtiykCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix loadavg accounting race
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200707102957.GN117543@hirez.programming.kicks-ass.net>
References: <20200707102957.GN117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159420157209.4006.10732608050891501703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dbfb089d360b1cc623c51a2c7cf9b99eff78e0e7
Gitweb:        https://git.kernel.org/tip/dbfb089d360b1cc623c51a2c7cf9b99eff78e0e7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 03 Jul 2020 12:40:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:49 +02:00

sched: Fix loadavg accounting race

The recent commit:

  c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")

moved these lines in ttwu():

	p->sched_contributes_to_load = !!task_contributes_to_load(p);
	p->state = TASK_WAKING;

up before:

	smp_cond_load_acquire(&p->on_cpu, !VAL);

into the 'p->on_rq == 0' block, with the thinking that once we hit
schedule() the current task cannot change it's ->state anymore. And
while this is true, it is both incorrect and flawed.

It is incorrect in that we need at least an ACQUIRE on 'p->on_rq == 0'
to avoid weak hardware from re-ordering things for us. This can fairly
easily be achieved by relying on the control-dependency already in
place.

The second problem, which makes the flaw in the original argument, is
that while schedule() will not change prev->state, it will read it a
number of times (arguably too many times since it's marked volatile).
The previous condition 'p->on_cpu == 0' was sufficient because that
indicates schedule() has completed, and will no longer read
prev->state. So now the trick is to make this same true for the (much)
earlier 'prev->on_rq == 0' case.

Furthermore, in order to make the ordering stick, the 'prev->on_rq = 0'
assignment needs to he a RELEASE, but adding additional ordering to
schedule() is an unwelcome proposition at the best of times, doubly so
for mere accounting.

Luckily we can push the prev->state load up before rq->lock, with the
only caveat that we then have to re-read the state after. However, we
know that if it changed, we no longer have to worry about the blocking
path. This gives us the required ordering, if we block, we did the
prev->state load before an (effective) smp_mb() and the p->on_rq store
needs not change.

With this we end up with the effective ordering:

	LOAD p->state           LOAD-ACQUIRE p->on_rq == 0
	MB
	STORE p->on_rq, 0       STORE p->state, TASK_WAKING

which ensures the TASK_WAKING store happens after the prev->state
load, and all is well again.

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Dave Jones <davej@codemonkey.org.uk>
Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Link: https://lkml.kernel.org/r/20200707102957.GN117543@hirez.programming.kicks-ass.net
---
 include/linux/sched.h |  4 +---
 kernel/sched/core.c   | 67 +++++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327..6833729 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -114,10 +114,6 @@ struct task_group;
 
 #define task_is_stopped_or_traced(task)	((task->state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
 
-#define task_contributes_to_load(task)	((task->state & TASK_UNINTERRUPTIBLE) != 0 && \
-					 (task->flags & PF_FROZEN) == 0 && \
-					 (task->state & TASK_NOLOAD) == 0)
-
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca5db40..950ac45 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1311,9 +1311,6 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible--;
-
 	enqueue_task(rq, p, flags);
 
 	p->on_rq = TASK_ON_RQ_QUEUED;
@@ -1323,9 +1320,6 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
 
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible++;
-
 	dequeue_task(rq, p, flags);
 }
 
@@ -2236,10 +2230,10 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 
 	lockdep_assert_held(&rq->lock);
 
-#ifdef CONFIG_SMP
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
 
+#ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 #endif
@@ -2583,7 +2577,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (p->on_rq && ttwu_remote(p, wake_flags))
+	if (READ_ONCE(p->on_rq) && ttwu_remote(p, wake_flags))
 		goto unlock;
 
 	if (p->in_iowait) {
@@ -2592,9 +2586,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	}
 
 #ifdef CONFIG_SMP
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2613,8 +2604,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 *
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
+	 *
+	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
+	 * schedule()'s deactivate_task() has 'happened' and p will no longer
+	 * care about it's own p->state. See the comment in __schedule().
 	 */
-	smp_rmb();
+	smp_acquire__after_ctrl_dep();
+
+	/*
+	 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
+	 * == 0), which means we need to do an enqueue, change p->state to
+	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
+	 * enqueue, such as ttwu_queue_wakelist().
+	 */
+	p->state = TASK_WAKING;
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -4097,6 +4100,7 @@ static void __sched notrace __schedule(bool preempt)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
+	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -4113,12 +4117,22 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
+	/* See deactivate_task() below. */
+	prev_state = prev->state;
+
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
-	 * done by the caller to avoid the race with signal_wake_up().
+	 * done by the caller to avoid the race with signal_wake_up():
+	 *
+	 * __set_current_state(@state)		signal_wake_up()
+	 * schedule()				  set_tsk_thread_flag(p, TIF_SIGPENDING)
+	 *					  wake_up_state(p, state)
+	 *   LOCK rq->lock			    LOCK p->pi_state
+	 *   smp_mb__after_spinlock()		    smp_mb__after_spinlock()
+	 *     if (signal_pending_state())	    if (p->state & @state)
 	 *
-	 * The membarrier system call requires a full memory barrier
+	 * Also, the membarrier system call requires a full memory barrier
 	 * after coming from user-space, before storing to rq->curr.
 	 */
 	rq_lock(rq, &rf);
@@ -4129,10 +4143,31 @@ static void __sched notrace __schedule(bool preempt)
 	update_rq_clock(rq);
 
 	switch_count = &prev->nivcsw;
-	if (!preempt && prev->state) {
-		if (signal_pending_state(prev->state, prev)) {
+	/*
+	 * We must re-load prev->state in case ttwu_remote() changed it
+	 * before we acquired rq->lock.
+	 */
+	if (!preempt && prev_state && prev_state == prev->state) {
+		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
+			prev->sched_contributes_to_load =
+				(prev_state & TASK_UNINTERRUPTIBLE) &&
+				!(prev_state & TASK_NOLOAD) &&
+				!(prev->flags & PF_FROZEN);
+
+			if (prev->sched_contributes_to_load)
+				rq->nr_uninterruptible++;
+
+			/*
+			 * __schedule()			ttwu()
+			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
+			 *   LOCK rq->lock		    goto out;
+			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
+			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
+			 *
+			 * After this, schedule() must not care about p->state any more.
+			 */
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
