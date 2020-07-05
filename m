Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDAAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5693820772
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgGEAWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:22:01 -0400
Received: from foss.arm.com ([217.140.110.172]:42988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgGEAWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:22:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B336830E;
        Sat,  4 Jul 2020 17:22:00 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D2CD3F73C;
        Sat,  4 Jul 2020 17:21:59 -0700 (PDT)
References: <20200703133259.GE4781@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        Oleg Nesterov <oleg@redhat.com>, david@fromorbit.com,
        pauld@redhat.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched: Better document ttwu()
In-reply-to: <20200703133259.GE4781@hirez.programming.kicks-ass.net>
Date:   Sun, 05 Jul 2020 01:21:57 +0100
Message-ID: <jhjmu4eg6ai.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/07/20 14:32, Peter Zijlstra wrote:
> Dave hit the problem fixed by commit:
>
>   b6e13e85829f ("sched/core: Fix ttwu() race")
>
> and failed to understand much of the code involved. Per his request a
> few comments to (hopefully) clarify things.
>
> Requested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Small extra comment below, otherwise FWIW:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> +++ b/kernel/sched/core.c
> @@ -79,6 +79,100 @@ __read_mostly int scheduler_running;
>   */
>  int sysctl_sched_rt_runtime = 950000;
>
> +
> +/*
> + * Serialization rules:
> + *
> + * Lock order:
> + *
> + *   p->pi_lock
> + *     rq->lock
> + *       hrtimer_cpu_base->lock (hrtimer_start() for bandwidth controls)
> + *
> + *  rq1->lock
> + *    rq2->lock  where: rq1 < rq2
> + *
> + * Regular state:
> + *
> + * Normal scheduling state is serialized by rq->lock. __schedule() takes the
> + * local CPU's rq->lock, it optionally removes the task from the runqueue and
> + * always looks at the local rq data structures to find the most elegible task
> + * to run next.
> + *
> + * Task enqueue is also under rq->lock, possibly taken from another CPU.
> + * Wakeups from another LLC domain might use an IPI to transfer the enqueue to
> + * the local CPU to avoid bouncing the runqueue state around [ see
> + * ttwu_queue_wakelist() ]
> + *
> + * Task wakeup, specifically wakeups that involve migration, are horribly
> + * complicated to avoid having to take two rq->locks.
> + *
> + * Special state:
> + *
> + * System-calls and anything external will use task_rq_lock() which acquires
> + * both p->pi_lock and rq->lock. As a consequence the state they change is
> + * stable while holding either lock:
> + *
> + *  - sched_setaffinity()/
> + *    set_cpus_allowed_ptr():	p->cpus_ptr, p->nr_cpus_allowed
> + *  - set_user_nice():		p->se.load, p->*prio
> + *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio,
> + *				p->se.load, p->rt_priority,
> + *				p->dl.dl_{runtime, deadline, period, flags, bw, density}

Uclamp stuff can also get updated in __sched_setscheduler(); see
__setscheduler_uclamp(). It's only p->uclamp_req AFAICT, but I don't think
there's harm in just saying p->uclamp*.

> + *  - sched_setnuma():		p->numa_preferred_nid
> + *  - sched_move_task()/
> + *    cpu_cgroup_fork():	p->sched_task_group
> + *  - uclamp_update_active()	p->uclamp*
> + *
