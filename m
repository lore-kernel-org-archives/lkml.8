Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEBF22CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGTMUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:20:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgGTMUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:20:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD1D106F;
        Mon, 20 Jul 2020 05:20:33 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D1B73F66E;
        Mon, 20 Jul 2020 05:20:32 -0700 (PDT)
References: <20200717122651.GA6067@redhat.com> <20200717124017.GB6067@redhat.com> <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org> <20200718171406.GB16791@redhat.com> <20200718174448.4btbjcvp6wbbdgts@wittgenstein> <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org> <20200720064326.GA6612@redhat.com> <20200720082657.GC6612@redhat.com> <20200720084106.GJ10769@hirez.programming.kicks-ass.net> <20200720105924.GE43129@hirez.programming.kicks-ass.net> <20200720112623.GF43129@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
In-reply-to: <20200720112623.GF43129@hirez.programming.kicks-ass.net>
Date:   Mon, 20 Jul 2020 13:20:26 +0100
Message-ID: <jhjwo2yidit.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/07/20 12:26, peterz@infradead.org wrote:
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
>       struct task_struct *prev, *next;
>       unsigned long *switch_count;
> -	unsigned long prev_state;
>       struct rq_flags rf;
>       struct rq *rq;
>       int cpu;
> @@ -4140,16 +4140,38 @@ static void __sched notrace __schedule(bool preempt)
>       rq_lock(rq, &rf);
>       smp_mb__after_spinlock();
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

IIUC if the state changed and isn't TASK_RUNNING it *has* to have
__TASK_TRACED, so can't that be

  SCHED_WARN_ON(tmp_state && !(tmp_state & __TASK_TRACED));

Other than that, LGTM.

> +		prev_state = tmp_state;
> +	}
> +
>       /* Promote REQ to ACT */
>       rq->clock_update_flags <<= 1;
>       update_rq_clock(rq);
>
>       switch_count = &prev->nivcsw;
> -	/*
> -	 * We must re-load prev->state in case ttwu_remote() changed it
> -	 * before we acquired rq->lock.
> -	 */
> -	if (!preempt && prev_state && prev_state == prev->state) {
> +	if (!preempt && prev_state) {
>               if (signal_pending_state(prev_state, prev)) {
>                       prev->state = TASK_RUNNING;
>               } else {
