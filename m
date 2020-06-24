Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA323C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F37820738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oWlSrYZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406112AbgFXSbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:31:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:39628 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405832AbgFXSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:31:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 47DCD2C3E50;
        Wed, 24 Jun 2020 14:31:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lAB4uXvAixEA; Wed, 24 Jun 2020 14:31:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E0D122C3D4D;
        Wed, 24 Jun 2020 14:31:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E0D122C3D4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593023493;
        bh=ex46BI9ETTL/BCzRdPw6lsqXqoFFIo+TQGQExtG3Mtw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oWlSrYZprvfiiNk7++RD0ri3eBaa6Y5yFee5ZagW8BD1D+aqKqmdAvn1jQ8LgyPOm
         4UdOpxMu/d1KJ3cdPhq8skAmLzpVrOT9C3xfWdYnLXurLTGJmTP+FnBTiCBfulEWcv
         DVvsWJQehQkG9FEmNOHumtPENetTI5Fb9H9suzQ4ZKb1r2iBiWxHWT/P8B647SloU0
         nHO52XVzwXGWa4eD+oIkIVWttuoS2XVeCwDzLsemjQmeWPPZXUOa8ggwGYOnk6TtS/
         3lGoi3VV0UK2isI451241YbXJd32BRwS0T1EnuVuBJlREyibvnQe0B/F+5qynCY5hx
         6ud0IinlMnKaQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LWF9hmxapiBM; Wed, 24 Jun 2020 14:31:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C29102C3F2F;
        Wed, 24 Jun 2020 14:31:33 -0400 (EDT)
Date:   Wed, 24 Jun 2020 14:31:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        paulmck <paulmck@kernel.org>, Julien Desfossez <ju@klipix.org>
Message-ID: <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200624121136.GF4800@hirez.programming.kicks-ass.net>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com> <20200624121136.GF4800@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: sched_pair_cpu: Introduce scheduler task pairing system call
Thread-Index: XRhW0jsK8rPwtRIr1IRE83MUHoJbwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 24, 2020, at 8:11 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Fri, Jun 19, 2020 at 04:25:16PM -0400, Mathieu Desnoyers wrote:
> 
>> @@ -660,6 +685,13 @@ struct task_struct {
>>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>>  	/* Current CPU: */
>>  	unsigned int			cpu;
>> +#endif
>> +#ifdef CONFIG_SCHED_PAIR_CPU
>> +	int				pair_cpu;
>> +	struct kthread_work		pair_cpu_work;
>> +	int				pair_cpu_need_worker;
>> +	int				pair_cpu_worker_active;
>> +	int				pair_cpu_queued_work;
> 
> That's bad layout.

Those should probably be moved to a bitmask instead, and also moved further
down in the task_struct so we don't take room which is usually taken by
scheduler fast-path cachelines.

But until now it was enough to show that it can at least survive testing. :)

> 
>>  #endif
>>  	unsigned int			wakee_flips;
>>  	unsigned long			wakee_flip_decay_ts;
> 
> 
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 8f360326861e..4f1ba8c7d292 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -39,6 +39,25 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>>  
>>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>>  
>> +#ifdef CONFIG_SCHED_PAIR_CPU
>> +
>> +#define MAX_SCHED_PAIR_CPU_WORK_NS	4000000		/* 4 ms */
>> +
>> +#define SCHED_PAIR_CPU_CMD_BITMASK	\
>> +	(SCHED_PAIR_CPU_CMD_SET | SCHED_PAIR_CPU_CMD_CLEAR)
>> +
>> +struct pair_cpu {
>> +	struct kthread_worker *worker;
>> +	int cpu;				/* protected cpu */
>> +	int worker_preempted;
>> +	struct task_struct *running;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct pair_cpu, pair_cpu);
> 
> Probably wants to be in rq

Good point! Will move it there.

