Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BA72065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGGKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:21:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGKU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:20:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 444A1C0A;
        Tue,  7 Jul 2020 03:20:55 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 295BD3F71E;
        Tue,  7 Jul 2020 03:20:54 -0700 (PDT)
References: <20200702171548.GA11813@codemonkey.org.uk> <20200702213627.GF3183@techsingularity.net> <20200703090226.GV4800@hirez.programming.kicks-ass.net> <20200703104033.GK117543@hirez.programming.kicks-ass.net> <20200703205153.GA19901@codemonkey.org.uk> <20200706145952.GB597537@hirez.programming.kicks-ass.net> <jhj5zb08agb.mognet@arm.com> <20200707081719.GK4800@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, paulmck@kernel.org
Subject: Re: weird loadavg on idle machine post 5.7
In-reply-to: <20200707081719.GK4800@hirez.programming.kicks-ass.net>
Date:   Tue, 07 Jul 2020 11:20:49 +0100
Message-ID: <jhj4kqj8w3i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/07/20 09:17, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 12:56:04AM +0100, Valentin Schneider wrote:
>
>> > @@ -2605,8 +2596,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>> >        *
>> >        * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
>> >        * __schedule().  See the comment for smp_mb__after_spinlock().
>> > +	 *
>> > +	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
>> > +	 * schedule()'s deactivate_task() has 'happened' and p will no longer
>> > +	 * care about it's own p->state. See the comment in __schedule().
>> >        */
>> > -	smp_rmb();
>> > +	smp_acquire__after_ctrl_dep();
>>
>> Apologies for asking again, but I'm foolishly hopeful I'll someday be able
>> to grok those things without half a dozen tabs open with documentation and
>> Paul McKenney papers.
>>
>> Do I get it right that the 'acquire' part hints this is equivalent to
>> issuing a load-acquire on whatever was needed to figure out whether or not
>> the take the branch (in this case, p->on_rq, amongst other things); IOW
>> ensures any memory access appearing later in program order has to happen
>> after the load?
>>
>> That at least explains to me the load->{load,store} wording in
>> smp_acquire__after_ctrl_dep().
>
> Yes.
>
> So the thing is that hardware MUST NOT speculate stores, or rather, if
> it does, it must take extreme measures to ensure they do not become
> visible in any way shape or form, since speculative stores lead to
> instant OOTA problems.
>
> Therefore we can say that branches order stores and if the branch
> condition depends on a load, we get a load->store order. IOW the load
> must complete before we can resolve the branch, which in turn enables
> the store to become visible/happen.
>

Right, I think that point is made clear in memory-barriers.txt.

> If we then add an smp_rmb() to the branch to order load->load, we end up
> with a load->{load,store} ordering, which is equivalent to a
> load-acquire.
>
> The reason to do it like that, is that load-aquire would otherwise
> require an smp_mb(), since for many platforms that's the only barrier
> that has load->store ordering.
>
> The down-side of doing it like this, as Paul will be quick to point out,
> is that the C standard doesn't recognise control dependencies and thus
> the compiler would be in its right to 'optimize' our conditional away.
>

Yikes!

> We're relying on the compilers not having done this in the past and
> there being sufficient compiler people interested in compiling Linux to
> avoid this from happening.
>
>
> Anyway, this patch is basically:
>
>       LOAD p->state		LOAD-ACQUIRE p->on_rq == 0
>       MB
>       STORE p->on_rq, 0	STORE p->state, TASK_WAKING
>
> which ensures the TASK_WAKING store happens after the p->state load.
> Just a wee bit complicated due to not actually adding any barriers while
> adding additional ordering.
>

Your newer changelog also helped in that regards.

Thanks a ton for the writeup!

> Anyway, let me now endeavour to write a coherent Changelog for this mess
> :-(
