Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146D822280
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592604958;
	bh=oGdrWFmzcn/fUI9vDRh7kkjCYNNTH9+Gfs7Db+4xdWQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ns7OcuZTeortLuhmDOja3ZZUGnWzMyjrgWwzHBtU/uXjYCsvCJN7j3QLRibEv61xv
	 p2RH712WG5htI8Vl99Z/+cA0mu9BynM8wYDof4F1vcGXZDlrb2V20unEXymVnLg9gW
	 3d+rPMlY2Xm4BXr+ATdTTf90ZvuRsB9ipFfEWFh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFSWP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbgFSWP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:15:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBD622277;
        Fri, 19 Jun 2020 22:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592604955;
        bh=oGdrWFmzcn/fUI9vDRh7kkjCYNNTH9+Gfs7Db+4xdWQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=emfRRWgrmE6MXKwdlaU2RV6Z0MiUsjXz1iPKV8TpWMYNeaAoC3sZRvMNq4CuJPUPH
         Y2o53+iwKD7+YHL3cFmU+2NdiTV8aLVjA2w/hTb+uXi/mLZHxpA3qTtdk3pWDCEZVc
         EzsadS1MgQYc6H37zA3mRlHu5Sb8VWmik+jJkb+0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5CEF93522B50; Fri, 19 Jun 2020 15:15:55 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:15:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200619221555.GA12280@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615171404.GI2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:14:04AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 15, 2020 at 06:24:27PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 15, 2020 at 05:55:13PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 15, 2020 at 05:49:05PM +0200, Peter Zijlstra wrote:
> > > > @@ -983,13 +993,17 @@ noinstr void rcu_nmi_enter(void)
> > > >  		if (!in_nmi())
> > > >  			rcu_cleanup_after_idle();
> > > >  
> > > > +		instrumentation_begin();
> > > > +		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> > > > +		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> > > > +		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
> > > > +		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > > > +
> > > >  		incby = 1;
> > > >  	} else if (!in_nmi()) {
> > > >  		instrumentation_begin();
> > > >  		rcu_irq_enter_check_tick();
> > > > -		instrumentation_end();
> > > >  	}
> > > > -	instrumentation_begin();
> > > >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> > > >  			  rdp->dynticks_nmi_nesting,
> > > >  			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
> > > 
> > > Oh, that's lost a possible instrumentation_begin() :/ But weirdly
> > > objtool didn't complain about that... Let me poke at that.
> 
> This merge window has been quite the trainwreck, hasn't it?  :-/
> 
> > Like so then...
> 
> Looks plausible, firing up some tests.

Just following up because I don't see this anywhere.  If I am supposed
to take this (which is more plausible now that v5.8-rc1 is out), please
let me know.

							Thanx, Paul

> > ---
> > Subject: rcu: Fixup noinstr warnings
> > 
> > A KCSAN build revealed we have explicit annoations through atomic_*()
> > usage, switch to arch_atomic_*() for the respective functions.
> > 
> > vmlinux.o: warning: objtool: rcu_nmi_exit()+0x4d: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_nmi_enter()+0x4f: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2a: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: __rcu_is_watching()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> > 
> > Additionally, without the NOP in instrumentation_begin(), objtool would
> > not detect the lack of the 'else instrumentation_begin();' branch in
> > rcu_nmi_enter().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/compiler.h |    2 +-
> >  kernel/rcu/tree.c        |   33 +++++++++++++++++++++++++--------
> >  2 files changed, 26 insertions(+), 9 deletions(-)
> > 
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -123,7 +123,7 @@ void ftrace_likely_update(struct ftrace_
> >  #ifdef CONFIG_DEBUG_ENTRY
> >  /* Begin/end of an instrumentation safe region */
> >  #define instrumentation_begin() ({					\
> > -	asm volatile("%c0:\n\t"						\
> > +	asm volatile("%c0: nop\n\t"						\
> >  		     ".pushsection .discard.instr_begin\n\t"		\
> >  		     ".long %c0b - .\n\t"				\
> >  		     ".popsection\n\t" : : "i" (__COUNTER__));		\
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -250,7 +250,7 @@ static noinstr void rcu_dynticks_eqs_ent
> >  	 * next idle sojourn.
> >  	 */
> >  	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> >  	// RCU is no longer watching.  Better be in extended quiescent state!
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> >  		     (seq & RCU_DYNTICK_CTRL_CTR));
> > @@ -274,13 +274,13 @@ static noinstr void rcu_dynticks_eqs_exi
> >  	 * and we also must force ordering with the next RCU read-side
> >  	 * critical section.
> >  	 */
> > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> >  	// RCU is now watching.  Better not be in an extended quiescent state!
> >  	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> >  		     !(seq & RCU_DYNTICK_CTRL_CTR));
> >  	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > +		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> >  		smp_mb__after_atomic(); /* _exit after clearing mask. */
> >  	}
> >  }
> > @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > +	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> >  }
> >  
> >  /*
> > @@ -633,6 +633,10 @@ static noinstr void rcu_eqs_enter(bool u
> >  	do_nocb_deferred_wakeup(rdp);
> >  	rcu_prepare_for_idle();
> >  	rcu_preempt_deferred_qs(current);
> > +
> > +	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
> > +	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > +
> >  	instrumentation_end();
> >  	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
> >  	// RCU is watching here ...
> > @@ -692,6 +696,7 @@ noinstr void rcu_nmi_exit(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > +	instrumentation_begin();
> >  	/*
> >  	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
> >  	 * (We are exiting an NMI handler, so RCU better be paying attention
> > @@ -705,7 +710,6 @@ noinstr void rcu_nmi_exit(void)
> >  	 * leave it in non-RCU-idle state.
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> > -		instrumentation_begin();
> >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> >  				  atomic_read(&rdp->dynticks));
> >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> > @@ -714,13 +718,15 @@ noinstr void rcu_nmi_exit(void)
> >  		return;
> >  	}
> >  
> > -	instrumentation_begin();
> >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> >  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> >  
> >  	if (!in_nmi())
> >  		rcu_prepare_for_idle();
> > +
> > +	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
> > +	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> >  	instrumentation_end();
> >  
> >  	// RCU is watching here ...
> > @@ -838,6 +844,10 @@ static void noinstr rcu_eqs_exit(bool us
> >  	rcu_dynticks_eqs_exit();
> >  	// ... but is watching here.
> >  	instrumentation_begin();
> > +
> > +	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
> > +	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > +
> >  	rcu_cleanup_after_idle();
> >  	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> > @@ -983,13 +993,20 @@ noinstr void rcu_nmi_enter(void)
> >  		if (!in_nmi())
> >  			rcu_cleanup_after_idle();
> >  
> > +		instrumentation_begin();
> > +		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> > +		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> > +		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
> > +		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > +
> >  		incby = 1;
> >  	} else if (!in_nmi()) {
> >  		instrumentation_begin();
> >  		rcu_irq_enter_check_tick();
> > -		instrumentation_end();
> > +	} else {
> > +		instrumentation_begin();
> >  	}
> > -	instrumentation_begin();
> > +
> >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> >  			  rdp->dynticks_nmi_nesting,
> >  			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
