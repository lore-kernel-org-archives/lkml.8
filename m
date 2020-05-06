Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F33C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078BF20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgEFODk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728629AbgEFODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:03:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE1C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:03:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWKe7-0004Am-66; Wed, 06 May 2020 16:03:35 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 367851001F5; Wed,  6 May 2020 16:03:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Prasad Sodagudi <psodagud@codeaurora.org>, john.stultz@linaro.org,
        sboyd@kernel.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v3 2/2] sched: Add a check for cpu unbound deferrable timers
In-Reply-To: <1588444137-18651-3-git-send-email-psodagud@codeaurora.org>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org> <1588444137-18651-3-git-send-email-psodagud@codeaurora.org>
Date:   Wed, 06 May 2020 16:03:34 +0200
Message-ID: <877dxpkvnt.fsf@nanos.tec.linutronix.de>
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

> Subject: sched: Add...

How is this related to the scheduler?

> Add a check to find expired unbound deferrable timers
> and trigger softirq for handling timers. This way a CPU
> can process all the expired deferrable timers whenever
> it is out off idle state due to an interrupt.

A little bit more context would be useful.

> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  include/linux/timer.h    |  3 +++
>  kernel/time/tick-sched.c |  8 +++++++-
>  kernel/time/timer.c      | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 0dc19a8..e85dd2d 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -172,6 +172,9 @@ extern int del_timer(struct timer_list * timer);
>  extern int mod_timer(struct timer_list *timer, unsigned long expires);
>  extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
>  extern int timer_reduce(struct timer_list *timer, unsigned long expires);
> +#ifdef CONFIG_SMP

This #ifdef is useless because ...

> +extern bool check_pending_deferrable_timers(int cpu);
> +#endif
>  
>  /*
>   * The jiffies value which is added to now, when there is no timer
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 3e2dc9b..16aec80 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/irq_work.h>
>  #include <linux/posix-timers.h>
> +#include <linux/timer.h>
>  #include <linux/context_tracking.h>
>  #include <linux/mm.h>
>  
> @@ -1274,8 +1275,13 @@ static inline void tick_nohz_irq_enter(void)
>  	now = ktime_get();
>  	if (ts->idle_active)
>  		tick_nohz_stop_idle(ts, now);
> -	if (ts->tick_stopped)
> +	if (ts->tick_stopped) {
>  		tick_nohz_update_jiffies(now);
> +#ifdef CONFIG_SMP
> +		if (check_pending_deferrable_timers(smp_processor_id()))
> +			raise_softirq_irqoff(TIMER_SOFTIRQ);
> +#endif

... you failed to provide a stub function which avoids this #ifdef

> +	}
>  }
>  
>  #else
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 1bf9b49..5947c63 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -221,6 +221,7 @@ static DECLARE_WORK(timer_update_work, timer_update_keys);
>  
>  #ifdef CONFIG_SMP
>  struct timer_base timer_base_deferrable;
> +static atomic_t deferrable_pending;
>  unsigned int sysctl_timer_migration = 1;
>  
>  DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
> @@ -1610,6 +1611,31 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
>  	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
>  }
>  
> +
> +#ifdef CONFIG_SMP
> +/*
> + * check_pending_deferrable_timers - Check for unbound deferrable timer expiry
> + * @cpu - Current CPU

Bogus doc format.

> + *
> + * The function checks whether any global deferrable pending timers
> + * are exipired or not. This function does not check cpu bounded
> + * diferrable pending timers expiry.

Editors have spell check.

> + *
> + * The function returns true when a cpu unbounded deferrable timer is expired.
> + */
> +bool check_pending_deferrable_timers(int cpu)
> +{
> +	if (cpu == tick_do_timer_cpu ||
> +		tick_do_timer_cpu == TICK_DO_TIMER_NONE) {

The second line conditional wants to be aligned with the first line
conditional.

> +		if (time_after_eq(jiffies, timer_base_deferrable.clk)
> +			&& !atomic_cmpxchg(&deferrable_pending, 0, 1)) {

Ditto. Aside of that this deferrable pending magic lacks any form of
explanation.

> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +#endif
> +
>  /**
>   * get_next_timer_interrupt - return the time (clock mono) of the next timer
>   * @basej:	base time jiffies
> @@ -1801,7 +1827,8 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>  	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
>  		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
>  #ifdef CONFIG_SMP
> -		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
> +		if ((atomic_cmpxchg(&deferrable_pending, 1, 0) &&

How is that supposed to compile with NOHZ=n?

For every version of these patches the 0-day robot is complaining about
exactly the same problem:

    Your testing is solely done with one config, i.e. the config you are
    interested in.

Is it really so hard to compile test for a total of 4 combinations of
SMP and NOHZ?

Thanks,

        tglx
