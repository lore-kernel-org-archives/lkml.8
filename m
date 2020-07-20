Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67FBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779E920B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NmNe1K8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgGTOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:05:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB182C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Or60w4j07KPRnhUWMuerFNPfKsEvTYFzIgX31q2mm+k=; b=NmNe1K8xZVMItM5Is2iUqHqo0+
        /dAyxnr3VfmmD69ras4ctm21gfMAxXi/wFSuTLEHlH9bZr5e4IBgrWKw/zop0rOvcFlVs7qEyabW/
        NLjqSFkf684Jm6/Zc0WuAw3rd4ytqM8ycieVBCU3WdSddeYJABI9SIve/qzPx+4By2vJaBHrHiBHx
        fj+P4Q2hkVmgGTd6PbrNHFyasSU8nDNQlqjlON4NE02o32nELoXyJrR9BmKrt32KF+lOGCY6fMHFe
        zk1LA8dnA5yGa+vKmdZ3BVZeNZdilz3qCYbE5y366mpLbFkeuXPmIkoeEglasoaLYxZghlb1B5q1m
        2t4FMHnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxWQI-0000yH-Ci; Mon, 20 Jul 2020 14:05:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B4203010C8;
        Mon, 20 Jul 2020 16:05:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56EA02120BDC2; Mon, 20 Jul 2020 16:05:41 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:05:41 +0200
From:   peterz@infradead.org
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Will Deacon <will@kernel.org>, paulmck@kernel.org
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720140541.GG43129@hirez.programming.kicks-ass.net>
References: <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720112623.GF43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720112623.GF43129@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:26:23PM +0200, peterz@infradead.org wrote:
>  kernel/sched/core.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e15543cb84812..b5973d7fa521c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4100,9 +4100,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   */
>  static void __sched notrace __schedule(bool preempt)
>  {
> +	unsigned long prev_state, tmp_state;
>  	struct task_struct *prev, *next;
>  	unsigned long *switch_count;
> -	unsigned long prev_state;
>  	struct rq_flags rf;
>  	struct rq *rq;
>  	int cpu;
> @@ -4140,16 +4140,38 @@ static void __sched notrace __schedule(bool preempt)
>  	rq_lock(rq, &rf);
>  	smp_mb__after_spinlock();
>  
> +	/*
> +	 * We must re-load prev->state in case ttwu_remote() changed it
> +	 * before we acquired rq->lock.
> +	 */
> +	tmp_state = prev->state;
> +	if (unlikely(prev_state != tmp_state)) {
> +		/*
> +		 * ptrace_{,un}freeze_traced() think it is cool to change
> +		 * ->state around behind our backs between TASK_TRACED and
> +		 *  __TASK_TRACED.
> +		 *
> +		 * This is safe because this, as well as any __TASK_TRACED
> +		 * wakeups are under siglock.
> +		 *
> +		 * For any other case, a changed prev_state must be to
> +		 * TASK_RUNNING, such that when it blocks, the load has
> +		 * happened before the smp_mb().
> +		 *
> +		 * Also see the comment with deactivate_task().
> +		 */
> +		SCHED_WARN_ON(tmp_state && (prev_state & __TASK_TRACED &&
> +					   !(tmp_state & __TASK_TRACED)));
> +
> +		prev_state = tmp_state;

While trying to write a changelog for this thing, I can't convince
myself we don't need:

		smp_mb();

here. Consider:

CPU0				CPU1				CPU2

				schedule()
				  prev_state = prev->state;
				  spin_lock(rq->lock);
				  smp_mb__after_spin_lock();
ptrace_freeze_traced()
  spin_lock(siglock)
  task->state = __TASK_TRACED;
  spin_unlock(siglock);
				  tmp_state = prev->state;
				  if (prev_state != tmp_state)
				    prev_state = tmp_state;
				  /* NO SMP_MB */
				  if (prev_state)
				    deactivate_task()
				      prev->on_rq = 0;
								spin_lock(siglock);
								ttwu()
								  if (rq->on_rq && ...)
								    goto unlock;
								  smp_acquire__after_ctrl_dep();
								  p->state = TASK_WAKING;

Looses the ordering we previously relied upon. That is, CPU1's
prev->state load and prev->on_rq store can get reordered vs CPU2.

OTOH, we have a control dependency on CPU1 as well, that should provide
LOAD->STORE ordering, after all we only do the ->on_rq=0 store, IFF we
see prev_state.

So that is:

	if (p->state)			if (!p->on_rq)
		p->on_rq = 0;			p->state = TASK_WAKING

which matches a CTRL-DEP to a CTRL-DEP ...

But this then means we can simplify dbfb089d360 as well, but now my head
hurts.

> +	}
> +
>  	/* Promote REQ to ACT */
>  	rq->clock_update_flags <<= 1;
>  	update_rq_clock(rq);
>  
>  	switch_count = &prev->nivcsw;
> -	/*
> -	 * We must re-load prev->state in case ttwu_remote() changed it
> -	 * before we acquired rq->lock.
> -	 */
> -	if (!preempt && prev_state && prev_state == prev->state) {
> +	if (!preempt && prev_state) {
>  		if (signal_pending_state(prev_state, prev)) {
>  			prev->state = TASK_RUNNING;
>  		} else {
