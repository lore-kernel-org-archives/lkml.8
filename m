Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B934C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFAB2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W+fjp8LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgH0BYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgH0BYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:24:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F2C0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:24:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o12so4492066qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjvfMWJedY4DOWLk38AcH8M6uY/+3x+bqJyVZvmXE64=;
        b=W+fjp8LDVZ053euUKL3TWuKh+8tcnzXi4q35YDh4WgA8KXCefAJP/iRhAX+1rqIx7V
         5M/ZhFh4A6AMpvPoCr/JfR78dNvaeDD+G/UVOQs6fNpjixsAHWHSlCKN6sEJLIZHikvT
         2GPx8NBkj+MJhRF7jyNg70QLVHc1KwDHzjcnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjvfMWJedY4DOWLk38AcH8M6uY/+3x+bqJyVZvmXE64=;
        b=Z4K64G7sp0nrmjsZGaBdkDUz41HJIXt+DIYyGMVNTGrFH4SjG+meJmnERD9l9/Wt8+
         2aZBe7JU9U9+ByZlBedhi7imMcQYQjVJfpqeBFT0lKMqkiiI8mKJVchC78aktN2po2Rd
         YC0QnrS58Vndv8xCU0XEpVi3/fmU/GZq/+fxxhLdW0rC2eI0DAPgtTIiPES+T6RXZifd
         AU0vmZjJMDmQST9djvE6dWbc5J7ht2wKVaa7K6jUJd2v9UViYA5LNg/PB+JPA5hFqNxg
         Nx3NULAU3E42Shdqo1Gt3h/QdbeqGoIIDbdA9esGtTFHFeccffP0tyh3j3RxDzhufrVu
         R9Hw==
X-Gm-Message-State: AOAM530vY08gHFCqVuXYX3I/qfCsg7G8VOSmiQqgwB3Z5xN1ZYuAJqtD
        KXp1Xrcnu4MeW19VPZHzNQzZtQ==
X-Google-Smtp-Source: ABdhPJwYoU4k2L7EQbkqQMNCHOW36ZWSYfRGfRa+OGy160Xsiao+8xdLiRBTYzfwK54u4+UWdJ/2cg==
X-Received: by 2002:a37:bdc4:: with SMTP id n187mr17090622qkf.192.1598491460816;
        Wed, 26 Aug 2020 18:24:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q9sm748774qkq.82.2020.08.26.18.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:24:19 -0700 (PDT)
Date:   Wed, 26 Aug 2020 21:24:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 03/11] sched,idle,rcu: Push rcu_idle deeper into the
 idle path
Message-ID: <20200827012419.GB1942571@google.com>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.310943801@infradead.org>
 <20200827011826.GA1942571@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827011826.GA1942571@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:18:26PM -0400, Joel Fernandes wrote:
> On Fri, Aug 21, 2020 at 10:47:41AM +0200, Peter Zijlstra wrote:
> > Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
> > that the locking tracepoints were using RCU.
> > 
> > Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
> > this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.
> > 
> > Specifically, sched_clock_idle_wakeup_event() will use ktime which
> > will use seqlocks which will tickle lockdep, and
> > stop_critical_timings() uses lock.
> 
> I was wondering if those tracepoints should just use _rcuidle variant of the
> trace call. But that's a terrible idea considering that would add unwanted
> overhead I think.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

BTW, if tracepoint is converted to use RCU-trace flavor, then these kinds of
issues go away, no? That RCU flavor is always watching.

thanks,

 - Joel

