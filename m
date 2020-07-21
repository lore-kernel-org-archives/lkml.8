Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D7620792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgGUJOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:14:44 -0400
Received: from foss.arm.com ([217.140.110.172]:60368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUJOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:14:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB2AA106F;
        Tue, 21 Jul 2020 02:14:42 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92B0F3F718;
        Tue, 21 Jul 2020 02:14:41 -0700 (PDT)
References: <20200717124017.GB6067@redhat.com> <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org> <20200718171406.GB16791@redhat.com> <20200718174448.4btbjcvp6wbbdgts@wittgenstein> <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org> <20200720064326.GA6612@redhat.com> <20200720082657.GC6612@redhat.com> <20200720084106.GJ10769@hirez.programming.kicks-ass.net> <20200720105924.GE43129@hirez.programming.kicks-ass.net> <20200720140224.GD6612@redhat.com> <20200720142105.GR10769@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
In-reply-to: <20200720142105.GR10769@hirez.programming.kicks-ass.net>
Date:   Tue, 21 Jul 2020 10:14:36 +0100
Message-ID: <jhjtuy1i60z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/07/20 15:21, Peter Zijlstra wrote:
> On Mon, Jul 20, 2020 at 04:02:24PM +0200, Oleg Nesterov wrote:
>> I have to admit, I do not understand the usage of prev_state in schedule(),
>> it looks really, really subtle...
>
> Right, so commit dbfb089d360 solved a problem where schedule() re-read
> prev->state vs prev->on_rq = 0. That is, schedule()'s dequeue and
> ttwu()'s enqueue disagreed over sched_contributes_to_load. and as a
> result load-accounting went wobbly.
>
> Now, looking at that commit again, I might've solved the problem twice
> :-P
>
> So on the one hand, I provider ordering:
>
>       LOAD p->state		LOAD-ACQUIRE p->on_rq == 0
>       MB
>       STORE p->on_rq, 0	STORE p->state, TASK_WAKING
>
> such that ttwu() will only change p->state, after on_rq==0, which is
> after loading p->state in schedule().
>
> At the same time, I also had schedule() set
> p->sched_contributes_to_load once, and then consistently used that value
> throughout, without ever looking at p->state again, which too makes it
> much harder to mess load-avg up.
>
>
> Now, the ordering in schedule(), relies on doing the p->state load
> before:
>
>       spin_lock(rq->lock)
>       smp_mb__after_spinlock();
>
> and doing a re-load check after, with the assumption that if the reload
> is different, it will not block.
>
> That said, in a crossed email, I just proposed we could simplify all
> this like so.. but now I need to go ask people to re-validate that
> loadavg muck again :-/
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a2a244af9a53..437fc3b241f2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(bool preempt)
>       local_irq_disable();
>       rcu_note_context_switch(preempt);
>
> -	/* See deactivate_task() below. */
> -	prev_state = prev->state;
> -
>       /*
>        * Make sure that signal_pending_state()->signal_pending() below
>        * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> @@ -4223,7 +4220,8 @@ static void __sched notrace __schedule(bool preempt)
>        * We must re-load prev->state in case ttwu_remote() changed it
>        * before we acquired rq->lock.
>        */
> -	if (!preempt && prev_state && prev_state == prev->state) {
> +	prev_state = prev->state;

AFAICT the ttwu/schedule ordering dance + the "trick" of updating
p->sched_contributes_to_load in __schedule() under rq lock ensures loadavg
accounting won't go awry here. I'm still a bit low on coffee, but that does
LGTM.


> +	if (!preempt && prev_state) {
>               if (signal_pending_state(prev_state, prev)) {
>                       prev->state = TASK_RUNNING;
>               } else {
> @@ -4237,10 +4235,12 @@ static void __sched notrace __schedule(bool preempt)
>
>                       /*
>                        * __schedule()			ttwu()
> -			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
> -			 *   LOCK rq->lock		    goto out;
> -			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
> -			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
> +			 *   if (prev_state)		  if (p->on_rq && ...)
> +			 *     p->on_rq = 0;		    goto out;
> +			 *				  smp_acquire__after_ctrl_dep();
> +			 *				  p->state = TASK_WAKING
> +			 *
> +			 * Where __schedule() and ttwu() have matching control dependencies.
>                        *
>                        * After this, schedule() must not care about p->state any more.
>                        */
