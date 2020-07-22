Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FECE22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595455787;
	bh=Ia353sLPOcP2dsD+d2MRKC/6UosDFuQpSkniVtNRaKo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OBqOZoZKWXAOkRX0xZKXum3WT+rpqYU7OoSsrK/cf219Wx7wQzu6G1dj0bY9rSd6x
	 I18XnlCrayW0v1au/arx9MGRXTniUETMrjTpbn7tapuVJDOjDNfB5f1Qf01wZXirbE
	 U8rbzTc/q3bzniyfJS0I78lpBbo2tqtQvoLBnVkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgGVWJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbgGVWJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:09:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A61C820825;
        Wed, 22 Jul 2020 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595455783;
        bh=Ia353sLPOcP2dsD+d2MRKC/6UosDFuQpSkniVtNRaKo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RI0SVps7P+HsuINuxwZ7Rs9Y5ECg7vg8+T6cpzB81CpkNBBiuExQBqnm9aOx3X9L3
         JhzSMb67yzyXSuPCramL3X4fkc7Vu/YpK7OPHgtUo9TsqGcz8us3fKOLf72lhnDvH7
         Wz58n4c0U+jsNG+4ffOkkPSJWWhfuHjYYAmItTdo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 853833522AB9; Wed, 22 Jul 2020 15:09:43 -0700 (PDT)
Date:   Wed, 22 Jul 2020 15:09:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 7/9] smp,irq_work: Use the new irq_work API
Message-ID: <20200722220943.GC23360@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200722150149.525408253@infradead.org>
 <20200722153017.445914025@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722153017.445914025@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:01:56PM +0200, Peter Zijlstra wrote:
> Convert the performance sensitive users of
> smp_call_single_function_async() over to the new
> irq_work_queue_remote_static().
> 
> The new API is marginally less crap but taking these users away allows
> fixing up smp_call_single_function_async() without risk of performance
> regressions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

But given that kvm.sh gives a return status like "git bisect run",
why not bisect?

And bisection converged on this patch with a similar splat.

Decoding the assembly makes it appear that nohz_work_func() got a bogus
pointer having a rather odd value of 0x200000001.

							Thanx, Paul

------------------------------------------------------------------------

0:  e8 35 52 ff ff          call   0xffffffffffff523a
5:  48 89 c3                mov    rbx,rax
8:  eb 93                   jmp    0xffffffffffffff9d
a:  8b 43 70                mov    eax,DWORD PTR [rbx+0x70]
d:  89 44 24 04             mov    DWORD PTR [rsp+0x4],eax
11: eb c2                   jmp    0xffffffffffffffd5
13: 48 c7 c0 ea ff ff ff    mov    rax,0xffffffffffffffea
1a: eb 94                   jmp    0xffffffffffffffb0
1c: e8 c9 02 a7 00          call   0xa702ea
21: 66 0f 1f 84 00 00 00    nop    WORD PTR [rax+rax*1+0x0]
28: 00 00
2a: 4c 63 8f f0 09 00 00    movsxd r9,DWORD PTR [rdi+0x9f0]  <-------
31: 48 c7 c1 00 91 02 00    mov    rcx,0x29100
38: 48 89 ca                mov    rdx,rcx