> 
>> +static enum cpuhp_state pair_cpu_hp_online;
>> +
>> +#endif /* CONFIG_SCHED_PAIR_CPU */
>> +
>>  #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
>>  /*
>>   * Debugging: various feature bits
>> @@ -1692,6 +1711,150 @@ int set_cpus_allowed_ptr(struct task_struct *p, const
>> struct cpumask *new_mask)
>>  }
>>  EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
>>  
>> +#ifdef CONFIG_SCHED_PAIR_CPU
>> +
>> +static void pair_cpu_preempt_ipi(void *data)
>> +{
>> +	trace_printk("pair_cpu_preempt_ipi on cpu %d task %p\n", smp_processor_id(),
>> current);
>> +	/*
>> +	 * Order prior userspace memory accesses of local CPU with following
>> +	 * remote userspace memory accesses.
>> +	 */
>> +	smp_mb();
> 
> After one reading, I'm still terminally confused what goes where. But I
> think this is implied by the smp_call_function_single() you're using.
> 
> It does:
> 
>	csd->func();
>	csd_unlock() := smp_store_release()
> 
> while the calling CPU does:
> 
>	csd_lock_wait() := smp_cond_load_acquire();

Good point! The smp_mb is redundant with the needed acquire/release semantic
already provided by csd in this case.

> 
> 
> Also:
> 
>> +	set_tsk_need_resched(current);
> 
> that's set_bit(), which is an atomic operation. But it also isn't
> sufficient, at the very least it needs set_preempt_need_resched(). Also
> see resched_curr();

Indeed, set_preempt_need_resched is needed. I don't think I need to grab
the runqueue lock of the target CPU however, because any task migration would
guarantee that the task has been preempted.


