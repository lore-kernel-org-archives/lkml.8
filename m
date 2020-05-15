Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F74C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B412076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UnN+uBBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEOOZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:25:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B0C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:24:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g11so519651ots.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrgp2986PlkyCk9J+GXSDElLOJy9O+udFBEXW76d7GM=;
        b=UnN+uBBuA89j47gx2ggmo0MvUeT9kXYX6nEpuBN6c1IeZGVUIVHeIqvVUOLtiKn4VC
         9ljZqs0oBPdP9fTqoYzHP4tRc55L9OIsftAnU3cDLtHpjbdk+WR9kfleObZyR62XVq+e
         UKdTJSLNqswGwoHVEOnh8MHGSs+y9T4ba1UsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrgp2986PlkyCk9J+GXSDElLOJy9O+udFBEXW76d7GM=;
        b=N4I1ujU2BejrWrKA0YnJXqu6/1lXKoxvgLF11d6sftevUHRdF03qpEehLjHOWbKWXt
         eNmeS8KXgmIgZrDIrWFnXNlehezkcORtYBz1guWIOZrNWZrfIYj3U+dzbQl+fPgXQ4tE
         iOW55x56FEORUzcsbcGa/xKRZ5fnXKWRuvrZMgPIhTp/nJxgLcJ3Mz+C96/vtTZymSit
         U5Y783kkSLYdhS/PVZG6iSFO+g9S9ql8uf4B/HT1T4Vi5R65M0bJ+p+3zX+pD3aGPAdK
         uu9Tw3AlPHrp6jJUervGaDO6QEztMDiqngCvpuxjFgZIqjgcuTuSFugwppFYjsTuRVJX
         LMwQ==
X-Gm-Message-State: AOAM531i+R47vQO+NN9hl+HDY0Dvj9PradspGEvLdOu3trIeAfpYg8lv
        UPPtx9SCVwTuV9XD1clAaIkC3NLWXD+sTlOFnZnOiQ==
X-Google-Smtp-Source: ABdhPJy2DsvFzTTowSk6UvyECOlAUT4AtHzuRMYk4vUKI0pTo32lfhYotqsSa5Se62GT6kwvrGvYVDUvOs37F5H+N+s=
X-Received: by 2002:a9d:6ac9:: with SMTP id m9mr2479709otq.33.1589552699030;
 Fri, 15 May 2020 07:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop> <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net> <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net> <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net> <CANaguZD_ZknCrnUA8TYs4rc0TLJZ9J2_FcWmW5cxEMWDTdL6hg@mail.gmail.com>
 <20200515103844.GG2978@hirez.programming.kicks-ass.net>
In-Reply-To: <20200515103844.GG2978@hirez.programming.kicks-ass.net>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 15 May 2020 10:24:47 -0400
Message-ID: <CANaguZBFeS7rUvvsRTVj4kf2nA5SD2+MS0npV0CMTn5n8cHT0Q@mail.gmail.com>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority comparison
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 6:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> It's complicated ;-)
>
> So this sync is basically a relative reset of S to 0.
>
> So with 2 queues, when one goes idle, we drop them both to 0 and one
> then increases due to not being idle, and the idle one builds up lag to
> get re-elected. So far so simple, right?
>
> When there's 3, we can have the situation where 2 run and one is idle,
> we sync to 0 and let the idle one build up lag to get re-election. Now
> suppose another one also drops idle. At this point dropping all to 0
> again would destroy the built-up lag from the queue that was already
> idle, not good.
>
Thanks for the clarification :-).

I was suggesting an idea of corewide force_idle. We sync the core_vruntime
on first force_idle of a sibling in the core and start using core_vruntime
for priority comparison from then on. That way, we don't reset the lag on
every force_idle and the lag builds up from the first sibling that was
forced_idle. I think this would work with infeasible weights as well,
but needs to think more to see if it would break. A sample check to enter
this core wide force_idle state is:
(cpumask_weight(cpu_smt_mask(cpu)) == old_active && new_active < old_active)

