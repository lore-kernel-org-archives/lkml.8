Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C366C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5834120726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxGOYgK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFCBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:01:01 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45419 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFCBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:01:00 -0500
Received: by mail-qv1-f67.google.com with SMTP id r8so257734qvs.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 18:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeO2EZIb5m/L0A9vgmfNDVgncGhqhLgXvsUkGV6aqvA=;
        b=uxGOYgK1IdIGDyGIR3Dx2CqMLJbgbDsEUdttRirJgkrlcl9hXB1z7sJ2DZBqAr6YTE
         BUPWYtv8JfYFGuly+vFMh3gvDClK7DLTkdprk1SJEQk7+BtcRFan5HfBB6WZ0kXJ+3mz
         D+ZXReMVat2VBR5uS92YT9bMPLZ8Fgl+ZC219uJHsz4MbK7OSc4yp2krRF5i6dvn8m3M
         +OnG195qdb1TLa84J8PRI+DxPPJFclr3vOea0vooX4xeiZF12yMHf8724jwd/5UH8ILw
         k1AYduG1HLKtLPrKKbCRUkwgWqtPs2WMy1yw0El5SpU3eipVvisCjeCxUjBRFYR5fCIP
         g1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeO2EZIb5m/L0A9vgmfNDVgncGhqhLgXvsUkGV6aqvA=;
        b=ZasJMAHQzDp/zJrI67TtP3RFtmv+S58UFVhO92tuvZdyKS99lJ28i2Dkyptl/AKyHy
         5H0bWOTo4rP8mzx/WBX/Ey9TZF4ncppz5t58XCSGA8o48vPtQG2jDe1l9hjpuEZFGzWP
         rInpAp7xqNtY8m/jabcQLppGceYX003rlxY0/WJL8x7IBYN3L6cUqCHGu8T++sfHQ6lq
         zp91q/BNZFgIzeccMI8ixSnf+9ilHqMndy4uL5JXbI+CkC857FankL+uawrZTGLRkBtA
         PVJM45nXBusL0Dgloum621/UpNRHNsT/822o/HB5QY7x1nSQvzpuwDCW4v7rPOiXbycB
         5wnQ==
X-Gm-Message-State: ANhLgQ0Us259KNtUMwE9j+tvs+YSlyE1RSmDUZwZuZTpljmfyHxWfuQv
        dZQZ2A6Dr9I29uvtDyawvqBLducwFf7gP10gYK8KoQ==
X-Google-Smtp-Source: ADFU+vuwJAO3rUmSH2HK7VnJM/1Ph8otZl4E9Gi+YPq5BoY7+1A0E3Iil9ed3jefaB4EktsddkyQhXAMqItq1MReKes=
X-Received: by 2002:ad4:5673:: with SMTP id bm19mr1026874qvb.231.1583460059385;
 Thu, 05 Mar 2020 18:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20200228010134.42866-1-joshdon@google.com> <20200304182139.GO2596@hirez.programming.kicks-ass.net>
In-Reply-To: <20200304182139.GO2596@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 5 Mar 2020 18:00:47 -0800
Message-ID: <CABk29NsOUwALWCGpVoTBE7536XiunwjGoAvxU6my55XeH+NCdA@mail.gmail.com>
Subject: Re: [PATCH] sched/cpuset: distribute tasks within affinity masks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments, I discussed further with Paul.  We agree with
simplifying this into a new cpumask macro, and thus cutting down the
changes needed directly in core.c.

> Why? Changelog doesn't seem to give a reason for adding another
> interface.

The new interface was to selectively enable distribution for specific
paths.  For some paths, we wanted to run on prev_cpu if in mask.
However, as described below, this concern is no longer relevant, I'll
remove the extra interface.

> I don't really buy the argument why that shortcut is problematic; it's
> all averages anyway, and keeping a task on a CPU where it's already
> running seems like a win.

It made sense for our use case at the time, but in general we agree
that it is fine to leave things where they are if possible.