> ---
>  block/blk-mq.c            |    8 ++++----
>  include/linux/blkdev.h    |    4 ++--
>  include/linux/netdevice.h |    3 ++-
>  kernel/sched/core.c       |   16 ++++++++--------
>  kernel/sched/fair.c       |    6 +++---
>  kernel/sched/sched.h      |    4 ++--
>  net/core/dev.c            |   15 ++++++++++-----
>  7 files changed, 31 insertions(+), 25 deletions(-)
> 
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -623,9 +623,9 @@ static int blk_softirq_cpu_dead(unsigned
>  }
>  
>  
> -static void __blk_mq_complete_request_remote(void *data)
> +static void __blk_mq_complete_request_remote(struct irq_work *work)
>  {
> -	struct request *rq = data;
> +	struct request *rq = container_of(work, struct request, work);
>  
>  	/*
>  	 * For most of single queue controllers, there is only one irq vector
> @@ -672,8 +672,8 @@ bool blk_mq_complete_request_remote(stru
>  		return false;
>  
>  	if (blk_mq_complete_need_ipi(rq)) {
> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> -		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
> +		rq->work = IRQ_WORK_INIT_HARD(__blk_mq_complete_request_remote);
> +		irq_work_queue_remote_static(rq->mq_ctx->cpu, &rq->work);
>  	} else {
>  		if (rq->q->nr_hw_queues > 1)
>  			return false;
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -19,7 +19,7 @@
>  #include <linux/stringify.h>
>  #include <linux/gfp.h>
>  #include <linux/bsg.h>
> -#include <linux/smp.h>
> +#include <linux/irq_work.h>
>  #include <linux/rcupdate.h>
>  #include <linux/percpu-refcount.h>
>  #include <linux/scatterlist.h>
> @@ -234,7 +234,7 @@ struct request {
>  	unsigned long deadline;
>  
>  	union {
> -		struct __call_single_data csd;
> +		struct irq_work work;
>  		u64 fifo_time;
>  	};
>  
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -26,6 +26,7 @@
>  #include <linux/delay.h>
>  #include <linux/atomic.h>
>  #include <linux/prefetch.h>
> +#include <linux/irq_work.h>
>  #include <asm/cache.h>
>  #include <asm/byteorder.h>
>  
> @@ -3126,7 +3127,7 @@ struct softnet_data {
>  	unsigned int		input_queue_head ____cacheline_aligned_in_smp;
>  
>  	/* Elements below can be accessed between CPUs for RPS/RFS */
> -	call_single_data_t	csd ____cacheline_aligned_in_smp;
> +	struct irq_work		work ____cacheline_aligned_in_smp;
>  	struct softnet_data	*rps_ipi_next;
>  	unsigned int		cpu;
>  	unsigned int		input_queue_tail;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -265,9 +265,9 @@ static void __hrtick_restart(struct rq *
>  /*
>   * called from hardirq (IPI) context
>   */
> -static void __hrtick_start(void *arg)
> +static void __hrtick_start(struct irq_work *work)
>  {
> -	struct rq *rq = arg;
> +	struct rq *rq = container_of(work, struct rq, hrtick_work);
>  	struct rq_flags rf;
>  
>  	rq_lock(rq, &rf);
> @@ -298,7 +298,7 @@ void hrtick_start(struct rq *rq, u64 del
>  	if (rq == this_rq())
>  		__hrtick_restart(rq);
>  	else
> -		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
> +		irq_work_queue_remote_static(cpu_of(rq), &rq->hrtick_work);
>  }
>  
>  #else
> @@ -323,7 +323,7 @@ void hrtick_start(struct rq *rq, u64 del
>  static void hrtick_rq_init(struct rq *rq)
>  {
>  #ifdef CONFIG_SMP
> -	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
> +	rq->hrtick_work = IRQ_WORK_INIT_HARD(__hrtick_start);
>  #endif
>  	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>  	rq->hrtick_timer.function = hrtick;
> @@ -633,14 +633,14 @@ void wake_up_nohz_cpu(int cpu)
>  		wake_up_idle_cpu(cpu);
>  }
>  
> -static void nohz_csd_func(void *info)
> +static void nohz_work_func(struct irq_work *work)
>  {
> -	struct rq *rq = info;
> +	struct rq *rq = container_of(work, struct rq, nohz_work);
>  	int cpu = cpu_of(rq);
>  	unsigned int flags;
>  
>  	/*
> -	 * Release the rq::nohz_csd.
> +	 * Release rq::nohz_work.
>  	 */
>  	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
>  	WARN_ON(!(flags & NOHZ_KICK_MASK));
> @@ -6827,7 +6827,7 @@ void __init sched_init(void)
>  		rq->last_blocked_load_update_tick = jiffies;
>  		atomic_set(&rq->nohz_flags, 0);
>  
> -		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
> +		rq->nohz_work = IRQ_WORK_INIT_HARD(nohz_work_func);
>  #endif
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10039,8 +10039,8 @@ static void kick_ilb(unsigned int flags)
>  		return;
>  
>  	/*
> -	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
> -	 * the first flag owns it; cleared by nohz_csd_func().
> +	 * Access to rq::nohz_work is serialized by NOHZ_KICK_MASK; he who sets
> +	 * the first flag owns it; cleared by nohz_work_func().
>  	 */
>  	flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
>  	if (flags & NOHZ_KICK_MASK)
> @@ -10051,7 +10051,7 @@ static void kick_ilb(unsigned int flags)
>  	 * is idle. And the softirq performing nohz idle load balance
>  	 * will be run before returning from the IPI.
>  	 */
> -	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
> +	irq_work_queue_remote_static(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_work);
>  }
>  
>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -904,7 +904,7 @@ struct rq {
>  #ifdef CONFIG_SMP
>  	unsigned long		last_blocked_load_update_tick;
>  	unsigned int		has_blocked_load;
> -	call_single_data_t	nohz_csd;
> +	struct irq_work		nohz_work;
>  #endif /* CONFIG_SMP */
>  	unsigned int		nohz_tick_stopped;
>  	atomic_t		nohz_flags;
> @@ -1015,7 +1015,7 @@ struct rq {
>  
>  #ifdef CONFIG_SCHED_HRTICK
>  #ifdef CONFIG_SMP
> -	call_single_data_t	hrtick_csd;
> +	struct irq_work		hrtick_work;
>  #endif
>  	struct hrtimer		hrtick_timer;
>  #endif
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4444,9 +4444,9 @@ EXPORT_SYMBOL(rps_may_expire_flow);
>  #endif /* CONFIG_RFS_ACCEL */
>  
>  /* Called from hardirq (IPI) context */
> -static void rps_trigger_softirq(void *data)
> +static void rps_trigger_softirq(struct irq_work *work)
>  {
> -	struct softnet_data *sd = data;
> +	struct softnet_data *sd = container_of(work, struct softnet_data, work);
>  
>  	____napi_schedule(sd, &sd->backlog);
>  	sd->received_rps++;
> @@ -6185,8 +6185,13 @@ static void net_rps_send_ipi(struct soft
>  	while (remsd) {
>  		struct softnet_data *next = remsd->rps_ipi_next;
>  
> -		if (cpu_online(remsd->cpu))
> -			smp_call_function_single_async(remsd->cpu, &remsd->csd);
> +		if (cpu_online(remsd->cpu)) {
> +			/*
> +			 * XXX can there be two CPUs calling into the same remsd?
> +			 * XXX serialized by NAPI_STATE_SCHED ??
> +			 */
> +			irq_work_queue_remote_static(remsd->cpu, &remsd->work);
> +		}
>  		remsd = next;
>  	}
>  #endif
> @@ -10661,7 +10666,7 @@ static int __init net_dev_init(void)
>  		INIT_LIST_HEAD(&sd->poll_list);
>  		sd->output_queue_tailp = &sd->output_queue;
>  #ifdef CONFIG_RPS
> -		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
> +		init_irq_work(&sd->work, rps_trigger_softirq);
>  		sd->cpu = i;
>  #endif
>  
> 
> 
