Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B58C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2831620772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGBSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:39:24 -0400
Received: from foss.arm.com ([217.140.110.172]:52470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgGBSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:39:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4CBE1FB;
        Thu,  2 Jul 2020 11:39:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E5D3F71E;
        Thu,  2 Jul 2020 11:39:21 -0700 (PDT)
References: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        Oleg Nesterov <oleg@redhat.com>, david@fromorbit.com
Subject: Re: [RFC][PATCH] sched: Better document ttwu()
In-reply-to: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
Date:   Thu, 02 Jul 2020 19:39:16 +0100
Message-ID: <jhjd05d92y3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 02/07/20 13:52, Peter Zijlstra wrote:
> Dave hit the problem fixed by commit:
>
>   b6e13e85829f ("sched/core: Fix ttwu() race")
>
> and failed to understand much of the code involved. Per his request a
> few comments to (hopefully) clarify things.
>

All of the below is already tremendously helpful! I remember it took me
quite some time to figure out e.g. how we could observe p->on_cpu &&
!p->on_rq and why we cared about it in ttwu(). On the bright side, I'm
happy that my notes aren't completely off - there may be hope for me yet.

Have some small comments below.

> Requested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h |  12 ++--
>  kernel/sched/core.c   | 195 +++++++++++++++++++++++++++++++++++++++++++-------
>  kernel/sched/sched.h  |  11 +++
>  3 files changed, 187 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9bd073a10224..ad36f70bef24 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
[...]
> + * Special state:
> + *
> + * System-calls and anything external will use task_rq_lock() which acquires
> + * both p->lock and rq->lock. As a consequence the state they change is stable
> + * while holding either lock:
> + *
> + *  - sched_setaffinity():	p->cpus_ptr
> + *  - set_user_nice():		p->se.load, p->static_prio
> + *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio, p->se.load,
> + *				p->dl.dl_{runtime, deadline, period, flags, bw, density}

Only extra thing that comes to mind is p->uclamp*; dunno how exhaustive you
want this list to be.

> + *  - sched_setnuma():		p->numa_preferred_nid
> + *  - sched_move_task()/
> + *    cpu_cgroup_fork():	p->sched_task_group
> + *
> + * p->state <- TASK_*:
> + *
> + *   is changed locklessly using set_current_state(), __set_current_state() or
> + *   set_special_state(), see their respective comments, or by
> + *   try_to_wake_up(). This latter uses p->pi_lock to serialize against
> + *   concurrent self.
> + *
> + * p->on_rq <- { 0, 1 = TASK_ON_RQ_QUEUED, 2 = TASK_ON_RQ_MIGRATING }:
> + *
> + *   is set by activate_task() and cleared by deactivate_task(), under
> + *   rq->lock. Non-zero indicates the task is runnable, the special
> + *   ON_RQ_MIGRATING state is used for migration without holding both
> + *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
> + *
> + * p->on_cpu <- { 0, 1 }:
> + *
> + *   is set by prepare_task() and cleared by finish_task() such that it will be
> + *   set before p is scheduled-in and cleared after p is scheduled-out, both
> + *   under rq->lock. Non-zero indicates the task is running on it's CPU.
> + *
> + *   [ The astute reader will observe that it is possible for two tasks on one
> + *     CPU to have ->on_cpu = 1 at the same time. ]
> + *
> + * task_cpu(p): is changed by set_task_cpu(), the rules are:
> + *
> + *  - Don't call set_task_cpu() on a blocked task:
> + *
> + *    We don't care what CPU we're not running on, this simplifies hotplug,
> + *    the CPU assignment of blocked tasks isn't required to be valid.
> + *

That's more of a good practice rather than a hard rule, right? We do that
with proxy execution (the whole migrate to owner's rq thing), at least in
its current shape.

> + *  - for try_to_wake_up(), called under p->pi_lock:
> + *
> + *    This allows try_to_wake_up() to only take one rq->lock, see its comment.
> + *
> + *  - for migration called under rq->lock:
> + *    [ see task_on_rq_migrating() in task_rq_lock() ]
> + *
> + *    o move_queued_task()
> + *    o __migrate_swap_task()

Isn't that one under double_rq_lock()?

> + *    o detach_task()
> + *
> + *  - for migration called under double_rq_lock():
> + *
> + *    o push_rt_task() / pull_rt_task()
> + *    o push_dl_task() / pull_dl_task()
> + *    o dl_task_offline_migration()
> + *
> + */
> +
>  /*
>   * __task_rq_lock - lock the rq @p resides on.
>   */
[...]
>  }
>
>  /*
> - * Called in case the task @p isn't fully descheduled from its runqueue,
> - * in this case we must do a remote wakeup. Its a 'light' wakeup though,
> - * since all we need to do is flip p->state to TASK_RUNNING, since
> - * the task is still ->on_rq.
> + * Consider @p being inside a wait loop:
> + *
> + *   for (;;) {
> + *           set_current_state(TASK_UNINTERRUPTIBLE);
> + *
> + *           if (CONDITION)
> + *         break;

For some reason the alignment is off in my mail view, but looks okay once
applied.

> + *
> + *           schedule();
> + *   }
> + *   __set_current_state(TASK_RUNNING);
> + *
> + * between set_current_state() and schedule(). In this case @p is still
> + * runnable, so all that needs doing is change p->state back to TASK_RUNNING in
> + * an atomic manner.
> + *

Sorry if I'm being dense; don't you mean "running" here? If it stops being
current inbetween set_current_state() and schedule(), __schedule() will
deactivate() it, so AFAICT it can only be either running or deactivated.

> + * By taking task_rq(p)->lock we serialize against schedule(), if @p->on_rq
> + * then schedule() must still happen and p->state can be changed to
> + * TASK_RUNNING. Otherwise we lost the race, schedule() has happened, and we
> + * need to do a full wakeup with enqueue.
> + *
> + * Returns: %true when the wakeup is done,
> + *          %false otherwise.
>   */
> -static int ttwu_remote(struct task_struct *p, int wake_flags)
> +static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  {
>       struct rq_flags rf;
>       struct rq *rq;
[...]
> @@ -2494,15 +2608,41 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>   * @state: the mask of task states that can be woken
>   * @wake_flags: wake modifier flags (WF_*)
>   *
> - * If (@state & @p->state) @p->state = TASK_RUNNING.
> + * Conceptually does:
> + *
> + *   If (@state & @p->state) @p->state = TASK_RUNNING.
>   *
>   * If the task was not queued/runnable, also place it back on a runqueue.
>   *
> - * Atomic against schedule() which would dequeue a task, also see
> - * set_current_state().
> + * This function:
> + *  - is atomic against schedule() which would dequeue the task;
> + *  - issues a full memory barrier before accessing @p->state.
> + * See the comment with set_current_state().
> + *
> + * Uses p->pi_lock to serialize against concurrent wake-ups.
> + *
> + * Relies on p->pi_lock stabilizing:
> + *  - p->sched_class
> + *  - p->cpus_ptr
> + *  - p->sched_task_group
> + * in order to do migration, see its use of select_task_rq()/set_task_cpu().
>   *
> - * This function executes a full memory barrier before accessing the task
> - * state; see set_current_state().
> + * Tries really hard to only take one task_rq(p)->lock for performance.
> + * Takes rq->lock in:
> + *  - ttwu_runnable()    -- old rq, unavoidable, see comment there;
> + *  - ttwu_queue()       -- new rq, for enqueue of the task;
> + *  - psi_ttwu_dequeue() -- much sadness :-( accounting will kill us.
> + *
> + * As a concequence we race really badly with just about everything. See the

s/concequence/consequence/

> + * many memory barriers and their comments for details. The basic order of
> + * reading things is:
> + *
> + *   LOAD p->state
> + *   RMB
> + *   LOAD p->on_rq
> + *   RMB
> + *   LOAD-ACQUIRE p->on_cpu
> + *   LOAD task_cpu()
>   *
>   * Return: %true if @p->state changes (an actual wakeup was done),
>   *	   %false otherwise.
> @@ -2518,7 +2658,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>               /*
>                * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
>                * == smp_processor_id()'. Together this means we can special
> -		 * case the whole 'p->on_rq && ttwu_remote()' case below
> +		 * case the whole 'p->on_rq && ttwu_runnable()' case below
>                * without taking any locks.
>                *
>                * In particular:
> @@ -2539,8 +2679,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>       /*
>        * If we are going to wake up a thread waiting for CONDITION we
>        * need to ensure that CONDITION=1 done by the caller can not be
> -	 * reordered with p->state check below. This pairs with mb() in
> -	 * set_current_state() the waiting thread does.
> +	 * reordered with p->state check below. This pairs with smp_store_mb()
> +	 * in set_current_state() that the waiting thread does.
>        */
>       raw_spin_lock_irqsave(&p->pi_lock, flags);
>       smp_mb__after_spinlock();
> @@ -2575,7 +2715,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>        * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
>        */
>       smp_rmb();
> -	if (p->on_rq && ttwu_remote(p, wake_flags))
> +	if (p->on_rq && ttwu_runnable(p, wake_flags))
>               goto unlock;
>
>       if (p->in_iowait) {
> @@ -3134,8 +3274,12 @@ static inline void prepare_task(struct task_struct *next)
>       /*
>        * Claim the task as running, we do this before switching to it
>        * such that any running task will have this set.
> +	 *
> +	 * __schedule()'s rq->lock and smp_mb__after_spin_lock() orders this
> +	 * store against prior state change of @next, also see
> +	 * try_to_wake_up(), specifically smp_load_acquire(&p->on_cpu).

smp_*cond*_load_acquire(&p->on_cpu, <blah>)

>        */
> -	next->on_cpu = 1;
> +	WRITE_ONCE(next->on_cpu, 1);
>  #endif
>  }
>
> @@ -3143,8 +3287,9 @@ static inline void finish_task(struct task_struct *prev)
>  {
>  #ifdef CONFIG_SMP
>       /*
> -	 * After ->on_cpu is cleared, the task can be moved to a different CPU.
> -	 * We must ensure this doesn't happen until the switch is completely
> +	 * This must be the very last reference to @prev from this CPU. After
> +	 * p->on_cpu is cleared, the task can be moved to a different CPU. We
> +	 * must ensure this doesn't happen until the switch is completely
>        * finished.
>        *
>        * In particular, the load of prev->state in finish_task_switch() must
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5aa6661ecaf1..73c0c5d0034b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1197,6 +1197,17 @@ struct rq_flags {
>  #endif
>  };
>
> +/*
> + * Lockdep annotation that avoid accidental unlock; any
> + * raw_spin_unlock(&rq->lock) without preceding rq_unpin_lock() with the
> + * correct cookie will result in a WARN.
> + *

ISTR that being described (by yourself?) as a "sticky/continuous
lockdep_assert_held()", which I think gets the point across.

> + * This avoids code that has access to 'struct rq *rq' (basically everything in
> + * the scheduler) from accidentally unlocking the rq if they do not also have a
> + * copy of the (on-stack) 'struct rq_flags rf'.
> + *
> + * Also see Documentation/locking/lockdep-design.rst.
> + */
>  static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>  {
>       rf->cookie = lockdep_pin_lock(&rq->lock);