On Wed, Mar 4, 2020 at 10:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 27, 2020 at 05:01:34PM -0800, Josh Don wrote:
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 04278493bf15..a2aab6a8a794 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1587,6 +1587,8 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
> >  #ifdef CONFIG_SMP
> >  extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
> >  extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
> > +extern int set_cpus_allowed_ptr_distribute(struct task_struct *p,
> > +                             const struct cpumask *new_mask);
>
> Why? Changelog doesn't seem to give a reason for adding another
> interface.
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1a9983da4408..2336d6d66016 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1612,6 +1612,32 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> >               set_next_task(rq, p);
> >  }
> >
> > +static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
> > +
> > +/*
> > + * Returns an arbitrary cpu within *srcp1 & srcp2
> > + *
> > + * Iterated calls using the same srcp1 and srcp2, passing the previous cpu each
> > + * time, will be distributed within their intersection.
> > + */
> > +static int distribute_to_new_cpumask(const struct cpumask *src1p,
> > +                                  const struct cpumask *src2p)
> > +{
> > +     int next, prev;
> > +
> > +     /* NOTE: our first selection will skip 0. */
> > +     prev = __this_cpu_read(distribute_cpu_mask_prev);
> > +
> > +     next = cpumask_next_and(prev, src1p, src2p);
> > +     if (next >= nr_cpu_ids)
> > +             next = cpumask_first_and(src1p, src2p);
> > +
> > +     if (next < nr_cpu_ids)
> > +             __this_cpu_write(distribute_cpu_mask_prev, next);
> > +
> > +     return next;
> > +}
>
> That's a valid implementation of cpumask_any_and(), it just has a really
> weird name.
>
> >  /*
> >   * Change a given task's CPU affinity. Migrate the thread to a
> >   * proper CPU and schedule it away if the CPU it's executing on
> > @@ -1621,11 +1647,11 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> >   * task must not exit() & deallocate itself prematurely. The
> >   * call is not atomic; no spinlocks may be held.
> >   */
> > -static int __set_cpus_allowed_ptr(struct task_struct *p,
> > +static int __set_cpus_allowed_ptr(struct task_struct *p, bool distribute_cpus,
> >                                 const struct cpumask *new_mask, bool check)
> >  {
> >       const struct cpumask *cpu_valid_mask = cpu_active_mask;
> > -     unsigned int dest_cpu;
> > +     unsigned int dest_cpu, prev_cpu;
> >       struct rq_flags rf;
> >       struct rq *rq;
> >       int ret = 0;
> > @@ -1652,8 +1678,33 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >       if (cpumask_equal(p->cpus_ptr, new_mask))
> >               goto out;
> >
> > -     dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
> > -     if (dest_cpu >= nr_cpu_ids) {
> > +     if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     prev_cpu = task_cpu(p);
> > +     if (distribute_cpus) {
> > +             dest_cpu = distribute_to_new_cpumask(new_mask,
> > +                                                  cpu_valid_mask);
> > +     } else {
> > +             /*
> > +              * Can the task run on the task's current CPU? If so, we're
> > +              * done.
> > +              *
> > +              * We only enable this short-circuit in the case that we're
> > +              * not trying to distribute tasks.  As we may otherwise not
> > +              * distribute away from a loaded CPU, or make duplicate
> > +              * assignments to it.
> > +              */
> > +             if (cpumask_test_cpu(prev_cpu, new_mask))
> > +                     dest_cpu = prev_cpu;
> > +             else
> > +                     dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
> > +     }
>
> That all seems overly complicated; what is wrong with just this:
>
>         dest_cpu = cpumask_any_and_fancy(cpu_valid_mask, new_mask);
>
> I don't really buy the argument why that shortcut is problematic; it's
> all averages anyway, and keeping a task on a CPU where it's already
> running seems like a win.
>
> > +     /* May have raced with cpu_down */
> > +     if (unlikely(dest_cpu >= nr_cpu_ids)) {
> >               ret = -EINVAL;
> >               goto out;
> >       }
