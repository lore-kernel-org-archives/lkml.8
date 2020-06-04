Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D23C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663B420772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591241652;
	bh=gt4qqSNeMEPnaSAiYD6PO8BVbCUAl+iOh1hthwO2Yz4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=x0VVaqOeOelPu4y9jTudPcSj6Y+6/ZRrrHF7xCNN3ZhpBHOEMv6MovNxq+/uOxxOk
	 C58b+UtvozopMcHa5BCk0t4J2GU7s4MJUOFERufXFtt0j63Epf7yEr6nocgRU10ADh
	 yt6Pp2UYYNNtnIYGK9lOk7ofp7TwT0O7KWuj5ufQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgFDDeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 23:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgFDDeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:34:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE42C206DC;
        Thu,  4 Jun 2020 03:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591241649;
        bh=gt4qqSNeMEPnaSAiYD6PO8BVbCUAl+iOh1hthwO2Yz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F8kKGoeQMHCcStKwKTGmR7SlI1ffeGcY5BuLwHDRWXMq5aFmzGmAFFPD4I03Tt2in
         MOEnf8DRvgjP9aGZVWObC9bFo2kZbwy39dMUSWSkp1NN9er6fo5NAN4K4Lw8PkvISK
         Jd7+gVFYKPdQ3+kTL5V+OXsL/c45wDep2PyPFWCY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B2EDE3522946; Wed,  3 Jun 2020 20:34:09 -0700 (PDT)
Date:   Wed, 3 Jun 2020 20:34:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200604033409.GX29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72>
 <20200603171320.GE2570@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603171320.GE2570@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 07:13:20PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 03, 2020 at 09:46:00AM -0700, Paul E. McKenney wrote:
> 
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -250,7 +250,7 @@ static noinstr void rcu_dynticks_eqs_ent
> > >  	 * next idle sojourn.
> > >  	 */
> > >  	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> > > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > 
> > To preserve KCSAN's ability to see this, there would be something like
> > instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) prior
> > to the instrumentation_end() invoked before rcu_dynticks_eqs_enter()
> > in each of rcu_eqs_enter() and rcu_nmi_exit(), correct?
> 
> Yes.
> 
> > >  	// RCU is no longer watching.  Better be in extended quiescent state!
> > >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > >  		     (seq & RCU_DYNTICK_CTRL_CTR));
> > > @@ -274,13 +274,13 @@ static noinstr void rcu_dynticks_eqs_exi
> > >  	 * and we also must force ordering with the next RCU read-side
> > >  	 * critical section.
> > >  	 */
> > > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > 
> > And same here, but after the instrumentation_begin() following
> > rcu_dynticks_eqs_exit() in both rcu_eqs_exit() and rcu_nmi_enter(),
> > correct?
> 
> Yep.
> 
> > >  	// RCU is now watching.  Better not be in an extended quiescent state!
> > >  	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> > >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > >  		     !(seq & RCU_DYNTICK_CTRL_CTR));
> > >  	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > > +		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > 
> > This one is gone in -rcu.
> 
> Good, because that would make things 'complicated' with the external
> instrumentation call. And is actually the reason I didn't even attempt
> it this time around.
> 
> > >  		smp_mb__after_atomic(); /* _exit after clearing mask. */
> > >  	}
> > >  }
> > > @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  
> > > -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > > +	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> 
> The above is actually instrumented by KCSAN, due to arch_atomic_read()
> being a READ_ONCE() and it now understanding volatile.
> 
> > Also instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) as

Right, this should instead be instrument_read(...).

Though if KCSAN is unconditionally instrumenting volatile, how does
this help?  Or does KCSAN's instrumentation of volatile somehow avoid
causing trouble?

> > follows:
> > 
> > o	rcu_nmi_exit(): After each following instrumentation_begin().
> 
> Yes
> 
> > o	In theory in rcu_irq_exit_preempt(), but as this generates code
> > 	only in lockdep builds, it might not be worth worrying about.
> > 
> > o	Ditto for rcu_irq_exit_check_preempt().
> > 
> > o	Ditto for __rcu_irq_enter_check_tick().
> 
> Not these, afaict they're all the above arch_atomic_read(), which is
> instrumented due to volatile in these cases.
> 
> > o	rcu_nmi_enter(): After each following instrumentation_begin().
> 
> Yes
> 
> > o	__rcu_is_watching() is itself noinstr:
> > 
> > 	o	idtentry_enter_cond_rcu(): After each following
> > 		instrumentation_begin().
> > 
> > o	rcu_is_watching(): Either before or after the call to
> > 	rcu_dynticks_curr_cpu_in_eqs().
> 
> Something like that yes.
> 
> > >  }
> > >  
> > >  /*
> > > @@ -692,6 +692,7 @@ noinstr void rcu_nmi_exit(void)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  
> > > +	instrumentation_begin();
> > >  	/*
> > >  	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
> > >  	 * (We are exiting an NMI handler, so RCU better be paying attention
> > > @@ -705,7 +706,6 @@ noinstr void rcu_nmi_exit(void)
> > >  	 * leave it in non-RCU-idle state.
> > >  	 */
> > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > > -		instrumentation_begin();
> > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> > >  				  atomic_read(&rdp->dynticks));
> > >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> > > @@ -714,7 +714,6 @@ noinstr void rcu_nmi_exit(void)
> > >  		return;
> > >  	}
> > >  
> > > -	instrumentation_begin();
> > >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> > >  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> > >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> > 
> > This one looks to be having no effect on instrumentation of atomics, but
> > rather coalescing a pair of instrumentation_begin() into one.
> > 
> > Do I understand correctly?
> 
> Almost, it puts the WARN_ON_ONCE()s under instrumentation_begin() too,
> and that makes a differnce, iirc it was the
> rcu_dynticks_curr_cpu_in_eqs() call that stood out. But that could've
> been before I switched it to arch_atomic_read(). In any case, I find
> this form a lot clearer.

Got it, thank you.

						Thanx, Paul
