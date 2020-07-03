Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749422073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGCKN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:13:26 -0400
Received: from foss.arm.com ([217.140.110.172]:45732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGCKNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:13:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338962F;
        Fri,  3 Jul 2020 03:13:25 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD9F3F68F;
        Fri,  3 Jul 2020 03:13:23 -0700 (PDT)
Subject: Re: [RFC][PATCH] sched: Better document ttwu()
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        mgorman@suse.de, Oleg Nesterov <oleg@redhat.com>,
        david@fromorbit.com
References: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8490f760-44ed-fbae-b91e-671590bdb8d6@arm.com>
Date:   Fri, 3 Jul 2020 12:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2020 14:52, Peter Zijlstra wrote:
> 
> Dave hit the problem fixed by commit:
> 
>   b6e13e85829f ("sched/core: Fix ttwu() race")
> 
> and failed to understand much of the code involved. Per his request a
> few comments to (hopefully) clarify things.
> 
> Requested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

LGTM. Just a couple of nitpicks below.

[...]

> + * Special state:
> + *
> + * System-calls and anything external will use task_rq_lock() which acquires
> + * both p->lock and rq->lock. As a consequence the state they change is stable

s/p->lock/p->pi_lock ?

> + * while holding either lock:
> + *
> + *  - sched_setaffinity():	p->cpus_ptr
> + *  - set_user_nice():		p->se.load, p->static_prio

Doesn't set_user_nice() also change p->prio and p->normal_prio, so
p->*prio ?

> + *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio, p->se.load,
> + *				p->dl.dl_{runtime, deadline, period, flags, bw, density}

p->rt_priority ?

> + *  - sched_setnuma():		p->numa_preferred_nid
> + *  - sched_move_task()/
> + *    cpu_cgroup_fork():	p->sched_task_group

maybe also: set_cpus_allowed_ptr() -> __set_cpus_allowed_ptr() (like
sched_setaffinity()) ?

[...]

> @@ -3134,8 +3274,12 @@ static inline void prepare_task(struct task_struct *next)
>  	/*
>  	 * Claim the task as running, we do this before switching to it
>  	 * such that any running task will have this set.
> +	 *
> +	 * __schedule()'s rq->lock and smp_mb__after_spin_lock() orders this
> +	 * store against prior state change of @next, also see
> +	 * try_to_wake_up(), specifically smp_load_acquire(&p->on_cpu).

s/smp_load_acquire/smp_cond_load_acquire ?

[...]
