Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFCBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6389F20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FS83lsIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405626AbgFYO4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:56:40 -0400
Received: from mail.efficios.com ([167.114.26.124]:46788 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405340AbgFYO4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:56:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9C0D02CB43B;
        Thu, 25 Jun 2020 10:56:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rZpe1Y_wGJPD; Thu, 25 Jun 2020 10:56:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AB0272CB263;
        Thu, 25 Jun 2020 10:56:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AB0272CB263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593096995;
        bh=Y7yOFBtsJX/mxNuN0Qh1BxfaPpf27Jmq6TKM4dXLIz4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FS83lsIc0kwcvJP1dJgoAwKkWgKoImiXRmUCVfSDaXTf2FnLNMLs7ubpm2Qgyaseg
         OqeR604jmB6sSGgFQZoRuQ2/KT9/Hteuj4vaOqAe7/Qi+hR0vHLayzr9hva+LXl20s
         iyKegIst6/1OqBLfgXcUNIsct2tFMf5QpbX3AJx7++dAkct4k77YvYjZ3WtLW2SdEl
         inU1OUFFwcssU3QV7x3MFYQXE4popdg7w/sbKNn6nNdSHw+SF/9CPAWF+tInUUcJOn
         DVdKD4Xv+FSGkbTdmb16lSh/S7dlquYLmlUi9XoOY+D97Jim8D0Vx2qf3fSPH3mKJB
         AZwxNwk2RMidA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kQDg4OcWMXYk; Thu, 25 Jun 2020 10:56:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8EC892CB68A;
        Thu, 25 Jun 2020 10:56:35 -0400 (EDT)
Date:   Thu, 25 Jun 2020 10:56:35 -0400 (EDT)
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
Message-ID: <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200624195030.GG4800@hirez.programming.kicks-ass.net>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com> <20200624121136.GF4800@hirez.programming.kicks-ass.net> <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com> <20200624195030.GG4800@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: sched_pair_cpu: Introduce scheduler task pairing system call
Thread-Index: KKF2EJ/UOyY4CnhVA6NZtcIQEi8jPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 24, 2020, at 3:50 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Jun 24, 2020 at 02:31:33PM -0400, Mathieu Desnoyers wrote:
> 
[...]
> 
>> >> +	/*
>> >> +	 * Consume CPU time as long as an associated task is running on another
>> >> +	 * CPU.
>> >> +	 */
>> >> +	while (READ_ONCE(task->pair_cpu_need_worker)
>> >> +	       && !READ_ONCE(cpum->worker_preempted)
>> >> +	       && task->state != TASK_DEAD) {
>> >> +		timeout = ktime_sub(ktime_get(), time_begin) > MAX_SCHED_PAIR_CPU_WORK_NS;
>> >> +		if (timeout)
>> >> +			break;
>> >> +		touch_softlockup_watchdog();
>> >> +		cond_resched();
>> >> +		cpu_relax();
>> >> +	}
>> > 
>> > Why does it have a timeout?
>> 
>> The timeout is used to handle case where the kernel worker thread is handling
>> the per-cpu data of an offline CPU. In that peculiar case, the worker thread
>> will be running on a CPU which is not the offline CPU, so no preemption will
>> set the "worker_preempted" flag in the struct pair_cpu as long as the CPU is
>> offline. The timeout ensures that a single worker task does not stay arbitrarily
>> long as "current", and gets kicked away to leave room for other tasks which may
>> also need to access that offlined cpu's per-cpu data.
> 
> But if the CPU is offline, you don't actually need to do anything. So
> that seems unfortunate.

Quite the opposite: if the CPU is offline, we need to serialize all tasks
which want to touch its per-cpu data concurrently. So in that situation,
the kworker thread acts as a request queuing mechanism, allowing only a
single task to touch that per-cpu data at a given time.

> 
>> > And this is a radically weird approach to
>> > testing if @task is currently running. And if we're the worker, we can't
>> > be preempted, per definition.
>> 
>> Note that the "worker_preempted" test is really testing whether the _worker_
>> has been preempted.
> 
> But this is the worker. You cannot know if you are preempted, because if
> you are, you don't run.

The worker can check if it _has been_ preempted since it began handling the
current work item. Setting the "worker_preempted" flag is done by the finish
task switch code.

> 
>> If we are the worker, we _can_ and _should_ be preempted if something else
>> needs to be scheduled. We don't want to prevent more important tasks to run.
> 
> Sure, you want to allow preemption for both the task and the worker. But
> having the worker check a variable that says if it is itself preempted
> makes no bloody sense.

Fair point.

> 
>> This implies that whatever the task calling sched_pair_cpu set/clear does
>> between set and clear to touch per-cpu data needs to be done with restartable
>> sequences, so the critical section is aborted if the task is preempted. Same
>> goes if the kworker thread is preempted: it preempts the paired task with an
>> IPI, which immediately prevents its user-space to touch the per-cpu data until
>> the kworker is scheduled back and picks the eventually re-queued work for
>> another round.
> 
> Sure, if the worker gets preempted we need to preempt the task, and if
> the task gets preempted, we need to stop the worker.

I'm starting to grasp where you are getting: this "worker_preempted" flag
is redundant with the fact that the finish task switch code IPI the paired
task when it preempts the worker thread. So by side-effect, that paired task
will set its "need worker" to 0, which will allow the worker thread to exit
the loop.

Indeed, I think I can just remove that worker_preempted flag.

> 
>> > If we're supposed to soak up cycles while @task runs, wth does it allow
>> > scheduling in this loop?
>> > 
>> > Basicaly I think this wants to be something like:
>> > 
>> >	while (READ_ONCE(task->on_cpu) && READ_ONCE(task->pair_cpu) == cpu)
>> >		cpu_relax();
>> > 
>> > Nothing more, nothing less.
>> 
>> The semantic of what you propose is:
>> 
>> - Stop running as soon as @task is not running,
>> - Stop running as soon as @task is not paired with the cpu serviced by this
>> worker thread.
>> 
>> The semantic I need is:
>> 
>> - Stop running as soon as @task does not need the worker thread,
> 
> Can be done by setting pair_cpu to -1

The state "pair_cpu >= 0" must last from sched_pair_cpu(SET) to sched_pair_cpu(CLEAR).

The state "need worker" needs to be cleared when the paired task is preempted. It lets the
worker thread know it must break its loop and stop handling this work, so the paired task
can enqueue further work for a later attempt. This provides some fairness across multiple
tasks using sched_pair_cpu on the same cpu number. Otherwise a task could keep the pairing
set for a very long time and prevent progress from other tasks paired to the same cpu.

So I'm afraid the two states cannot be easily combined.

> 
>> - Stop running as soon as the worker thread is preempted,
> 
> This is the bloody worker thread. It cannot know if it is preempted.

As discussed above, it can know if it _has been_ preempted since beginning of
work item handling, but this happens to be redundant with checking the "need worker"
flag, so I'll remove the "worker_preempted" flag.

>> - Stop running as soon as @task has exited,
> 
> Weirdly enough ->on_cpu is always 0 for dead tasks.

I don't think we can use "->on_cpu == 0" to break the worker thread's loop.

The paired task, before returning to user-space, will enqueue the kwork
before blocking. Then, the kworker thread will eventually awaken the task.
However, AFAIU nothing guarantees that the task reaches a ->on_cpu==1 state
before the kworker thread starts its loop. It may take some time for
the scheduler to really schedule that task if there are more important things
to run on that runqueue.

> 
>> - Stop running as soon as timeout is reached.
> 
> I still don't get the timeout, if the pair_cpu is offline, the worker
> simply shouldn't run.

If we don't keep a kworker for offlined cpus, then we need _something else_
to act as a queue manager, ensuring that only a single queued work is allowed
at any given time. Because we can have many tasks which try to touch the offline
CPU's per-cpu data concurrently, and we need to serialize that as if everyone is
running on the same runqueue.

The simple trick I use here is to keep using the same kworker thread which is
tied to the offline cpu, and keep it handling work for the offline CPU. I let it
run wherever it wants.

> 
>> > None of this makes sense; task_cpu() will always be >= 0, and if it
>> > timed out, it can't be on an offline cpu, because offline CPUs don't run
>> > tasks.
>> 
>> There are three scenarios to consider here:
>> 
>> 1) The kernel worker thread is handling a CPU which is offline: This explains
>> the
>>    need for a "timeout", as discussed earlier.
> 
> Still doesn't make sense

