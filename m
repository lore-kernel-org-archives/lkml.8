Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F9AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345732065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KjdSUQd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGGKaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGKaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:30:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A7C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QyJLw2bRT+321HRHgYlJVqDKnLEycAWOatNSooJM3fo=; b=KjdSUQd03TwxpfZ1B4qjvSGb6V
        IonIBE5zT2/T1SKQ762LTZPSsXQ4TPpCjJ9DU7Mv9TixpxZn8nuTFa3Fu1phEqrd1vGwgrY30PiXD
        lOhju+efMoSKQDlKLl1znfraTd03xHacaKT4hBk35Mfxy/9URnrM/qtvY263usZWhsywF2vRNh9X4
        97ZouCKOVFtxuESJaYwM536mYIZ/g2nl6T2S2mMpp//YrEpUBZZB31IO33oG6I7xzWH6jwHiNbBtR
        wcieOlIL5p8/HMpu6kxAooW9XlqwadJkwVrHDm9myFXxw+JKnAuGJoyqw/Dlc6403fb+n++gmPHqy
        +/3A/I8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jskrO-0003ub-4B; Tue, 07 Jul 2020 10:29:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A799B304B90;
        Tue,  7 Jul 2020 12:29:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96DB42120F4C3; Tue,  7 Jul 2020 12:29:57 +0200 (CEST)
Date:   Tue, 7 Jul 2020 12:29:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, paulmck@kernel.org
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200707102957.GN117543@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
 <20200706145952.GB597537@hirez.programming.kicks-ass.net>
 <jhj5zb08agb.mognet@arm.com>
 <20200707081719.GK4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707081719.GK4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:17:19AM +0200, Peter Zijlstra wrote:
> Anyway, let me now endeavour to write a coherent Changelog for this mess

I'll go stick this in sched/urgent and update that other documentation
patch (again)..

---
Subject: sched: Fix loadavg accounting race
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 3 Jul 2020 12:40:33 +0200

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
---
 include/linux/sched.h |    4 --
 kernel/sched/core.c   |   67 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 51 insertions(+), 20 deletions(-)

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
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1313,9 +1313,6 @@ static inline void dequeue_task(struct r
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible--;
-
 	enqueue_task(rq, p, flags);
 
 	p->on_rq = TASK_ON_RQ_QUEUED;
@@ -1325,9 +1322,6 @@ void deactivate_task(struct rq *rq, stru
 {
 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
 
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible++;
-
 	dequeue_task(rq, p, flags);
 }
 
@@ -2228,10 +2222,10 @@ ttwu_do_activate(struct rq *rq, struct t
 
 	lockdep_assert_held(&rq->lock);
 
-#ifdef CONFIG_SMP
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
 
+#ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 #endif
@@ -2575,7 +2569,7 @@ try_to_wake_up(struct task_struct *p, un
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (p->on_rq && ttwu_remote(p, wake_flags))
+	if (READ_ONCE(p->on_rq) && ttwu_remote(p, wake_flags))
 		goto unlock;
 
 	if (p->in_iowait) {
@@ -2584,9 +2578,6 @@ try_to_wake_up(struct task_struct *p, un
 	}
 
 #ifdef CONFIG_SMP
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2605,8 +2596,20 @@ try_to_wake_up(struct task_struct *p, un
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
@@ -4088,6 +4091,7 @@ static void __sched notrace __schedule(b
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
+	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -4104,12 +4108,22 @@ static void __sched notrace __schedule(b
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
@@ -4120,10 +4134,31 @@ static void __sched notrace __schedule(b
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
