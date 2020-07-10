Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A5920772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrphOs14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGJNWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgGJNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:22:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179AC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:22:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so6421840ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o1UfQlAEMtddeeV9kuS8p26Lv8L/G4pSiLrlGn2Aqk=;
        b=wrphOs14VNB/ngmF0wUJT3Uf9KtUL89Lcy4LCL0EXtJfpNl69lh1lqro3MTY/gCLXs
         SY/0H7QlgjhjdLJJIajinEaVLSVQKRq0ta/74AMCmmIWkoa9XXCkUcGLuBzw4Vyq3w/N
         JSZ75jpnnChL/omfmamzIq4omKlDy9sGKunfzo0L6Hq1qO+AFbg8+9OZVkp59sdjnbia
         Du0PEkG4XwBcK9/KsJetkMT7k/YDV2QmmKqrYzGafm9mF3/vZXeF5zTQoej3Q72lJZFc
         ud3bqBQ/k5ZZq8XaI5StVDtjFjfbGcOl6CuIY+T2RBxlOkllTuKDrf+e1I3QB9mslAwT
         Qsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o1UfQlAEMtddeeV9kuS8p26Lv8L/G4pSiLrlGn2Aqk=;
        b=kkiDe6UkY9uMTGDxDvjw0/4nCuXAAc8TYMFCy6gV795D6PIQzKhw/1elPvcsmcXZt1
         FkPHmepYPlg/xwW3jdy7pi7boewZ0EDluTtVU83JvI5rkBMnzkvptCeVHLzsPi2UQXsg
         lSeoTQ9OorXSFVyRcNR9rukbqe94N2UXeJL4B3sd+9G6Ybk0pzyo5Nvq5+PMlVNipJTY
         4GrdgEtE0wzydrs9BtvsDv7S4nJ7lSRrPuNShb6brrwSuhewsIlMRO/xEk+Rrrmr85hL
         9IqBTY5Yz8I6vPipQ/uoJFEnbXod/4EBGjqIt38rNetI+dkJXSD88zHMrzrGEc1eZ99m
         9Epw==
X-Gm-Message-State: AOAM531bQFhE3GgP5D+dXLvWmEbEg+jNb2IFACYKkVpwJEKzBV6gsU+q
        Mfw+Luk229o5NZDUjBNybY3fifOGOWG8pYKQQzaRpg==
X-Google-Smtp-Source: ABdhPJwqZPetDhH459IB7VUc7S1DvEiBxDVUwg4+jjR4RV0xjgCiZtIrtaob/pbtz3b7rGcHem1UhHIOAlj3TUtUfzc=
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr2672874ljg.69.1594387319184;
 Fri, 10 Jul 2020 06:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net> <87blla2pdt.derkling@matbug.net>
In-Reply-To: <87blla2pdt.derkling@matbug.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Jul 2020 15:21:48 +0200
Message-ID: <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com>
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

Hi Patrick,

On Tue, 23 Jun 2020 at 09:49, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
>
> On Tue, Jun 23, 2020 at 09:29:03 +0200, Patrick Bellasi <patrick.bellasi@matbug.net> wrote...
>
> > .:: Scheduler Wakeup Path Requirements Collection Template
> > ==========================================================
> >
> > A) Name
>
> Runtime tunable vruntime wakeup bonus.

Thanks for describing this use case.

>
>
> > B) Target behavior
>
> All SCHED_OTHER tasks get the same (max) vruntime wakeup bonus. This
> bonus affects the chance the task has to preempt the currently running
> task. Some tasks, which are (known to be) latency tolerant, should have
> a smaller chance to preempt a (known to be) latency sensitive task. To
> the contrary, latency sensitive tasks should have a higher chance to
> preempt a currently running latency tolerant task.
>
> This task specific distinction is not provided by the current
> implementation and all SCHED_OTHER tasks are handled according to the
> same simple, system-wide and not run-time tunable policy.
>
>
> > C) Existing control paths
>
> Assuming:
>
>  C: CFS task currently running on CPUx
>  W: CFS task waking up on the same CPUx
>
> And considering the overall simplified workflow:
>
> core::try_to_wake_up()
>
>   // 1) Select on which CPU W will run
>   core::select_task_rq()
>     fair::select_task_rq_fair()
>
>   // 2) Enqueue W on the selected CPU
>   core::ttwu_queue()
>     core::ttwu_do_activate()
>       core::activate_task()
>         core::enqueue_task()
>           fair::enqueue_task_fair()
>             fair::enqueue_entity()
>
>               // 3) Set W's vruntime bonus
>               fair::place_entity()
>                 se->vruntime = ...
>
>       // 4) Check if C can be preempted by W
>       core::ttwu_do_wakeup()
>         core::check_preempt_curr()
>           fair::check_preempt_curr()
>             fair::check_preempt_wakeup(curr, se)
>               fair::wakeup_preempt_entity(curr, se)
>                 vdiff = curr.vruntime - se.vruntime
>                 return vdiff > wakeup_gran(se)
>
> We see that W preempts C iff:
>
>    vdiff > wakeup_gran(se)
>
> Since:
>
> enqueue_entity(cfs_rq, se, flags)
>   place_entity(cfs_rq, se, initial=0)
>     thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)
>     vruntime = cfs_rq->min_vruntime - thresh
>     se->vruntime = max_vruntime(se->vruntime, vruntime)
>
> a waking task's W.vruntime can get a "vruntime bonus" up to:
>  - 1   scheduler latency (w/  GENTLE_FAIR_SLEEPERS)
>  - 1/2 scheduler latency (w/o GENTLE_FAIR_SLEEPERS)
>
>
> > D) Desired behavior
>
> The "vruntime bonus" (thresh) computed in place_entity() should have a
> per-task definition, which defaults to the current implementation.
>
> A bigger vruntime bonus can be configured for latency sensitive tasks.
> A smaller vruntime bonus can be configured for latency tolerant tasks.

