Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A839C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EE2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aE1d2Ymc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgGMNAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgGMNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:00:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F79AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:00:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q4so17705364lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YmGNk7HvKfqc0MmccnDLFFIP1KuuSkhAyXthRmd39Y=;
        b=aE1d2YmcAEGo187eRJdNek96Tsizj8xb0iEASuNCt0FHCC3ejIBU0Ai3URmOqXU41p
         zh5wibfc+b0DwIOthAHu/C2Id7dQP03t/sZi+vvNNeaxM46PfkEK3MyvxhVkWoS9MQoC
         F+H4rz/Vtbjyq3yt4osukpbC1dFjkHjNWoRepc0uH4m45Kvuxu9ryAveK9adFOwivkUH
         rSlyIYfX94sxABbJeZ8zLTgSXTgCyPseOaeQLE7Q6F+uV/fXiL2r+8aEjfjLcCrFojjc
         fcpI8NJjaiXtNfL+LhgECwAteXvYgPny7u8HSVd0f6i+PCc/Z6ZD1ZfapIcUdr/31h6z
         m+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YmGNk7HvKfqc0MmccnDLFFIP1KuuSkhAyXthRmd39Y=;
        b=RAJ2B9G9VTzhy7FkYsweQ5OglGbxDQAYwhMBBixALEkz+xBdIHBeaIK/LYVipFXcEW
         1O62XbZLRujKD6OP0tVNDKBe2uuM8BuSG8NY5VhVm2UAStaBDTIyK9RWxdz/YCgfxg/P
         oOLqclXJjq5uGs7f7BsXLM7Rxwv+9x/hwUlIJ+cufVZ8uBhjc8pvHWuLAbW6LXJiXdzf
         +mdXLS6+eofMyBhC9Nh1lPVcZSZxhvK14iG4RLRzKT2NDrhpZhfeqTO1ZhWglv2gUg9n
         7sJAdccBGTRg4uLrjUG9Q1yydTTN6eeS8Pfg1/r7p/fuAWfPJ2oT1iqu7ZedY/3BSb+Y
         VApQ==
X-Gm-Message-State: AOAM530Z3QXIxINwOLgJtg9/rGjr6KztVZsf62WMSlRtqw5QpoHUPCzq
        AIWbheSf8HsdKlKm2rYbXMyJES7xInvaPZNuIv8LFg==
X-Google-Smtp-Source: ABdhPJwg1vGyKk4kvuctjGaeEZQS3cVQs0eGDsXh5y4er53For+FT12EOY2pE8cUlHa3/2yCgGv4IlJiap9uJe7aDeo=
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr11810366ljg.69.1594645202243;
 Mon, 13 Jul 2020 06:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <87blla2pdt.derkling@matbug.net> <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com>
 <878sfrywd8.derkling@matbug.net>
In-Reply-To: <878sfrywd8.derkling@matbug.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 13 Jul 2020 14:59:51 +0200
Message-ID: <CAKfTPtAWgWZMx4GA_N0j1jxXRtDDdo9yix7mOBZ_zdsRrqJA8Q@mail.gmail.com>
Subject: Re: [SchedulerWakeupLatency] Per-task vruntime wakeup bonus
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 at 21:59, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
>
> On Fri, Jul 10, 2020 at 15:21:48 +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote...
>
> > Hi Patrick,
>
> Hi Vincent,
>
> [...]
>
> >> > C) Existing control paths
> >>
> >> Assuming:
> >>
> >>  C: CFS task currently running on CPUx
> >>  W: CFS task waking up on the same CPUx
> >>
> >> And considering the overall simplified workflow:
> >>
> >> core::try_to_wake_up()
> >>
> >>   // 1) Select on which CPU W will run
> >>   core::select_task_rq()
> >>     fair::select_task_rq_fair()
> >>
> >>   // 2) Enqueue W on the selected CPU
> >>   core::ttwu_queue()
> >>     core::ttwu_do_activate()
> >>       core::activate_task()
> >>         core::enqueue_task()
> >>           fair::enqueue_task_fair()
> >>             fair::enqueue_entity()
> >>
> >>               // 3) Set W's vruntime bonus
> >>               fair::place_entity()
> >>                 se->vruntime = ...
> >>
> >>       // 4) Check if C can be preempted by W
> >>       core::ttwu_do_wakeup()
> >>         core::check_preempt_curr()
> >>           fair::check_preempt_curr()
> >>             fair::check_preempt_wakeup(curr, se)
> >>               fair::wakeup_preempt_entity(curr, se)
> >>                 vdiff = curr.vruntime - se.vruntime
> >>                 return vdiff > wakeup_gran(se)
> >>
> >> We see that W preempts C iff:
> >>
> >>    vdiff > wakeup_gran(se)
> >>
> >> Since:
> >>
> >> enqueue_entity(cfs_rq, se, flags)
> >>   place_entity(cfs_rq, se, initial=0)
> >>     thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)
> >>     vruntime = cfs_rq->min_vruntime - thresh
> >>     se->vruntime = max_vruntime(se->vruntime, vruntime)
> >>
> >> a waking task's W.vruntime can get a "vruntime bonus" up to:
> >>  - 1   scheduler latency (w/  GENTLE_FAIR_SLEEPERS)
> >>  - 1/2 scheduler latency (w/o GENTLE_FAIR_SLEEPERS)
> >>
> >>
> >> > D) Desired behavior
> >>
> >> The "vruntime bonus" (thresh) computed in place_entity() should have a
> >> per-task definition, which defaults to the current implementation.
> >>
> >> A bigger vruntime bonus can be configured for latency sensitive tasks.
> >> A smaller vruntime bonus can be configured for latency tolerant tasks.
> >
> > I'm not sure that adjusting what you called "vruntime bonus" is the
> > right way to provide some latency because it doesn't only provide a
> > wakeup latency bonus but also provides a runtime bonus.
>
> True, however that's what we already do but _just_ in an hard-coded way.
>
> A task waking up from sleep gets 1 sched_latency bonus, or 1/2 w/o
> FAIR_SLEEPERS. Point is that not all tasks are the same: for some this

