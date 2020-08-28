Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00168C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2DF2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zs6v88Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgH1Mzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbgH1Mzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:55:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8DC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:55:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x77so660318lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnhroHrclp1KWVwvSy8+50HO8y/Hv9mEvg3yQSs6BZQ=;
        b=zs6v88ChrAviT6VBNCODyfhX1USiLfRecZGF5bErEDMijIR1ZPxIjWHeXmZgqlomzb
         wmrRNXaxABCtDxl6SbXQh8Tx95Z64ThwSmcI7vhgTvayFyr6TVYAtPI0pMDc9mov3AQY
         tdLvQjIVCweNldNjw7dZwcvHhEIXHyx/fCCj5ZpPsORNHiX45Us1DaFQUauxx6Y+i+eQ
         QJEVLyaLMTUrSyjR72GwGj0jmZd5Sc4+hwAmF9YfKRdyZosfpBoUURzbgqclPvJk+xPx
         eef6bV14HNBMhNiLdTF2sq233VukosXgPtxmnI6k7g/gvFIod//9rrZT4TJJbNRD4+CU
         blYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnhroHrclp1KWVwvSy8+50HO8y/Hv9mEvg3yQSs6BZQ=;
        b=MLCQFcQJINCAK7qqvpJrB8i3sUmz4fc3ou4tdb8X/5ANSQldwUfgUVxD0TR5IZQRy0
         +ebX7bmVJ/zhz9vZd4e4DyjS/pNEJpYiky53I59cBzlTM5KerbfmkfZk1ZMA+LtIC5nI
         dxGRu3o9pylhB/nY8+n2stuj6inLZ06qQDPKOuVQ1HQTX8F2G7MCbX+aZVtZ7iETKg3A
         ViUNCBLF9NJbL1UL3Kzl7AamaG/kGmSiSPjzaHlgS7YTqW7WXQq0C+2SSWxsZt3qyXPz
         R6E5xEq42DblORa4xbSp/MXpqxc8XVuDE368QvhHbfwsT9texjsnyoB3ya0vyfz9qWEJ
         i78g==
X-Gm-Message-State: AOAM533QelxZojcUbvU/tVUKhS8KIpAFbdfYH4A9b88VbH81PYzEP3uI
        /esTkeufLhaYAtxaFg1zB7if0HKUZhA0gvmASzsQEA==
X-Google-Smtp-Source: ABdhPJxGzBSi6hCyvQFxeWzyBnpsAhIJfkADeUstGjqtZcnC4MvtVL7PkoFtMO5VslppKBMHqBfsLD3EHi0dSBKR76U=
X-Received: by 2002:a05:6512:36cf:: with SMTP id e15mr744001lfs.149.1598619340813;
 Fri, 28 Aug 2020 05:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net> <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
 <CAPJCdBmbTULFE=tS0-VM9aqKmC0b0PFfny6=UiuVZB=hVW996Q@mail.gmail.com>
In-Reply-To: <CAPJCdBmbTULFE=tS0-VM9aqKmC0b0PFfny6=UiuVZB=hVW996Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Aug 2020 14:55:29 +0200
Message-ID: <CAKfTPtCTd5eihtcg=B0Gu3RUydbSgjurD1uHD3rEvbTV61nf6Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Aug 2020 at 09:33, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Vincent and Peter
>
> On Thu, 20 Aug 2020 at 22:09, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
> > >
> > > > That's been said, not compensating the vruntime for a sched_idle task
> > > > makes sense for me. Even if that will only help for others task in the
> > > > same cfs_rq
> > >
> > > Yeah, but it is worth the extra pointer chasing and branches?
> >
> > For that I let Jiang provides figures to show the worthful
> Using the following configuration for rt-app,
> {
>         "tasks" : {
>                 "task_other" : {
>                         "instance" : 1, //only 1 instance to be easy to observe
>                         "cpus" : [2],
>                         "loop" : 2000,
>                         "policy" : "SCHED_OTHER",
>                         "run" : -1,  //make normal task 100% running
>                         "priority" : 0,
>                         "sleep" : 0
>                 },
>                 "task_idle" : {
>                         "instance" : 1,
>                         "cpus" : [2],
>                         "loop" : 2000,
>                         "policy" : "SCHED_IDLE",
>                         "run" : 1, //only run 1us to avoid
> blocking(always waiting for running), making check_preempt_wakeup
> work(S->R switching)
>                         "timer" : { "ref" : "unique2" , "period" :
> 16000, "mode" : "absolute" }
>                 }
>         },
>         "global" : {
>                 "calibration" : "CPU0",
>                 "default_policy" : "SCHED_OTHER",
>                 "duration" : -1
>         }
> }
> without the patch,
>           <...>-39771 [002] d.h. 42478.177771: sched_wakeup:
> comm=task_idle-1 pid=39772 prio=120 target_cpu=002
>            <...>-39771 [002] d... 42478.190437: sched_switch:
> prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=39772 next_prio=120
>            <...>-39771 [002] d.h. 42478.193771: sched_wakeup:
> comm=task_idle-1 pid=39772 prio=120 target_cpu=002
>            <...>-39771 [002] d... 42478.206438: sched_switch:
> prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=39772 next_prio=120
>            <...>-39771 [002] d.h. 42478.209771: sched_wakeup:
> comm=task_idle-1 pid=39772 prio=120 target_cpu=002
>            <...>-39771 [002] d... 42478.222438: sched_switch:
> prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=39772 next_prio=120
>            <...>-39771 [002] d.h. 42478.225771: sched_wakeup:
> comm=task_idle-1 pid=39772 prio=120 target_cpu=002
>            <...>-39771 [002] d... 42478.238438: sched_switch:
> prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=39772 next_prio=120
> *task_idle*  preempts every 12ms because of the compensation.
>
> with the patch,
>    task_other-0-27670 [002] d.h. 136785.278059: sched_wakeup:
> comm=task_idle-1 pid=27671 prio=120 target_cpu=002
>     task_other-0-27670 [002] d... 136785.293623: sched_switch:
> prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=27671 next_prio=120
>     task_other-0-27670 [002] d.h. 136785.294059: sched_wakeup:
> comm=task_idle-1 pid=27671 prio=120 target_cpu=002
>     task_other-0-27670 [002] d... 136785.317624: sched_switch:
> prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=27671 next_prio=120
>     task_other-0-27670 [002] d.h. 136785.326059: sched_wakeup:
> comm=task_idle-1 pid=27671 prio=120 target_cpu=002
>     task_other-0-27670 [002] d... 136785.341622: sched_switch:
> prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=27671 next_prio=120
>     task_other-0-27670 [002] d.h. 136785.342059: sched_wakeup:
> comm=task_idle-1 pid=27671 prio=120 target_cpu=002
>     task_other-0-27670 [002] d... 136785.365623: sched_switch:
> prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> next_comm=task_idle-1 next_pid=27671 next_prio=120
> *task_idle* preempts every 24 or 16 ms.
>
> This patch could reduce the preempting frequency of task_idle, and
> reduce the interference from SCHED_IDLE task.

For this use case, the preemption is only 1us long. Is it a realistic
problem use case ? your normal threads might be more impacted by tick,
interrupt, timer and others things than this 1us idle thread every
16ms. I mean, the patch moves the impact from 1us every 12ms (0.01%)
to 1us every 24ms (0.005%). Then, If the idle thread starts to run a
bit longer, the period before preempting the normal thread quickly
increases

What is the improvement for an idle thread trying to run 1ms every
16ms as an example ?

Regards,
Vincent
>
> Thx.
> Regards,
> Jiang
