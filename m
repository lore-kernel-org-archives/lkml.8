Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A77206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8eYE6Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgFKMB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgFKMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:01:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0BC08C5C3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:01:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so6577915ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOjUBjavuZ4PP3pqeN7MITws22OwPsrlOfoep6Vvoe8=;
        b=i8eYE6Og5ZMfQeISnzWMdaATxvHpgBHPfSuPJBQgdZujekSLmkbSPf68i/yhzx5e1Q
         P8HmHduoCZX6jR3pYBzpGssVILELDCqAheIdjBiL4K4hzX9Xi59O5U+bxKDIxzM66h3e
         e9tFSNospkVlQU3vrkfLoDOhp67tMiU66UCp0pNEssbmgIuJxZwOj6WbSQ/HwdoRV6II
         eyIDpK4Xix8GCxHKl3gN5PjWpGa65B2r3oDnUkozOZm7C3/ZOnOdTB7hEh8atnwjoCEp
         d+9NloCNZFKbP/ydu6DdIQt1j8RyU4s0JLkFbEo6jcgLyRZvPmdm5N5e9MFgSIgRCa/c
         lrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOjUBjavuZ4PP3pqeN7MITws22OwPsrlOfoep6Vvoe8=;
        b=lrUR+mDpkHOsQdxnR8Q0DoVN1F6/jS2zh1yQvcUTvN2JHONrJhXnS/4yNfvr+HoByE
         EsNVD/VlLfWhaMQBtGjIJ4rbTIcRBVsQ0HGqnm0JnvnnTXV/4W+qn9HJ3HovgIagWUSb
         45YSRnTE+3Oy9xh6bdWhmaIrWJqVY7daEs5RS7GTj1xp5yhYNb9xfUA01twAFERYYFMN
         4YhTl+jDTETukGbhT2X9U7zVhEqDJiUIAsK/nvMbV908IRMYebtc61QIxBQgtXxdfxeI
         jioimFn+2cdhGbSlfd1WkkSSGrUO323+XKdlBQpCCvkS2ypCTm3iZb/6VIyeUXTzUN6y
         sgbQ==
X-Gm-Message-State: AOAM530pjl+csOkoHJLYjYYu46S1bfQBoqEOF7Zmgkj2Ab2hNEH4Qqs/
        OHrdZtvCn8/6w91uPu1laEy1muJIo/AKSNxE2qWBtg==
X-Google-Smtp-Source: ABdhPJwuDOtvgK0tlLu3an8tpYmbdgfjM5ieGq7jDPC6FWg9a321K1QipVzJrI6h/LBXlfaVLVBpVHBVxZ5BMN1Fs5s=
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr4494427ljn.111.1591876882689;
 Thu, 11 Jun 2020 05:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de> <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net> <20200603101022.GG3070@suse.de>
 <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
 <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
 <CAKfTPtCKS-2RoaMHhKGigjzc7dhXhx0z3dYNQLD3Q9aRC_tCnw@mail.gmail.com> <20200611102407.vhy3zjexrhorx753@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200611102407.vhy3zjexrhorx753@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 11 Jun 2020 14:01:11 +0200