From a nice and fair PoV, it's not a bonus but the opposite. In fact
it's limiting how much credit, the task will keep from its sleep time.
Also keep in mind that this value is clamped by its vruntime so a task
can't get bonus

> bonus can be not really required, for others too small.
>
> Regarding the 'runtime bonus' I think it's kind of unavoidable,
> if we really want a latency sensitive task being scheduled
> before the others.

That's where I disagree.
2 tasks with the same nice priority must get the same running time
whatever their latency_nice priority. The only difference should be to
select which one will run 1st or make it easy for 1 task to preempt
the other one but at the end both should be able to get the same
running time

>
> > It means that one can impact the running time by playing with
> > latency_nice whereas the goal is only to impact the wakeup latency.
>
> Well, but I'm not sure how much you can really gain considering that
> this bonus is given only at wakeup time: the task should keep
> suspending himself. It would get a better result by just asking for a
> lower nice value.
>
> Now, asking for a reduced nice value is RLIMIT_NICE and CAP_SYS_NICE
> protected. The same will be for latency_nice.
>
> Moreover, considering that by default tasks will get what we already
> have as hard-coded or less of a bonus, I don't see how easy should be to
> abuse.
>
> To the contrary we can introduce a very useful knob to allow certain
> tasks to voluntarily demote themselves and avoid annoying a currently
> running task.
>
> > Instead, it should weight the decision in wakeup_preempt_entity() and
> > wakeup_gran()
>
> In those functions we already take the task prio into consideration
> (ref details at the end of this message).
>
> Lower nice value tasks have more chances to preempt current since they
> will have a smaller wakeup_gran, indeed:

yes, and this is there to ensure a fair distribution of running time
and prevent a task to increase significantly its vruntime compare to
others

-1 min that se already got more runtime than current
0 that se's vruntime will go above current's vruntime after a runtime
duration of  sched_min_granularity
and 1 means that se got less runtime than current and its vruntime
will still be lower than current ones even after a runtime duration of
sched_min_granularity

IMHO, latency_nice should impact the decision only for case 0 but not
the case -1 and 1.
That being said, we can extend the case 0 a bit to include the
situation where current's vruntime will become greater than se's
vruntimes after a runtime duration of  sched_min_granularity like
below:

                                                           curr->vruntime
                                          |<-- wakeup_gran(se) -->|<--
wakeupgran(curr) -->|
current range: se->vruntime          +1   |        0              |    -1
new range:     se->vruntime          +1   |                       0
                    |   -1


>
>     we preempt  IFF   vdiff(se, current) > wakeup_gran(se)
>                       \----------------/   \-------------/
>                                A                  B
>
> While task's prio affects B, in this proposal, lantecy_nice works on the
> A side of the equation above by making it a bit more task specific.
>
> That said, it's true that both latency_nice and prio will ultimately
> play a role on how much CPU bandwidth a task gets.

whereas nice is there to split CPU bandwidth between task according to
their prio, latency nice should not

>
> Question is: do we deem it useful to have an additional knob working on
> the A side of the equation above?
>
> Best,
> Patrick
>
>
>
> ---8<------8<------8<------8<------8<------8<------8<------8<------8<------8<---
>
> TL;DR: The nice value already affects the wakeup latency
>
> As reported above:
>
>    check_preempt_wakeup(rq, p, wake_flags)
>      wakeup_preempt_entity(curr, se)
> (d)    vdiff = curr.vruntime - se.vruntime
> (e)    return vdiff > wakeup_gran(se)
>
> we see that W preempts C iff:
>
>    vdiff > wakeup_gran(se)
>
> But:
>
>        wakeup_gran(se)
>          calc_delta_fair(delta=sysctl_sched_wakeup_granularity, se)
>            __calc_delta(delta_exec=delta, weight=NICE_0_LOAD, lw=&se->load)
> (c)          wakeup_gran = sched_wakeup_granularity * (NICE_0_LOAD / W.load.weight)
>
> Thus, the wakeup granularity of W depends on:
>  - the system-wide configured wakeup granularity
>      sysctl_sched_wakeup_granularity := [0..1e9]ns
>  - W.load.weight [88761, .., 15]
>
> But since:
>
>    set_user_nice()
>      p->static_prio = NICE_TO_PRIO(nice) = 120 + nice
>      set_load_weight(p, update_load=true)
>        reweight_task(p, prio)
> (a)      prio = p->static_prio - MAX_RT_PRIO = 120 + nice - 100 = nice + 20
> (b)      weight = scale_load(sched_prio_to_weight[prio]) = [88761, ..., 15]
>          reweight_entity(cfs_rq, se, weight=weight, runnable=weight)
>            update_load_set(lw=&se->load, w=weight)
>              lw->weight = w
>      p->prio = effective_prio(p)
>
> We see that by tuning a task's nice value we affect its wakeup granularity:
>
>   lower the nice
>     =(a)=> lower the prio
>       =(b)=> higher the weight
>         =(c)=> smaller the wakeup_grain
>
> This means that for a given system-wide knob (sched_wakeup_granularity),
> we still get different behaviours depending on a task specific knob.
> A smaller nice makes more likely W to preempt C.
>
