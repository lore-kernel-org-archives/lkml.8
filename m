Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD177C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812F2206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3peLCn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIAKPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:15:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E985C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:15:10 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y5so680399otg.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7BGqaiz9dINOgjYt82iTXwUyul7PGJdsTFMlYvma8Y=;
        b=H3peLCn7LEgbM+JJiaU9bJpt8F4BTtz1LSaQTJY7MaO8DG9+DLhN8XidKha1A/2Dh6
         FEP7vd1qlwJq9kjBnHuF984ZxcvFHPZe30M4RuZiy4ucvA14FoIXua9AOB4EnuVOYmCo
         hiMTKSWmwLFRblS6vOYClS3pcf3imHrHoezMERbaFUn3oykNuTNs/iWrjj2YYjBFNLNV
         fwihUcgPUOfU+NxeV2wXSds6M1FB+WF+ROa/C4AmGBMbqh2m1kdUZjMFAlAmXn/r9UzQ
         aiA+ff5bYcwaNsTTniWM71MKJuAs/WxSX++F8a/nGx2yQa7MXgppBq9NqpH7d/8oG+0Y
         24rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7BGqaiz9dINOgjYt82iTXwUyul7PGJdsTFMlYvma8Y=;
        b=EhJPOXtYqvcW/nSaDDNv8xvJ1rFZdyNOq6RBZW4Gy7V9wjmHQiijkxfb1x9v3Zg91y
         ms+n872Ar1flb6SWnJbLIjfZ89WhlpC//3q40MiNonFzhOH2WcrGz73aeWClNTv/5g2B
         BCFM3dFtxcFS0XHVIk94M1MRCOgnlCG5jbVCyna1rEkCYIm38kVryB6LUilWr8O01k3L
         hcJVgVXVaFlwrkJvlZglzLBszcRNLes7QQAU5LC6Xz8ULkEFNZaR6DlK9/LVGqHjznXT
         iTNyGqbhRit1n6tz8KnRjcRnTvnvRA+M0uQa4E/z9NQ3nnlW5Kkud6+Pji7xx7W6IW1C
         6pHg==
X-Gm-Message-State: AOAM533RaLrk8qJRIScTAHQBNqTMkuTp0sZBcYf4Wm3gbcEB0+jLIxTs
        DpfDj2MQZsIrVaXd4z5UoCfKxi95IrWZg5dVzWE=
X-Google-Smtp-Source: ABdhPJxPuEJ2fdzzt716Nq2dio4wX23+EDnJP5O/OC69gurXW2H7RQrbiJXuhMR5kP8IWoX02l+Pq/MPvM/E7qdkTZ8=
X-Received: by 2002:a9d:6b0e:: with SMTP id g14mr809047otp.237.1598955309634;
 Tue, 01 Sep 2020 03:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net> <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
 <CAPJCdBmbTULFE=tS0-VM9aqKmC0b0PFfny6=UiuVZB=hVW996Q@mail.gmail.com> <CAKfTPtCTd5eihtcg=B0Gu3RUydbSgjurD1uHD3rEvbTV61nf6Q@mail.gmail.com>
In-Reply-To: <CAKfTPtCTd5eihtcg=B0Gu3RUydbSgjurD1uHD3rEvbTV61nf6Q@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 1 Sep 2020 18:14:58 +0800
Message-ID: <CAPJCdBmzcmomLaxNyN=VJiOCxrqrYdeJ=N8YksJ8mVY-BGHASA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Vincent Guittot <vincent.guittot@linaro.org>
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

Hi, Vincent

Sorry for the late reply.:)

