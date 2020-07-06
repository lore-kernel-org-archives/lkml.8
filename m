Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA90BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE02620715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QOa7ydc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgGFOJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgGFOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:09:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFCC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:09:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so17219178qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T4DYPfHXZrlEiNa9YQLgLIz6+9qYG6ZVOFibOXX+4GI=;
        b=QOa7ydc/GfozryFfUihTGwMGpCWTx1uL8Ox1wOl2gxQx+YargjRVrXUI5TGI5SUwQY
         ADsSe5tYyRMlmX/aEeospYW8RePbyI0UwM8MO6FuBK8lgH36CJsnkU4Vz0fZYlGRflnn
         bbgH3o/0l3ONnQfr3hCJuUVVT/1xCGSwR0dc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T4DYPfHXZrlEiNa9YQLgLIz6+9qYG6ZVOFibOXX+4GI=;
        b=r5puq5iO+irlNfWrKoSVpheRUicFQbNzEclr1uiF3i+zUCalqTwQlhxU8JZyzNzPx0
         5NBaSgZshrdC4C1/1LK7OzByaMgSOziQO6nT34ZWh61DklLsKF1d4K4nKM00w49IU3M/
         e7P3Lswu6hgNl29qwd5ODYdmax9hfFEI7poAPcj7t1CPzeTvKCWPTk5+pCnIvHX0Qcss
         RJwTTUCESmprXjSrgmHOLwhpsAd3is2WcaES9mK5ciXhVF9dQtNfDKKWwwXWJq0+4J0C
         El98RP2f/rA7F7GDpd3laIkQA9097oxZka7FiUVrWcVWRgve7WFqMIMGrUs/fdFdw926
         +n9w==
X-Gm-Message-State: AOAM5331CQw0XZcPjr+hZnROczkT7UmbCcwsxrOGzg7jrWrsFSzp5GzU
        zgybj0Ab0pF3kBzzaqD/3QQzVw==
X-Google-Smtp-Source: ABdhPJyVfBghcDBGvfOyPHbtjCeYfs6AHhYc9wDJm6GY7r1MJ8w+WQE6gD6tGpvcE4en5iU9IchB4w==
X-Received: by 2002:a05:6214:1882:: with SMTP id cx2mr48199028qvb.240.1594044569711;
        Mon, 06 Jul 2020 07:09:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r5sm23506256qtc.20.2020.07.06.07.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 07:09:29 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:09:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200706140928.GA170866@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com>
 <CANaguZDtZrXbjmot2crLM0ComgY=NfqxWYs7GzUEY8aLeaUVrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDtZrXbjmot2crLM0ComgY=NfqxWYs7GzUEY8aLeaUVrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:21:46PM -0400, Vineeth Remanan Pillai wrote:
> On Wed, Jul 1, 2020 at 7:28 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] sched: Fix CPU hotplug causing crashes in task selection logic
> >
> > The selection logic does not run correctly if the current CPU is not in the
> > cpu_smt_mask (which it is not because the CPU is offlined when the stopper
> > finishes running and needs to switch to idle).  There are also other issues
> > fixed by the patch I think such as: if some other sibling set core_pick to
> > something, however the selection logic on current cpu resets it before
> > selecting. In this case, we need to run the task selection logic again to
> > make sure it picks something if there is something to run. It might end up
> > picking the wrong task.
> >
> I am not sure if this can happen. If the other sibling sets core_pick, it
> will be under the core wide lock and it should set the core_sched_seq also
> before releasing the lock. So when this cpu tries, it would see the core_pick
> before resetting it. Is this the same case you were mentioning? Sorry if I
> misunderstood the case you mentioned..

If you have a case where you have 3 siblings all trying to enter the schedule
loop. Call them A, B and C.

A picks something for B in core_pick. Now C comes and resets B's core_pick
before running the mega-loop, hoping to select something for it shortly.
However, C then does an unconstrained pick and forgets to set B's pick to
something.

I don't know if this can really happen - but this is why I added the warning
in the end of the patch. I think we should make the code more robust and
handle these kind of cases.

> > Yet another issue was, if the stopper thread is an
> > unconstrained pick, then rq->core_pick is set. The next time task selection
> > logic runs when stopper needs to switch to idle, the current CPU is not in
> > the smt_mask. This causes the previous ->core_pick to be picked again which
> > happens to be the unconstrained task! so the stopper keeps getting selected
> > forever.
> >
> I did not clearly understand this. During an unconstrained pick, current
> cpu's core_pick is not set and tasks are not picked for siblings as well.
> If it is observed being set in the v6 code, I think it should be a bug.

