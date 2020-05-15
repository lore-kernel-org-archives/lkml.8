Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8091DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBD720709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOMWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:22:37 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:52517 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgEOMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:22:37 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 409171C386F
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:22:34 +0100 (IST)
Received: (qmail 9770 invoked from network); 15 May 2020 12:22:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 May 2020 12:22:33 -0000
Date:   Fri, 15 May 2020 13:22:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200515122231.GL3758@techsingularity.net>
References: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515112815.GT2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200515112815.GT2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:28:15PM +0200, Peter Zijlstra wrote:
> On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:
> > sched: Wake cache-local tasks via wake_list if wakee CPU is polling
> > 
> > There are two separate method for waking a task from idle, one for
> > tasks running on CPUs that share a cache and one for when the caches are
> > separate. The methods can loosely be called local and remote even though
> > this is not directly related to NUMA and instead is due to the expected
> > cost of accessing data that is cache-hot on another CPU. The "local" costs
> > are expected to be relatively cheap as they share the LLC in comparison to
> > a remote IPI that is potentially required when using the "remote" wakeup.
> > The problem is that the local wakeup is not always cheaper and it appears
> > to have degraded even further around the 4.19 mark.
> > 
> > There appears to be a couple of reasons why it can be slower.
> > 
> > The first is specific to pairs of tasks where one or both rapidly enters
> > idle. For example, on netperf UDP_STREAM, the client sends a bunch of
> > packets, wakes the server, the server processes some packets and goes
> > back to sleep. There is a relationship between the tasks but it's not
> > strictly synchronous. The timing is different if the client/server are on
> > separate NUMA nodes and netserver is more likely to enter idle (measured
> > as server entering idle 10% more times when tasks are local vs remote
> > but machine-specific). However, the wakeups are so rapid that the wakeup
> > happens while the server is descheduling. That forces the waker to spin
> > on smp_cond_load_acquire for longer. In this case, it can be cheaper to
> > add the task to the rq->wake_list even if that potentially requires an IPI.
> > 
> > The second is that the local wakeup path is simply not always
> > that fast. Using ftrace, the cost of the locks, update_rq_clock and
> > ttwu_do_activate was measured as roughly 4.5 microseconds. While it's
> > a single instance, the cost of the "remote" wakeup for try_to_wake_up
> > was roughly 2.5 microseconds versus 6.2 microseconds for the "fast" local
> > wakeup. When there are tens of thousands of wakeups per second, these costs
> > accumulate and manifest as a throughput regression in netperf UDP_STREAM.
> > 
> > The essential difference in costs comes down to whether the CPU is fully
> > idle, a task is descheduling or polling in poll_idle(). This patch
> > special cases ttwu_queue() to use the "remote" method if the CPUs
> > task is polling as it's generally cheaper to use the wake_list in that
> > case than the local method because an IPI should not be required. As it is
> > race-prone, a reschedule IPI may still be sent but in that case the local
> > wakeup would also have to send a reschedule IPI so it should be harmless.
> 
> We don't in fact send a wakeup IPI when polling.

I know when it's polling that an IPI can be skipped as set_nr_if_polling
will succeed.

> So this might end up
> with an extra IPI.
> 

Yes, it might. If between the check for polling and set_nr_and_not_polling,
the polling may have stopped and the CPU entered a c-state and an IPI
is sent but in that case, either path is likely to result in some sort
of IPI.

> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9a2fbf98fd6f..59077c7c6660 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2380,13 +2380,32 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> >  	struct rq_flags rf;
> >  
> >  #if defined(CONFIG_SMP)
> > -	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> > +	if (sched_feat(TTWU_QUEUE)) {
> > +		/*
> > +		 * A remote wakeup is often expensive as can require
> > +		 * an IPI and the wakeup path is slow. However, in
> > +		 * the specific case where the target CPU is idle
> > +		 * and polling, the CPU is active and rapidly checking
> > +		 * if a reschedule is needed.
> 
> Not strictly true; MWAIT can be very deep idle, it's just that with
> POLLING we indicate we do not have to send an IPI to wake up. Just
> setting the TIF_NEED_RESCHED flag is sufficient to wake up -- the
> monitor part of monitor-wait.
> 

The terminology is unhelpful. In this case when I said "idle and polling",
I was thinking of the idle task running poll_idle() and the CPU should
not be in any c-state below C0 but it doesn't really matter due to your
own comments.

> >                                             In this case, the idle
> > +		 * task just needs to be marked for resched and p
> > +		 * will rapidly be requeued which is less expensive
> > +		 * than the direct wakeup path.
> > +		 */
> > +		if (cpus_share_cache(smp_processor_id(), cpu)) {
> > +			struct thread_info *ti = task_thread_info(p);
> > +			typeof(ti->flags) val = READ_ONCE(ti->flags);
> > +
> > +			if (val & _TIF_POLLING_NRFLAG)
> > +				goto activate;
> 
> I'm completely confused... the result here is that if you're polling you
> do _NOT_ queue on the wake_list, but instead immediately enqueue.
> 
> (which kinda makes sense, since if the remote CPU is idle, it doesn't
> have these lines in its cache anyway)
> 

Crap, I rushed this and severely confused myself about what is going
on. It is definitely the case that flipping this check does not give
any benefit. The patch shows a benefit but I'm failing to understand
exactly why. How I ended up here was perf indicating a lot of time spent
on smp_cond_load_acquire() which made me look closely at ttwu_remote()
and looking at function graphs to compare the different types of wakeups
and their timings.

With this patch when netperf is waking the server, netperf is all that
is active with the wakeup completing 3.489 microseconds. If this check
is flipped, the idle thread is running at the same time and clearly
interleaving with netperf in the ftrace function_graph and the wakeup
takes 9.449 microseconds. The exact timings vary obviously but it's
what led to the patch -- brute force starting at function_graphs until
something fell out.

> But the subject and comments all seem to suggest the opposite !?
> 

Yeah, I need to think more about why exactly this patch makes a difference.

> Also, this will fail compilation when !defined(TIF_POLLING_NRFLAGG).
> 

I can fix that.

> > +		}
> > +
> >  		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> >  		ttwu_queue_remote(p, cpu, wake_flags);
> >  		return;
> >  	}
> >  #endif
> >  
> > +activate:
> 
> The labels wants to go inside the ifdef, otherwise GCC will complain
> about unused labels etc..
> 

And that too.

Thanks.

-- 
Mel Gorman
SUSE Labs
