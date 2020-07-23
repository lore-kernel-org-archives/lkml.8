Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A530C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46AE207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595520855;
	bh=MUgEvttOZFit21GEOnkcJYKUfhWw2/6qnDhuAAp/BH8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=P2waFP8hPxLdQyjZRLb714c/fMjuQ4x7GFTfhpd/ecVJPJqK0GhbZhY+ioyEIyz7v
	 OzM9jDkIToZSRm6O73HB78WE/CjYldcLOG+adPioZR/Al/cx8qsnWFvHau/rHrJ4YW
	 HaGSa7GLtpyLCWTrvqToDlhDBdJMkbd4UdG0ltzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGWQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgGWQOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:14:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F41208E4;
        Thu, 23 Jul 2020 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595520851;
        bh=MUgEvttOZFit21GEOnkcJYKUfhWw2/6qnDhuAAp/BH8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c/T/LAEFVMVcPW2H0Q+NTe/uPRvhHT917vKYfJC9y4pk/C/1ZGCbD75cxQHKu5JdW
         qgOlF8F1D6HyD7ecR6VXr5FreYyVL4LzIgErBz6ZTQo2Y3KBwjuBywczamt2FX9/44
         l2dQ9FA4xBTbQyuvaJpsF/uZX6WYreyOpwvTdOoI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1AC5835235E4; Thu, 23 Jul 2020 09:14:11 -0700 (PDT)
Date:   Thu, 23 Jul 2020 09:14:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200723161411.GA23103@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722153017.024407984@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:01:50PM +0200, Peter Zijlstra wrote:
> Get rid of the __call_single_node union and clean up the API a little
> to avoid external code relying on the structure layout as much.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

As noted earlier, cleaning up that union is most welcome!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

