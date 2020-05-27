Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB34C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC68E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mOMM9cG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391266AbgE0QgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:36:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388698AbgE0QgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3SwWv1b1ZZ0d4qKk4MUGy+soL9XW1X7q0hmvw8xul90=; b=mOMM9cG2XuJFDBG+fyrTTt8Gd/
        9/AQlxNVJTeLpT1Aqthkwtrr7sxOOarLnF0AmOHigdFz7jenleaQS/Iqv8ykne0lZjoVXaM7w8f/6
        Bp2Uzf06E/YkIhWdLz0SZq0K3IJG3oyombnNucT8PKzTIMYVcHRhymEyJvOY5yTtr8s1p2xS5OCOn
        9Oc14s9FeGx2IhU6V0r86h1We/4XTeoJ1fdJeWuhG90/hSRmKQszcoGsgsnLyWyZwqygzApAWXkil
        QFj8gUle2Sr6ecnxSycKwKWm38PNyNKMBNhF017oQMYd6vCW/QFCN2fJqQ2CzLk/AJyRfc3SnsXvB
        OtWjTnOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdz1u-0002oU-0o; Wed, 27 May 2020 16:35:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6C30300478;
        Wed, 27 May 2020 18:35:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9033A2B9C7024; Wed, 27 May 2020 18:35:43 +0200 (CEST)
Date:   Wed, 27 May 2020 18:35:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200527163543.GA706478@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527155656.GU2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 08:56:56AM -0700, Paul E. McKenney wrote:
> On Wed, May 27, 2020 at 12:15:13PM +0200, Peter Zijlstra wrote:

> > At first glance, something like the below could work. But obviously I
> > might have overlooked something more subtle than a brick :-)
> 
> This can work, but only if the call from the idle loop is a place where
> either RCU isn't watching on the one hand or that cannot be in an RCU
> read-side critical section on the other. 

Guaranteed no RCU read side, although the call is in a place where RCU
is active again, is that a problem? I think with a bit of work I can
move it to where RCU is still idle.

> Because rcu_exp_handler() assumes that if this function returns true,
> we are not in an RCU read-side critical section.  (I would expect this
> to be the case, but I figured that I should make it explicit.)

Indeed, I shall put a comment in the idle look to make sure it stays that way.

> > ---
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 90c8be22d57a..0792c032a972 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -426,8 +426,11 @@ EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
> >   */
> 
> Could we please have a comment noting the change in semantics and
> the reason?

A Changelog you mean? Sure, I can do, but I wasn't nowhere confident
enough in the change to even bother trying to write one.

> >  static int rcu_is_cpu_rrupt_from_idle(void)
> >  {
> > -	/* Called only from within the scheduling-clock interrupt */
> > -	lockdep_assert_in_irq();
> > +	/*
> > +	 * Usually called from the tick; but also used from smp_call_function()
> > +	 * for expedited grace periods.
> > +	 */
> > +	lockdep_assert_irqs_disabled();
> >  
> >  	/* Check for counter underflows */
> >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> > @@ -435,8 +438,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> >  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> >  
> > -	/* Are we at first interrupt nesting level? */
> > -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> > +	/*
> > +	 * Are we at first interrupt nesting level? -- or below, when running
> > +	 * directly from the idle loop itself.
> > +	 */
> > +	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) > 1)
> 
> Wouldn't it also be a good idea to check that we are in the context of
> an idle thread?  Just in case some idiot like me drops a call to this
> function in the wrong place, for example, if I were to mistakenly remember
> the old semantics where it would return false from process context?
> 
> Maybe something like this?
> 
> 	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting;
> 	if (nesting > 1)
> 		return false;
> 	WARN_ON_ONCE(!nesting && !is_idle_task(current));

Yep, that should do.

> >  		return false;
> >  
> >  	/* Does CPU appear to be idle from an RCU standpoint? */
> 
> And let's check the other callers:
> 
> rcu_sched_clock_irq():  This will always be called from IRQ (right?), so
> 	no problem.
> 
> rcu_pending():  Only called from rcu_sched_clock_irq(), so still no problem.
> 
> rcu_flavor_sched_clock_irq(): Ditto for both definitions.

Right, I went though them, didn't find anything obvious amiss. OK, let
me do a nicer patch.
