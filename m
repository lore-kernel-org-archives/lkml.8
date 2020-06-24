Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1621EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0992088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLjQPUTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbgFXMMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbgFXMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:12:19 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jfy3MqPGlJhlX1mSUGSfZnXwkNS+Ecp54WS9QDzRF6g=; b=fLjQPUTkEBcuGPGkI5znFLO2Dn
        JK5oFSaiKPXt1DEVTCp5wEKAHKOL8HJrjz47mQmKCqQzo/ZmnaDyhL3tQnFe9alB7lks+L9mflZ1X
        JRrNUV2g8aGqpP+l1TyelcBE8ARTb4KqdUDq2Vy3de4HsB46SNK9ERfn+BYPVfv9FHzK7kMHVmUc4
        mDpSB/dHJOE96/vstiOLASAbOt6IbkBSyPDPNxAuM4cWQIlY0XuUyFG5+9jyHJsiDk1XYnVBqnvVc
        Xy+eVyhGh3m4Zk4AKtEXyMEwCeWrfsuzjTzh+/in84an6kV4uX46joLcIH5UZpC9FMe/jF28OF8Gc
        OFJrFNoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo4Ff-0002ix-Qv; Wed, 24 Jun 2020 12:11:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBC2B300261;
        Wed, 24 Jun 2020 14:11:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A46D720D94FED; Wed, 24 Jun 2020 14:11:36 +0200 (CEST)
Date:   Wed, 24 Jun 2020 14:11:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Julien Desfossez <ju@klipix.org>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
Message-ID: <20200624121136.GF4800@hirez.programming.kicks-ass.net>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619202516.7109-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:25:16PM -0400, Mathieu Desnoyers wrote:

> @@ -660,6 +685,13 @@ struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */
>  	unsigned int			cpu;
> +#endif
> +#ifdef CONFIG_SCHED_PAIR_CPU
> +	int				pair_cpu;
> +	struct kthread_work		pair_cpu_work;
> +	int				pair_cpu_need_worker;
> +	int				pair_cpu_worker_active;
> +	int				pair_cpu_queued_work;

That's bad layout.

>  #endif
>  	unsigned int			wakee_flips;
>  	unsigned long			wakee_flip_decay_ts;



> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8f360326861e..4f1ba8c7d292 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -39,6 +39,25 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> +#ifdef CONFIG_SCHED_PAIR_CPU
> +
> +#define MAX_SCHED_PAIR_CPU_WORK_NS	4000000		/* 4 ms */
> +
> +#define SCHED_PAIR_CPU_CMD_BITMASK	\
> +	(SCHED_PAIR_CPU_CMD_SET | SCHED_PAIR_CPU_CMD_CLEAR)
> +
> +struct pair_cpu {
> +	struct kthread_worker *worker;
> +	int cpu;				/* protected cpu */
> +	int worker_preempted;
> +	struct task_struct *running;
> +};
> +
> +static DEFINE_PER_CPU(struct pair_cpu, pair_cpu);

Probably wants to be in rq

> +static enum cpuhp_state pair_cpu_hp_online;
> +
> +#endif /* CONFIG_SCHED_PAIR_CPU */
> +
>  #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
>  /*
>   * Debugging: various feature bits
> @@ -1692,6 +1711,150 @@ int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
>  }
>  EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
>  
> +#ifdef CONFIG_SCHED_PAIR_CPU
> +
> +static void pair_cpu_preempt_ipi(void *data)
> +{
> +	trace_printk("pair_cpu_preempt_ipi on cpu %d task %p\n", smp_processor_id(), current);
> +	/*
> +	 * Order prior userspace memory accesses of local CPU with following
> +	 * remote userspace memory accesses.
> +	 */
> +	smp_mb();

After one reading, I'm still terminally confused what goes where. But I
think this is implied by the smp_call_function_single() you're using.

It does:

	csd->func();
	csd_unlock() := smp_store_release()

while the calling CPU does:

	csd_lock_wait() := smp_cond_load_acquire();


Also:

> +	set_tsk_need_resched(current);

that's set_bit(), which is an atomic operation. But it also isn't
sufficient, at the very least it needs set_preempt_need_resched(). Also
see resched_curr();

> +}


