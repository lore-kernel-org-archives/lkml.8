Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D761CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A149F2067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liAKRa+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIANHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgIANFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:05:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923D8C061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:04:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so1430972ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTcj+wa4y57JaNrJlYMrHlaBIBb/iNOmqo6BATfC9sg=;
        b=liAKRa+REiDeMjzfTE1zQL4EYPj1FCh3Vu1AlT48XpHOj6bbVSg0mZmlGZR8jstUBS
         HoWlsHwjjpfwQYy9t2UX4P59Cy1XeQOqiqSwoi2ryEsGdS3A+eFJ53wep1tbZYsqdzf+
         C+TBKPvUm1SfoIWH/vdUgOQogx3PY6fgaouFQsvV+WAttz2l5PHNN7oQJHlhjXBIqukb
         X9NvEfGtNHUQ9g/aCsYeleknOeJsQzZWf7ewUeR1YSX3pZmyOyoX3X1ufQz9ZW2pUJjP
         IgA9AMHqlYlykN+9puTQbOs2iW1thM6fFGeGlSzZuyT9CORWQ7UgOc/GI8r1DVXieIZF
         Wpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTcj+wa4y57JaNrJlYMrHlaBIBb/iNOmqo6BATfC9sg=;
        b=sdZykAf6Ui16ROaxmwuh9f14fzRlBVfmrvXO8aUtZ9kwgFzIR2cVnysj7wm4NrIAm3
         t6A7BNlcoTOM54tN7b+k833vfcQXJK4nC6sOJBoBqeZvmp4/OCssmWrlO8Q0mwC4laTP
         dFoN8u5h6alMY3F975ytkYHkr6iLMhXYqUXONZezzMXt5m6jbsWfMrSVbUI9LzSYtt2q
         Cb7BTBDfOAh+NwA99k1wmnKfzZcz3za1OJwv/V99QwR7AHbY13Us1EhvNb1WA9rno1PR
         xfnvp1NuViK4y0cAHRMboQ2lwlhe3ZI0MxCSuIC8ZdiaodGYNrFo04KEuV5axhiXja+y
         fnUA==
X-Gm-Message-State: AOAM533sMSWvnt1iqEYy65Vc8TFmFV4OB3V99zF5WFFYbTQuc2U0LtXs
        Z3VC/BIsx1I5hAl8hT1HFJyrC42YRO7U/s0kL+C8bA==
X-Google-Smtp-Source: ABdhPJziCz/TmZc2bRvVdNUOr7hpnLxFIgH2l1HM1bwJL5j9RBC9bW2/QB/Mx5pndc64On9txvdHEuolgfBTBBZDUfI=
X-Received: by 2002:a2e:81d7:: with SMTP id s23mr579639ljg.69.1598965488779;
 Tue, 01 Sep 2020 06:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net> <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
 <CAPJCdBmbTULFE=tS0-VM9aqKmC0b0PFfny6=UiuVZB=hVW996Q@mail.gmail.com>
 <CAKfTPtCTd5eihtcg=B0Gu3RUydbSgjurD1uHD3rEvbTV61nf6Q@mail.gmail.com> <CAPJCdBmzcmomLaxNyN=VJiOCxrqrYdeJ=N8YksJ8mVY-BGHASA@mail.gmail.com>
In-Reply-To: <CAPJCdBmzcmomLaxNyN=VJiOCxrqrYdeJ=N8YksJ8mVY-BGHASA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 1 Sep 2020 15:04:37 +0200
Message-ID: <CAKfTPtBerqpbay-=2ws85K6hRJNXfsexaNpUyesz4OtZrZVRWQ@mail.gmail.com>
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

