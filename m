Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE5EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4467C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgIKMWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:22:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgIKMRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:17:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99F7A113E;
        Fri, 11 Sep 2020 05:17:48 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6333F68F;
        Fri, 11 Sep 2020 05:17:47 -0700 (PDT)
References: <20200911081745.214686199@infradead.org> <20200911082536.528661716@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        Vincent Donnefort <Vincent.Donnefort@arm.com>
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run during hotplug
In-reply-to: <20200911082536.528661716@infradead.org>
Date:   Fri, 11 Sep 2020 13:17:45 +0100
Message-ID: <jhjr1r85wye.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(+Cc VincentD, who's been looking at some of this)

On 11/09/20 09:17, Peter Zijlstra wrote:
> In preparation for migrate_disable(), make sure only per-cpu kthreads
> are allowed to run on !active CPUs.
>
> This is ran (as one of the very first steps) from the cpu-hotplug
> task which is a per-cpu kthread and completion of the hotplug
> operation only requires such tasks.
>
> This contraint enables the migrate_disable() implementation to wait

s/contraint/constraint/

> for completion of all migrate_disable regions on this CPU at hotplug
> time without fear of any new ones starting.
>
> This replaces the unlikely(rq->balance_callbacks) test at the tail of
> context_switch with an unlikely(rq->balance_work), the fast path is
> not affected.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h |    5 ++
>  2 files changed, 106 insertions(+), 2 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6836,6 +6849,87 @@ static void migrate_tasks(struct rq *dea
>
>       rq->stop = stop;
>  }
> +
> +static int __balance_push_stop(void *arg)

__balance_push_cpu_stop()? _cpu_stop() seems to be the usual suffix.

> +{
> +	struct task_struct *p = arg;
> +	struct rq *rq = this_rq();
> +	struct rq_flags rf;
> +	int cpu;
> +
> +	raw_spin_lock_irq(&p->pi_lock);
> +	rq_lock(rq, &rf);
> +
> +	if (task_rq(p) == rq && task_on_rq_queued(p)) {
> +		cpu = select_fallback_rq(rq->cpu, p);
> +		rq = __migrate_task(rq, &rf, p, cpu);
> +	}
> +
> +	rq_unlock(rq, &rf);
> +	raw_spin_unlock_irq(&p->pi_lock);
> +
> +	put_task_struct(p);
> +
> +	return 0;
> +}
> +
> +static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
> +
> +/*
> + * Ensure we only run per-cpu kthreads once the CPU goes !active.
> + */
> +static bool balance_push(struct rq *rq)
> +{
> +	struct task_struct *push_task = rq->curr;
> +
> +	lockdep_assert_held(&rq->lock);
> +	SCHED_WARN_ON(rq->cpu != smp_processor_id());
> +
> +	/*
> +	 * Both the cpu-hotplug and stop task are in this class and are
> +	 * required to complete the hotplug process.

Nit: s/class/case/? I can't not read "class" as "sched_class", and
those two are *not* in the same sched_class, and confusion ensues.

> +	 */
> +	if (is_per_cpu_kthread(push_task))
> +		return false;
> +
> +	get_task_struct(push_task);
> +	/*
> +	 * Temporarily drop rq->lock such that we can wake-up the stop task.
> +	 * Both preemption and IRQs are still disabled.
> +	 */
> +	raw_spin_unlock(&rq->lock);
> +	stop_one_cpu_nowait(rq->cpu, __balance_push_stop, push_task,
> +			    this_cpu_ptr(&push_work));
> +	/*
> +	 * At this point need_resched() is true and we'll take the loop in
> +	 * schedule(). The next pick is obviously going to be the stop task
> +	 * which is_per_cpu_kthread() and will push this task away.
> +	 */
> +	raw_spin_lock(&rq->lock);
> +
> +	return true;
> +}
> +
> @@ -6968,6 +7064,8 @@ int sched_cpu_deactivate(unsigned int cp
>        */
>       synchronize_rcu();
>
> +	balance_push_set(cpu, true);
> +

IIUC this is going to make every subsequent finish_lock_switch()
migrate the switched-to task if it isn't a pcpu kthread. So this is going
to lead to a dance of

switch_to(<task0>) -> switch_to(<stopper>) -> switch_to(<task1>) -> switch_to(<stopper>) ...

Wouldn't it be better to batch all those in a migrate_tasks() sibling that
skips pcpu kthreads?

>  #ifdef CONFIG_SCHED_SMT
>       /*
>        * When going down, decrement the number of cores with SMT present.
