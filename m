Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33EF2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGJUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:20:10 -0400
Received: from foss.arm.com ([217.140.110.172]:33460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgGGJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60775C0A;
        Tue,  7 Jul 2020 02:20:09 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45C8E3F68F;
        Tue,  7 Jul 2020 02:20:08 -0700 (PDT)
Date:   Tue, 7 Jul 2020 10:20:05 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, valentin.schneider@arm.com
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200707092004.jviycpvzb4l5ytiz@e107158-lin.cambridge.arm.com>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
 <20200706145952.GB597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706145952.GB597537@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/20 16:59, Peter Zijlstra wrote:

[...]

> @@ -4104,12 +4108,19 @@ static void __sched notrace __schedule(bool preempt)
>  	local_irq_disable();
>  	rcu_note_context_switch(preempt);
>  
> +	prev_state = prev->state;
> +
>  	/*
> -	 * Make sure that signal_pending_state()->signal_pending() below
> -	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> -	 * done by the caller to avoid the race with signal_wake_up().
> +	 * __set_current_state(@state)
> +	 * schedule()				signal_wake_up()
> +	 *   prev_state = p->state		  set_tsk_thread_flag(p, TIF_SIGPENDING)
> +	 *					  wake_up_state()
> +	 *   LOCK rq->lock			    LOCK p->pi_state
> +	 *   smp_mb__after_spinlock()		    smp_mb__after_spinlock()
> +	 *     if (signal_pending_state()	    if (p->state & @state)
> +	 *
>  	 *
> -	 * The membarrier system call requires a full memory barrier
> +	 * Also, the membarrier system call requires a full memory barrier
>  	 * after coming from user-space, before storing to rq->curr.
>  	 */
>  	rq_lock(rq, &rf);
> @@ -4120,10 +4131,30 @@ static void __sched notrace __schedule(bool preempt)
>  	update_rq_clock(rq);
>  
>  	switch_count = &prev->nivcsw;
> -	if (!preempt && prev->state) {
> -		if (signal_pending_state(prev->state, prev)) {
> +	/*
> +	 * We must re-load p->state in case ttwu_runnable() changed it
> +	 * before we acquired rq->lock.
> +	 */
> +	if (!preempt && prev_state && prev_state == prev->state) {

I think the compiler won't optimize `prev_state == prev->state` out because of
the smp_mb__after_spinlock() which implies a compiler barrier. Still not sure
if it's worth making prev->state accesses a READ_ONCE()?

Thanks

--
Qais Yousef