One nit below, with that fixed:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  drivers/gpu/drm/i915/i915_request.c |    4 ++--
>  include/linux/irq_work.h            |   33 +++++++++++++++++++++------------
>  include/linux/irqflags.h            |    4 ++--
>  kernel/bpf/stackmap.c               |    2 +-
>  kernel/irq_work.c                   |   18 +++++++++---------
>  kernel/printk/printk.c              |    6 ++----
>  kernel/rcu/tree.c                   |    3 +--
>  kernel/time/tick-sched.c            |    6 ++----
>  kernel/trace/bpf_trace.c            |    2 +-
>  9 files changed, 41 insertions(+), 37 deletions(-)
> 
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -196,7 +196,7 @@ __notify_execute_cb(struct i915_request
>  
>  	llist_for_each_entry_safe(cb, cn,
>  				  llist_del_all(&rq->execute_cb),
> -				  work.llnode)
> +				  work.node.llist)
>  		fn(&cb->work);
>  }
>  
> @@ -478,7 +478,7 @@ __await_execution(struct i915_request *r
>  	 * callback first, then checking the ACTIVE bit, we serialise with
>  	 * the completed/retired request.
>  	 */
> -	if (llist_add(&cb->work.llnode, &signal->execute_cb)) {
> +	if (llist_add(&cb->work.node.llist, &signal->execute_cb)) {
>  		if (i915_request_is_active(signal) ||
>  		    __request_in_flight(signal))
>  			__notify_execute_cb_imm(signal);
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -14,28 +14,37 @@
>   */
>  
>  struct irq_work {
> -	union {
> -		struct __call_single_node node;
> -		struct {
> -			struct llist_node llnode;
> -			atomic_t flags;
> -		};
> -	};
> +	struct __call_single_node node;
>  	void (*func)(struct irq_work *);
>  };
>  
> +#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
> +	.node = { .u_flags = (_flags), },			\
> +	.func = (_func),					\
> +}
> +
> +#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
> +#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
> +#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
> +
> +#define DEFINE_IRQ_WORK(name, _f)				\
> +	struct irq_work name = IRQ_WORK_INIT(_f)
> +
>  static inline
>  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
>  {
> -	atomic_set(&work->flags, 0);
> -	work->func = func;
> +	*work = IRQ_WORK_INIT(func);
>  }
>  
> -#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
> -		.flags = ATOMIC_INIT(0),			\
> -		.func  = (_f)					\
> +static inline bool irq_work_is_pending(struct irq_work *work)
> +{
> +	return atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING;
>  }
>  
> +static inline bool irq_work_is_busy(struct irq_work *work)
> +{
> +	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
> +}
>  
>  bool irq_work_queue(struct irq_work *work);
>  bool irq_work_queue_on(struct irq_work *work, int cpu);
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -95,12 +95,12 @@ do {						\
>  
>  # define lockdep_irq_work_enter(__work)					\
>  	  do {								\
> -		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
> +		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
>  			current->irq_config = 1;			\
>  	  } while (0)
>  # define lockdep_irq_work_exit(__work)					\
>  	  do {								\
> -		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
> +		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
>  			current->irq_config = 0;			\
>  	  } while (0)
>  
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -293,7 +293,7 @@ static void stack_map_get_build_id_offse
>  	if (irqs_disabled()) {
>  		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  			work = this_cpu_ptr(&up_read_work);
> -			if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY) {
> +			if (irq_work_is_busy(&work->irq_work)) {
>  				/* cannot queue more up_read, fallback */
>  				irq_work_busy = true;
>  			}
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -31,7 +31,7 @@ static bool irq_work_claim(struct irq_wo
>  {
>  	int oflags;
>  
> -	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->flags);
> +	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
>  	/*
>  	 * If the work is already pending, no need to raise the IPI.
>  	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
> @@ -53,12 +53,12 @@ void __weak arch_irq_work_raise(void)
>  static void __irq_work_queue_local(struct irq_work *work)
>  {
>  	/* If the work is "lazy", handle it from next tick if any */
> -	if (atomic_read(&work->flags) & IRQ_WORK_LAZY) {
> -		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
> +	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
> +		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
>  		    tick_nohz_tick_stopped())
>  			arch_irq_work_raise();
>  	} else {
> -		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
> +		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
>  			arch_irq_work_raise();
>  	}
>  }
> @@ -102,7 +102,7 @@ bool irq_work_queue_on(struct irq_work *
>  	if (cpu != smp_processor_id()) {
>  		/* Arch remote IPI send/receive backend aren't NMI safe */
>  		WARN_ON_ONCE(in_nmi());
> -		__smp_call_single_queue(cpu, &work->llnode);
> +		__smp_call_single_queue(cpu, &work->node.llist);
>  	} else {
>  		__irq_work_queue_local(work);
>  	}
> @@ -142,7 +142,7 @@ void irq_work_single(void *arg)
>  	 * to claim that work don't rely on us to handle their data
>  	 * while we are in the middle of the func.
>  	 */
> -	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
> +	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->node.a_flags);
>  
>  	lockdep_irq_work_enter(work);
>  	work->func(work);
> @@ -152,7 +152,7 @@ void irq_work_single(void *arg)
>  	 * no-one else claimed it meanwhile.
>  	 */
>  	flags &= ~IRQ_WORK_PENDING;
> -	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
> +	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
>  }
>  
>  static void irq_work_run_list(struct llist_head *list)
> @@ -166,7 +166,7 @@ static void irq_work_run_list(struct lli
>  		return;
>  
>  	llnode = llist_del_all(list);
> -	llist_for_each_entry_safe(work, tmp, llnode, llnode)
> +	llist_for_each_entry_safe(work, tmp, llnode, node.llist)
>  		irq_work_single(work);
>  }
>  
> @@ -198,7 +198,7 @@ void irq_work_sync(struct irq_work *work
>  {
>  	lockdep_assert_irqs_enabled();
>  
> -	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
> +	while (irq_work_is_busy(work))
>  		cpu_relax();
>  }
>  EXPORT_SYMBOL_GPL(irq_work_sync);
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3068,10 +3068,8 @@ static void wake_up_klogd_work_func(stru
>  		wake_up_interruptible(&log_wait);
>  }
>  
> -static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
> -	.func = wake_up_klogd_work_func,
> -	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
> -};
> +static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
> +	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
>  
>  void wake_up_klogd(void)
>  {
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1287,8 +1287,6 @@ static int rcu_implicit_dynticks_qs(stru
>  		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
>  		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
>  		    (rnp->ffmask & rdp->grpmask)) {
> -			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);

We are actually better off with the IRQ_WORK_INIT_HARD() here rather
than unconditionally at boot.

The reason for this is that we get here only if a single grace
period extends beyond 10.5 seconds (mainline) or beyond 30 seconds
(many distribution kernels).  Which almost never happens.  And yes,
rcutree_prepare_cpu() is also invoked as each CPU that comes online,
not that this is all that common outside of rcutorture and boot time.  ;-)

> -			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
>  			rdp->rcu_iw_pending = true;
>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> @@ -3895,6 +3893,7 @@ int rcutree_prepare_cpu(unsigned int cpu
>  	rdp->cpu_no_qs.b.norm = true;
>  	rdp->core_needs_qs = false;
>  	rdp->rcu_iw_pending = false;
> +	rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);
>  	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
>  	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -243,10 +243,8 @@ static void nohz_full_kick_func(struct i
>  	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
>  }
>  
> -static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
> -	.func = nohz_full_kick_func,
> -	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
> -};
> +static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
> +	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
>  
>  /*
>   * Kick this CPU if it's full dynticks in order to force it to
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1057,7 +1057,7 @@ static int bpf_send_signal_common(u32 si
>  			return -EINVAL;
>  
>  		work = this_cpu_ptr(&send_signal_work);
> -		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
> +		if (irq_work_is_busy(&work->irq_work))
>  			return -EBUSY;
>  
>  		/* Add the current task, which is the target of sending signal,
> 
> 