> 
>> +}
> 
> 
>> +
>> +static void pair_cpu_work_func(struct kthread_work *work)
>> +{
>> +	struct task_struct *task = container_of(work, struct task_struct,
>> +						pair_cpu_work);
>> +	int task_pair_cpu = READ_ONCE(task->pair_cpu);
>> +	struct pair_cpu *cpum;
>> +	ktime_t time_begin = ktime_get();
>> +	bool timeout = false;
>> +
>> +	WARN_ON_ONCE(task_pair_cpu < 0);
>> +	cpum = per_cpu_ptr(&pair_cpu, task_pair_cpu);
>> +
>> +	preempt_disable();
>> +	/* Set worker active for task. */
>> +	WRITE_ONCE(cpum->worker_preempted, 0);
>> +	WRITE_ONCE(cpum->running, task);
> 
> I'm confused by this, we're the worker, and what is task?

The worker is the kernel worker thread affined to the CPU which
"owns" the per-cpu data.

The "task" is the task which invokes sched_pair_cpu() to be
paired with that CPU.

> 
>> +	/*
>> +	 * Order prior userspace memory accesses of local CPU with following
>> +	 * remote userspace memory accesses.
>> +	 */
>> +	smp_mb();
>> +	WRITE_ONCE(task->pair_cpu_worker_active, 1);
> 
> Don't we have smp_store_release() for that? Comment also fails to point
> to pairing barrier.

Indeed, I'll change those explicit smp_mb() into acquire/release of:

pair_cpu_need_worker: acquired by worker thread, released by paired task.
pair_cpu_worker_active: acquired by paired task, released by worker thread.

> 
>> +	trace_printk("active from cpu %d task %p\n", smp_processor_id(), task);
>> +	preempt_enable();
>> +
>> +	trace_printk("wakeup from cpu %d task %p\n", smp_processor_id(), task);
>> +	/*
>> +	 * Wake up target task.
>> +	 */
>> +	wake_up_process(task);
> 
> That comment is the canonical bad comment. It says abosolutely nothing
> the code doesn't already say. Comment are supposed to clarify things
> that are not obvious from the code, like wth task is and where it's
> supposed to be blocked on. Why are we waking it now?

Changing for:

        /*
         * The paired task has queued this kthread work and is blocked awaiting
         * for this thread to set "pair_cpu_worker_active" and awaken it.
         */
        wake_up_process(task);

> 
>> +	/*
>> +	 * Consume CPU time as long as an associated task is running on another
>> +	 * CPU.
>> +	 */
>> +	while (READ_ONCE(task->pair_cpu_need_worker)
>> +	       && !READ_ONCE(cpum->worker_preempted)
>> +	       && task->state != TASK_DEAD) {
>> +		timeout = ktime_sub(ktime_get(), time_begin) > MAX_SCHED_PAIR_CPU_WORK_NS;
>> +		if (timeout)
>> +			break;
>> +		touch_softlockup_watchdog();
>> +		cond_resched();
>> +		cpu_relax();
>> +	}
> 
> Why does it have a timeout?

The timeout is used to handle case where the kernel worker thread is handling
the per-cpu data of an offline CPU. In that peculiar case, the worker thread
will be running on a CPU which is not the offline CPU, so no preemption will
set the "worker_preempted" flag in the struct pair_cpu as long as the CPU is
offline. The timeout ensures that a single worker task does not stay arbitrarily
long as "current", and gets kicked away to leave room for other tasks which may
also need to access that offlined cpu's per-cpu data.

> And this is a radically weird approach to
> testing if @task is currently running. And if we're the worker, we can't
> be preempted, per definition.

Note that the "worker_preempted" test is really testing whether the _worker_
has been preempted.

If we are the worker, we _can_ and _should_ be preempted if something else
needs to be scheduled. We don't want to prevent more important tasks to run.

This implies that whatever the task calling sched_pair_cpu set/clear does
between set and clear to touch per-cpu data needs to be done with restartable
sequences, so the critical section is aborted if the task is preempted. Same
goes if the kworker thread is preempted: it preempts the paired task with an
IPI, which immediately prevents its user-space to touch the per-cpu data until
the kworker is scheduled back and picks the eventually re-queued work for
another round.

> 
> If we're supposed to soak up cycles while @task runs, wth does it allow
> scheduling in this loop?
> 
> Basicaly I think this wants to be something like:
> 
>	while (READ_ONCE(task->on_cpu) && READ_ONCE(task->pair_cpu) == cpu)
>		cpu_relax();
> 
> Nothing more, nothing less.

The semantic of what you propose is:

- Stop running as soon as @task is not running,
- Stop running as soon as @task is not paired with the cpu serviced by this worker thread.

The semantic I need is:

- Stop running as soon as @task does not need the worker thread,
- Stop running as soon as the worker thread is preempted,
- Stop running as soon as @task has exited,
- Stop running as soon as timeout is reached.

> 
>> +
>> +	trace_printk("inactive from cpu %d task %p\n", smp_processor_id(), task);
>> +	WRITE_ONCE(cpum->running, NULL);
>> +	WRITE_ONCE(task->pair_cpu_worker_active, 0);
>> +
>> +	if (timeout) {
>> +		/*
>> +		 * If worker timed out, we need to preempt the associated task with
>> +		 * an IPI. The IPI may fail if targetting an offline cpu. This implies
>> +		 * that a preemption of the target task has happened since it ran on
>> +		 * that cpu.
>> +		 */
>> +		int cpu = task_cpu(task);
>> +
>> +		trace_printk("worker timeout from cpu %d task %p task_cpu %d\n",
>> smp_processor_id(), task, cpu);
>> +		if (cpu >= 0)
>> +			smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);
> 
> None of this makes sense; task_cpu() will always be >= 0, and if it
> timed out, it can't be on an offline cpu, because offline CPUs don't run
> tasks.

There are three scenarios to consider here:

1) The kernel worker thread is handling a CPU which is offline: This explains the
   need for a "timeout", as discussed earlier.

2) The paired task was running on @cpu when task_cpu() is issued, but the CPU is
   concurrently going offline before we send the IPI: As the comment explains, the
   preemption of @task is required in order to allow its CPU to go offline makes the IPI
   redundant.

3) The paired task is blocked on @cpu in parallel with the timeout being reached by
   the worker thread: AFAIU this would cause cpu < 0. Again in this case, the task
   has been preempted, which means our IPI would be redundant.

