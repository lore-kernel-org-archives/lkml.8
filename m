Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D565C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C16E20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgEONDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:03:50 -0400
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:59357 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgEONDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:03:50 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 5EE9BFAD72
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:03:48 +0100 (IST)
Received: (qmail 24034 invoked from network); 15 May 2020 13:03:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 May 2020 13:03:48 -0000
Date:   Fri, 15 May 2020 14:03:46 +0100
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
Message-ID: <20200515130346.GM3758@techsingularity.net>
References: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200515111732.GS2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:17:32PM +0200, Peter Zijlstra wrote:
> On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:
> 
> > However, the wakeups are so rapid that the wakeup
> > happens while the server is descheduling. That forces the waker to spin
> > on smp_cond_load_acquire for longer. In this case, it can be cheaper to
> > add the task to the rq->wake_list even if that potentially requires an IPI.
> 
> Right, I think Rik ran into that as well at some point. He wanted to
> make ->on_cpu do a hand-off, but simply queueing the wakeup on the prev
> cpu (which is currently in the middle of schedule()) should be an easier
> proposition.
> 
> Maybe something like this untested thing... could explode most mighty,
> didn't thing too hard.
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fa6c19d38e82..c07b92a0ee5d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2312,7 +2312,7 @@ static void wake_csd_func(void *info)
>  	sched_ttwu_pending();
>  }
>  
> -static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
> +static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  
> @@ -2354,6 +2354,17 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
>  {
>  	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
>  }
> +
> +static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
> +{
> +	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> +		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> +		__ttwu_queue_remote(p, cpu, wake_flags);
> +		return true;
> +	}
> +
> +	return false;
> +}
>  #endif /* CONFIG_SMP */
>  
>  static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> @@ -2362,11 +2373,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>  	struct rq_flags rf;
>  
>  #if defined(CONFIG_SMP)
> -	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> -		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> -		ttwu_queue_remote(p, cpu, wake_flags);
> +	if (ttwu_queue_remote(p, cpu, wake_flags))
>  		return;
> -	}
>  #endif
>  
>  	rq_lock(rq, &rf);
> @@ -2550,7 +2558,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	if (p->on_rq && ttwu_remote(p, wake_flags))
>  		goto unlock;
>  
> +	if (p->in_iowait) {
> +		delayacct_blkio_end(p);
> +		atomic_dec(&task_rq(p)->nr_iowait);
> +	}
> +
>  #ifdef CONFIG_SMP
> +	p->sched_contributes_to_load = !!task_contributes_to_load(p);
> +	p->state = TASK_WAKING;
> +
>  	/*
>  	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
>  	 * possible to, falsely, observe p->on_cpu == 0.
> @@ -2581,15 +2597,10 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * This ensures that tasks getting woken will be fully ordered against
>  	 * their previous state and preserve Program Order.
>  	 */
> -	smp_cond_load_acquire(&p->on_cpu, !VAL);
> -
> -	p->sched_contributes_to_load = !!task_contributes_to_load(p);
> -	p->state = TASK_WAKING;
> +	if (READ_ONCE(p->on_cpu) && __ttwu_queue_remote(p, cpu, wake_flags))
> +		goto unlock;
>  
> -	if (p->in_iowait) {
> -		delayacct_blkio_end(p);
> -		atomic_dec(&task_rq(p)->nr_iowait);
> -	}
> +	smp_cond_load_acquire(&p->on_cpu, !VAL);
>  
>  	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
>  	if (task_cpu(p) != cpu) {

I don't see a problem with moving the updating of p->state to the other
side of the barrier but I'm relying on the comment that the barrier is
only related to on_rq and on_cpu.

However, I'm less sure about what exactly you intended to do.
__ttwu_queue_remote is void so maybe you meant to use ttwu_queue_remote.
In that case, we potentially avoid spinning on on_rq for wakeups between
tasks that do not share CPU but it's not clear why it would be specific to
remote tasks. If you meant to call __ttwu_queue_remote unconditionally,
it's not clear why that's now safe when smp_cond_load_acquire() 
cared about on_rq being 0 before queueing a task for wakup or directly
waking it up.

Also because __ttwu_queue_remote() now happens before select_task_rq(), is
there not a risk that in some cases we end up stacking tasks unnecessarily?

> @@ -2597,14 +2608,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		psi_ttwu_dequeue(p);
>  		set_task_cpu(p, cpu);
>  	}
> -
> -#else /* CONFIG_SMP */
> -
> -	if (p->in_iowait) {
> -		delayacct_blkio_end(p);
> -		atomic_dec(&task_rq(p)->nr_iowait);
> -	}
> -
>  #endif /* CONFIG_SMP */
>  
>  	ttwu_queue(p, cpu, wake_flags);

-- 
Mel Gorman
SUSE Labs
