Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960CDC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFEB206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgEFN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgEFN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:28:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C75C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:28:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWK6R-0003dl-6S; Wed, 06 May 2020 15:28:47 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 32FCA1001F5; Wed,  6 May 2020 15:28:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Prasad Sodagudi <psodagud@codeaurora.org>, john.stultz@linaro.org,
        sboyd@kernel.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        psodagud@codeaurora.org, pkondeti@codeaurora.org,
        Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really not bound to a cpu
In-Reply-To: <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org> <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
Date:   Wed, 06 May 2020 15:28:46 +0200
Message-ID: <87a72lkx9t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad Sodagudi <psodagud@codeaurora.org> writes:
> To make all cpu unbound deferrable timers are scalable, introduce a common
> timer base which is only for cpu unbound deferrable timers to make those
> are indeed cpu unbound so that can be scheduled by any of non idle cpus.
> This common timer fixes scalability issue of delayed work and all other cpu
> unbound deferrable timer using implementations.

Scalability? That's really the wrong term here. A global timer base is
the opposite and you really want to explain why this is not creating a
scalability problem on large systems.

>  #ifdef CONFIG_SMP
> +struct timer_base timer_base_deferrable;
>  unsigned int sysctl_timer_migration = 1;
>  
>  DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
> @@ -841,8 +842,14 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
>  	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
>  	 * to use the deferrable base.
>  	 */
> -	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
> -		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
> +	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE)) {
> +#ifdef CONFIG_SMP
> +		base = &timer_base_deferrable;
> +#endif

There are definitely smarter ways of solving this than sprinkling
#ifdef's around the code.

> +		if (tflags & TIMER_PINNED)
> +			base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
> +	}
> +
>  	return base;
>  }
> @@ -1785,8 +1798,14 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>  	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>  
>  	__run_timers(base);
> -	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
> +	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
>  		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
> +#ifdef CONFIG_SMP
> +		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
> +				tick_do_timer_cpu == smp_processor_id())
> +			__run_timers(&timer_base_deferrable);
> +#endif

Again, this can be solved in readable ways. Just slapping #ifdefs all
over the place is sloppy and lazy.

Aside of that accessing the tick internals here open coded is just a
layering violation.

> +	}
>  }
>  
>  /*
> @@ -2025,6 +2044,16 @@ static void __init init_timer_cpu(int cpu)
>  	}
>  }
>  
> +#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
> +static void __init init_timer_deferrable_global(void)
> +{
> +	timer_base_deferrable.cpu = nr_cpu_ids;

This was obviously never tested with CONFIG_DEBUG_PER_CPU_MAPS=y as this
will simply result in out of bounds accesses.

>  static void __init init_timer_cpus(void)
>  {
>  	int cpu;
> @@ -2036,6 +2065,9 @@ static void __init init_timer_cpus(void)
>  void __init init_timers(void)
>  {
>  	init_timer_cpus();
> +#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
> +	init_timer_deferrable_global();
> +#endif

Stub functions exist to avoid this unreadable #ifdef garbage.

Thanks,

        tglx