I'm not sure that adjusting what you called "vruntime bonus" is the
right way to provide some latency because it doesn't only provide a
wakeup latency bonus but also provides a runtime bonus. It means that
one can impact the running time by playing with latency_nice whereas
the goal is only to impact the wakeup latency.  Instead, it should
weight the decision in wakeup_preempt_entity() and wakeup_gran()

>
> TL;DR
>
> The "vruntime bonus" is meant to give sleepers a compensation for the
> service deficit due to them not having (possibly) fully consumed their
> assigned fair CPU quota within the current sched_latency interval, see:
>
>   commit 51e0304ce6e5 ("sched: Implement a gentler fair-sleepers feature")
>
> The scheduler does that based on a conservative assumption: when a task
> sleeps it gives up a portion (P) of its fair CPU bandwidth share in the
> current sched_latency period.
> Willing to be FAIR, i.e. each task gets a FAIR quota of the CPU in each
> sched_latency period, the scheduler wants to give back P to waking
> tasks.
>
> However, striving to minimize overheads and complexity, the CFS
> scheduler does that using a simple heuristic: each task waking up gets a
> bonus, which is capped at one sched_latency period, independently from
> "its nature".
>
> What the scheduler completely disregards is that being completely FAIR
> is not always necessary. Depending on the nature of a task, not all
> tasks require a bonus. To the contrary:
>
>  - a GENTLE_FAIR_SLEEPERS bonus given to a background task could result
>    in preempting a latency sensitive currently running task
>
>  - giving only 1/2 scheduler latency bonus to a latency sensitive task
>    could result in that task being preempted before it completes its
>    current activation.
>
>
> > E) Existing knobs
>
> The SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true) defined vruntime bonus value
> can be considered the current mainline default value.
>
> This means that "all" CFS tasks waking up will get a
>
>    0.5 * sysctl_sched_latency
>
> vruntime bonus wrt the cfs_rq->min_vruntime.
>
>
> > F) Existing knobs limitations
>
> GENTLE_FAIR_SLEEPERS is a system-wide knob and it's not run-time
> tunable on production systems (being a SCHED_DEBUG feature).
>
> Thus, the sched_feature should be removed and replaced by a per-task
> knob.
>
>
> > G) Proportionality Analysis
>
> The value of the vruntime bonus directly affects the chance a task has
> to preempt the currently running task.
>
> Indeed, from the code analysis in C:
>
>   thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)
>
> is the "wakeup bonus", which is used as:
>
>   vruntime = cfs_rq->min_vruntime - thresh
>   se->vruntime = max_vruntime(se->vruntime, vruntime)
>   vdiff = curr.vruntime - se.vruntime
>
>   preempt condition: vdiff > wakeup_gran(se)
>
>
> > H) Range Analysis
>
> The new per-task knob can cover the range [0..sysctl_sched_latency]
>
> Latency sensitive tasks will get sysctl_sched_latency as bonus.
> Latency tolerant tasks will get 0.
>
> Values lower than the default sysctl_sched_latency/2 will require
> special capabilities (e.g. CAP_SYS_NICE). OTHA, a task can relax
> its wakeup latency requirement by asking for a bonus smaller than the
> default.
>
> Mapping Analysis: check if the range can be mapped into a generic one
> =================
>
> The latency_nice proposal [2] offers a [-20, 19] range which can be
> easily mapped into a vruntime bonus range, e.g. using a simpler linear
> transformation function.
>
> A more elaborated mapping could be defined, based on recomputed
> constants, to provide a relative constant increment.
>
>
> > I) System-Wide tuning
>
> The latency_nice provided knobs should be enough to get the desired
> effect.
>
> In (the remote) case a range wider than the one proposed in [H] should
> be required, perhaps an additional sysctl_sched_latency's multiplier
> knob could be required.
>
>
> > J) Per-Task tuning
>
> The latency_nice provided knobs.
>
>
> > K) Task-Group tuning
>
> For tasks-groups, similarly to what uclamp does, a pair of
> latency_nice_{min,max} clamps should be enough.
>
> The task-specific latency_nice requested value will be restricted by the
> task group's clamps.
>