> 
> thanks,
> 
>  - Joel
> 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Tested-by: Marco Elver <elver@google.com>
> > ---
> >  drivers/cpuidle/cpuidle.c |   12 ++++++++----
> >  kernel/sched/idle.c       |   22 ++++++++--------------
> >  2 files changed, 16 insertions(+), 18 deletions(-)
> > 
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -145,13 +145,14 @@ static void enter_s2idle_proper(struct c
> >  	 * executing it contains RCU usage regarded as invalid in the idle
> >  	 * context, so tell RCU about that.
> >  	 */
> > -	RCU_NONIDLE(tick_freeze());
> > +	tick_freeze();
> >  	/*
> >  	 * The state used here cannot be a "coupled" one, because the "coupled"
> >  	 * cpuidle mechanism enables interrupts and doing that with timekeeping
> >  	 * suspended is generally unsafe.
> >  	 */
> >  	stop_critical_timings();
> > +	rcu_idle_enter();
> >  	drv->states[index].enter_s2idle(dev, drv, index);
> >  	if (WARN_ON_ONCE(!irqs_disabled()))
> >  		local_irq_disable();
> > @@ -160,7 +161,8 @@ static void enter_s2idle_proper(struct c
> >  	 * first CPU executing it calls functions containing RCU read-side
> >  	 * critical sections, so tell RCU about that.
> >  	 */
> > -	RCU_NONIDLE(tick_unfreeze());
> > +	rcu_idle_exit();
> > +	tick_unfreeze();
> >  	start_critical_timings();
> >  
> >  	time_end = ns_to_ktime(local_clock());
> > @@ -229,16 +231,18 @@ int cpuidle_enter_state(struct cpuidle_d
> >  	/* Take note of the planned idle state. */
> >  	sched_idle_set_state(target_state);
> >  
> > -	trace_cpu_idle_rcuidle(index, dev->cpu);
> > +	trace_cpu_idle(index, dev->cpu);
> >  	time_start = ns_to_ktime(local_clock());
> >  
> >  	stop_critical_timings();
> > +	rcu_idle_enter();
> >  	entered_state = target_state->enter(dev, drv, index);
> > +	rcu_idle_exit();
> >  	start_critical_timings();
> >  
> >  	sched_clock_idle_wakeup_event();
> >  	time_end = ns_to_ktime(local_clock());
> > -	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> > +	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
> >  
> >  	/* The cpu is no longer idle or about to enter idle. */
> >  	sched_idle_set_state(NULL);
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -54,17 +54,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
> >  
> >  static noinline int __cpuidle cpu_idle_poll(void)
> >  {
> > +	trace_cpu_idle(0, smp_processor_id());
> > +	stop_critical_timings();
> >  	rcu_idle_enter();
> > -	trace_cpu_idle_rcuidle(0, smp_processor_id());
> >  	local_irq_enable();
> > -	stop_critical_timings();
> >  
> >  	while (!tif_need_resched() &&
> > -		(cpu_idle_force_poll || tick_check_broadcast_expired()))
> > +	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
> >  		cpu_relax();
> > -	start_critical_timings();
> > -	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> > +
> >  	rcu_idle_exit();
> > +	start_critical_timings();
> > +	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> >  
> >  	return 1;
> >  }
> > @@ -91,7 +92,9 @@ void __cpuidle default_idle_call(void)
> >  		local_irq_enable();
> >  	} else {
> >  		stop_critical_timings();
> > +		rcu_idle_enter();
> >  		arch_cpu_idle();
> > +		rcu_idle_exit();
> >  		start_critical_timings();
> >  	}
> >  }
> > @@ -158,7 +161,6 @@ static void cpuidle_idle_call(void)
> >  
> >  	if (cpuidle_not_available(drv, dev)) {
> >  		tick_nohz_idle_stop_tick();
> > -		rcu_idle_enter();
> >  
> >  		default_idle_call();
> >  		goto exit_idle;
> > @@ -178,21 +180,17 @@ static void cpuidle_idle_call(void)
> >  		u64 max_latency_ns;
> >  
> >  		if (idle_should_enter_s2idle()) {
> > -			rcu_idle_enter();
> >  
> >  			entered_state = call_cpuidle_s2idle(drv, dev);
> >  			if (entered_state > 0)
> >  				goto exit_idle;
> >  
> > -			rcu_idle_exit();
> > -
> >  			max_latency_ns = U64_MAX;
> >  		} else {
> >  			max_latency_ns = dev->forced_idle_latency_limit_ns;
> >  		}
> >  
> >  		tick_nohz_idle_stop_tick();
> > -		rcu_idle_enter();
> >  
> >  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> >  		call_cpuidle(drv, dev, next_state);
> > @@ -209,8 +207,6 @@ static void cpuidle_idle_call(void)
> >  		else
> >  			tick_nohz_idle_retain_tick();
> >  
> > -		rcu_idle_enter();
> > -
> >  		entered_state = call_cpuidle(drv, dev, next_state);
> >  		/*
> >  		 * Give the governor an opportunity to reflect on the outcome
> > @@ -226,8 +222,6 @@ static void cpuidle_idle_call(void)
> >  	 */
> >  	if (WARN_ON_ONCE(irqs_disabled()))
> >  		local_irq_enable();
> > -
> > -	rcu_idle_exit();
> >  }
> >  
> >  /*
> > 
> > 
