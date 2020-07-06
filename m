Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949CC20857
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGFX4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:56:09 -0400
Received: from foss.arm.com ([217.140.110.172]:57554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgGFX4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:56:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E89B31B;
        Mon,  6 Jul 2020 16:56:08 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1913F68F;
        Mon,  6 Jul 2020 16:56:07 -0700 (PDT)
References: <20200702171548.GA11813@codemonkey.org.uk> <20200702213627.GF3183@techsingularity.net> <20200703090226.GV4800@hirez.programming.kicks-ass.net> <20200703104033.GK117543@hirez.programming.kicks-ass.net> <20200703205153.GA19901@codemonkey.org.uk> <20200706145952.GB597537@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com
Subject: Re: weird loadavg on idle machine post 5.7
In-reply-to: <20200706145952.GB597537@hirez.programming.kicks-ass.net>
Date:   Tue, 07 Jul 2020 00:56:04 +0100
Message-ID: <jhj5zb08agb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/07/20 15:59, Peter Zijlstra wrote:
> OK, lots of cursing later, I now have the below...
>
> The TL;DR is that while schedule() doesn't change p->state once it
> starts, it does read it quite a bit, and ttwu() will actually change it
> to TASK_WAKING. So if ttwu() changes it to WAKING before schedule()
> reads it to do loadavg accounting, things go sideways.
>
> The below is extra complicated by the fact that I've had to scrounge up
> a bunch of load-store ordering without actually adding barriers. It adds
> yet another control dependency to ttwu(), so take that C standard :-)
>
> I've booted it, and build a few kernels with it and checked loadavg
> drops to 0 after each build, so from that pov all is well, but since
> I'm not confident I can reproduce the issue, I can't tell this actually
> fixes anything, except maybe phantoms of my imagination.
>

As you said on IRC, the one apparent race would lead into "negative"
rq->nr_uninterruptible accounting, i.e. we'd skip some increments so would
end up with more decrements. As for the described issue, I think we were
both expecting "positive" accounting, i.e. more increments than decrements,
leading into an artificially inflated loadavg.

In any case, this should get rid of any existing race. I'll need some more
time (and more aperol spritz) to go through it all though.

> @@ -2605,8 +2596,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>        *
>        * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
>        * __schedule().  See the comment for smp_mb__after_spinlock().
> +	 *
> +	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
> +	 * schedule()'s deactivate_task() has 'happened' and p will no longer
> +	 * care about it's own p->state. See the comment in __schedule().
>        */
> -	smp_rmb();
> +	smp_acquire__after_ctrl_dep();

Apologies for asking again, but I'm foolishly hopeful I'll someday be able
to grok those things without half a dozen tabs open with documentation and
Paul McKenney papers.

Do I get it right that the 'acquire' part hints this is equivalent to
issuing a load-acquire on whatever was needed to figure out whether or not
the take the branch (in this case, p->on_rq, amongst other things); IOW
ensures any memory access appearing later in program order has to happen
after the load?

That at least explains to me the load->{load,store} wording in
smp_acquire__after_ctrl_dep().

> +
> +	/*
> +	 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
> +	 * == 0), which means we need to do an enqueue, change p->state to
> +	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
> +	 * enqueue, such as ttwu_queue_wakelist().
> +	 */
> +	p->state = TASK_WAKING;
>
>       /*
>        * If the owning (remote) CPU is still in the middle of schedule() with