> +
> +static void pair_cpu_work_func(struct kthread_work *work)
> +{
> +	struct task_struct *task = container_of(work, struct task_struct,
> +						pair_cpu_work);
> +	int task_pair_cpu = READ_ONCE(task->pair_cpu);
> +	struct pair_cpu *cpum;
> +	ktime_t time_begin = ktime_get();
> +	bool timeout = false;
> +
> +	WARN_ON_ONCE(task_pair_cpu < 0);
> +	cpum = per_cpu_ptr(&pair_cpu, task_pair_cpu);
> +
> +	preempt_disable();
> +	/* Set worker active for task. */
> +	WRITE_ONCE(cpum->worker_preempted, 0);
> +	WRITE_ONCE(cpum->running, task);

I'm confused by this, we're the worker, and what is task?

> +	/*
> +	 * Order prior userspace memory accesses of local CPU with following
> +	 * remote userspace memory accesses.
> +	 */
> +	smp_mb();
> +	WRITE_ONCE(task->pair_cpu_worker_active, 1);

Don't we have smp_store_release() for that? Comment also fails to point
to pairing barrier.

> +	trace_printk("active from cpu %d task %p\n", smp_processor_id(), task);
> +	preempt_enable();
> +
> +	trace_printk("wakeup from cpu %d task %p\n", smp_processor_id(), task);
> +	/*
> +	 * Wake up target task.
> +	 */
> +	wake_up_process(task);

That comment is the canonical bad comment. It says abosolutely nothing
the code doesn't already say. Comment are supposed to clarify things
that are not obvious from the code, like wth task is and where it's
supposed to be blocked on. Why are we waking it now?

> +	/*
> +	 * Consume CPU time as long as an associated task is running on another
> +	 * CPU.
> +	 */
> +	while (READ_ONCE(task->pair_cpu_need_worker)
> +	       && !READ_ONCE(cpum->worker_preempted)
> +	       && task->state != TASK_DEAD) {
> +		timeout = ktime_sub(ktime_get(), time_begin) > MAX_SCHED_PAIR_CPU_WORK_NS;
> +		if (timeout)
> +			break;
> +		touch_softlockup_watchdog();
> +		cond_resched();
> +		cpu_relax();
> +	}

Why does it have a timeout? And this is a radically weird approach to
testing if @task is currently running. And if we're the worker, we can't
be preempted, per definition.

If we're supposed to soak up cycles while @task runs, wth does it allow
scheduling in this loop?

Basicaly I think this wants to be something like:

	while (READ_ONCE(task->on_cpu) && READ_ONCE(task->pair_cpu) == cpu)
		cpu_relax();

Nothing more, nothing less.

> +
> +	trace_printk("inactive from cpu %d task %p\n", smp_processor_id(), task);
> +	WRITE_ONCE(cpum->running, NULL);
> +	WRITE_ONCE(task->pair_cpu_worker_active, 0);
> +
> +	if (timeout) {
> +		/*
> +		 * If worker timed out, we need to preempt the associated task with
> +		 * an IPI. The IPI may fail if targetting an offline cpu. This implies
> +		 * that a preemption of the target task has happened since it ran on
> +		 * that cpu.
> +		 */
> +		int cpu = task_cpu(task);
> +
> +		trace_printk("worker timeout from cpu %d task %p task_cpu %d\n", smp_processor_id(), task, cpu);
> +		if (cpu >= 0)
> +			smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);

None of this makes sense; task_cpu() will always be >= 0, and if it
timed out, it can't be on an offline cpu, because offline CPUs don't run
tasks.

> +	}
> +
> +	/*
> +	 * Order prior userspace memory accesses of remote CPU with following
> +	 * local userspace memory accesses.
> +	 */
> +	smp_mb();

What?

> +
> +	put_task_struct(task);

That's an atomic with release semantics.