(replied above)

> 
>> 
>> 2) The paired task was running on @cpu when task_cpu() is issued, but the CPU is
>>    concurrently going offline before we send the IPI: As the comment explains, the
>>    preemption of @task is required in order to allow its CPU to go offline makes
>>    the IPI
>>    redundant.
> 
> Tasks' CPU cannot go offline without task beeing preempted. Same for a
> worker. Either preemption will cycle the state.

Exactly. This is why I comment that a failed IPI is not an issue, because it is
redundant.

> 
>> 3) The paired task is blocked on @cpu in parallel with the timeout being reached
>> by
>>    the worker thread: AFAIU this would cause cpu < 0. Again in this case, the task
>>    has been preempted, which means our IPI would be redundant.
> 
> task_cpu() is never <0. For blocked tasks, task_cpu() is the last cpu
> they ran on, which must be a valid cpu. We use it for placement on
> wakeup.

I did not notice this, good point ! I'll fix that.

> 
>> >> +	preempt_disable();
>> >> +	set_current_state(TASK_INTERRUPTIBLE);
>> >> +	trace_printk("notify resume block for cpu %d from task %p state 0x%lx\n",
>> >> task_pair_cpu,
>> >> +	       current, current->state);
>> >> +	WARN_ON_ONCE(current->pair_cpu_worker_active);
>> >> +	WRITE_ONCE(current->pair_cpu_need_worker, 1);
>> >> +	get_task_struct(current);
>> >> +	kthread_init_work(&current->pair_cpu_work, pair_cpu_work_func);
>> >> +	kthread_queue_work(cpum->worker, &current->pair_cpu_work);
>> >> +	current->pair_cpu_queued_work = 1;
>> >> +	preempt_enable();
>> >> +	schedule();
>> > 
>> > Did you consider spurious wakeups? A naked schedule() pretty much always
>> > wrong. They need to come in loops and testing variables.
>> > 
>> > Basically this should be something like:
>> > 
>> >	rcu_wait_event(.., smp_load_acquire(&current->pair_cpu_worker_active),
>> >			TASK_INTERRUPTIBLE);
>> 
>> This schedule() is already in a loop: __sched_pair_cpu_handle_notify_resume()
>> is called from exit_to_usermode_loop().
> 
> urgh..
> 
>> > Also, I can't help but think this should've been a task_work.
>> 
>> "queuing" that work is needed from IPI context and from finish task switch.
>> As long as we can queue task_work from atomic context, we could indeed use
>> that instead. The struct callback_head would sit in the task struct.
> 
> It's a cmpxchg add + set_notify_resume() if the list was empty.

