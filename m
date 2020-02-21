Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7BC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A308207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBULIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:08:24 -0500
Received: from foss.arm.com ([217.140.110.172]:36764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBULIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:08:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B330E31B;
        Fri, 21 Feb 2020 03:08:22 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6357C3F68F;
        Fri, 21 Feb 2020 03:08:21 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:08:19 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/rt: allow pulling unfitting task
Message-ID: <20200221110818.ysnyrtvbhqlps45e@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-3-qais.yousef@arm.com>
 <20200217091042.GB28029@codeaurora.org>
 <20200219134306.4uvnlh4co3zwohzw@e107158-lin>
 <20200221080701.GF28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221080701.GF28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/20 13:37, Pavan Kondeti wrote:
> Hi Quais,

I know my name breaks the English rules, but there's no u after my Q :)

> 
> On Wed, Feb 19, 2020 at 01:43:08PM +0000, Qais Yousef wrote:
> 
> [...]
> 
> > > 
> > > Here rq is source rq from which the task is being pulled. I can't understand
> > > how marking overload condition on source_rq help. Because overload condition
> > > gets cleared in the task dequeue path. i.e dec_rt_tasks->dec_rt_migration->
> > > update_rt_migration().
> > > 
> > > Also, the overload condition with nr_running=1 may not work as expected unless
> > > we track this overload condition (due to unfit) separately. Because a task
> > > can be pushed only when it is NOT running. So a task running on silver will
> > > continue to run there until it wakes up next time or another high prio task
> > > gets queued here (due to affinity).
> > > 
> > > btw, Are you testing this path by disabling RT_PUSH_IPI feature? I ask this
> > > because, This feature gets turned on by default in our b.L platforms and
> > > RT task migrations happens by the busy CPU pushing the tasks. Or are there
> > > any cases where we can run into pick_rt_task() even when RT_PUSH_IPI is
> > > enabled?
> > 
> > I changed the approach to set the overload at wake up now. I think I got away
> > without having to encode the reason in rq->rt.overload.
> > 
> > Steve, Pavan, if you can scrutinize this approach I'd be appreciated. It seemed
> > to work fine with my testing.
> > 
> 
> The 1st patch in this series added the support to return an unfit CPU incase

If you can give your reviewed-by and maybe tested-by for that patch that'd be
great.

> all other BIG CPUs are busy with RT tasks. I believe that change it self
> solves the RT tasks spreading problem if we just remove
> rt_task_fits_capacity() from pick_rt_task(). In fact rt_task_fits_capacity()

Yes I will be removing this.

> can also be removed from switched_to_rt() and task_woken_rt(). Because
> a RT task can be pulled/pushed only if it not currently running. If the

I did actually consider pushing a patch that does just that.

The issue is that I have seen delays in migrating the task to the big CPU,
although the CPU was free. It was hard to hit, but I had runs where the
migration didn't happen at all during the 1s test duration.

I need to use the same overloaded trick in switched_to_rt() too though.

> intention is to push/pull a running RT task from an unfit CPU to a BIG CPU,
> that won't work as we are not waking any migration/X to carry the migration.

Hmm, I thought this should happen as a side effect of the push/pull functions.

> 
> If an CPU has 2 RT tasks (excluding the running RT task), then we have a
> choice about which RT task to be pushed based on the destination CPU's
> capacity. Are we trying to solve this problem in this patch?

If there are 2 tasks on the same CPU (rq), then it's overloaded and the push
should be triggered anyway, no?

What I'm trying to solve is if a task has woken up on the wrong CPU, or has
just switched to RT on the wrong CPU, then we want to push ASAP.

We can rely on select_task_rq_rt() to do the work, but I have seen big delays
for this to trigger.

> 
> Please see the below comments as well and let me know if we are on the
> same page or not.
> 
> > 
> > 
> > When implemented RT Capacity Awareness; the logic was done such that if
> > a task was running on a fitting CPU, then it was sticky and we would try
> > our best to keep it there.
> > 
> > But as Steve suggested, to adhere to the strict priority rules of RT
> > class; allow pulling an RT task to unfitting CPU to ensure it gets a
> > chance to run ASAP.
> > 
> > To better handle the fact the task is running on unfit CPU, when it
> > wakes up mark it as overloaded which will cause it to be pushed to
> > a fitting CPU when it becomes available.
> > 
> > The latter change requires teaching push_rt_task() how to handle pushing
> > unfit task.
> > 
> > If the unfit task is the only pushable task, then we only force the push
> > if we find a fitting CPU. Otherwise we bail out.
> > 
> > Else if the task is higher priorirty than current task, then we
> > reschedule.
> > 
> > Else if the rq has other pushable tasks, then we push the unfitting task
> > anyway to reduce the pressure on the rq even if the target CPU is unfit
> > too.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/rt.c | 52 +++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 48 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 6d959be4bba0..6d92219d5733 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1658,8 +1658,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> >  {
> >  	if (!task_running(rq, p) &&
> > -	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> > -	    rt_task_fits_capacity(p, cpu))
> > +	    cpumask_test_cpu(cpu, p->cpus_ptr))
> >  		return 1;
> >  
> 
> Yes. We come here means rq has more than 1 runnable task, so we prefer
> spreading.

I might put this change only for this patch and send the fixes so they can go
before 5.6 is released. Unless the current patch ends up needing few tweaks
only.

> 
> >  	return 0;
> > @@ -1860,6 +1859,7 @@ static int push_rt_task(struct rq *rq)
> >  	struct task_struct *next_task;
> >  	struct rq *lowest_rq;
> >  	int ret = 0;
> > +	bool fit;
> >  
> >  	if (!rq->rt.overloaded)
> >  		return 0;
> > @@ -1872,12 +1872,21 @@ static int push_rt_task(struct rq *rq)
> >  	if (WARN_ON(next_task == rq->curr))
> >  		return 0;
> >  
> > +	/*
> > +	 * The rq could be overloaded because it has unfitting task, if that's
> > +	 * the case they we need to try harder to find a better fitting CPU.
> > +	 */
> > +	fit = rt_task_fits_capacity(next_task, cpu_of(rq));
> > +
> >  	/*
> >  	 * It's possible that the next_task slipped in of
> >  	 * higher priority than current. If that's the case
> >  	 * just reschedule current.
> > +	 *
> > +	 * Unless next_task doesn't fit in this cpu, then continue with the
> > +	 * attempt to push it.
> >  	 */
> > -	if (unlikely(next_task->prio < rq->curr->prio)) {
> > +	if (unlikely(next_task->prio < rq->curr->prio && fit)) {
> >  		resched_curr(rq);
> >  		return 0;
> >  	}
> > @@ -1920,6 +1929,33 @@ static int push_rt_task(struct rq *rq)
> >  		goto retry;
> >  	}
> >  
> > +	/*
> > +	 * Bail out if the task doesn't fit on either CPUs.
> > +	 *
> > +	 * Unless..
> > +	 *
> > +	 * * The priority of next_task is higher than current, then we
> > +	 *   resched_curr(). We forced skipping this condition above.
> > +	 *
> > +	 * * The rq has more tasks to push, then we probably should push anyway
> > +	 *   reduce the load on this rq.
> > +	 */
> > +	if (!fit && !rt_task_fits_capacity(next_task, cpu_of(lowest_rq))) {
> > +
> > +		/* we forced skipping this condition, so re-evaluate it */
> > +		if (unlikely(next_task->prio < rq->curr->prio)) {
> > +			resched_curr(rq);
> > +			goto out_unlock;
> > +		}
> > +
> > +		/*
> > +		 * If there are more tasks to push, then the rq is overloaded
> > +		 * with more than just this task, so push anyway.
> > +		 */
> > +		if (has_pushable_tasks(rq))
> > +			goto out_unlock;

Hmm, I accidently inverted the logic too before posting the patch. It should
have been (!has_pushable_tasks).

> 
> The next_task is not yet removed from the pushable_tasks list, so this will
> always be true and we skip pushing. Even if you add some logic, what happens

I saw the loop in push_rt_task[s]() and thought pick_next_pushable_task() is
what dequeues..

Is there another way to know how many tasks are pushable? Or do I need a new
helper?

> if the other task also does not fit? How would the task finally be pushed
> to other CPUs?

If we had 2 unfitting tasks; we'll push one and keep one. If we had 2 tasks,
one unfitting and one fitting, then we'll still push 1. I think the dequeue
should have cleared the overloaded state after pushing the first task anyway.

Does this answer your question or were you trying to point out something else?

> 
> > +	}
> > +
> >  	deactivate_task(rq, next_task, 0);
> >  	set_task_cpu(next_task, lowest_rq->cpu);
> >  	activate_task(lowest_rq, next_task, 0);
> > @@ -1927,6 +1963,7 @@ static int push_rt_task(struct rq *rq)
> >  
> >  	resched_curr(lowest_rq);
> >  
> > +out_unlock:
> >  	double_unlock_balance(rq, lowest_rq);
> >  
> >  out:
> > @@ -2223,7 +2260,14 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
> >  			    (rq->curr->nr_cpus_allowed < 2 ||
> >  			     rq->curr->prio <= p->prio);
> >  
> > -	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
> > +	bool fit = rt_task_fits_capacity(p, cpu_of(rq));
> > +
> > +	if (!fit && !rq->rt.overloaded) {
> > +		rt_set_overload(rq);
> > +		rq->rt.overloaded = 1;
> > +	}
> > +
> > +	if (need_to_push || !fit)
> >  		push_rt_tasks(rq);
> >  }
> 
> If this is the only RT task queued on this CPU and current task is not a RT
> task, why are we calling push_rt_tasks() in case if unfit scenario. In most
> cases, the task is woken on this rq, because there is no other higher capacity
> rq that can take this task for whatever reason.

But what if the big CPU is now free for it to run?

I need to add a similar condition to switched_to_rt() otherwise the
push_rt_tasks() would be a NOP.

> 
> btw, if we set overload condition with just 1 RT task, we keep receiving the
> IPI (irq work) to push the task and we can't do that because a running RT
> task can't be pushed.

Good point.

We can teach the logic not to send IPIs in this case?

Given all of that. I might still agree this might be unnecessary work. So I'll
split it out into a separate patch anyway and send an updated series of the
fixes we agreed on to go into 5.6.

Thanks!

--
Qais Yousef
