Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337BC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2DF206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588702422;
	bh=nFqsSItk6/KyZhr1ODof6nzz4Q3gFjuZ16+guqpiANE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=x40pA/EiqgbvRCSE+zITl7ppt/mduEGFqVFD06DIBvQqmUdyaunoYW/4U5F7d0zsL
	 6R5pH5uCa2jShnosfv9vQrRYzXl5hU48Ug6XqifvYOVg85AzVnjlFVFtB2aQwT1KJp
	 LqQSB8H5bH8CpR2Xm5VcBZr7bQ2FstXFMRLW0ErQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgEESNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbgEESNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:13:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703CB20721;
        Tue,  5 May 2020 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588702420;
        bh=nFqsSItk6/KyZhr1ODof6nzz4Q3gFjuZ16+guqpiANE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0vvda6SWmb3xZwH7XfggcRPPJLcH60ZCq51PlEw72oXpHiaK9j8Tfbi57QZTjeMUk
         5+oyRtExWYlGB6VGTvr0C+z4qyELDLgL1YsbpcKu71otq+p3qeeaMJsTU8wVIF0Xvy
         832kyMtCKYSUj+iSogudPH/lqQ09Jj8L6jL2+yqg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4EBCE3523039; Tue,  5 May 2020 11:13:40 -0700 (PDT)
Date:   Tue, 5 May 2020 11:13:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 36/36] rcu: Make RCU IRQ enter/exit functions
 rely on in_nmi()
Message-ID: <20200505181340.GI2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505131602.633487962@linutronix.de>
 <20200505134101.617130349@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134101.617130349@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:38PM +0200, Thomas Gleixner wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> "irq" parameter that indicates whether these functions are invoked from
> an irq handler (irq==true) or an NMI handler (irq==false).  However,
> recent changes have applied notrace to a few critical functions such
> that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> on in_nmi().  Note that in_nmi() works no differently than before,
> but rather that tracing is now prohibited in code regions where in_nmi()
> would incorrectly report NMI state.
> 
> Therefore remove the "irq" parameter and inlines rcu_nmi_enter_common() and
> rcu_nmi_exit_common() into rcu_nmi_enter() and rcu_nmi_exit(),
> respectively.

Not a bad job of ghostwriting, actually.  I had forgotten about this
entirely, but did find my February 13th email containing this patch.  ;-)

But why not make the commit log official?

------------------------------------------------------------------------

The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
"irq" parameter that indicates whether these functions have been invoked
from an irq handler (irq==true) or an NMI handler (irq==false).  However,
recent changes have applied notrace to a number of critical functions,
thus allowing rcu_nmi_enter_common() and rcu_nmi_exit_common() to rely
on in_nmi().  Note that in_nmi() works no differently than before.
Instead, tracing is now prohibited in code regions where in_nmi() would
previously have incorrectly reported NMI state.

This commit therefore removes the "irq" parameter and inlines
rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
and rcu_nmi_exit(), respectively.

------------------------------------------------------------------------

With that commit log, looks good to me!

							Thanx, Paul

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/rcu/tree.c |   47 +++++++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 32 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -627,16 +627,18 @@ noinstr void rcu_user_enter(void)
>  }
>  #endif /* CONFIG_NO_HZ_FULL */
>  
> -/*
> +/**
> + * rcu_nmi_exit - inform RCU of exit from NMI context
> + *
>   * If we are returning from the outermost NMI handler that interrupted an
>   * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
>   * to let the RCU grace-period handling know that the CPU is back to
>   * being RCU-idle.
>   *
> - * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> + * If you add or remove a call to rcu_nmi_exit(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -static __always_inline void rcu_nmi_exit_common(bool irq)
> +noinstr void rcu_nmi_exit(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -667,7 +669,7 @@ static __always_inline void rcu_nmi_exit
>  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
> -	if (irq)
> +	if (!in_nmi())
>  		rcu_prepare_for_idle();
>  	instr_end();
>  
> @@ -675,22 +677,11 @@ static __always_inline void rcu_nmi_exit
>  	rcu_dynticks_eqs_enter();
>  	// ... but is no longer watching here.
>  
> -	if (irq)
> +	if (!in_nmi())
>  		rcu_dynticks_task_enter();
>  }
>  
>  /**
> - * rcu_nmi_exit - inform RCU of exit from NMI context
> - *
> - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> - * with CONFIG_RCU_EQS_DEBUG=y.
> - */
> -void noinstr rcu_nmi_exit(void)
> -{
> -	rcu_nmi_exit_common(false);
> -}
> -
> -/**
>   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
>   *
>   * Exit from an interrupt handler, which might possibly result in entering
> @@ -712,7 +703,7 @@ void noinstr rcu_nmi_exit(void)
>  void noinstr rcu_irq_exit(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -	rcu_nmi_exit_common(true);
> +	rcu_nmi_exit();
>  }
>  
>  /*
> @@ -801,7 +792,7 @@ void noinstr rcu_user_exit(void)
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> - * rcu_nmi_enter_common - inform RCU of entry to NMI context
> + * rcu_nmi_enter - inform RCU of entry to NMI context
>   * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
> @@ -810,10 +801,10 @@ void noinstr rcu_user_exit(void)
>   * long as the nesting level does not overflow an int.  (You will probably
>   * run out of stack space first.)
>   *
> - * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> + * If you add or remove a call to rcu_nmi_enter(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -static __always_inline void rcu_nmi_enter_common(bool irq)
> +noinstr void rcu_nmi_enter(void)
>  {
>  	long incby = 2;
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> @@ -831,18 +822,18 @@ static __always_inline void rcu_nmi_ente
>  	 */
>  	if (rcu_dynticks_curr_cpu_in_eqs()) {
>  
> -		if (irq)
> +		if (!in_nmi())
>  			rcu_dynticks_task_exit();
>  
>  		// RCU is not watching here ...
>  		rcu_dynticks_eqs_exit();
>  		// ... but is watching here.
>  
> -		if (irq)
> +		if (!in_nmi())
>  			rcu_cleanup_after_idle();
>  
>  		incby = 1;
> -	} else if (irq) {
> +	} else if (!in_nmi()) {
>  		instr_begin();
>  		if (tick_nohz_full_cpu(rdp->cpu) &&
>  		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> @@ -877,14 +868,6 @@ static __always_inline void rcu_nmi_ente
>  }
>  
>  /**
> - * rcu_nmi_enter - inform RCU of entry to NMI context
> - */
> -noinstr void rcu_nmi_enter(void)
> -{
> -	rcu_nmi_enter_common(false);
> -}
> -
> -/**
>   * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
>   *
>   * Enter an interrupt handler, which might possibly result in exiting
> @@ -909,7 +892,7 @@ noinstr void rcu_nmi_enter(void)
>  noinstr void rcu_irq_enter(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -	rcu_nmi_enter_common(true);
> +	rcu_nmi_enter();
>  }
>  
>  /*
> 
