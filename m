Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74398C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5244120C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590608357;
	bh=NYjYFRWuetYB9Od8nP9wiWBPb4skmdKoSCs7OaoHLEg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MLkQqxCmhLcLnIj9zF7VXXS6pyp5K0zbpaLU/9KVpiO4CSD4HlQCFttZb0xbPWi80
	 xr/hvhwaZnOod6tttgjJh2WQOVftURmm7CQtxjrpiZuGRO/N0LL1dU0H4bWhchO/B+
	 uTphFbpj0xhlmIFGmSqeHysKZ4a/NL17HNiQRxVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgE0TjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0TjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:39:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4C02089D;
        Wed, 27 May 2020 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590608354;
        bh=NYjYFRWuetYB9Od8nP9wiWBPb4skmdKoSCs7OaoHLEg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jvUIALf9+RrftAxL1TGJe1MRf37O6szJEUVBZ2R5oVnWzYOOTNawv9kcv0rruCSIH
         CDBX/0mWJ7sv3aKK8KDcOu9wb3vic7VzxpgsVh8wrYNis+xNNBHXCxZr+HTznNaDPr
         Qtzas+Sbql95uoXeQm0Dtnomn7GugXx6L/eT6r5s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2E197352283B; Wed, 27 May 2020 12:39:14 -0700 (PDT)
Date:   Wed, 27 May 2020 12:39:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200527193914.GW2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
 <20200527163543.GA706478@hirez.programming.kicks-ass.net>
 <20200527171236.GC706495@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527171236.GC706495@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 07:12:36PM +0200, Peter Zijlstra wrote:
> On Wed, May 27, 2020 at 06:35:43PM +0200, Peter Zijlstra wrote:
> > Right, I went though them, didn't find anything obvious amiss. OK, let
> > me do a nicer patch.
> 
> something like so then?
> 
> ---
> Subject: rcu: Allow for smp_call_function() running callbacks from idle
> 
> Current RCU hard relies on smp_call_function() callbacks running from
> interrupt context. A pending optimization is going to break that, it
> will allow idle CPUs to run the callbacks from the idle loop. This
> avoids raising the IPI on the requesting CPU and avoids handling an
> exception on the receiving CPU.
> 
> Change rcu_is_cpu_rrupt_from_idle() to also accept task context,
> provided it is the idle task.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c   | 25 +++++++++++++++++++------
>  kernel/sched/idle.c |  4 ++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d8e9dbbefcfa..c716eadc7617 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -418,16 +418,23 @@ void rcu_momentary_dyntick_idle(void)
>  EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
>  
>  /**
> - * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
> + * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
>   *
>   * If the current CPU is idle and running at a first-level (not nested)
> - * interrupt from idle, return true.  The caller must have at least
> - * disabled preemption.
> + * interrupt, or directly, from idle, return true.
> + *
> + * The caller must have at least disabled IRQs.
>   */
>  static int rcu_is_cpu_rrupt_from_idle(void)
>  {
> -	/* Called only from within the scheduling-clock interrupt */
> -	lockdep_assert_in_irq();
> +	long nesting;
> +
> +	/*
> +	 * Usually called from the tick; but also used from smp_function_call()
> +	 * for expedited grace periods. This latter can result in running from
> +	 * the idle task, instead of an actual IPI.
> +	 */
> +	lockdep_assert_irqs_disabled();
>  
>  	/* Check for counter underflows */
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> @@ -436,9 +443,15 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
>  
>  	/* Are we at first interrupt nesting level? */
> -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> +	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> +	if (nesting > 1)
>  		return false;
>  
> +	/*
> +	 * If we're not in an interrupt, we must be in the idle task!
> +	 */
> +	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> +
>  	/* Does CPU appear to be idle from an RCU standpoint? */
>  	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
>  }
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index e9cef84c2b70..05deb81bb3e3 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -289,6 +289,10 @@ static void do_idle(void)
>  	 */
>  	smp_mb__after_atomic();
>  
> +	/*
> +	 * RCU relies on this call to be done outside of an RCU read-side
> +	 * critical section.
> +	 */
>  	flush_smp_call_function_from_idle();
>  	schedule_idle();
>  
