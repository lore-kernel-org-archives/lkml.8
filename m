Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086C620674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQYalxlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgFCRNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCRNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:13:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19176C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c0f9q7KFHLtUF97X4RtjWgNnpjq+ROwNailvfwoaSyI=; b=gQYalxlXRQuw6vvvJaM/uTx6jl
        AecyrA1TLwvJsPpxhvxTNivdDreADthRBYzaR9j4LuGX45ZX2+zVvTAcCqHJOC4mDnb4A2rFDXvQo
        d4ArrmaorfVmjVurNRmJ/MQ6BPrjHnmPLo+mydhsP+AOdhTbxVAVVBqmp/0tFomS74t+bGeINVa2I
        cfVgqCA9d5mLrfq4Eqalq0xeyqXApoIhk+Umvd/yYhovi6xnZDuKyhju9mS/gYaf3I8sn+0SPN70M
        VUrUdJYYyaBjSZ8ToWHM5yQC0uzLNyur8RCh1czRBCyVfl93vWXlxbiZTRSGzA+kqJVEIbGaMGeno
        /kAci79Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgWx8-0001a4-TM; Wed, 03 Jun 2020 17:13:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44AAC3006D0;
        Wed,  3 Jun 2020 19:13:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3191120C23592; Wed,  3 Jun 2020 19:13:20 +0200 (CEST)
Date:   Wed, 3 Jun 2020 19:13:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200603171320.GE2570@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603164600.GQ29598@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 09:46:00AM -0700, Paul E. McKenney wrote:

> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -250,7 +250,7 @@ static noinstr void rcu_dynticks_eqs_ent
> >  	 * next idle sojourn.
> >  	 */
> >  	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> 
> To preserve KCSAN's ability to see this, there would be something like
> instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) prior
> to the instrumentation_end() invoked before rcu_dynticks_eqs_enter()
> in each of rcu_eqs_enter() and rcu_nmi_exit(), correct?

Yes.

> >  	// RCU is no longer watching.  Better be in extended quiescent state!
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> >  		     (seq & RCU_DYNTICK_CTRL_CTR));
> > @@ -274,13 +274,13 @@ static noinstr void rcu_dynticks_eqs_exi
> >  	 * and we also must force ordering with the next RCU read-side
> >  	 * critical section.
> >  	 */
> > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> 
> And same here, but after the instrumentation_begin() following
> rcu_dynticks_eqs_exit() in both rcu_eqs_exit() and rcu_nmi_enter(),
> correct?

Yep.

> >  	// RCU is now watching.  Better not be in an extended quiescent state!
> >  	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> >  		     !(seq & RCU_DYNTICK_CTRL_CTR));
> >  	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > +		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> 
> This one is gone in -rcu.

Good, because that would make things 'complicated' with the external
instrumentation call. And is actually the reason I didn't even attempt
it this time around.

> >  		smp_mb__after_atomic(); /* _exit after clearing mask. */
> >  	}
> >  }
> > @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > +	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);

The above is actually instrumented by KCSAN, due to arch_atomic_read()
being a READ_ONCE() and it now understanding volatile.

> Also instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) as
> follows:
> 
> o	rcu_nmi_exit(): After each following instrumentation_begin().

Yes

> o	In theory in rcu_irq_exit_preempt(), but as this generates code
> 	only in lockdep builds, it might not be worth worrying about.
> 
> o	Ditto for rcu_irq_exit_check_preempt().
> 
> o	Ditto for __rcu_irq_enter_check_tick().

Not these, afaict they're all the above arch_atomic_read(), which is
instrumented due to volatile in these cases.

> o	rcu_nmi_enter(): After each following instrumentation_begin().

Yes

> o	__rcu_is_watching() is itself noinstr:
> 
> 	o	idtentry_enter_cond_rcu(): After each following
> 		instrumentation_begin().
> 
> o	rcu_is_watching(): Either before or after the call to
> 	rcu_dynticks_curr_cpu_in_eqs().

Something like that yes.

> >  }
> >  
> >  /*
> > @@ -692,6 +692,7 @@ noinstr void rcu_nmi_exit(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > +	instrumentation_begin();
> >  	/*
> >  	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
> >  	 * (We are exiting an NMI handler, so RCU better be paying attention
> > @@ -705,7 +706,6 @@ noinstr void rcu_nmi_exit(void)
> >  	 * leave it in non-RCU-idle state.
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> > -		instrumentation_begin();
> >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> >  				  atomic_read(&rdp->dynticks));
> >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> > @@ -714,7 +714,6 @@ noinstr void rcu_nmi_exit(void)
> >  		return;
> >  	}
> >  
> > -	instrumentation_begin();
> >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> >  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> 
> This one looks to be having no effect on instrumentation of atomics, but
> rather coalescing a pair of instrumentation_begin() into one.
> 
> Do I understand correctly?

Almost, it puts the WARN_ON_ONCE()s under instrumentation_begin() too,
and that makes a differnce, iirc it was the
rcu_dynticks_curr_cpu_in_eqs() call that stood out. But that could've
been before I switched it to arch_atomic_read(). In any case, I find
this form a lot clearer.