And we exit the core wide force_idle state when the last sibling goes out
of force_idle and can start using min_vruntime for priority comparison
from then on.

When there is a cookie match on all siblings, we don't do priority comparison
now. But I think we need to do priority comparison for cookie matches
also, so that we update 'max' in the loop. And for this comparison during
a no forced_idle scenario, I hope it should be fine to use the min_vruntime.
Updating 'max' in the loop when cookie matches is not really needed for SMT2,
but would be needed for SMTn.

This is just a wild idea on top of your patches. Might not be accurate
in all cases and need to think more about the corner cases. I thought I
would think it loud here :-)

> So instead of syncing everything, we can:
>
>   less := !((s64)(s_a - s_b) <= 0)
>
>   (v_a - S_a) - (v_b - S_b) == v_a - v_b - S_a + S_b
>                             == v_a - (v_b - S_a + S_b)
>
> IOW, we can recast the (lag) comparison to a one-sided difference.
> So if then, instead of syncing the whole queue, sync the idle queue
> against the active queue with S_a + S_b at the point where we sync.
>
> (XXX consider the implication of living in a cyclic group: N / 2^n N)
>
> This gives us means of syncing single queues against the active queue,
> and for already idle queues to preseve their build-up lag.
>
> Of course, then we get the situation where there's 2 active and one
> going idle, who do we pick to sync against? Theory would have us sync
> against the combined S, but as we've already demonstated, there is no
> such thing in infeasible weight scenarios.
>
> One thing I've considered; and this is where that core_active rudiment
> came from, is having active queues sync up between themselves after
> every tick. This limits the observed divergence due to the work
> conservance.
>
> On top of that, we can improve upon things by moving away from our
> horrible (10) hack and moving to (9) and employing (13) here.
>
> Anyway, I got partway through that in the past days, but then my head
> hurt. I'll consider it some more :-)
This sounds much better and a more accurate approach then the one I
mentioned above. Please share the code when you have it in some form :-)

>
> > > +                       new_active++;
> > I think we need to reset new_active on restarting the selection.
>
> But this loop is after selection has been done; we don't modify
> new_active during selection.
My bad, sorry about this false alarm!

> > > +
> > > +       vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
> > > +       vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
> > Should we be using core_vruntime conditionally? should it be min_vruntime for
> > default comparisons and core_vruntime during force_idle?
>
> At the very least it should be min_vruntime when cfs_rq_a == cfs_rq_b,
> ie. when we're on the same CPU.
>
yes, this makes sense.

The issue that I was thinking about is, when there is no force_idle and
all siblings run compatible tasks for a while, min_vruntime progresses,
but core_vruntime lags behind. And when a new task gets enqueued, it gets
the min_vruntime. But now during comparison it might be treated unfairly.

Consider a small example of two rqs rq1 and rq2.
rq1->cfs->min_vruntime = 1000
rq2->cfs->min_vruntime = 2000

During a force_idle, core_vruntime gets synced and

rq1->cfs->core_vruntime = 1000
rq2->cfs->core_vruntime = 2000

Now, suppose the core is out of force_idle and runs two compatible tasks
for a while, where the task on rq1 has more weight. min_vruntime progresses
on both, but slowly on rq1. Say the progress looks like:
rq1->cfs->min_vruntime = 1200, se1->vruntime = 1200
rq2->cfs->min_vruntime = 2500, se2->vruntime = 2500

If a new incompatible task(se3) gets enqueued to rq2, it's vruntime would
be based on rq2's min_vruntime, say:
se3->vruntime = 2500

During our priority comparison, lag would be:
l_se1 = 200
l_se3 = 500

So se1, will get selected and run with se2 until its lag catches up with
se3's lag(even if se3 has more weight than se1).

This is a hypothetical situation, but can happen I think. And if we use
min_vruntime for comparison during no force_idle scenario, we could
avoid this. What do you think?

I didn't clearly understand the tick based active sync and probably would
better fix this problem I guess.

Thanks,
Vineeth
