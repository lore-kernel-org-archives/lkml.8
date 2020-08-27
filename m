Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF66C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BA82075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nAPU2Dd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH0BSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgH0BS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:18:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9CC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:18:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so3479695qtw.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3iBsmvYXjS76V9LCK+z2HaGa73AfxRjgBvqaEc9ru4U=;
        b=nAPU2Dd5ugwB//giUmF6/JiMEfIFheeg9ufhJZd/MLsppIIPnWIlrDhayxHh5sW9S4
         jTZy5PxmkMPv5ElaZTiSbeyFn+BzqQjGoyJUf7DL6YA5LDDirvilpVAA2JASY9AW8UTz
         vVqtSnNTWu/w9PFpvENUg1cIFO/i5olq99fkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3iBsmvYXjS76V9LCK+z2HaGa73AfxRjgBvqaEc9ru4U=;
        b=o45rFyXeyITWZAWXoFp3lFea7h8BzDsWm0VYqJua0o8oR0UZe3dcowkQ1z96LTTMPK
         hnKiUWiejVHih/0rKJCwazgR3nvaKdmJjmyCpoPb1N4pQ9pz71T4AgNPZAe0K8VmJ4ae
         3y9jPSeoWrewq8KTnAi5llmpbBI6Ha6NhrOTLiTmLcj6FJynf2PhoO7ZPP5KbYBJjZ7b
         FHSILvDGl4XbogmnA1I09IdZCxWp1VL794ZpFf5SY+TNoRklM9BQ7XBcgaUzK1URt1MQ
         pzaf32sUejP+BX0j7tCHnTmvse2KLtMe5mBGeyP29jWyYWX5I2Ifd9YjkcC11q1Uifux
         rqCg==
X-Gm-Message-State: AOAM532Z+Wpubu008Pp2QYrYoYMj4Qs1YkNo/gy9GjtczG3V0IBBpSAf
        xLrjqHrOE6xNxrkTTrB+iK1MGw==
X-Google-Smtp-Source: ABdhPJzPwTJEoigMNYPi8U6yuminJHh99Hx2hutE3GFCdE1QP58bRu0NGSdKMjRR+Oq/n6PDsDZB0Q==
X-Received: by 2002:ac8:e89:: with SMTP id v9mr16971905qti.100.1598491107913;
        Wed, 26 Aug 2020 18:18:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f14sm632376qkl.52.2020.08.26.18.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:18:27 -0700 (PDT)
Date:   Wed, 26 Aug 2020 21:18:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 03/11] sched,idle,rcu: Push rcu_idle deeper into the
 idle path
Message-ID: <20200827011826.GA1942571@google.com>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.310943801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821085348.310943801@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:47:41AM +0200, Peter Zijlstra wrote:
> Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
> that the locking tracepoints were using RCU.
> 
> Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
> this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.
> 
> Specifically, sched_clock_idle_wakeup_event() will use ktime which
> will use seqlocks which will tickle lockdep, and
> stop_critical_timings() uses lock.

