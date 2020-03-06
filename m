Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F8CC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62AC2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJNSEoTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgCFJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:12:30 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34620 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:12:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id w27so1321657lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+MBr2XOJp369zIh9acbrg6Jln3yOnAZ/d3wvHcuhIs=;
        b=YJNSEoTAI/WrxhMtNHCO8rRbBJMxUaNuKJH3FqxHYb54Qu23y4xrhOO5bvtEz2FHkz
         6qQC2pFopQNVRsAEZEqVEwqTsqTHlfXjvEeIdECR70lwmZHu2XBBVg+lelBHmWNSwgO5
         Qv6GigDPNjL2qQMnHNyyX1Fxon+lcy1rw+6n9bAAea9WQTSv+QN6ej8nNjnNlmsKbaJa
         jUaxR8W2spVmB7om+WzlgHkFq2umA1ST/y/vZVj219InjwzcI+1u3zMi8mDGU76GoLpC
         IvfcKLwba58Ile+sKcL6s4d28UDZ5qLSlL0IKq/qPzWAu5CWlgx1tRE8y0EH4T8YwOTp
         Lsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+MBr2XOJp369zIh9acbrg6Jln3yOnAZ/d3wvHcuhIs=;
        b=LEzMzNoCwtGh6tqO7kVmpx53hNV4EaZFEja4BMrOrd/dMVrCTF6YmMXtxj9ySYsaob
         z2MPf3qP053iuYlKQUsS6ib+iRy+rb3GM3v+VqAMojZRW4Nrx/TSbYETZlQPILo86QgI
         N5M/7t9fqoIL5YSI3KrE5lnJJWtDWeFrDVAeGS6lQ0pSgnsCmi5dH6RH3Vmxl/Jt0ASD
         Y0IOcXtJ42d9pOUKZYLzw3vCSxBPtPcHDIlEOuDjaQAMAZH1JV+7Tu+WTVYvtH+kflmI
         64dczjbArWjiVPk02xEu6lTikGgZszotBaPQGGBPU6R40nQXWqjHzfTfO6t1LhLZZ4ha
         mDIA==
X-Gm-Message-State: ANhLgQ30zm5tH8IOYyGmVXh5gTyeYFmKWoONHYSPEWYFFp2e1eBJBcYG
        IyngSKevgsLeMt9B1ZC0Xn3K923T/wlqRVEHcTIVqA==
X-Google-Smtp-Source: ADFU+vtOu/2gUEQj4Qoa5+/zPNnscM0oTYTHASvT6kmxPQWY3UVInJ9ZFFlTUIr6qgaOa7jxtwEofnlL1X8+S51nLh4=
X-Received: by 2002:ac2:5492:: with SMTP id t18mr1356778lfk.184.1583485945142;
 Fri, 06 Mar 2020 01:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20200305172921.22743-1-vincent.guittot@linaro.org> <e31aa232-bc7e-a7b9-5b6a-a1131ac88164@arm.com>
In-Reply-To: <e31aa232-bc7e-a7b9-5b6a-a1131ac88164@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Mar 2020 10:12:13 +0100
Message-ID: <CAKfTPtAqg+CGNBHF53dXp4BcmtucgW4k4skQ1x1jxuyo0PDaMg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix enqueue_task_fair warning
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "# v4 . 16+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 20:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 05/03/2020 18:29, Vincent Guittot wrote:
> > When a cfs rq is throttled, the latter and its child are removed from the
> > leaf list but their nr_running is not changed which includes staying higher
> > than 1. When a task is enqueued in this throttled branch, the cfs rqs must
> > be added back in order to ensure correct ordering in the list but this can
> > only happens if nr_running == 1.
> > When cfs bandwidth is used, we call unconditionnaly list_add_leaf_cfs_rq()
> > when enqueuing an entity to make sure that the complete branch will be
> > added.
> >
> > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: stable@vger.kernel.org #v5.1+
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fcc968669aea..bdc5bb72ab31 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4117,6 +4117,7 @@ static inline void check_schedstat_required(void)
> >  #endif
> >  }
> >
> > +static inline bool cfs_bandwidth_used(void);
> >
> >  /*
> >   * MIGRATION
> > @@ -4195,10 +4196,16 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >               __enqueue_entity(cfs_rq, se);
> >       se->on_rq = 1;
> >
> > -     if (cfs_rq->nr_running == 1) {
> > +     /*
> > +      * When bandwidth control is enabled, cfs might have been removed because of
> > +      * a parent been throttled but cfs->nr_running > 1. Try to add it
> > +      * unconditionnally.
> > +      */
> > +     if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
> >               list_add_leaf_cfs_rq(cfs_rq);
> > +
> > +     if (cfs_rq->nr_running == 1)
> >               check_enqueue_throttle(cfs_rq);
> > -     }
> >  }
> >
> >  static void __clear_buddies_last(struct sched_entity *se)
>
> I experimented with an rt-app based setup on Arm64 Juno (6 CPUs):
>
> cgroupv1 hierarchy A/B/C, all CFS bw controlled (30,000/100,000)
>
> I create A/B/C outside rt-app so I can have rt-app runs with an already
> existing taskgroup hierarchy. There is a 4 secs gap between consecutive
> rt-app runs.
>
> The rt-app files contains 6 periodic CFS tasks (25,000/100,000) running
> in /A/B/C, /A/B, /A (3 rt-app task phases).
>
> I get w/ the patch (and the debug patch applied to unthrottle_cfs_rq()):
>
> root@juno:~#
> [  409.236925] CPU1 path=/A/B on_list=1 nr_running=1 throttled=1
> [  409.242682] CPU1 path=/A on_list=0 nr_running=0 throttled=1
> [  409.248260] CPU1 path=/ on_list=1 nr_running=0 throttled=0
> [  409.253748] ------------[ cut here ]------------
> [  409.258365] rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
> [  409.258382] WARNING: CPU: 1 PID: 0 at kernel/sched/fair.c:380
> unthrottle_cfs_rq+0x21c/0x2a8
> ...
> [  409.275196] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc3-dirty #62
> [  409.281990] Hardware name: ARM Juno development board (r0) (DT)
> ...
> [  409.384644] Call trace:
> [  409.387089]  unthrottle_cfs_rq+0x21c/0x2a8
> [  409.391188]  distribute_cfs_runtime+0xf4/0x198
> [  409.395634]  sched_cfs_period_timer+0x134/0x240
> [  409.400168]  __hrtimer_run_queues+0x10c/0x3c0
> [  409.404527]  hrtimer_interrupt+0xd4/0x250
> [  409.408539]  tick_handle_oneshot_broadcast+0x17c/0x208
> [  409.413683]  sp804_timer_interrupt+0x30/0x40
>
> If I add the following snippet the issue goes away:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e9fd5379bb7e..5e03be046aba 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4627,11 +4627,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>                         break;
>         }
>
> -       assert_list_leaf_cfs_rq(rq);
> -
>         if (!se)
>                 add_nr_running(rq, task_delta);
>
> +       for_each_sched_entity(se) {
> +               cfs_rq = cfs_rq_of(se);
> +
> +               list_add_leaf_cfs_rq(cfs_rq);
> +       }

Yes make sense.

> +
> +       assert_list_leaf_cfs_rq(rq);
> +
>         /* Determine whether we need to wake up potentially idle CPU: */
>         if (rq->curr == rq->idle && rq->cfs.nr_running)
>                 resched_curr(rq);
