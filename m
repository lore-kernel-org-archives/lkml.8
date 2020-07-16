Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CE6206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgGPTzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:55:14 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40003 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGPTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:55:13 -0400
Received: by mail-ej1-f68.google.com with SMTP id o18so7875758eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=vt7ITewVfT1FKOncBMD8aS/IW6ECtYREeQVdm+3b0mU=;
        b=IP/2GefkGn+lZimhHPrrsGeQpLAlu7ihRabPFihzjBc7zPRJ4j6z553Qf/dNBbNt9O
         +zxINy2Cosu/uFv/t3Y7GGLjQxVpq1nOHT+bVKZVgJQb8xDytljVVy9G8ce+PRs2IvBp
         eHlqfIFR2FSLsu/k6O67fuRxT3mEbZ2DvwT4gCIIMgnGre9E5HuWcAGRXbj3uUSmek5d
         JSxf2Yd7IshXorZtkrHr/Ns6J2m2SaIBxUhxm1M4nP1K2nWcPlLsSnaClWYpJxX2SKVC
         GZ9YIfbPWhpjdvKGqinTZdTCXIDT3qRkdoZ0JZQjhpgW0T5hLOadvU/G4S4KI1F0ueB0
         rfDw==
X-Gm-Message-State: AOAM530t2voS6ChZg4V/UXChR2oNBaf58s6jatblcKI7X5NxCjfVQPlp
        NpaSWkWpzVK71f+hpdVf81c=
X-Google-Smtp-Source: ABdhPJx2D74Sj4IWN1QSWgyxW68n/TFdYMtaOZ0qXd34Y5R4W953DzLPtFbi0+Hkoc/C2QveYfd/fw==
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr5010720ejf.398.1594929310133;
        Thu, 16 Jul 2020 12:55:10 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id g21sm6141969edr.45.2020.07.16.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:55:09 -0700 (PDT)
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net> <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net> <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net> <87blla2pdt.derkling@matbug.net> <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com> <878sfrywd8.derkling@matbug.net> <CAKfTPtAWgWZMx4GA_N0j1jxXRtDDdo9yix7mOBZ_zdsRrqJA8Q@mail.gmail.com>
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
In-reply-to: <CAKfTPtAWgWZMx4GA_N0j1jxXRtDDdo9yix7mOBZ_zdsRrqJA8Q@mail.gmail.com>
Message-ID: <87imen5j7c.derkling@matbug.net>
Date:   Thu, 16 Jul 2020 21:54:47 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

On Mon, Jul 13, 2020 at 14:59:51 +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote...

> On Fri, 10 Jul 2020 at 21:59, Patrick Bellasi <patrick.bellasi@matbug.net> wrote:
>> On Fri, Jul 10, 2020 at 15:21:48 +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote...
>>
>> [...]
>>
>> >> > C) Existing control paths
>> >>
>> >> Assuming:
>> >>
>> >>  C: CFS task currently running on CPUx
>> >>  W: CFS task waking up on the same CPUx
>> >>
>> >> And considering the overall simplified workflow:
>> >>
>> >> core::try_to_wake_up()
>> >>
>> >>   // 1) Select on which CPU W will run
>> >>   core::select_task_rq()
>> >>     fair::select_task_rq_fair()
>> >>
>> >>   // 2) Enqueue W on the selected CPU
>> >>   core::ttwu_queue()
>> >>     core::ttwu_do_activate()
>> >>       core::activate_task()
>> >>         core::enqueue_task()
>> >>           fair::enqueue_task_fair()
>> >>             fair::enqueue_entity()
>> >>
>> >>               // 3) Set W's vruntime bonus
>> >>               fair::place_entity()
>> >>                 se->vruntime = ...
>> >>
>> >>       // 4) Check if C can be preempted by W
>> >>       core::ttwu_do_wakeup()
>> >>         core::check_preempt_curr()
>> >>           fair::check_preempt_curr()
>> >>             fair::check_preempt_wakeup(curr, se)
>> >>               fair::wakeup_preempt_entity(curr, se)
>> >>                 vdiff = curr.vruntime - se.vruntime
>> >>                 return vdiff > wakeup_gran(se)
>> >>
>> >> We see that W preempts C iff:
>> >>
>> >>    vdiff > wakeup_gran(se)
>> >>
>> >> Since:
>> >>
>> >> enqueue_entity(cfs_rq, se, flags)
>> >>   place_entity(cfs_rq, se, initial=0)
>> >>     thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)
>> >>     vruntime = cfs_rq->min_vruntime - thresh
>> >>     se->vruntime = max_vruntime(se->vruntime, vruntime)
>> >>
>> >> a waking task's W.vruntime can get a "vruntime bonus" up to:
>> >>  - 1   scheduler latency (w/  GENTLE_FAIR_SLEEPERS)
>> >>  - 1/2 scheduler latency (w/o GENTLE_FAIR_SLEEPERS)
>> >>
>> >>
>> >> > D) Desired behavior
>> >>
>> >> The "vruntime bonus" (thresh) computed in place_entity() should have a
>> >> per-task definition, which defaults to the current implementation.
>> >>
>> >> A bigger vruntime bonus can be configured for latency sensitive tasks.
>> >> A smaller vruntime bonus can be configured for latency tolerant tasks.
>> >
>> > I'm not sure that adjusting what you called "vruntime bonus" is the
>> > right way to provide some latency because it doesn't only provide a
>> > wakeup latency bonus but also provides a runtime bonus.
>>
>> True, however that's what we already do but _just_ in an hard-coded way.
>>
>> A task waking up from sleep gets 1 sched_latency bonus, or 1/2 w/o
>> FAIR_SLEEPERS. Point is that not all tasks are the same: for some this
>
> From a nice and fair PoV, it's not a bonus but the opposite. In fact
> it's limiting how much credit, the task will keep from its sleep time.

