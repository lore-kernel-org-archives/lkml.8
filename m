Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B5DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA6322482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXmHAwiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGTPU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGTPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:20:58 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51620C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:20:58 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k13so955379lfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ysf+8/YCdjEbrDK2wJdiI6loWpMIMt3osD9k/2Tbbrw=;
        b=UXmHAwiu2MCd+wxhb5pCceWUNu/Y0e0Newrd/B9iSC9gYykchTh5GEb5qevcCOU0+V
         svFOKjX+qGRZoAoN7h4v2IyGs2PZpCP82PWhAyaRc8FrH50TvlNQgSxnVEe9pa5K1E/c
         oOh8oRjeqczsX0lq1k6CbI9xBzrmSQDq62Nqr/cA4959szT1+qT5CsCrCRPbHzOyzlXS
         FZmYOR2Zf6uZDHYMWOttgXcpoFrjqYfBAaZODtaEBd4GFzeKqCMvFBZO/XSAYN5b2pXt
         K4/D/EvFiL/RGBaakIr2AMTXbXO0GhJlaHKZ4/x7xTNeJQx740Ke0jvV6XJ1CpmdP8au
         +V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ysf+8/YCdjEbrDK2wJdiI6loWpMIMt3osD9k/2Tbbrw=;
        b=Zpm60R8rm7GV0F3O/TJCk0pl9rq1F8EFy+UgnId0RbIbqUmjNinZMZ2nqYnAPIF6wU
         s6lxAmDOEXgsvOGr0NdAxD9GT+fHEhqJt1IXzIeTHi/3ld6aOcGFogPOeMQ8HpwPukzM
         MhlqSjdFRvhKFjWf8nPV6N91XuCAv7K6AgUQMyqFDSSTkTdITcYQz78RBMdsfleH4edn
         ttUpXrAV1uO00x7UgVnA9V0F95gEsYS+tUehgMvhyPLP3s4mODsONnKhRIB86kRHTetA
         CsfgOWNDIAU3i7eviuHloDbU7A7jcXuWnoqfFwa95d4FUYD2dYiiT54N3pSKNJ/rlKRQ
         n+oQ==
X-Gm-Message-State: AOAM531Fl+7sl6T+XKmXrxPG3fEdzOGzWoA0ikvRARDBE1i+I8j2q3Lu
        5zehQqeePm6rzGMCX+kyJ1aAI0AzK9uN7E68E73F0g==
X-Google-Smtp-Source: ABdhPJw+jnq+DjUbXk/OacT5JbgIXzr3rPodhkyFZmiByvH1HmUQZshQ/Fhidw8MW3NgIOS3oKeSi/C5q3GcI6Qx+s4=
X-Received: by 2002:a19:834f:: with SMTP id f76mr3089419lfd.25.1595258456652;
 Mon, 20 Jul 2020 08:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net> <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
In-Reply-To: <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Jul 2020 17:20:44 +0200
Message-ID: <CAKfTPtAxcdQ=bNapyvsrG_Cb6p8h2ut4=waiSPmay+tNxF8fZQ@mail.gmail.com>
Subject: Re: [SchedulerTaskPacking] Small background task packing
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parth,

