Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03535C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B220C204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GQZg09Xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:28:58 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B943C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5nhH7XCvMNPLgr/SaozWYIO34BzLn3ulz7bnIl+wGhQ=; b=GQZg09XhZH6ap38v8hI5cRQJ++
        RAOODbH+VFa1+9bQC7uwYziac/1gsvXJs12sVXIQhy5M3QZAQ10L/CVphDMFOCGFgYDh6xDm/b84n
        B5H8f6xDnPLbWLwaTcjXvA5NYa5sqCe4jgn17drG5mvfvv720xHHijYUfqUE6ntJVv52Tvso4cI9p
        cewZvRs0OAWuE+TzfAhmDGfNckP3u1od9jsqSVMaeSsEIuRLMVWaY/W2mYULfsRNc1FtrC3M61VM5
        PWul2uD3aacRHVKMQPgFUdBSa9Jzpi/yLZPeewzeAoSL3EANRHf63RYBSZjU81EVqpqh4/yfwk1g1
        fq7S2r2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZYVm-0006i1-C7; Fri, 15 May 2020 11:28:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4085A301205;
        Fri, 15 May 2020 13:28:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BF7B20267E65; Fri, 15 May 2020 13:28:15 +0200 (CEST)
Date:   Fri, 15 May 2020 13:28:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <20200515112815.GT2957@hirez.programming.kicks-ass.net>
References: <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515084740.GJ3758@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:
> sched: Wake cache-local tasks via wake_list if wakee CPU is polling
> 
> There are two separate method for waking a task from idle, one for
> tasks running on CPUs that share a cache and one for when the caches are
> separate. The methods can loosely be called local and remote even though
> this is not directly related to NUMA and instead is due to the expected
> cost of accessing data that is cache-hot on another CPU. The "local" costs
> are expected to be relatively cheap as they share the LLC in comparison to
> a remote IPI that is potentially required when using the "remote" wakeup.
> The problem is that the local wakeup is not always cheaper and it appears
> to have degraded even further around the 4.19 mark.
> 
> There appears to be a couple of reasons why it can be slower.
> 
> The first is specific to pairs of tasks where one or both rapidly enters
> idle. For example, on netperf UDP_STREAM, the client sends a bunch of
> packets, wakes the server, the server processes some packets and goes
> back to sleep. There is a relationship between the tasks but it's not
> strictly synchronous. The timing is different if the client/server are on
> separate NUMA nodes and netserver is more likely to enter idle (measured
> as server entering idle 10% more times when tasks are local vs remote
> but machine-specific). However, the wakeups are so rapid that the wakeup
> happens while the server is descheduling. That forces the waker to spin
> on smp_cond_load_acquire for longer. In this case, it can be cheaper to
> add the task to the rq->wake_list even if that potentially requires an IPI.
> 
> The second is that the local wakeup path is simply not always
> that fast. Using ftrace, the cost of the locks, update_rq_clock and
> ttwu_do_activate was measured as roughly 4.5 microseconds. While it's
> a single instance, the cost of the "remote" wakeup for try_to_wake_up
> was roughly 2.5 microseconds versus 6.2 microseconds for the "fast" local
> wakeup. When there are tens of thousands of wakeups per second, these costs
> accumulate and manifest as a throughput regression in netperf UDP_STREAM.
> 
> The essential difference in costs comes down to whether the CPU is fully
> idle, a task is descheduling or polling in poll_idle(). This patch
> special cases ttwu_queue() to use the "remote" method if the CPUs
> task is polling as it's generally cheaper to use the wake_list in that
> case than the local method because an IPI should not be required. As it is
> race-prone, a reschedule IPI may still be sent but in that case the local
> wakeup would also have to send a reschedule IPI so it should be harmless.

We don't in fact send a wakeup IPI when polling. So this might end up
with an extra IPI.


> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..59077c7c6660 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2380,13 +2380,32 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>  	struct rq_flags rf;
>  
>  #if defined(CONFIG_SMP)
> -	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> +	if (sched_feat(TTWU_QUEUE)) {
> +		/*
> +		 * A remote wakeup is often expensive as can require
> +		 * an IPI and the wakeup path is slow. However, in
> +		 * the specific case where the target CPU is idle
> +		 * and polling, the CPU is active and rapidly checking
> +		 * if a reschedule is needed.

Not strictly true; MWAIT can be very deep idle, it's just that with
POLLING we indicate we do not have to send an IPI to wake up. Just
setting the TIF_NEED_RESCHED flag is sufficient to wake up -- the
monitor part of monitor-wait.

>                                             In this case, the idle
> +		 * task just needs to be marked for resched and p
> +		 * will rapidly be requeued which is less expensive
> +		 * than the direct wakeup path.
> +		 */
> +		if (cpus_share_cache(smp_processor_id(), cpu)) {
> +			struct thread_info *ti = task_thread_info(p);
> +			typeof(ti->flags) val = READ_ONCE(ti->flags);
> +
> +			if (val & _TIF_POLLING_NRFLAG)
> +				goto activate;

I'm completely confused... the result here is that if you're polling you
do _NOT_ queue on the wake_list, but instead immediately enqueue.

(which kinda makes sense, since if the remote CPU is idle, it doesn't
have these lines in its cache anyway)

But the subject and comments all seem to suggest the opposite !?

Also, this will fail compilation when !defined(TIF_POLLING_NRFLAGG).

> +		}
> +
>  		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>  		ttwu_queue_remote(p, cpu, wake_flags);
>  		return;
>  	}
>  #endif
>  
> +activate:

The labels wants to go inside the ifdef, otherwise GCC will complain
about unused labels etc..

>  	rq_lock(rq, &rf);
>  	update_rq_clock(rq);
>  	ttwu_do_activate(rq, p, wake_flags, &rf);