That works.

> 
>> Doing that change means that I cannot rely on the return to usermode loop
>> to call this again after schedule, so I should put that in a loop myself.
> 
> Yes, using a wait-event style API is much easier to understand.

Changing this custom wait/wakeup to a wait-event API, one question arises:
Should we use a TASK_INTERRUPTIBLE or TASK_UNINTERRUPTIBLE state ? I especially
wonder how we should handle interruption by signal within this task_work, given
that this can be running on top of return to userspace on top of pretty much
anything, including an interrupt. So returning things like ERESTARTSYS or EINTR
does not seem possible here.

> 
>> >> +/*
>> >> + * If we preempt the cpu mutex worker, we need to IPI the CPU
>> >> + * running the thread currently associated to it before scheduling
>> >> + * other tasks.
>> >> + *
>> >> + * This only targets pair_cpu worker for online cpus.
>> >> + */
>> >> +static void pair_cpu_finish_switch_worker(struct task_struct *prev)
>> >> +{
>> >> +	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, smp_processor_id());
>> >> +	struct task_struct *running_task;
>> >> +	int cpu;
>> >> +
>> >> +	if (!cpum->worker || prev != cpum->worker->task)
>> >> +		return;
>> >> +	running_task = READ_ONCE(cpum->running);
>> >> +	if (!running_task)
>> >> +		return;
>> > 
>> > You're doing this for _every_ context switch, the above is unconditional
>> > new lines touched and a big no-no.
>> 
>> The only state I need to check here is whether the scheduler is preempting a
>> thread which is a pair-cpu kworker thread. This could be a simple
>> flag within an already cache-hot cacheline in the task struct. The rest
>> then becomes a slow-path.
>> 
>> Would that solve your performance concern ?
> 
> The other alternative is using a preempt_notifier for the worker I
> suppose.

Good point!