I agree about 'limiting a credit', thus being a _credit_ IMO it's a bonus
and the limiting happens only with GENTLE_FAIR_SLEEPER.

So, in general, tasks _waking up_ get a (limited) credit, i.e. a
vruntime bonus.

Form the FAIR PoV it is even more a bonus since all the machinery AFAIU
it's designed to give some vruntime bonus to _non_ CPU bound / batch
tasks.

That's done to compensate for them being suspended and thus not having a
chance to consume all their fair CPU share in the previous activation.

> Also keep in mind that this value is clamped by its vruntime so a task
> can't get bonus

True, at wakeup we clamped it with the SE (normalized) vruntime.

But still since we do:

   se->vruntime = max(se->vruntime, cfs_rq->min_vruntime-VRUNTIME_BONUS)
                      \---- A ----/ \--------------- B ---------------/

The bigger B is the more likely we are to "penalize" the SE vuntime.


>> bonus can be not really required, for others too small.
>>
>> Regarding the 'runtime bonus' I think it's kind of unavoidable,
>> if we really want a latency sensitive task being scheduled
>> before the others.
>
> That's where I disagree.
> 2 tasks with the same nice priority must get the same running time
> whatever their latency_nice priority.

This is granted only in the very simple case of CPU bound tasks, and the
mechanism I describe is not impacting those tasks.

For sleeping tasks, if you consider all the approximations we do (gentle
fair sleepers to begin with) we will never be "precise".
... not to speak of tasks migrations or running at different OPPs.

> The only difference should be to select which one will run 1st or make
> it easy for 1 task to preempt the other one but at the end both should
> be able to get the same running time

Agree, but I would say that we should aim at getting this result across
few sched_latencies.

IOW, granting the exact same fair CPU share within a sched_latency
period with sleeping tasks I'm not convinced is something we already
have.

>> > It means that one can impact the running time by playing with
>> > latency_nice whereas the goal is only to impact the wakeup latency.
>>
>> Well, but I'm not sure how much you can really gain considering that
>> this bonus is given only at wakeup time: the task should keep
>> suspending himself. It would get a better result by just asking for a
>> lower nice value.
>>
>> Now, asking for a reduced nice value is RLIMIT_NICE and CAP_SYS_NICE
>> protected. The same will be for latency_nice.
>>
>> Moreover, considering that by default tasks will get what we already
>> have as hard-coded or less of a bonus, I don't see how easy should be to
>> abuse.
>>
>> To the contrary we can introduce a very useful knob to allow certain
>> tasks to voluntarily demote themselves and avoid annoying a currently
>> running task.
>>
>> > Instead, it should weight the decision in wakeup_preempt_entity() and
>> > wakeup_gran()
>>
>> In those functions we already take the task prio into consideration
>> (ref details at the end of this message).
>>
>> Lower nice value tasks have more chances to preempt current since they
>> will have a smaller wakeup_gran, indeed:
>
> yes, and this is there to ensure a fair distribution of running time
> and prevent a task to increase significantly its vruntime compare to
> others

Don't follow you here :/

> -1 min that se already got more runtime than current
> 0 that se's vruntime will go above current's vruntime after a runtime
> duration of  sched_min_granularity
> and 1 means that se got less runtime than current and its vruntime
> will still be lower than current ones even after a runtime duration of
> sched_min_granularity
>
> IMHO, latency_nice should impact the decision only for case 0 but not
> the case -1 and 1.
> That being said, we can extend the case 0 a bit to include the
> situation where current's vruntime will become greater than se's
> vruntimes after a runtime duration of  sched_min_granularity like
> below:

(I hope I reformatted the following as you intended it)

>                                       curr->vruntime
>                           | wakeup_gran(se) | wakeup_gran(curr) |
> current: se->vruntime  +1 |        0        |  -1
>     new: se->vruntime  +1 |        0                            |  -1
>

Does that means to penalize a waking up tasks wrt current, such that an
high latency_nice task waking up has less chances to preempt current?

>>     we preempt  IFF   vdiff(se, current) > wakeup_gran(se)
>>                       \----------------/   \-------------/
>>                                A                  B
>>
>> While task's prio affects B, in this proposal, lantecy_nice works on the
>> A side of the equation above by making it a bit more task specific.
>>
>> That said, it's true that both latency_nice and prio will ultimately
>> play a role on how much CPU bandwidth a task gets.
>
> whereas nice is there to split CPU bandwidth between task according to
> their prio, latency nice should not

Of course that would be something new for which I see your concerns.

However, I still think that making a bit more tunable the task-agnostic
and hard-coded heuristics we have for A (above) could give benefits for
tasks that are very short running (compared to a sched_latency) while
still never really spoil/abuse the FAIR repartitioning of the CPU
bandwidth.

I'm thinking for example to graphics pipeline tasks which run for <1ms
every 16ms.

