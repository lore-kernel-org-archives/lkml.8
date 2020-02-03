Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16449C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D9C21775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgBCO6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:58:01 -0500
Received: from foss.arm.com ([217.140.110.172]:54336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgBCO6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:58:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B008B30E;
        Mon,  3 Feb 2020 06:57:57 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 355453F68E;
        Mon,  3 Feb 2020 06:57:56 -0800 (PST)
Date:   Mon, 3 Feb 2020 14:57:53 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200203145752.sqxpqse6pav4nxxv@e107158-lin>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
 <20200203053235.GE27398@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203053235.GE27398@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 11:02, Pavan Kondeti wrote:
> Full trace is attached. Copy/pasting the snippet where it shows packing is
> happening. The custom trace_printk are added in cpupri_find() before calling
> fitness_fn(). As you can see pid=535 is woken on CPU#7 where pid=538 RT task
> is runnning. Right after waking, the push is tried but it did not work either.
> 
> This is not a serious problem for us since we don't set RT tasks
> uclamp.min=1024 . However, it changed the behavior and might introduce latency
> for RT tasks on b.L platforms running the upstream kernel as is.
> 
>         big-task-538   [007] d.h.   403.401633: irq_handler_entry: irq=3 name=arch_timer
>         big-task-538   [007] d.h2   403.401633: sched_waking: comm=big-task pid=535 prio=89 target_cpu=007
>         big-task-538   [007] d.h2   403.401635: cpupri_find: before task=big-task-535 lowest_mask=f
>         big-task-538   [007] d.h2   403.401636: cpupri_find: after task=big-task-535 lowest_mask=0
>         big-task-538   [007] d.h2   403.401637: cpupri_find: it comes here
>         big-task-538   [007] d.h2   403.401638: find_lowest_rq: task=big-task-535 ret=0 lowest_mask=0
>         big-task-538   [007] d.h3   403.401640: sched_wakeup: comm=big-task pid=535 prio=89 target_cpu=007
>         big-task-538   [007] d.h3   403.401641: cpupri_find: before task=big-task-535 lowest_mask=f
>         big-task-538   [007] d.h3   403.401642: cpupri_find: after task=big-task-535 lowest_mask=0
>         big-task-538   [007] d.h3   403.401642: cpupri_find: it comes here
>         big-task-538   [007] d.h3   403.401643: find_lowest_rq: task=big-task-535 ret=0 lowest_mask=0
>         big-task-538   [007] d.h.   403.401644: irq_handler_exit: irq=3 ret=handled
>         big-task-538   [007] d..2   403.402413: sched_switch: prev_comm=big-task prev_pid=538 prev_prio=89 prev_state=S ==> next_comm=big-task next_pid=535 next_prio=89

Thanks for that.

If I read the trace correctly, the 5 tasks end up all being on the *all* the
big cores (ie: sharing), correct?

The results I posted did show that we can end up with 2 tasks on a single big
core. I don't think we can say this is a good or a bad thing, though for me
I see it a good thing since it honored a request to be on the big core which
the system tried its best to provide.

Maybe we do want to cater for a default all boosted RT tasks, is this what
you're saying? If yes, how do you propose the logic to look like? My thought is
to provide a real time knob to tune down most RT tasks to sensible default
dependong on how powerful (and power hungry) the system is, then use the per
task API to boost the few tasks that really need more performance out of the
system.

Note from my results assuming I didn't do anything stupid, if you boot with
a system that runs with rt_task->uclamp_min = 1024, then some will race to the
big cores and the rest will stay where they are on the littles.

In my first version things looked slightly different and I think handling of
the fallback not finding a fitting CPU was better.

Please have a look at and let me know what you think.

https://lore.kernel.org/lkml/20190903103329.24961-1-qais.yousef@arm.com/

Thanks

--
Qais Yousef