On Fri, 28 Aug 2020 at 20:55, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sun, 23 Aug 2020 at 09:33, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Hi, Vincent and Peter
> >
> > On Thu, 20 Aug 2020 at 22:09, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
> > > >
> > > > > That's been said, not compensating the vruntime for a sched_idle task
> > > > > makes sense for me. Even if that will only help for others task in the
> > > > > same cfs_rq
> > > >
> > > > Yeah, but it is worth the extra pointer chasing and branches?
> > >
> > > For that I let Jiang provides figures to show the worthful
> > Using the following configuration for rt-app,
> > {
> >         "tasks" : {
> >                 "task_other" : {
> >                         "instance" : 1, //only 1 instance to be easy to observe
> >                         "cpus" : [2],
> >                         "loop" : 2000,
> >                         "policy" : "SCHED_OTHER",
> >                         "run" : -1,  //make normal task 100% running
> >                         "priority" : 0,
> >                         "sleep" : 0
> >                 },
> >                 "task_idle" : {
> >                         "instance" : 1,
> >                         "cpus" : [2],
> >                         "loop" : 2000,
> >                         "policy" : "SCHED_IDLE",
> >                         "run" : 1, //only run 1us to avoid
> > blocking(always waiting for running), making check_preempt_wakeup
> > work(S->R switching)
> >                         "timer" : { "ref" : "unique2" , "period" :
> > 16000, "mode" : "absolute" }
> >                 }
> >         },
> >         "global" : {
> >                 "calibration" : "CPU0",
> >                 "default_policy" : "SCHED_OTHER",
> >                 "duration" : -1
> >         }
> > }
> > without the patch,
> >           <...>-39771 [002] d.h. 42478.177771: sched_wakeup:
> > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> >            <...>-39771 [002] d... 42478.190437: sched_switch:
> > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=39772 next_prio=120
> >            <...>-39771 [002] d.h. 42478.193771: sched_wakeup:
> > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> >            <...>-39771 [002] d... 42478.206438: sched_switch:
> > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=39772 next_prio=120
> >            <...>-39771 [002] d.h. 42478.209771: sched_wakeup:
> > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> >            <...>-39771 [002] d... 42478.222438: sched_switch:
> > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=39772 next_prio=120
> >            <...>-39771 [002] d.h. 42478.225771: sched_wakeup:
> > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> >            <...>-39771 [002] d... 42478.238438: sched_switch:
> > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > *task_idle*  preempts every 12ms because of the compensation.
> >
> > with the patch,
> >    task_other-0-27670 [002] d.h. 136785.278059: sched_wakeup:
> > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> >     task_other-0-27670 [002] d... 136785.293623: sched_switch:
> > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=27671 next_prio=120
> >     task_other-0-27670 [002] d.h. 136785.294059: sched_wakeup:
> > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> >     task_other-0-27670 [002] d... 136785.317624: sched_switch:
> > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=27671 next_prio=120
> >     task_other-0-27670 [002] d.h. 136785.326059: sched_wakeup:
> > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> >     task_other-0-27670 [002] d... 136785.341622: sched_switch:
> > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=27671 next_prio=120
> >     task_other-0-27670 [002] d.h. 136785.342059: sched_wakeup:
> > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> >     task_other-0-27670 [002] d... 136785.365623: sched_switch:
> > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > *task_idle* preempts every 24 or 16 ms.
> >
> > This patch could reduce the preempting frequency of task_idle, and
> > reduce the interference from SCHED_IDLE task.
>
> For this use case, the preemption is only 1us long. Is it a realistic
> problem use case ? your normal threads might be more impacted by tick,
Nop.
1us is just to make the logic in place_entity() work. If the preemption is
longer, the IDLE task could not finish its work before being preempted back
by normal task, and the IDLE task would be always in RUNNING status from
then on. In that case place_entity() would never be reached because of the
RUNNING status.

> interrupt, timer and others things than this 1us idle thread every
> 16ms. I mean, the patch moves the impact from 1us every 12ms (0.01%)
> to 1us every 24ms (0.005%). Then, If the idle thread starts to run a
> bit longer, the period before preempting the normal thread quickly
> increases
Exactly.

>
> What is the improvement for an idle thread trying to run 1ms every
> 16ms as an example ?
If to run 1ms, the IDLE task would be always RUNNING status  as said
above. In that case, place_entity() would not work, and the preemption
would happen every 340ms as always.

Thx.
Regards,
Jiang