> 
>> +	}
>> +
>> +	/*
>> +	 * Order prior userspace memory accesses of remote CPU with following
>> +	 * local userspace memory accesses.
>> +	 */
>> +	smp_mb();
> 
> What?
> 
>> +
>> +	put_task_struct(task);
> 
> That's an atomic with release semantics.

Good point.

Although the ordering is really provided by the following for
each scenario:

- pair_cpu_need_worker=0: I'm adding a smp_load_acquire() in the worker thread loop paired with
  smp_store_release() when the paired thread sets it to 0.
- timeout reached: the required smp_call_function_single to IPI the paired thread provides
  the acquire/release semantic.
- worker_preempted: pair_cpu_finish_switch_worker performs the IPI to the paired thread,
  which provides acquire/release semantic.
- task DEAD: there is nothing to order against anymore on the remote cpu.

> 
>> +}
>> +
>> +void __sched_pair_cpu_handle_notify_resume(struct ksignal *sig,
>> +					   struct pt_regs *regs)
>> +{
>> +	int task_pair_cpu = READ_ONCE(current->pair_cpu);
>> +	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, task_pair_cpu);
>> +
>> +	WARN_ON_ONCE(task_pair_cpu < 0);
>> +	preempt_disable();
>> +	if (task_pair_cpu == smp_processor_id()) {
>> +		WRITE_ONCE(current->pair_cpu_need_worker, 0);
>> +		preempt_enable();
>> +		if (current->pair_cpu_queued_work) {
>> +			if (kthread_cancel_work_sync(&current->pair_cpu_work))
>> +				put_task_struct(current);
>> +			current->pair_cpu_queued_work = 0;
>> +		}
> 
> Why do we need pair_cpu_queued_work ? Can't we see that from
> pair_cpu_work state itself?

Good point, I think I'll need the following changes to make it work:

- Initialize pair_cpu_work in sched_pair_cpu set, just before setting
  current->pair_cpu to a value >= 0. It could alternatively be done on
  every task creation, but I don't want to slow down a relatively common
  code path for the sake of a slow path (sched_pair_cpu).

AFAIU doing so would ensure we can issue kthread_cancel_work_sync() on the initialized
but non-queued work.

> 
>> +		trace_printk("notify resume run same cpu for cpu %d from task %p\n",
>> task_pair_cpu,
>> +		       current);
>> +		return;
>> +	}
>> +	if (READ_ONCE(current->pair_cpu_worker_active)) {
>> +		preempt_enable();
>> +		trace_printk("notify resume run diff cpu for cpu %d from task %p\n",
>> task_pair_cpu,
>> +		       current);
>> +		/*
>> +		 *
>> +		 * Order prior userspace memory accesses of remote CPU with
>> +		 * following local userspace memory accesses.
>> +		 */
>> +		smp_mb();
> 
> smp_load_acquire(->pair_cpu_worker_active);

Done.

> 
>> +		return;
>> +	}
> 
> 
>> +	preempt_enable();
>> +
>> +	if (current->pair_cpu_queued_work) {
>> +		if (kthread_cancel_work_sync(&current->pair_cpu_work))
>> +			put_task_struct(current);
>> +		current->pair_cpu_queued_work = 0;
>> +	}
> 
> Wait what ? You want it queued here, why waste cycles removing it.

I now notice that kthread_queue_work returns whether the work is already pending.
That's indeed all I need to check to know whether I need to get a reference to the
task struct. I'll remove this unneeded cancel work by using that scheme.

> 
>> +
>> +	preempt_disable();
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +	trace_printk("notify resume block for cpu %d from task %p state 0x%lx\n",
>> task_pair_cpu,
>> +	       current, current->state);
>> +	WARN_ON_ONCE(current->pair_cpu_worker_active);
>> +	WRITE_ONCE(current->pair_cpu_need_worker, 1);
>> +	get_task_struct(current);
>> +	kthread_init_work(&current->pair_cpu_work, pair_cpu_work_func);
>> +	kthread_queue_work(cpum->worker, &current->pair_cpu_work);
>> +	current->pair_cpu_queued_work = 1;
>> +	preempt_enable();
>> +	schedule();
> 
> Did you consider spurious wakeups? A naked schedule() pretty much always
> wrong. They need to come in loops and testing variables.
> 
> Basically this should be something like:
> 
>	rcu_wait_event(.., smp_load_acquire(&current->pair_cpu_worker_active),
>			TASK_INTERRUPTIBLE);