I was wondering if those tracepoints should just use _rcuidle variant of the
trace call. But that's a terrible idea considering that would add unwanted
overhead I think.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Marco Elver <elver@google.com>
> ---
>  drivers/cpuidle/cpuidle.c |   12 ++++++++----
>  kernel/sched/idle.c       |   22 ++++++++--------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -145,13 +145,14 @@ static void enter_s2idle_proper(struct c
>  	 * executing it contains RCU usage regarded as invalid in the idle
>  	 * context, so tell RCU about that.
>  	 */
> -	RCU_NONIDLE(tick_freeze());
> +	tick_freeze();
>  	/*
>  	 * The state used here cannot be a "coupled" one, because the "coupled"
>  	 * cpuidle mechanism enables interrupts and doing that with timekeeping
>  	 * suspended is generally unsafe.
>  	 */
>  	stop_critical_timings();
> +	rcu_idle_enter();
>  	drv->states[index].enter_s2idle(dev, drv, index);
>  	if (WARN_ON_ONCE(!irqs_disabled()))
>  		local_irq_disable();
> @@ -160,7 +161,8 @@ static void enter_s2idle_proper(struct c
>  	 * first CPU executing it calls functions containing RCU read-side
>  	 * critical sections, so tell RCU about that.
>  	 */
> -	RCU_NONIDLE(tick_unfreeze());
> +	rcu_idle_exit();
> +	tick_unfreeze();
>  	start_critical_timings();
>  
>  	time_end = ns_to_ktime(local_clock());
> @@ -229,16 +231,18 @@ int cpuidle_enter_state(struct cpuidle_d
>  	/* Take note of the planned idle state. */
>  	sched_idle_set_state(target_state);
>  
> -	trace_cpu_idle_rcuidle(index, dev->cpu);
> +	trace_cpu_idle(index, dev->cpu);
>  	time_start = ns_to_ktime(local_clock());
>  
>  	stop_critical_timings();
> +	rcu_idle_enter();
>  	entered_state = target_state->enter(dev, drv, index);
> +	rcu_idle_exit();
>  	start_critical_timings();
>  
>  	sched_clock_idle_wakeup_event();
>  	time_end = ns_to_ktime(local_clock());
> -	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> +	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>  
>  	/* The cpu is no longer idle or about to enter idle. */
>  	sched_idle_set_state(NULL);
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -54,17 +54,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
>  
>  static noinline int __cpuidle cpu_idle_poll(void)
>  {
> +	trace_cpu_idle(0, smp_processor_id());
> +	stop_critical_timings();
>  	rcu_idle_enter();
> -	trace_cpu_idle_rcuidle(0, smp_processor_id());
>  	local_irq_enable();
> -	stop_critical_timings();
>  
>  	while (!tif_need_resched() &&
> -		(cpu_idle_force_poll || tick_check_broadcast_expired()))
> +	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
>  		cpu_relax();
> -	start_critical_timings();
> -	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> +
>  	rcu_idle_exit();
> +	start_critical_timings();
> +	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>  
>  	return 1;
>  }
> @@ -91,7 +92,9 @@ void __cpuidle default_idle_call(void)
>  		local_irq_enable();
>  	} else {
>  		stop_critical_timings();
> +		rcu_idle_enter();
>  		arch_cpu_idle();
> +		rcu_idle_exit();
>  		start_critical_timings();
>  	}
>  }
> @@ -158,7 +161,6 @@ static void cpuidle_idle_call(void)
>  
>  	if (cpuidle_not_available(drv, dev)) {
>  		tick_nohz_idle_stop_tick();
> -		rcu_idle_enter();
>  
>  		default_idle_call();
>  		goto exit_idle;
> @@ -178,21 +180,17 @@ static void cpuidle_idle_call(void)
>  		u64 max_latency_ns;
>  
>  		if (idle_should_enter_s2idle()) {
> -			rcu_idle_enter();
>  
>  			entered_state = call_cpuidle_s2idle(drv, dev);
>  			if (entered_state > 0)
>  				goto exit_idle;
>  
> -			rcu_idle_exit();
> -
>  			max_latency_ns = U64_MAX;
>  		} else {
>  			max_latency_ns = dev->forced_idle_latency_limit_ns;
>  		}
>  
>  		tick_nohz_idle_stop_tick();
> -		rcu_idle_enter();
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>  		call_cpuidle(drv, dev, next_state);
> @@ -209,8 +207,6 @@ static void cpuidle_idle_call(void)
>  		else
>  			tick_nohz_idle_retain_tick();
>  
> -		rcu_idle_enter();
> -
>  		entered_state = call_cpuidle(drv, dev, next_state);
>  		/*
>  		 * Give the governor an opportunity to reflect on the outcome
> @@ -226,8 +222,6 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (WARN_ON_ONCE(irqs_disabled()))
>  		local_irq_enable();
> -
> -	rcu_idle_exit();
>  }
>  
>  /*
> 
> 