> 
>> >> +/*
>> >> + * If we preempt a task currently associated with a cpu mutex worker,
>> >> + * we need to tell the worker to stop using cpu time.
>> >> + */
>> >> +static void pair_cpu_finish_switch_task(struct task_struct *prev, long
>> >> prev_state)
>> >> +{
>> >> +	int prev_pair_cpu;
>> >> +
>> >> +	prev_pair_cpu = READ_ONCE(prev->pair_cpu);
>> >> +	if (prev_pair_cpu < 0 || !READ_ONCE(prev->pair_cpu_need_worker)
>> >> +	    || !READ_ONCE(prev->pair_cpu_worker_active))
>> >> +		return;
>> > 
>> > Again, you're doing this every context switch, touching memory we didn't
>> > used to touch.
>> 
>> Same argument about placing this in a single "hot path" flag in the task struct.
>> Would that address your performance concerns ?
> 
> preempt_notifier could work here too I suppose, install it on yourself
> when you do the pear syscall and take it away again when you're finished
> with it.

Good point, will do!

> 
>> >>  
>> >>  	if (likely(prev != next)) {
>> >>  		rq->nr_switches++;
>> > 
>> > 
>> > I think if you use a task instead of a kthread_work things become much
>> > simpler. Regardless, you have too much state which mightily confuses
>> > things.
>> 
>> Do you mean "use a task_work" or really "use a task" ?
> 
> I meant replace the kthread_work with a full kthread, a task.
> 
>> I used a kthread_work to eliminate the need to re-implement the work
>> handling logic. What would be the benefit of using a task rather than
>> kthread_work here ?
> 
> If the worker is a dedicated task, it is much easier to see if it is
> running, simply look at worker->on_cpu. Similarly, if it is a full task
> the fact of ->on_cpu being 0 means it has scheduled, which implies
> barriers.
> 
> But I think I see why, you can have multiple tasks requiring the same
> worker. I'd overlooked that this morning.

OK, so I'll stick with a kworker for now.

> 
>> > As with all the other approaches, I don't love this.. All of this
>> > complexity is because sodding hotplug -- something that should really
>> > never happen.
>> 
>> Actually, it's not only hotplug. It's hotplug _and_ cgroup cpusets.
> 
> Argh.. I'd forgotten cpusets again :-(

Yes, cpusets make things "interesting". ;)

> 
>> > - make fcntl(F_*SIG) work on /sys/devices/system/cpu/cpuN/online such
>> >   that we receive a signal when the state changes, and before userspace
>> >   starts. The signal triggers rseq restart.
>> 
>> Just knowing a CPU is offline is not enough. We then need to be able to
>> synchronize concurrent updates to that per-CPU data structure while the
>> CPU is offline, in a way which is also safe against that CPU coming back
>> online again.
> 
> That's exactly what that signal would do. It would send SIGIO when the
> state changes.
> 
> So you want to access CPU-n's data, you open that file, register a
> signal and read it's state, if offline, you good, do the rseq. If it
> suddenly decides to come back online, you're guaranteed that SIGIO
> before it reaches userspace.
>
> The nice thing is that it's all R/O so available to normal users, you
> don't have to write to the file.

So let's say you have two threads trying to access (offline) CPU-n's data
with that algorithm concurrently. How are they serialized with each other ?

> 
>> Also it does not solve the issues associated with cgroup cpusets, where
>> a CPU may very well be online, but not part of our thread's allowed cpu
>> mask.
> 
> Let's just say I violated the CoC...

:-)

> 
>> We do not want to override the affinity restricted by cgroups because
>> we don't want to hurt performance characteristics of another partition
>> of the system.
>> 
>> The sched_pair_cpu approach has the benefit of allowing us to touch
>> per-cpu data of a given CPU without requiring to run on that CPU, which
>> ensures that we do not thrash the cpu cache of cpus on which a thread
>> is not allowed to run. It takes care of issues caused by both cgroup
>> cpusets and cpu hotplug.
> 
> But now I worry that your thing allows escaping the cgroup contraints,
> you can perturb random CPUs you're not allowed on. That's a really bad
> 'feature'.
> 
> Offline cpus are okay, because you don't actually need to do anything as
> long as they're offline, but restricted CPUs we really should not be
> touching, not even a little.

With sched_pair_cpu, the paired task never needs to run on the target CPU.
The kworker thread runs on the target CPU in the same way other existing
worker threads run today, e.g. the ones handling RCU callbacks. AFAIK the
priority of those threads can be configured by a system administrator.

Are there additional steps we should take to minimize the impact of this
worker thread ? In the same way "no rcu callbacks" CPU can be configured
at boot time, we could have "no sched pair cpu" configured at boot, which
would prevent sched_pair_cpu system calls from targeting that CPU entirely,
and not spawn any kworker on that cpu.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