This schedule() is already in a loop: __sched_pair_cpu_handle_notify_resume()
is called from exit_to_usermode_loop().

The state which gets tested on each loop is:

- whether the current task is now running on the paired cpu (task_pair_cpu == smp_processor_id())
- whether current->pair_cpu_worker_active == 1
- else, set current task state as TASK_INTERRUPTIBLE, indicate that it needs the worker thread,
  and queue work before calling schedule.

If a spurious wakeup happens, this will cause the entire function __sched_pair_cpu_handle_notify_resume
to be called again by exit_to_usermode_loop because our call to schedule() will have set the
_TIF_NOTIFY_RESUME thread flag (see sched_pair_cpu_preempt() invoked very early in schedule).

I suspect I should be more clever about sched_pair_cpu_preempt(). Rather than placing it
right in middle of an extremely hot path in the scheduler, I should rather do:

- Set _TIF_NOTIFY_RESUME flag for current->pair_cpu >= 0 in finish task switch,
- Also set it right after the call to schedule() in __sched_pair_cpu_handle_notify_resume,
- Also set it in pair_cpu_preempt_ipi().

> 
>> +	trace_printk("notify resume unblock for cpu %d from task %p state 0x%lx\n",
>> task_pair_cpu,
>> +	       current, current->state);
>> +}
> 
> Also, I can't help but think this should've been a task_work.

"queuing" that work is needed from IPI context and from finish task switch.
As long as we can queue task_work from atomic context, we could indeed use
that instead. The struct callback_head would sit in the task struct.

Doing that change means that I cannot rely on the return to usermode loop
to call this again after schedule, so I should put that in a loop myself.