> +}
> +
> +void __sched_pair_cpu_handle_notify_resume(struct ksignal *sig,
> +					   struct pt_regs *regs)
> +{
> +	int task_pair_cpu = READ_ONCE(current->pair_cpu);
> +	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, task_pair_cpu);
> +
> +	WARN_ON_ONCE(task_pair_cpu < 0);
> +	preempt_disable();
> +	if (task_pair_cpu == smp_processor_id()) {
> +		WRITE_ONCE(current->pair_cpu_need_worker, 0);
> +		preempt_enable();
> +		if (current->pair_cpu_queued_work) {
> +			if (kthread_cancel_work_sync(&current->pair_cpu_work))
> +				put_task_struct(current);
> +			current->pair_cpu_queued_work = 0;
> +		}

Why do we need pair_cpu_queued_work ? Can't we see that from
pair_cpu_work state itself?

> +		trace_printk("notify resume run same cpu for cpu %d from task %p\n", task_pair_cpu,
> +		       current);
> +		return;
> +	}
> +	if (READ_ONCE(current->pair_cpu_worker_active)) {
> +		preempt_enable();
> +		trace_printk("notify resume run diff cpu for cpu %d from task %p\n", task_pair_cpu,
> +		       current);
> +		/*
> +		 *
> +		 * Order prior userspace memory accesses of remote CPU with
> +		 * following local userspace memory accesses.
> +		 */
> +		smp_mb();

smp_load_acquire(->pair_cpu_worker_active);

> +		return;
> +	}


> +	preempt_enable();
> +
> +	if (current->pair_cpu_queued_work) {
> +		if (kthread_cancel_work_sync(&current->pair_cpu_work))
> +			put_task_struct(current);
> +		current->pair_cpu_queued_work = 0;
> +	}

Wait what ? You want it queued here, why waste cycles removing it.

> +
> +	preempt_disable();
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	trace_printk("notify resume block for cpu %d from task %p state 0x%lx\n", task_pair_cpu,
> +	       current, current->state);
> +	WARN_ON_ONCE(current->pair_cpu_worker_active);
> +	WRITE_ONCE(current->pair_cpu_need_worker, 1);
> +	get_task_struct(current);
> +	kthread_init_work(&current->pair_cpu_work, pair_cpu_work_func);
> +	kthread_queue_work(cpum->worker, &current->pair_cpu_work);
> +	current->pair_cpu_queued_work = 1;
> +	preempt_enable();
> +	schedule();

Did you consider spurious wakeups? A naked schedule() pretty much always
wrong. They need to come in loops and testing variables.

Basically this should be something like:

	rcu_wait_event(.., smp_load_acquire(&current->pair_cpu_worker_active),
			TASK_INTERRUPTIBLE);

> +	trace_printk("notify resume unblock for cpu %d from task %p state 0x%lx\n", task_pair_cpu,
> +	       current, current->state);
> +}

Also, I can't help but think this should've been a task_work.

