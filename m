Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B919C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764DD20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590595025;
	bh=Ik6t3kw79TqNezTHS+OiIuNo2tlFgr4eybIwx61pe/8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OGG2ImT04+thmgAiBXdsec7LPyFukVopm6Ni0UserDj3pgTf5a125O8SWnW/TyjP1
	 Qs9ODHN/gVp3FGt0NNFYeUjaKWbeEx3+2rgvRefnepP2sJu575bwxFXvE+Df/qHQiM
	 gJ4S0wSPdvOfZcORKOoQl96uxmbWjCLWu4OyOODs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgE0P5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbgE0P45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:56:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1682320776;
        Wed, 27 May 2020 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590595017;
        bh=Ik6t3kw79TqNezTHS+OiIuNo2tlFgr4eybIwx61pe/8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ooaILInhRblQrCFPRyWa/J6/8OQCLqzd3B+W0MH4F3bJu7mCY5F7RVJzR++paYS+6
         mAxqnYdkYb5zDA5FlQYjrOE4JounVdJ88UBifHr/S6Vx9GUKBZRRx3P8fvR0Ae02QS
         /TR5lXbcf2etddptyx08Pq6Bbad0r8xzRHhD8R40=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DA74F3522839; Wed, 27 May 2020 08:56:56 -0700 (PDT)
Date:   Wed, 27 May 2020 08:56:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200527155656.GU2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:15:13PM +0200, Peter Zijlstra wrote:
> On Wed, May 27, 2020 at 11:56:45AM +0200, Peter Zijlstra wrote:
> 
> > This is rcu_is_cpu_rrupt_from_idle()'s lockdep_assert_in_irq() tripping
> > up (it's comment is obviously a bit antiquated).
> > 
> > Now, if I read that code correctly, it actually relies on
> > rcu_irq_enter() and thus really wants to be in an interrupt. Is there
> > any way this code can be made to work from the new context too?
> > 
> > After all, all that really is different is not having gone throught he
> > bother of setting up the IRQ context, nothing else changed -- it just so
> > happens you actually relied on that ;/
> 
> At first glance, something like the below could work. But obviously I
> might have overlooked something more subtle than a brick :-)

This can work, but only if the call from the idle loop is a place where
either RCU isn't watching on the one hand or that cannot be in an RCU
read-side critical section on the other.  Because rcu_exp_handler()
assumes that if this function returns true, we are not in an RCU read-side
critical section.  (I would expect this to be the case, but I figured
that I should make it explicit.)

> ---
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 90c8be22d57a..0792c032a972 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -426,8 +426,11 @@ EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
>   */

Could we please have a comment noting the change in semantics and
the reason?

>  static int rcu_is_cpu_rrupt_from_idle(void)
>  {
> -	/* Called only from within the scheduling-clock interrupt */
> -	lockdep_assert_in_irq();
> +	/*
> +	 * Usually called from the tick; but also used from smp_call_function()
> +	 * for expedited grace periods.
> +	 */
> +	lockdep_assert_irqs_disabled();
>  
>  	/* Check for counter underflows */
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> @@ -435,8 +438,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
>  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
>  
> -	/* Are we at first interrupt nesting level? */
> -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> +	/*
> +	 * Are we at first interrupt nesting level? -- or below, when running
> +	 * directly from the idle loop itself.
> +	 */
> +	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) > 1)

Wouldn't it also be a good idea to check that we are in the context of
an idle thread?  Just in case some idiot like me drops a call to this
function in the wrong place, for example, if I were to mistakenly remember
the old semantics where it would return false from process context?

Maybe something like this?

	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting;
	if (nesting > 1)
		return false;
	WARN_ON_ONCE(!nesting && !is_idle_task(current));

>  		return false;
>  
>  	/* Does CPU appear to be idle from an RCU standpoint? */

And let's check the other callers:

rcu_sched_clock_irq():  This will always be called from IRQ (right?), so
	no problem.

rcu_pending():  Only called from rcu_sched_clock_irq(), so still no problem.

rcu_flavor_sched_clock_irq(): Ditto for both definitions.

							Thanx, Paul
