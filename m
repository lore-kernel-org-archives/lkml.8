Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15186C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E002075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGJT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:59:54 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:33500 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:59:53 -0400
Received: by mail-ed1-f44.google.com with SMTP id h28so5585916edz.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=S8r66+/DFKF1zCTkthcct+d77VKn5GTWlwTl280ke2o=;
        b=TehO+m4gMhmN9y6T3fzxueBtR1JZdPr9xre7ESLhInkUhF9PXBRKaX7vNGo796+jS3
         dCdhXgDi/dT+7rTh0Q+Pe/7NVdjicFlompB8oLk9+6vayQF3/GBqQgTyKInYu+hcPAiP
         wjA64nkp31zFJFQwQEo2BsldX8QBjlb+23/siYgGjux61MbysqUEH43+4+EVw5PB6kMk
         hDJgqX+iLFr7NStBuJVpFTwJWxJSvZy6iNGkMaH7Rct/U1FsW+G4PdM3+NmRS+UenUUV
         Outv6iyR0d+sAiwD11JMI+LcIyZGoEotODC3BzAiO1VsXsFJ3w4PS+MKI+Mtu0p3l2P3
         MP4A==
X-Gm-Message-State: AOAM533Q439DSyl27K/coRh/6aPeHhYm0QIEZrEhWHxj5/cSAzosPqt3
        RzFl4eNRKI1bSpzbH7BPIGI=
X-Google-Smtp-Source: ABdhPJxE8gbVhebAblcesQe5gXc4/vfaG8GyBUIN0+E13Y3+X6Zk9Yslpz0NHMjIUzNSFPv6OZWBGA==
X-Received: by 2002:a05:6402:947:: with SMTP id h7mr79218298edz.213.1594411190802;
        Fri, 10 Jul 2020 12:59:50 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id mj22sm4314079ejb.118.2020.07.10.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:59:49 -0700 (PDT)
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net> <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net> <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net> <87blla2pdt.derkling@matbug.net> <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [SchedulerWakeupLatency] Per-task vruntime wakeup bonus
In-reply-to: <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com>
Message-ID: <878sfrywd8.derkling@matbug.net>
Date:   Fri, 10 Jul 2020 21:59:31 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jul 10, 2020 at 15:21:48 +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote...

> Hi Patrick,

Hi Vincent,

[...]

>> > C) Existing control paths
>>
>> Assuming:
>>
>>  C: CFS task currently running on CPUx
>>  W: CFS task waking up on the same CPUx
>>
>> And considering the overall simplified workflow:
>>
>> core::try_to_wake_up()
>>
>>   // 1) Select on which CPU W will run
>>   core::select_task_rq()
>>     fair::select_task_rq_fair()
>>
>>   // 2) Enqueue W on the selected CPU
>>   core::ttwu_queue()
>>     core::ttwu_do_activate()
>>       core::activate_task()
>>         core::enqueue_task()
>>           fair::enqueue_task_fair()
>>             fair::enqueue_entity()
>>
>>               // 3) Set W's vruntime bonus
>>               fair::place_entity()
>>                 se->vruntime = ...
>>
>>       // 4) Check if C can be preempted by W
>>       core::ttwu_do_wakeup()
>>         core::check_preempt_curr()
>>           fair::check_preempt_curr()
>>             fair::check_preempt_wakeup(curr, se)
>>               fair::wakeup_preempt_entity(curr, se)
>>                 vdiff = curr.vruntime - se.vruntime
>>                 return vdiff > wakeup_gran(se)
>>
>> We see that W preempts C iff:
>>
>>    vdiff > wakeup_gran(se)
>>
>> Since:
>>
>> enqueue_entity(cfs_rq, se, flags)
>>   place_entity(cfs_rq, se, initial=0)
>>     thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)
>>     vruntime = cfs_rq->min_vruntime - thresh
>>     se->vruntime = max_vruntime(se->vruntime, vruntime)
>>
>> a waking task's W.vruntime can get a "vruntime bonus" up to:
>>  - 1   scheduler latency (w/  GENTLE_FAIR_SLEEPERS)
>>  - 1/2 scheduler latency (w/o GENTLE_FAIR_SLEEPERS)
>>
>>
>> > D) Desired behavior
>>
>> The "vruntime bonus" (thresh) computed in place_entity() should have a
>> per-task definition, which defaults to the current implementation.
>>
>> A bigger vruntime bonus can be configured for latency sensitive tasks.
>> A smaller vruntime bonus can be configured for latency tolerant tasks.
>
> I'm not sure that adjusting what you called "vruntime bonus" is the
> right way to provide some latency because it doesn't only provide a
> wakeup latency bonus but also provides a runtime bonus.

