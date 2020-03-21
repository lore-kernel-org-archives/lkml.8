Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7761C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B344620753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584808862;
	bh=aLFpN7azzh+LrYbTd9kSEjrYC/vM8kmZqvN4T5O775Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MvOFLtmer6n5btFDbtqE9PlfvqYeZhUGCY6C33YA3uvlj9HUXTxsRl6g5C6p05T73
	 T06bPlLC6DjrqhBj6TJ68a4qaXJUlOlgHFq6wS6nd9IWhpOH1Z6pMB6WQs2w/TikU2
	 5zZAiJazvTkTHN0m/7Yunadct6+QX/nFOCg3t2GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCUQlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgCUQlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:41:01 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B9220732;
        Sat, 21 Mar 2020 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584808860;
        bh=aLFpN7azzh+LrYbTd9kSEjrYC/vM8kmZqvN4T5O775Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCE8kiaDBhK/QW5fivlSowbUNNrZEFJibh2lRHO5S21B93DIqSyquPgRzvv5pdm0B
         Kikdz+bwcHWP0aBvUPY/KUcHVB2DlFiKlnd/jgUbVwd2NwAw1g58Wk5ozO8THnKkTB
         FG966KWkpVaH2CHFdEe2IiRDDZp1mr4uMk2Fz0us=
Date:   Sat, 21 Mar 2020 17:40:58 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Annotate irq_work
Message-ID: <20200321164057.GA9634@lenoir>
References: <20200321113242.643576700@linutronix.de>
 <158480602510.28353.4851999853077941579.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158480602510.28353.4851999853077941579.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 03:53:45PM -0000, tip-bot2 for Sebastian Andrzej Siewior wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     49915ac35ca7b07c54295a72d905be5064afb89e
> Gitweb:        https://git.kernel.org/tip/49915ac35ca7b07c54295a72d905be5064afb89e
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Sat, 21 Mar 2020 12:26:03 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Sat, 21 Mar 2020 16:00:24 +01:00
> 
> lockdep: Annotate irq_work
> 
> Mark irq_work items with IRQ_WORK_HARD_IRQ which should be invoked in
> hardirq context even on PREEMPT_RT. IRQ_WORK without this flag will be
> invoked in softirq context on PREEMPT_RT.
> 
> Set ->irq_config to 1 for the IRQ_WORK items which are invoked in softirq
> context so lockdep knows that these can safely acquire a spinlock_t.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200321113242.643576700@linutronix.de
> ---
>  include/linux/irq_work.h |  2 ++
>  include/linux/irqflags.h | 13 +++++++++++++
>  kernel/irq_work.c        |  2 ++
>  kernel/rcu/tree.c        |  1 +
>  kernel/time/tick-sched.c |  1 +
>  5 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 02da997..3b752e8 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -18,6 +18,8 @@
>  
>  /* Doesn't want IPI, wait for tick: */
>  #define IRQ_WORK_LAZY		BIT(2)
> +/* Run hard IRQ context, even on RT */
> +#define IRQ_WORK_HARD_IRQ	BIT(3)
>  
>  #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
>  
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 9c17f9c..f23f540 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -69,6 +69,17 @@ do {						\
>  			current->irq_config = 0;	\
>  	  } while (0)
>  
> +# define lockdep_irq_work_enter(__work)					\
> +	  do {								\
> +		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
> +			current->irq_config = 1;			\

So, irq_config == 1 means we are in a softirq? Are there other values for
irq_config? In which case there should be enums or something?
I can't find the patch that describes this.

> +	  } while (0)
> +# define lockdep_irq_work_exit(__work)					\
> +	  do {								\
> +		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
> +			current->irq_config = 0;			\
> +	  } while (0)
> +
>  #else
>  # define trace_hardirqs_on()		do { } while (0)
>  # define trace_hardirqs_off()		do { } while (0)
> @@ -83,6 +94,8 @@ do {						\
>  # define lockdep_softirq_exit()		do { } while (0)
>  # define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
>  # define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
> +# define lockdep_irq_work_enter(__work)		do { } while (0)
> +# define lockdep_irq_work_exit(__work)		do { } while (0)
>  #endif
>  
>  #if defined(CONFIG_IRQSOFF_TRACER) || \
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 828cc30..48b5d1b 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -153,7 +153,9 @@ static void irq_work_run_list(struct llist_head *list)
>  		 */
>  		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
>  
> +		lockdep_irq_work_enter(work);
>  		work->func(work);
> +		lockdep_irq_work_exit(work);
>  		/*
>  		 * Clear the BUSY bit and return to the free state if
>  		 * no-one else claimed it meanwhile.
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d91c915..5066d1d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1113,6 +1113,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
>  		    (rnp->ffmask & rdp->grpmask)) {
>  			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
> +			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
>  			rdp->rcu_iw_pending = true;
>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 4be756b..3e2dc9b 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
>  
>  static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
>  	.func = nohz_full_kick_func,
> +	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
>  };

I get why these need to be in hardirq but some basic explanations for
ordinary mortals as to why those two specifically and not all the others
(and there are many) would have been nice.

Thanks.

>  
>  /*