> +
> +#endif /* CONFIG_SCHED_PAIR_CPU */
> +
>  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  {
>  #ifdef CONFIG_SCHED_DEBUG
> @@ -3181,6 +3344,99 @@ static inline void finish_lock_switch(struct rq *rq)
>  # define finish_arch_post_lock_switch()	do { } while (0)
>  #endif
>  
> +#ifdef CONFIG_SCHED_PAIR_CPU
> +
> +/*
> + * If we preempt the cpu mutex worker, we need to IPI the CPU
> + * running the thread currently associated to it before scheduling
> + * other tasks.
> + *
> + * This only targets pair_cpu worker for online cpus.
> + */
> +static void pair_cpu_finish_switch_worker(struct task_struct *prev)
> +{
> +	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, smp_processor_id());
> +	struct task_struct *running_task;
> +	int cpu;
> +
> +	if (!cpum->worker || prev != cpum->worker->task)
> +		return;
> +	running_task = READ_ONCE(cpum->running);
> +	if (!running_task)
> +		return;

You're doing this for _every_ context switch, the above is unconditional
new lines touched and a big no-no. Also see the performance regression
0day gifted you.

> +	WRITE_ONCE(cpum->worker_preempted, 1);
> +	WRITE_ONCE(running_task->pair_cpu_worker_active, 0);
> +	WRITE_ONCE(cpum->running, NULL);

I can't help but feel you have _way_ too much duplicate state.

> +	/*
> +	 * If worker was preempted, we need to preempt the associated task with
> +	 * an IPI. The IPI may fail if targetting an offline cpu. This implies
> +	 * that a preemption of the target task has happened since it ran on
> +	 * that cpu.
> +	 */
> +	cpu = task_cpu(running_task);
> +
> +	trace_printk("worker preempted from cpu %d task %p task_cpu %d\n", smp_processor_id(), running_task, cpu);
> +	if (cpu >= 0) {
> +		smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);
> +		/*
> +		 * Order prior userspace memory accesses of remote CPU with
> +		 * following local userspace memory accesses.
> +		 */
> +		smp_mb();

Already guaranteed by smp_call_function_single(), as explained earlier.

> +	}
> +}
> +
> +
> +static void pair_cpu_remote_mb(void *data)
> +{
> +       /*
> +        * Order prior userspace memory accesses of remote CPU with following
> +        * local userspace memory accesses.
> +        */
> +       smp_mb();

I think you can do without, see callsite.

> +}
> +
> +/*
> + * If we preempt a task currently associated with a cpu mutex worker,
> + * we need to tell the worker to stop using cpu time.
> + */
> +static void pair_cpu_finish_switch_task(struct task_struct *prev, long prev_state)
> +{
> +	int prev_pair_cpu;
> +
> +	prev_pair_cpu = READ_ONCE(prev->pair_cpu);
> +	if (prev_pair_cpu < 0 || !READ_ONCE(prev->pair_cpu_need_worker)
> +	    || !READ_ONCE(prev->pair_cpu_worker_active))
> +		return;

Again, you're doing this every context switch, touching memory we didn't
used to touch.

> +	/*
> +	* Order prior userspace memory accesses of local CPU with following
> +	* remote userspace memory accesses.
> +	*/
> +	smp_mb();

We're at the end of schedule; there is no way to get here without
already having done one of these since userspace.

> +	/*
> +	* IPI may fail if CPU is offlined, in which case the memory barrier
> +	* before the worker completes will suffice.
> +	*/
> +	smp_call_function_single(prev_pair_cpu, pair_cpu_remote_mb, NULL, 1);

per the .wait=1 you already have a remote store-release and local
load-acquire chain.

> +	WRITE_ONCE(prev->pair_cpu_worker_active, 0);
> +	WRITE_ONCE(prev->pair_cpu_need_worker, 0);
> +}
> +
> +static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
> +{
> +	pair_cpu_finish_switch_worker(prev);
> +	pair_cpu_finish_switch_task(prev, prev_state);
> +}
> +
> +#else /* CONFIG_SCHED_PAIR_CPU */
> +
> +static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
> +{
> +}
> +
> +#endif /* CONFIG_SCHED_PAIR_CPU */
> +
>  /**
>   * prepare_task_switch - prepare to switch tasks
>   * @rq: the runqueue preparing to switch
> @@ -3269,6 +3525,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	finish_lock_switch(rq);
>  	finish_arch_post_lock_switch();
>  	kcov_finish_switch(current);
> +	pair_cpu_finish_switch(prev, prev_state);

So you're adding a bunch of cacheline misses here

>  
>  	fire_sched_in_preempt_notifiers(current);
>  	/*
> @@ -4123,6 +4380,7 @@ static void __sched notrace __schedule(bool preempt)
>  	next = pick_next_task(rq, prev, &rf);
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
> +	sched_pair_cpu_preempt(prev);

And one here.

>  
>  	if (likely(prev != next)) {
>  		rq->nr_switches++;


I think if you use a task instead of a kthread_work things become much
simpler. Regardless, you have too much state which mightily confuses
things.

As with all the other approaches, I don't love this.. All of this
complexity is because sodding hotplug -- something that should really
never happen.

So you're proposing adding code to incredibly hot paths to compensate
for the absolute slowest path in the entire kernel, that can't be right.

Things I would hate less:

 - making open-files of /sys/devices/system/cpu/cpuN/online
   pin the hotplug state (yuck! :-)

 - make fcntl(F_*SIG) work on /sys/devices/system/cpu/cpuN/online such
   that we receive a signal when the state changes, and before userspace
   starts. The signal triggers rseq restart.

 - sched_setaffinity2() that includes a flags argument.

   with this it might be possible to expose a flag that allows
   userspace to affine to offline CPUs, with the promise that
   when the CPU goes online it will migrate the task before it
   starts running userspace. This migration triggers rseq restart.

I think the second probably has the best complexity:yuck ratio.