True, however that's what we already do but _just_ in an hard-coded way.

A task waking up from sleep gets 1 sched_latency bonus, or 1/2 w/o
FAIR_SLEEPERS. Point is that not all tasks are the same: for some this
bonus can be not really required, for others too small.

Regarding the 'runtime bonus' I think it's kind of unavoidable,
if we really want a latency sensitive task being scheduled
before the others.

> It means that one can impact the running time by playing with
> latency_nice whereas the goal is only to impact the wakeup latency.

Well, but I'm not sure how much you can really gain considering that
this bonus is given only at wakeup time: the task should keep
suspending himself. It would get a better result by just asking for a
lower nice value.

Now, asking for a reduced nice value is RLIMIT_NICE and CAP_SYS_NICE
protected. The same will be for latency_nice.

Moreover, considering that by default tasks will get what we already
have as hard-coded or less of a bonus, I don't see how easy should be to
abuse.

To the contrary we can introduce a very useful knob to allow certain
tasks to voluntarily demote themselves and avoid annoying a currently
running task. 

> Instead, it should weight the decision in wakeup_preempt_entity() and
> wakeup_gran()

In those functions we already take the task prio into consideration
(ref details at the end of this message).

Lower nice value tasks have more chances to preempt current since they
will have a smaller wakeup_gran, indeed:

    we preempt  IFF   vdiff(se, current) > wakeup_gran(se)
                      \----------------/   \-------------/
                               A                  B

While task's prio affects B, in this proposal, lantecy_nice works on the
A side of the equation above by making it a bit more task specific.

That said, it's true that both latency_nice and prio will ultimately
play a role on how much CPU bandwidth a task gets.

Question is: do we deem it useful to have an additional knob working on
the A side of the equation above?

Best,
Patrick



---8<------8<------8<------8<------8<------8<------8<------8<------8<------8<---

TL;DR: The nice value already affects the wakeup latency

As reported above:

   check_preempt_wakeup(rq, p, wake_flags)
     wakeup_preempt_entity(curr, se)
(d)    vdiff = curr.vruntime - se.vruntime
(e)    return vdiff > wakeup_gran(se)

we see that W preempts C iff:

   vdiff > wakeup_gran(se)

But:

       wakeup_gran(se)
         calc_delta_fair(delta=sysctl_sched_wakeup_granularity, se)
           __calc_delta(delta_exec=delta, weight=NICE_0_LOAD, lw=&se->load)
(c)          wakeup_gran = sched_wakeup_granularity * (NICE_0_LOAD / W.load.weight)

Thus, the wakeup granularity of W depends on:
 - the system-wide configured wakeup granularity
     sysctl_sched_wakeup_granularity := [0..1e9]ns
 - W.load.weight [88761, .., 15]

But since:

   set_user_nice()
     p->static_prio = NICE_TO_PRIO(nice) = 120 + nice
     set_load_weight(p, update_load=true)
       reweight_task(p, prio)
(a)      prio = p->static_prio - MAX_RT_PRIO = 120 + nice - 100 = nice + 20
(b)      weight = scale_load(sched_prio_to_weight[prio]) = [88761, ..., 15]
         reweight_entity(cfs_rq, se, weight=weight, runnable=weight)
           update_load_set(lw=&se->load, w=weight)
             lw->weight = w
     p->prio = effective_prio(p)

We see that by tuning a task's nice value we affect its wakeup granularity:

  lower the nice
    =(a)=> lower the prio
      =(b)=> higher the weight
        =(c)=> smaller the wakeup_grain

This means that for a given system-wide knob (sched_wakeup_granularity),
we still get different behaviours depending on a task specific knob.
A smaller nice makes more likely W to preempt C.