> 
>> +
>> +#endif /* CONFIG_SCHED_PAIR_CPU */
>> +
>>  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>>  {
>>  #ifdef CONFIG_SCHED_DEBUG
>> @@ -3181,6 +3344,99 @@ static inline void finish_lock_switch(struct rq *rq)
>>  # define finish_arch_post_lock_switch()	do { } while (0)
>>  #endif
>>  
>> +#ifdef CONFIG_SCHED_PAIR_CPU
>> +
>> +/*
>> + * If we preempt the cpu mutex worker, we need to IPI the CPU
>> + * running the thread currently associated to it before scheduling
>> + * other tasks.
>> + *
>> + * This only targets pair_cpu worker for online cpus.
>> + */
>> +static void pair_cpu_finish_switch_worker(struct task_struct *prev)
>> +{
>> +	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, smp_processor_id());
>> +	struct task_struct *running_task;
>> +	int cpu;
>> +
>> +	if (!cpum->worker || prev != cpum->worker->task)
>> +		return;
>> +	running_task = READ_ONCE(cpum->running);
>> +	if (!running_task)
>> +		return;
> 
> You're doing this for _every_ context switch, the above is unconditional
> new lines touched and a big no-no.

The only state I need to check here is whether the scheduler is preempting a
thread which is a pair-cpu kworker thread. This could be a simple
flag within an already cache-hot cacheline in the task struct. The rest
then becomes a slow-path.

Would that solve your performance concern ?

> Also see the performance regression 0day gifted you.

Yes, I've seen it. I suspect it's because of the location where I added the
new pair_cpu fields in the task struct. I think I'm kicking out cache-hot
fields into additional cache lines. AFAIU moving my pair_cpu fields further
down in the task struct should solve this.

> 
>> +	WRITE_ONCE(cpum->worker_preempted, 1);
>> +	WRITE_ONCE(running_task->pair_cpu_worker_active, 0);
>> +	WRITE_ONCE(cpum->running, NULL);
> 
> I can't help but feel you have _way_ too much duplicate state.

Let's do one round of addressing your feedback and respinning the
patch, then it will be easier to look into shrinking duplicate state.

> 
>> +	/*
>> +	 * If worker was preempted, we need to preempt the associated task with
>> +	 * an IPI. The IPI may fail if targetting an offline cpu. This implies
>> +	 * that a preemption of the target task has happened since it ran on
>> +	 * that cpu.
>> +	 */
>> +	cpu = task_cpu(running_task);
>> +
>> +	trace_printk("worker preempted from cpu %d task %p task_cpu %d\n",
>> smp_processor_id(), running_task, cpu);
>> +	if (cpu >= 0) {
>> +		smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);
>> +		/*
>> +		 * Order prior userspace memory accesses of remote CPU with
>> +		 * following local userspace memory accesses.
>> +		 */
>> +		smp_mb();
> 
> Already guaranteed by smp_call_function_single(), as explained earlier.

Yep. Fixed.

> 
>> +	}
>> +}
>> +
>> +
>> +static void pair_cpu_remote_mb(void *data)
>> +{
>> +       /*
>> +        * Order prior userspace memory accesses of remote CPU with following
>> +        * local userspace memory accesses.
>> +        */
>> +       smp_mb();
> 
> I think you can do without, see callsite.

I do not think csd provides the right ordering in this case: the acquire/release
chain we get from .wait=1 pairs release on the ipi handler with acquire on the caller. What
we need here is to pair an acquire on the ipi handler with a release on the caller,
which is the opposite.

I clarified this comment:

+        * Order prior userspace memory accesses of caller CPU with following
+        * userspace memory accesses on the CPU running this handler. This is
+        * paired with a memory barrier at the beginning of scheduling.

> 
>> +}
>> +
>> +/*
>> + * If we preempt a task currently associated with a cpu mutex worker,
>> + * we need to tell the worker to stop using cpu time.
>> + */
>> +static void pair_cpu_finish_switch_task(struct task_struct *prev, long
>> prev_state)
>> +{
>> +	int prev_pair_cpu;
>> +
>> +	prev_pair_cpu = READ_ONCE(prev->pair_cpu);
>> +	if (prev_pair_cpu < 0 || !READ_ONCE(prev->pair_cpu_need_worker)
>> +	    || !READ_ONCE(prev->pair_cpu_worker_active))
>> +		return;
> 
> Again, you're doing this every context switch, touching memory we didn't
> used to touch.

Same argument about placing this in a single "hot path" flag in the task struct.
Would that address your performance concerns ?

> 
>> +	/*
>> +	* Order prior userspace memory accesses of local CPU with following
>> +	* remote userspace memory accesses.
>> +	*/
>> +	smp_mb();
> 
> We're at the end of schedule; there is no way to get here without
> already having done one of these since userspace.

Good point, so this memory barrier can go away, but not the one within
pair_cpu_remote_mb.

> 
>> +	/*
>> +	* IPI may fail if CPU is offlined, in which case the memory barrier
>> +	* before the worker completes will suffice.
>> +	*/
>> +	smp_call_function_single(prev_pair_cpu, pair_cpu_remote_mb, NULL, 1);
> 
> per the .wait=1 you already have a remote store-release and local
> load-acquire chain.

As explained above, we need the opposite acquire/release order in this case.

> 
>> +	WRITE_ONCE(prev->pair_cpu_worker_active, 0);
>> +	WRITE_ONCE(prev->pair_cpu_need_worker, 0);
>> +}
>> +
>> +static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
>> +{
>> +	pair_cpu_finish_switch_worker(prev);
>> +	pair_cpu_finish_switch_task(prev, prev_state);
>> +}
>> +
>> +#else /* CONFIG_SCHED_PAIR_CPU */
>> +
>> +static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_SCHED_PAIR_CPU */
>> +
>>  /**
>>   * prepare_task_switch - prepare to switch tasks
>>   * @rq: the runqueue preparing to switch
>> @@ -3269,6 +3525,7 @@ static struct rq *finish_task_switch(struct task_struct
>> *prev)
>>  	finish_lock_switch(rq);
>>  	finish_arch_post_lock_switch();
>>  	kcov_finish_switch(current);
>> +	pair_cpu_finish_switch(prev, prev_state);
> 
> So you're adding a bunch of cacheline misses here

It could be turned into a task struct flag test instead.

> 
>>  
>>  	fire_sched_in_preempt_notifiers(current);
>>  	/*
>> @@ -4123,6 +4380,7 @@ static void __sched notrace __schedule(bool preempt)
>>  	next = pick_next_task(rq, prev, &rf);
>>  	clear_tsk_need_resched(prev);
>>  	clear_preempt_need_resched();
>> +	sched_pair_cpu_preempt(prev);
> 
> And one here.

This one can entirely go away as discussed further up.

> 
>>  
>>  	if (likely(prev != next)) {
>>  		rq->nr_switches++;
> 
> 
> I think if you use a task instead of a kthread_work things become much
> simpler. Regardless, you have too much state which mightily confuses
> things.

Do you mean "use a task_work" or really "use a task" ?

AFAIU task_work would only replace the custom return to usermode handler
I implemented.

I used a kthread_work to eliminate the need to re-implement the work
handling logic. What would be the benefit of using a task rather than
kthread_work here ?

> As with all the other approaches, I don't love this.. All of this
> complexity is because sodding hotplug -- something that should really
> never happen.

Actually, it's not only hotplug. It's hotplug _and_ cgroup cpusets.

> 
> So you're proposing adding code to incredibly hot paths to compensate
> for the absolute slowest path in the entire kernel, that can't be right.

As I said above, I'm pretty sure we could optimize the addition to those
hot paths to almost nothing.

> Things I would hate less:
> 
> - making open-files of /sys/devices/system/cpu/cpuN/online
>   pin the hotplug state (yuck! :-)

I don't see this being available to non-root users, nor to containerized
environments. Also, it would not handle cgroup cpusets.

> - make fcntl(F_*SIG) work on /sys/devices/system/cpu/cpuN/online such
>   that we receive a signal when the state changes, and before userspace
>   starts. The signal triggers rseq restart.

Just knowing a CPU is offline is not enough. We then need to be able to
synchronize concurrent updates to that per-CPU data structure while the
CPU is offline, in a way which is also safe against that CPU coming back
online again.

Also it does not solve the issues associated with cgroup cpusets, where
a CPU may very well be online, but not part of our thread's allowed cpu
mask.

> 
> - sched_setaffinity2() that includes a flags argument.
> 
>   with this it might be possible to expose a flag that allows
>   userspace to affine to offline CPUs, with the promise that
>   when the CPU goes online it will migrate the task before it
>   starts running userspace. This migration triggers rseq restart.

This is very similar to the earlier "pin_on_cpu" system call I proposed.
Note that it would also need to serialize execution of all threads which
are affined to that offline cpu, so concurrent updates to an offlined
cpu per-cpu data don't corrupt each other.

While we can make the hotplug case work, the main issue remaining with
that approach is interaction with cgroup cpusets. What should we do when
migration to the requested CPU is disallowed by cgroups ? Note that this
cpuset change can be triggered by an external "manager" process concurrently.

We do not want to override the affinity restricted by cgroups because
we don't want to hurt performance characteristics of another partition
of the system.

The sched_pair_cpu approach has the benefit of allowing us to touch
per-cpu data of a given CPU without requiring to run on that CPU, which
ensures that we do not thrash the cpu cache of cpus on which a thread
is not allowed to run. It takes care of issues caused by both cgroup
cpusets and cpu hotplug.

> 
> I think the second probably has the best complexity:yuck ratio.

Unfortunately the cgroup cpuset issues are not taken into account by
the 3 approaches you propose above. Those added constraints are what
motivated me to implement the sched_pair_cpu system call.

Thanks Peter for the thorough review,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
