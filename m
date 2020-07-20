Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD8C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FB422B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgGTM5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:57:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37441 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgGTM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:57:38 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jxVMJ-0001ZJ-Ft; Mon, 20 Jul 2020 12:57:31 +0000
Date:   Mon, 20 Jul 2020 14:57:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     peterz@infradead.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720125730.6mr2xgc4kzzuaxzo@wittgenstein>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720112623.GF43129@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:26:23PM +0200, peterz@infradead.org wrote:
> On Mon, Jul 20, 2020 at 12:59:24PM +0200, peterz@infradead.org wrote:
> > On Mon, Jul 20, 2020 at 10:41:06AM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 20, 2020 at 10:26:58AM +0200, Oleg Nesterov wrote:
> > > > Peter,
> > > > 
> > > > Let me add another note. TASK_TRACED/TASK_STOPPED was always protected by
> > > > ->siglock. In particular, ttwu(__TASK_TRACED) must be always called with
> > > > ->siglock held. That is why ptrace_freeze_traced() assumes it can safely
> > > > do s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock).
> > > > 
> > > > Can this change race with
> > > > 
> > > > 		if (signal_pending_state(prev->state, prev)) {
> > > > 			prev->state = TASK_RUNNING;
> > > > 		}
> > > > 
> > > > in __schedule() ? Hopefully not, signal-state is protected by siglock too.
> > > > 
> > > > So I think this logic was correct even if it doesn't look nice. But "doesn't
> > > > look nice" is true for the whole ptrace code ;)
> > > 
> > > *groan*... another bit of obscure magic :-(
> > > 
> > > let me go try and wake up and figure out how best to deal with this.
> 
> This then? That seems to survive the strace thing.

Ran a mainline v5.8-rc6 -> reproduced crash
Ran a mainling v5.8-rc6 + patch below -> testsuite runs fine/not able to reproduce crash

So fwiw
Tested-by: Christian Brauner <christian.brauner@ubuntu.com> 
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> 
> ---
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
