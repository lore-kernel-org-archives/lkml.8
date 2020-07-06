Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B6620715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXsHFI+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgGFPAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGFPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:00:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AC0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lY00MqOKGmJov5UoZkQDdd/758jr0xUm0VQZf0FL5nc=; b=FXsHFI+aQ7C3SsplOpWB50OzYp
        0hPlaVkyCVgGv/BahZSkJqvxT4GQQR7oV8JN7PtoZ0JM+z6UxRLx5sXTPtIjSVhHSDiINwDhISzss
        9V5I1j8REuZIdNgbJc6KsCxjp335jLIzCe+Y1/mEDVODF/hATd4bljxebD/4K1Sk/lQv+2/B+PyH+
        OwXOYfChrNAaTiPcpclXfDXBw13CpWyop1792dDIaQUHnBK388IrzJ08UW2jlzbBGNTvLVogo+eYR
        OXIvq6lPJx3xJCWNfv82xUxOkiKYTXD1muGETucl3CtoeDQn1YZs0wXDaR5NXz7vTtxu+4K++8g+f
        TlmyUJKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsSb6-0002SV-8e; Mon, 06 Jul 2020 14:59:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2F503013E5;
        Mon,  6 Jul 2020 16:59:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A941C213C65B5; Mon,  6 Jul 2020 16:59:52 +0200 (CEST)
Date:   Mon, 6 Jul 2020 16:59:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     paul.gortmaker@windriver.com, valentin.schneider@arm.com
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200706145952.GB597537@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703205153.GA19901@codemonkey.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:51:53PM -0400, Dave Jones wrote:
> On Fri, Jul 03, 2020 at 12:40:33PM +0200, Peter Zijlstra wrote:
>  
>  > So ARM/Power/etc.. can speculate the load such that the
>  > task_contributes_to_load() value is from before ->on_rq.
>  > 
>  > The compiler might similar re-order things -- although I've not found it
>  > doing so with the few builds I looked at.
>  > 
>  > So I think at the very least we should do something like this. But i've
>  > no idea how to reproduce this problem.
>  > 
>  > Mel's patch placed it too far down, as the WF_ON_CPU path also relies on
>  > this, and by not resetting p->sched_contributes_to_load it would skew
>  > accounting even worse.
> 
> looked promising the first few hours, but as soon as it hit four hours
> of uptime, loadavg spiked and is now pinned to at least 1.00

OK, lots of cursing later, I now have the below...

The TL;DR is that while schedule() doesn't change p->state once it
starts, it does read it quite a bit, and ttwu() will actually change it
to TASK_WAKING. So if ttwu() changes it to WAKING before schedule()
reads it to do loadavg accounting, things go sideways.

The below is extra complicated by the fact that I've had to scrounge up
a bunch of load-store ordering without actually adding barriers. It adds
yet another control dependency to ttwu(), so take that C standard :-)

I've booted it, and build a few kernels with it and checked loadavg
drops to 0 after each build, so from that pov all is well, but since
I'm not confident I can reproduce the issue, I can't tell this actually
fixes anything, except maybe phantoms of my imagination.

---
 include/linux/sched.h |  4 ---
 kernel/sched/core.c   | 67 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9bd073a10224..e26c8bbeda00 100644
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
index 1d3d2d67f398..f245444b4b15 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1313,9 +1313,6 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible--;
-
 	enqueue_task(rq, p, flags);
 
 	p->on_rq = TASK_ON_RQ_QUEUED;
@@ -1325,9 +1322,6 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
 
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible++;
-
 	dequeue_task(rq, p, flags);
 }
 
@@ -2228,10 +2222,10 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 
 	lockdep_assert_held(&rq->lock);
 
-#ifdef CONFIG_SMP
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
 
+#ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 #endif
@@ -2575,7 +2569,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (p->on_rq && ttwu_remote(p, wake_flags))
+	if (READ_ONCE(p->on_rq) && ttwu_remote(p, wake_flags))
 		goto unlock;
 
 	if (p->in_iowait) {
@@ -2584,9 +2578,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	}
 
 #ifdef CONFIG_SMP
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2605,8 +2596,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
@@ -4088,6 +4091,7 @@ static void __sched notrace __schedule(bool preempt)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
+	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -4104,12 +4108,19 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
+	prev_state = prev->state;
+
 	/*
-	 * Make sure that signal_pending_state()->signal_pending() below
-	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
-	 * done by the caller to avoid the race with signal_wake_up().
+	 * __set_current_state(@state)
+	 * schedule()				signal_wake_up()
+	 *   prev_state = p->state		  set_tsk_thread_flag(p, TIF_SIGPENDING)
+	 *					  wake_up_state()
+	 *   LOCK rq->lock			    LOCK p->pi_state
+	 *   smp_mb__after_spinlock()		    smp_mb__after_spinlock()
+	 *     if (signal_pending_state()	    if (p->state & @state)
+	 *
 	 *
-	 * The membarrier system call requires a full memory barrier
+	 * Also, the membarrier system call requires a full memory barrier
 	 * after coming from user-space, before storing to rq->curr.
 	 */
 	rq_lock(rq, &rf);
@@ -4120,10 +4131,30 @@ static void __sched notrace __schedule(bool preempt)
 	update_rq_clock(rq);
 
 	switch_count = &prev->nivcsw;
-	if (!preempt && prev->state) {
-		if (signal_pending_state(prev->state, prev)) {
+	/*
+	 * We must re-load p->state in case ttwu_runnable() changed it
+	 * before we acquired rq->lock.
+	 */
+	if (!preempt && prev_state && prev_state == prev->state) {
+		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
+			prev->sched_contributes_to_load =
+				(prev_state & (TASK_UNINTERRUPTIBLE | TASK_NOLOAD)) == TASK_UNINTERRUPTIBLE &&
+				(prev->flags & PF_FROZEN) == 0;
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
