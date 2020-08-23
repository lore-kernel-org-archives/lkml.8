Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB84CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 07:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F3520768
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7NprVWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHWHd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 03:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHWHd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 03:33:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B38C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 00:33:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id h3so5486630oie.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBjDd96sYjerF1OmD4oaakFsMI7Mmrw+Fd+bPpIRiHQ=;
        b=R7NprVWmYRo4EEWHLnjsbACdJkcy2N2R/+kBPj+0zoATXmigFyIsLKCnJ5TWI66J/p
         qHJBAF5P+Nl8ogf3iw+06lvLzD14kSdisBQCGikfWFSnvFJQI2B5Cv54sTlWtzuOMcjp
         VOw8p3a7fiELgehYcZxjomqoN2gCcrOdiNh7wJqnJuLShB9vHmth2wFYi7tnOzYFxI72
         IND7Ck6ivbnrVyH0MFeL7f0RpjFxUORpSOwirnf2FRN5490Gy94cosMI4uVhl0LLyKq8
         WTcH5xUnyGxfd8g0yITwZbZXUWZ5HFYMu1bNHhLUsaqcnqEp+xuCADb/r8nVDDTicHQV
         gOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBjDd96sYjerF1OmD4oaakFsMI7Mmrw+Fd+bPpIRiHQ=;
        b=LUiP+ZIbcllAcTflMzIV3RwXzDbmfHIYKtYVL0HKGWUWacldCebOTlpbVebL+BJ8DK
         +JFvd8V/+S652IO8Dnj2BZBS3JGpS4/j67CZm3ZKuvPjUrgj2IkWC0yGbzDgBXwOf2L5
         ub2fKyXmgo2BjnoxucYsBlDJxpJvKGOMl2he7HOhUP1qpTakEJi0RPK5P9odhioBbADU
         H6p+7DQI5L4jBNWQFcvEraax//8FN46Jwjae9cPnoBtPBNulw2im0PTUhTuB0DLF0QEf
         X7fgqTEO9XJWhN69PIa+wU1FLqCGJLl+bfD3xILv/Hb4XkpgbW/FoFxQnhdLutRrYFPM
         TmkQ==
X-Gm-Message-State: AOAM532bUgstlj4HUOm7/fJPu/LWK1TFbjChJhWS35Vr3gTbb8JrKL9h
        iUTb4uBOc/Rv8uj1058HGx6elESkzggemgVy5ag=
X-Google-Smtp-Source: ABdhPJy0cyVfI4OKoiBIxFu5ayCT77zX01UYMLvyL3Q+LNjAkq0V8iNBgBZ9goA32uudupP1E7geG4e8vcRp4kSnHkQ=
X-Received: by 2002:a05:6808:64c:: with SMTP id z12mr201284oih.5.1598168004882;
 Sun, 23 Aug 2020 00:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net> <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
In-Reply-To: <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Sun, 23 Aug 2020 15:33:13 +0800
Message-ID: <CAPJCdBmbTULFE=tS0-VM9aqKmC0b0PFfny6=UiuVZB=hVW996Q@mail.gmail.com>
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

Hi, Vincent and Peter

On Thu, 20 Aug 2020 at 22:09, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
> >
> > > That's been said, not compensating the vruntime for a sched_idle task
> > > makes sense for me. Even if that will only help for others task in the
> > > same cfs_rq
> >
> > Yeah, but it is worth the extra pointer chasing and branches?
>
> For that I let Jiang provides figures to show the worthful
Using the following configuration for rt-app,
{
        "tasks" : {
                "task_other" : {
                        "instance" : 1, //only 1 instance to be easy to observe
                        "cpus" : [2],
                        "loop" : 2000,
                        "policy" : "SCHED_OTHER",
                        "run" : -1,  //make normal task 100% running
                        "priority" : 0,
                        "sleep" : 0
                },
                "task_idle" : {
                        "instance" : 1,
                        "cpus" : [2],
                        "loop" : 2000,
                        "policy" : "SCHED_IDLE",
                        "run" : 1, //only run 1us to avoid
blocking(always waiting for running), making check_preempt_wakeup
work(S->R switching)
                        "timer" : { "ref" : "unique2" , "period" :
16000, "mode" : "absolute" }
                }
        },
        "global" : {
                "calibration" : "CPU0",
                "default_policy" : "SCHED_OTHER",
                "duration" : -1
        }
}
without the patch,
          <...>-39771 [002] d.h. 42478.177771: sched_wakeup:
comm=task_idle-1 pid=39772 prio=120 target_cpu=002
           <...>-39771 [002] d... 42478.190437: sched_switch:
prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=39772 next_prio=120
           <...>-39771 [002] d.h. 42478.193771: sched_wakeup:
comm=task_idle-1 pid=39772 prio=120 target_cpu=002
           <...>-39771 [002] d... 42478.206438: sched_switch:
prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=39772 next_prio=120
           <...>-39771 [002] d.h. 42478.209771: sched_wakeup:
comm=task_idle-1 pid=39772 prio=120 target_cpu=002
           <...>-39771 [002] d... 42478.222438: sched_switch:
prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=39772 next_prio=120
           <...>-39771 [002] d.h. 42478.225771: sched_wakeup:
comm=task_idle-1 pid=39772 prio=120 target_cpu=002
           <...>-39771 [002] d... 42478.238438: sched_switch:
prev_comm=task_other-0 prev_pid=39771 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=39772 next_prio=120
*task_idle*  preempts every 12ms because of the compensation.

with the patch,
   task_other-0-27670 [002] d.h. 136785.278059: sched_wakeup:
comm=task_idle-1 pid=27671 prio=120 target_cpu=002
    task_other-0-27670 [002] d... 136785.293623: sched_switch:
prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=27671 next_prio=120
    task_other-0-27670 [002] d.h. 136785.294059: sched_wakeup:
comm=task_idle-1 pid=27671 prio=120 target_cpu=002
    task_other-0-27670 [002] d... 136785.317624: sched_switch:
prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=27671 next_prio=120
    task_other-0-27670 [002] d.h. 136785.326059: sched_wakeup:
comm=task_idle-1 pid=27671 prio=120 target_cpu=002
    task_other-0-27670 [002] d... 136785.341622: sched_switch:
prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=27671 next_prio=120
    task_other-0-27670 [002] d.h. 136785.342059: sched_wakeup:
comm=task_idle-1 pid=27671 prio=120 target_cpu=002
    task_other-0-27670 [002] d... 136785.365623: sched_switch:
prev_comm=task_other-0 prev_pid=27670 prev_prio=120 prev_state=R ==>
next_comm=task_idle-1 next_pid=27671 next_prio=120
*task_idle* preempts every 24 or 16 ms.

This patch could reduce the preempting frequency of task_idle, and
reduce the interference from SCHED_IDLE task.

Thx.
Regards,
Jiang