Again, it is about making the code more robust. Why should not set
rq->core_pick when we pick something? As we discussed in the private
discussion - we should make the code robust and consistent. Correctness is
not enough, the code has to be robust and maintainable.

I think in our private discussion, you agreed with me that there is no harm
in setting core_pick in this case.

> > That and there are a few more safe guards and checks around checking/setting
> > rq->core_pick. To test it, I ran rcutorture and made it tag all torture
> > threads. Then ran it in hotplug mode (hotplugging every 200ms) and it hit the
> > issue. Now it runs for an hour or so without issue. (Torture testing debug
> > changes: https://bit.ly/38htfqK ).
> >
> > Various fixes were tried causing varying degrees of crashes.  Finally I found
> > that it is easiest to just add current CPU to the smt_mask's copy always.
> > This is so that task selection logic always runs on the current CPU which
> > called schedule().
> >
> > [...]
> >         cpu = cpu_of(rq);
> > -       smt_mask = cpu_smt_mask(cpu);
> > +       /* Make a copy of cpu_smt_mask as we should not set that. */
> > +       cpumask_copy(&select_mask, cpu_smt_mask(cpu));
> > +
> > +       /*
> > +        * Always make sure current CPU is added to smt_mask so that below
> > +        * selection logic runs on it.
> > +        */
> > +       cpumask_set_cpu(cpu, &select_mask);
> >
> I like this idea. Probably we can optimize it a bit. We get here with cpu
> not in smt_mask only during an offline and online(including the boot time
> online) phase. So we could probably wrap it in an "if (unlikely())". Also,
> during this time, it would be idle thread or some hotplug online thread that
> would be runnable and no other tasks should be runnable on this cpu. So, I
> think it makes sense to do an unconstrained pick rather than a costly sync
> of all siblings. Probably something like:
> 
> cpumask_copy(&select_mask, cpu_smt_mask(cpu));
> if (unlikely(cpumask_test_cpu(cpu, &select_mask))) {
>     cpumask_set_cpu(cpu, &select_mask);
>     need_sync = false;
> }

Nah, more lines of code for no good no reason, plus another branch right? I'd
like to leave my one liner alone than adding 4 more lines :-)

> By setting need_sync to false, we will do an unconstrained pick and will
> not sync with other siblings. I guess we need to reset need_sync after
> or in the following for_each_cpu loop, because the loop may set it.

I don't know if we want to add more conditions really and make it more
confusing. If anything, I believe we should simplify the existing code more TBH.

> >         /*
> >          * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
> > @@ -4351,7 +4358,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> 
> >                         if (i == cpu && !need_sync && !p->core_cookie) {
> >                                 next = p;
> > +                               rq_i->core_pick = next;
> > +                               rq_i->core_sched_seq = rq_i->core->core_pick_seq;
> >
> I think we would not need these here. core_pick needs to be set only
> for siblings if we are picking a task for them. For unconstrained pick,
> we pick only for ourselves. Also, core_sched_seq need not be synced here.
> We might already be synced with the existing core->core_pick_seq. Even
> if it is not synced, I don't think it will cause an issue in subsequent
> schedule events.

As discussed both privately and above, there is no harm and it is good to
keep the code consistent. I'd rather have any task picking set core_pick and
core_sched_seq to prevent confusion.

And if anything is resetting an existing ->core_pick of a sibling in the
selection loop, it better set it to something sane.

> >  done:
> > +       /*
> > +        * If we reset a sibling's core_pick, make sure that we picked a task
> > +        * for it, this is because we might have reset it though it was set to
> > +        * something by another selector. In this case we cannot leave it as
> > +        * NULL and should have found something for it.
> > +        */
> > +       for_each_cpu(i, &select_mask) {
> > +               WARN_ON_ONCE(!cpu_rq(i)->core_pick);
> > +       }
> > +
> I think this check will not be true always. For unconstrained pick, we
> do not pick tasks for siblings and hence do not set core_pick for them.
> So this WARN_ON will fire for unconstrained pick. Easily reproducible
> by creating an empty cgroup and tagging it. Then only unconstrained
> picks will happen and this WARN_ON fires. I guess this check after the
> done label does not hold and could be removed.

As discussed above, > 2 SMT case, we don't really know if the warning will
fire or not. I would rather keep the warning just in case for the future.

Thanks!

 - Joel