Message-ID: <CAKfTPtDnWuBOJxJP7ahX4Kzu+8jvPjAcE6XErMtG1SCJMdZZ-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 at 12:24, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/09/20 19:10, Vincent Guittot wrote:
> > On Mon, 8 Jun 2020 at 14:31, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 06/04/20 14:14, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > > I have tried your patch and I don't see any difference compared to
> > > > previous tests. Let me give you more details of my setup:
> > > > I create 3 levels of cgroups and usually run the tests in the 4 levels
> > > > (which includes root). The result above are for the root level
> > > >
> > > > But I see a difference at other levels:
> > > >
> > > >                            root           level 1       level 2       level 3
> > > >
> > > > /w patch uclamp disable     50097         46615         43806         41078
> > > > tip uclamp enable           48706(-2.78%) 45583(-2.21%) 42851(-2.18%)
> > > > 40313(-1.86%)
> > > > /w patch uclamp enable      48882(-2.43%) 45774(-1.80%) 43108(-1.59%)
> > > > 40667(-1.00%)
> > > >
> > > > Whereas tip with uclamp stays around 2% behind tip without uclamp, the
> > > > diff of uclamp with your patch tends to decrease when we increase the
> > > > number of level
> > >
> > > So I did try to dig more into this, but I think it's either not a good
> > > reproducer or what we're observing here is uArch level latencies caused by the
> > > new code that seem to produce a bigger knock on effect than what they really
> > > are.
> > >
> > > First, CONFIG_FAIR_GROUP_SCHED is 'expensive', for some definition of
> > > expensive..
> >
> > yes, enabling CONFIG_FAIR_GROUP_SCHED adds an overhead
> >
> > >
> > > *** uclamp disabled/fair group enabled ***
> > >
> > >         # Executed 50000 pipe operations between two threads
> > >
> > >              Total time: 0.958 [sec]
> > >
> > >               19.177100 usecs/op
> > >                   52145 ops/sec
> > >
> > > *** uclamp disabled/fair group disabled ***
> > >
> > >         # Executed 50000 pipe operations between two threads
> > >              Total time: 0.808 [sec]
> > >
> > >              16.176200 usecs/op
> > >                  61819 ops/sec
> > >
> > > So there's a 15.6% drop in ops/sec when enabling this option. I think it's good
> > > to look at the absolutely number of usecs/op, Fair group adds around
> > > 3 usecs/op.
> > >
> > > I dropped FAIR_GROUP_SCHED from my config to eliminate this overhead and focus
> > > on solely on uclamp overhead.
> >
> > Have you checked that both tests run at the root level ?
>
> I haven't actively moved tasks to cgroups. As I said that snippet was
> particularly bad and I didn't see that level of nesting in every call.
>
> > Your function-graph log below shows several calls to
> > update_cfs_group() which means that your trace below has not been made
> > at root level but most probably at the 3rd level and I wonder if you
> > used the same setup for running the benchmark above. This could
> > explain such huge difference because I don't have such difference on
> > my platform but more around 2%
>
> What promoted me to look at this is when you reported that even without uclamp
> the nested cgroup showed a drop at each level. I was just trying to understand
> how both affect the hot path in hope to understand the root cause of uclamp
> overhead.
>
> >
> > For uclamp disable/fair group enable/ function graph enable :  47994ops/sec
> > For uclamp disable/fair group disable/ function graph enable : 49107ops/sec
> >
> > >
> > > With uclamp enabled but no fair group I get
> > >
> > > *** uclamp enabled/fair group disabled ***
> > >
> > >         # Executed 50000 pipe operations between two threads
> > >              Total time: 0.856 [sec]
> > >
> > >              17.125740 usecs/op
> > >                  58391 ops/sec
> > >
> > > The drop is 5.5% in ops/sec. Or 1 usecs/op.
> > >
> > > I don't know what's the expectation here. 1 us could be a lot, but I don't
> > > think we expect the new code to take more than few 100s of ns anyway. If you
> > > add potential caching effects, reaching 1 us wouldn't be that hard.
> > >
> > > Note that in my runs I chose performance governor and use `taskset 0x2` to
> >
> > You might want to set 2 CPUs in your cpumask instead of 1 in order to
> > have 1 CPU for each thread
>
> I did try that but it didn't seem to change the number. I think the 2 tasks
> interleave so running in 2 CPUs doesn't change the result. But to ease ftrace
> capture, it's easier to monitor a single cpu.
>
> >
> > > force running on a big core to make sure the runs are repeatable.
> >
> > I also use performance governor but don't pinned tasks because I use smp.
>
> Is your arm platform SMP?

Yes, all my tests are done on the Arm64 octo core  smp system

>
> >
> > >
> > > On Juno-r2 I managed to scrap most of the 1 us with the below patch. It seems
> > > there was weird branching behavior that affects the I$ in my case. It'd be good
> > > to try it out to see if it makes a difference for you.
> >
> > The perf are slightly worse on my setup:
> > For uclamp enable/fair group disable/ function graph enable : 48413ops/sec
> > with patch  below : 47804os/sec
>
> I am not sure if the new code could just introduce worse cache performance
> in a platform dependent way. The evidences I have so far point in this
> direction.
>
> >
> > >
> > > The I$ effect is my best educated guess. Perf doesn't catch this path and
> > > I couldn't convince it to look at cache and branch misses between 2 specific
> > > points.
> > >
> > > Other subtle code shuffling did have weird effect on the result too. One worthy
> > > one is making uclamp_rq_dec() noinline gains back ~400 ns. Making
> > > uclamp_rq_inc() noinline *too* cancels this gain out :-/
> > >
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0464569f26a7..0835ee20a3c7 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1071,13 +1071,11 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> > >
> > >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > >  {
> > > -       enum uclamp_id clamp_id;
> > > -
> > >         if (unlikely(!p->sched_class->uclamp_enabled))
> > >                 return;
> > >
> > > -       for_each_clamp_id(clamp_id)
> > > -               uclamp_rq_inc_id(rq, p, clamp_id);
> > > +       uclamp_rq_inc_id(rq, p, UCLAMP_MIN);
> > > +       uclamp_rq_inc_id(rq, p, UCLAMP_MAX);
> > >
> > >         /* Reset clamp idle holding when there is one RUNNABLE task */
> > >         if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > > @@ -1086,13 +1084,11 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > >
> > >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> > >  {
> > > -       enum uclamp_id clamp_id;
> > > -
> > >         if (unlikely(!p->sched_class->uclamp_enabled))
> > >                 return;
> > >
> > > -       for_each_clamp_id(clamp_id)
> > > -               uclamp_rq_dec_id(rq, p, clamp_id);
> > > +       uclamp_rq_dec_id(rq, p, UCLAMP_MIN);
> > > +       uclamp_rq_dec_id(rq, p, UCLAMP_MAX);
> > >  }
> > >
> > >  static inline void
> > >
> > >
> > > FWIW I fail to see activate/deactivate_task in perf record. They don't show up
> > > on the list which means this micro benchmark doesn't stress them as Mel's test
> > > does.
> >
> > Strange because I have been able to trace them.
>
> On your arm platform? I can certainly see them on x86.

yes on my arm platform

>
> Thanks

>
> --
> Qais Yousef