On Tue, 1 Sep 2020 at 12:15, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Vincent
>
> Sorry for the late reply.:)
>
> On Fri, 28 Aug 2020 at 20:55, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Sun, 23 Aug 2020 at 09:33, Jiang Biao <benbjiang@gmail.com> wrote:
> > >
> > > Hi, Vincent and Peter
> > >
> > > On Thu, 20 Aug 2020 at 22:09, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
> > > > >
> > > > > > That's been said, not compensating the vruntime for a sched_idle task
> > > > > > makes sense for me. Even if that will only help for others task in the
> > > > > > same cfs_rq
> > > > >
> > > > > Yeah, but it is worth the extra pointer chasing and branches?
> > > >
> > > > For that I let Jiang provides figures to show the worthful
> > > Using the following configuration for rt-app,
> > > {
> > >         "tasks" : {
> > >                 "task_other" : {
> > >                         "instance" : 1, //only 1 instance to be easy to observe
> > >                         "cpus" : [2],
> > >                         "loop" : 2000,
> > >                         "policy" : "SCHED_OTHER",
> > >                         "run" : -1,  //make normal task 100% running
> > >                         "priority" : 0,
> > >                         "sleep" : 0
> > >                 },
> > >                 "task_idle" : {
> > >                         "instance" : 1,
> > >                         "cpus" : [2],
> > >                         "loop" : 2000,
> > >                         "policy" : "SCHED_IDLE",
> > >                         "run" : 1, //only run 1us to avoid
> > > blocking(always waiting for running), making check_preempt_wakeup
> > > work(S->R switching)
> > >                         "timer" : { "ref" : "unique2" , "period" :
> > > 16000, "mode" : "absolute" }
> > >                 }
> > >         },
> > >         "global" : {
> > >                 "calibration" : "CPU0",
> > >                 "default_policy" : "SCHED_OTHER",
> > >                 "duration" : -1
> > >         }
> > > }
> > > without the patch,
> > >           <...>-39771 [002] d.h. 42478.177771: sched_wakeup:
> > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > >            <...>-39771 [002] d... 42478.190437: sched_switch:
> > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > >            <...>-39771 [002] d.h. 42478.193771: sched_wakeup:
> > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > >            <...>-39771 [002] d... 42478.206438: sched_switch:
> > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > >            <...>-39771 [002] d.h. 42478.209771: sched_wakeup:
> > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > >            <...>-39771 [002] d... 42478.222438: sched_switch:
> > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > >            <...>-39771 [002] d.h. 42478.225771: sched_wakeup:
> > > comm=task_idle-1 pid=39772 prio=120 target_cpu=002
> > >            <...>-39771 [002] d... 42478.238438: sched_switch:
> > > prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=39772 next_prio=120
> > > *task_idle*  preempts every 12ms because of the compensation.
> > >
> > > with the patch,
> > >    task_other-0-27670 [002] d.h. 136785.278059: sched_wakeup:
> > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > >     task_other-0-27670 [002] d... 136785.293623: sched_switch:
> > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > >     task_other-0-27670 [002] d.h. 136785.294059: sched_wakeup:
> > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > >     task_other-0-27670 [002] d... 136785.317624: sched_switch:
> > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > >     task_other-0-27670 [002] d.h. 136785.326059: sched_wakeup:
> > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > >     task_other-0-27670 [002] d... 136785.341622: sched_switch:
> > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > >     task_other-0-27670 [002] d.h. 136785.342059: sched_wakeup:
> > > comm=task_idle-1 pid=27671 prio=120 target_cpu=002
> > >     task_other-0-27670 [002] d... 136785.365623: sched_switch:
> > > prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
> > > next_comm=task_idle-1 next_pid=27671 next_prio=120
> > > *task_idle* preempts every 24 or 16 ms.
> > >
> > > This patch could reduce the preempting frequency of task_idle, and
> > > reduce the interference from SCHED_IDLE task.
> >
> > For this use case, the preemption is only 1us long. Is it a realistic
> > problem use case ? your normal threads might be more impacted by tick,
> Nop.
> 1us is just to make the logic in place_entity() work. If the preemption is
> longer, the IDLE task could not finish its work before being preempted back
> by normal task, and the IDLE task would be always in RUNNING status from
> then on. In that case place_entity() would never be reached because of the
> RUNNING status.

Yeah, I agree that the setup is the right one to check the worst
wakeup pre emption period but it doesn't sound like a realistic
problem

Have you tried this with your system and does it improve anything ?
Otherwise, I agree with Peter that it doesn't worth having an
additional test in the wakeup path if it doesn't help any cases

>
> > interrupt, timer and others things than this 1us idle thread every
> > 16ms. I mean, the patch moves the impact from 1us every 12ms (0.01%)
> > to 1us every 24ms (0.005%). Then, If the idle thread starts to run a
> > bit longer, the period before preempting the normal thread quickly
> > increases
> Exactly.
>
> >
> > What is the improvement for an idle thread trying to run 1ms every
> > 16ms as an example ?
> If to run 1ms, the IDLE task would be always RUNNING status  as said
> above. In that case, place_entity() would not work, and the preemption
> would happen every 340ms as always.
>
> Thx.
> Regards,
> Jiang