On Thu, 9 Jul 2020 at 14:09, Parth Shah <parth@linux.ibm.com> wrote:
>
> > A) Name:
>
> Small background task packing
>
> > B) Target behaviour:
>
> All fair task wakeup follows a procedure of finding an idle CPU and
> waking the task on this idle CPU. There are two major wakeup paths:
> 1. Slow-path: Wake up the task on an idle CPU which is in the shallowest
> idle states by searching in the highest sched_domain flagged with
> SD_BALANCE_FORK or SD_BALANCE_EXEC.
> 2. Fast-path: Wake up the task on an idle CPU in the LLC sched_domain of
> the waker CPU. There are optimization to bias task placement on prev_cpu or
> wake_cpu of the task. This path is majorly used except in few cases like
> during fork() and exec().
>
> This assumption of picking an idle CPU is fair in-order to uniformly
> consume system resources. But not all tasks deserves to wakeup an idle core
> as it can hurt power consumption. For e.g. like small background tasks
> waking up an idle core and runs only for very small duration. Reducing
> number of active cores allows busier cores to boost frequency and hence
> saving power can also result in performance benefits.
>
> There is no mechanism in existing wake up path to detect small
> background tasks which can be packed on fewer cores.
>
> > C) Existing control paths:
>
> fair:: .select_task_rq = select_task_rq_fair
>
> fair::select_task_rq_fair()
>     // 1) Slow-path: find idle CPU with shallowest idle states
>     find_idlest_cpu()
>
>     // 2) Fast-path: find idle CPU
>     fair:select_idle_sibling()
>         // Wake up on idle core if available
>         fair:select_idle_core()
>         // Else wakeup on idle CPU if available
>         fair:select_idle_cpu()
>         fair:select_idle_smt()
>
>
> There are multiple ways to call fair:select_task_rq_fair();
>
> // 1) try_to_wake_up which should lead to fast-path
>    core::try_to_wake_up()
>       cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
>
> // 2) wake_up_new_task which should lead to slow-path
>    core::wake_up_new_task()
>       __set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK,0));
>
> // 3) sched_exec which should lead to slow-path
>    core::sched_exec()
>       dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p),
> SD_BALANCE_EXEC, 0);
>
> > D) Desired behaviour:
>
> Latency tolerant tasks with small utilization should be packed
> on a busy core rather than waking up a new core/CPU.
>
> Upon detecting small-background tasks, different code-path can be used to
> search for a busy core as described below;
>
> sched/fair.c:
> static inline bool is_small_bg_task(struct task_struct *p)
> {
>         if (is_latency_tolerant(p) &&
>             (task_util(p) > (SCHED_CAPACITY_SCALE >> 3)))

This condition seems to be quite arbitrary and probably works on your
current platform but other platforms might want another threshold. Is
there a way to know how much utilization can be added to a CPU which
would not use more capacity than the extra capacity that is provided
by the turbo mode ?

Also you may want to use task_util_est() instead of task_util() to
make sure that the small background task has low chance to become a
large one and not use more capacity than the one provided by turbo at
the end

>                 return true;
>
>         return false;
> }
>
> sched/fair.c: in select_task_rq_fair()
>
> if (sd_flag & SD_BALANCE_WAKE) {
>         if (is_small_bg_task(p)) {
>                 // New proposed wakeup path to do task packing
>                 new_cpu = select_non_idle_core(p, prev_cpu);
>                 if (new_cpu >= 0)
>                         return new_cpu;
>         }
> }
>
> where select_non_idle_core() searches for a busy core already running some
> tasks and selects an idle CPU in that busy core to pack the waking task.
>
> Complete code can be found on TurboSched patches [1].
>
> > E) Existing knobs (if any): reference to whatever existing tunable
>
> There are no existing knob which can hint the scheduler about the latency
> nature of task. Detecting latency nature of the task can help in
> classifying task as small background tasks to be packed on fewer number of
> cores.
>
> There are user-space hacks to do task packing for background tasks with the
> use of cpuset.cpus or sched_setaffinity() to manually affine the process to
> fewer  dedicated cores.
>
> > F) Existing knobs (if any): one paragraph description of the limitations
>
> Sysadmin/user has to define cpumask for each process (aka task pinning)
> which is static in nature. There are multiple limitations to pin the small
> background tasks;
>
> - In presence of just one small background task, there is no power
> consumption benefit here. It would be preferable to pin it to busy CPU.
>
> - If a task changes the behavior in its life-cycle then sysadmin will have
> to manually pin/unpin such tasks. This is limitation of user to classify
> tasks as only "background "one and cannot say if and when it will be
> "small" in utilization.
>
> - Sysadmin cannot change the task's affinity mask based on the scheduling
> pattern to give most optimal performance and energy consumption.
>
> > G) Proportionality Analysis: check the nature of the target behavior
>
> Task packing has to be noninvasive in nature, meaning only the tasks which
> are latency tolerant should be packed on fewer cores. Providing this
> behavior needs a run-time tunable knob which can hint the scheduler on
> whether the waking task can be packed or not.
>
> Upon detecting the nature of the task, a specific wakeup path can be followed:
> 1. On latency-tolerant tasks with low utilization, a new proposed
> scheduling wakeup path will be followed to do packing
> 2. On latency-sensitive task, an exiting approach of wakeup can be used.
>
> > H) Range Analysis: identify meaningful ranges
>
> The new knob can be binary input accepting 0/1, where 0 means
> latency-sensitive and 1 means latency-tolerant task.
>
> Latency-sensitive tasks (value = 0) can search idle CPU in only the llc
> sched_domain while the latency-tolerance (value = 1) tasks can go across
> llc sched_domain (just like in slow-path) but here in-order to search for a
> busy core.
>
> Mapping analysis:
> ================
> The latency_nice proposal [2] offers a [-20, 19] range which can be
> mapped into a binary switch, e.g. using a threshold based function.
>
> However, it is possible to extend the concept of finding busy core by
> limiting the time spent on searching based on the latency_nice value from
> range [-20, 19] where value of 19 indicates searching in the whole chip for
> a busy core, whereas value of 10 could mean search for half of the cores in
> the chip.
>
> > I) System-Wide tuning: which knobs are required
>
> The latency_nice provided knobs should be enough to get the desired
> effect.
>
> > J) Per-Task tuning: which knobs are required
>
> sched_setscheduler() is sufficient.
>
> > K) Task-Group tuning: which knobs are required
>
> A single attribute classifying task-group as latency_nice or
> latency_tolerant is sufficient.
>
>
> > .:: References
> > ==============
>
> [1] [RFC v6 0/5] TurboSched: A scheduler for sustaining Turbo Frequencies
>     for longer durations
>     https://lkml.org/lkml/2020/1/21/39
> [2] [PATCH v5 0/4] Introduce per-task latency_nice for scheduler hints
>     Message-ID: 20200228090755.22829-1-parth@linux.ibm.com
>     https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com
> [3] TurboSched: the return of small-task packing
>     https://lwn.net/Articles/792471/
>     https://www.phoronix.com/scan.php?page=news_item&px=Linux-TurboSched-V4
