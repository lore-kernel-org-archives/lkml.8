Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D071D207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lVcCoEvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgE1Bfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgE1Bfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:35:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBCC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:35:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y1so10333195qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kdRDIUud9vdh99K7Eu/EqGMgSstVkExNLQUlmKuT+XE=;
        b=lVcCoEvHHzK6BC2/IL8DEorOj1zfU8FM/FFH0JZW5EPmI5W9+BCLzWrHQ0cR0aRcLv
         hy30GVtibgm9CCMA/xMhNu/gqV+CjItzrLcj3hDMxj6Gab9PbBrmLUFmh4BICFw13YNS
         3skYqmhMj+bOTA4rswSY0pUwACTGEtFqMfIXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdRDIUud9vdh99K7Eu/EqGMgSstVkExNLQUlmKuT+XE=;
        b=btcY1R51M7UqWmL7nKQs9BrUexgpATX8tSyhybLxEuIFpYddh/bEkYRlfert+sqiiO
         kU8QN7pYb4Y6M1ip18oj9xIkBU+wGXVd4xBJm4BJuVD6CXt60Tyez2QXQM3Qc2lZ8dg4
         57vME9PEFQjxDTM/qykBoAloFxkVzoUC4oNUEJrxY/mPiBRBAy3vwclaS4gNxk6/kIGR
         2FzWXqoqf9aeAATt7GC1wQa6vTm09N3PydcPCriltAE+3Ckmi2yhroKSgADGs+mMScuo
         nvZO+ZgxdcIcbuD9Qgv9u7NEMtlLIK3v0omwkNljsdIeeHFv0b1eRu9i2+dbwS8GvmJl
         qUsw==
X-Gm-Message-State: AOAM531/XJYxfbn0atTBop6LSbGFlmndMdhQzBv82Tx4kz0YB81/hXZS
        y9kkeRu3nAxS1NTn34ZHvRVCMw==
X-Google-Smtp-Source: ABdhPJyqJD2UWpKGXVbqLCOwpvGJcWLOzlcWnB1yRcdvyrM2ucSR2PMyGQx0fSddBkTCjnJpg2lCRA==
X-Received: by 2002:ac8:6b06:: with SMTP id w6mr766037qts.320.1590629740394;
        Wed, 27 May 2020 18:35:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w43sm4404278qtw.68.2020.05.27.18.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:35:39 -0700 (PDT)
Date:   Wed, 27 May 2020 21:35:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200528013539.GA220442@google.com>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
 <20200527163543.GA706478@hirez.programming.kicks-ass.net>
 <20200527171236.GC706495@hirez.programming.kicks-ass.net>
 <20200527193914.GW2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527193914.GW2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:39:14PM -0700, Paul E. McKenney wrote:
> On Wed, May 27, 2020 at 07:12:36PM +0200, Peter Zijlstra wrote:
> > On Wed, May 27, 2020 at 06:35:43PM +0200, Peter Zijlstra wrote:
> > > Right, I went though them, didn't find anything obvious amiss. OK, let
> > > me do a nicer patch.
> > 
> > something like so then?
> > 
> > ---
> > Subject: rcu: Allow for smp_call_function() running callbacks from idle
> > 
> > Current RCU hard relies on smp_call_function() callbacks running from
> > interrupt context. A pending optimization is going to break that, it
> > will allow idle CPUs to run the callbacks from the idle loop. This
> > avoids raising the IPI on the requesting CPU and avoids handling an
> > exception on the receiving CPU.
> > 
> > Change rcu_is_cpu_rrupt_from_idle() to also accept task context,
> > provided it is the idle task.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Looks good to me!
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> > ---
> >  kernel/rcu/tree.c   | 25 +++++++++++++++++++------
> >  kernel/sched/idle.c |  4 ++++
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d8e9dbbefcfa..c716eadc7617 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -418,16 +418,23 @@ void rcu_momentary_dyntick_idle(void)
> >  EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
> >  
> >  /**
> > - * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
> > + * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
> >   *
> >   * If the current CPU is idle and running at a first-level (not nested)
> > - * interrupt from idle, return true.  The caller must have at least
> > - * disabled preemption.
> > + * interrupt, or directly, from idle, return true.
> > + *
> > + * The caller must have at least disabled IRQs.
> >   */
> >  static int rcu_is_cpu_rrupt_from_idle(void)
> >  {
> > -	/* Called only from within the scheduling-clock interrupt */
> > -	lockdep_assert_in_irq();
> > +	long nesting;
> > +
> > +	/*
> > +	 * Usually called from the tick; but also used from smp_function_call()
> > +	 * for expedited grace periods. This latter can result in running from
> > +	 * the idle task, instead of an actual IPI.
> > +	 */
> > +	lockdep_assert_irqs_disabled();
> >  
> >  	/* Check for counter underflows */
> >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> > @@ -436,9 +443,15 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> >  
> >  	/* Are we at first interrupt nesting level? */
> > -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> > +	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> > +	if (nesting > 1)
> >  		return false;
> >  
> > +	/*
> > +	 * If we're not in an interrupt, we must be in the idle task!
> > +	 */
> > +	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> > +
> >  	/* Does CPU appear to be idle from an RCU standpoint? */
> >  	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> >  }
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index e9cef84c2b70..05deb81bb3e3 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -289,6 +289,10 @@ static void do_idle(void)
> >  	 */
> >  	smp_mb__after_atomic();
> >  
> > +	/*
> > +	 * RCU relies on this call to be done outside of an RCU read-side
> > +	 * critical section.
> > +	 */
> >  	flush_smp_call_function_from_idle();
> >  	schedule_idle();
> >  
