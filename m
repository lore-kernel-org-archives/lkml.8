Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B74B2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUtrGS5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJKcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:32:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7EDC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sxon7IzSlHs45Yy4U12N88DFtVtUgny5wC6EGI7rsbQ=; b=MUtrGS5gy0QbVToSBj7YkEmNmt
        OUkGkaFjlHBTN33YDi1y7PkxOBhAklSqwFme4hJuV6BKh0PKgA/MSwyYOPGHtegAXusBQN7e28FGy
        AtWmVJfziLlbXHQw2lD6QtDYiO4YSAOANc3ZakrMnee3j7XD54FFyJiOkhOD2f/Nl0rs7jI1yDm3M
        zWy//SnidiofM9zlvHJjUInJdyMxB76uvaK2J3aORMR2VgF17QRl6+vNTuPztZhm3ogJZ55Zi4r5+
        cw/uD1I2iwuomsQMu3GjETI+JfRbrRVPlHCR+KSLARev/Iyvx3mmuJZf1nvYKhbyJvngGnRANEWPp
        iH3SAfuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtqKT-0003ty-5C; Fri, 10 Jul 2020 10:32:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C4CD304E03;
        Fri, 10 Jul 2020 12:32:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D4582B5130C7; Fri, 10 Jul 2020 12:32:27 +0200 (CEST)
Date:   Fri, 10 Jul 2020 12:32:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org
Subject: Re: [PATCH smp 2/2] kernel/smp: Provide CSD lock timeout diagnostics
Message-ID: <20200710103227.GD4800@hirez.programming.kicks-ass.net>
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
 <20200709235557.21080-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709235557.21080-2-paulmck@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:55:57PM -0700, paulmck@kernel.org wrote:

So the biggest problem I have with this patch is that while it adds a
Kconfig debug knob, it doesn't seem to actually use it.

Stuff like:

> +/* Record current CSD work for current CPU, NULL to erase. */
> +static void csd_lock_record(call_single_data_t *csd)
> +{
> +	if (!csd) {
> +		smp_mb(); // NULL cur_csd after unlock.
> +		__this_cpu_write(cur_csd, NULL);
> +		return;
> +	}
> +	__this_cpu_write(cur_csd, csd);
> +	__this_cpu_write(cur_csd_func, csd->func);
> +	__this_cpu_write(cur_csd_info, csd->info);
> +	smp_mb(); // Update cur_csd before function call.
> +		  // Or before unlock, as the case may be.
> +}
> +
> +static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
> +{
> +	unsigned int csd_type;
> +
> +	csd_type = CSD_TYPE(csd);
> +#ifdef CONFIG_64BIT
> +	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
> +		return csd->dst; // Other CSD_TYPE_ values might not have ->dst.
> +#endif
> +	return -1;
> +}

is unconditional, and thus adds unconditional fulll barriers :-(

> +/*
> + * Complain if too much time spent waiting.  Note that only
> + * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> + * so waiting on other types gets much less information.
> + */
> +static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> +{
> +	int cpu = -1;
> +	call_single_data_t *cpu_cur_csd;
> +	bool firsttime;
> +	unsigned int flags = READ_ONCE(csd->flags);
> +	u64 quo;
> +	u32 rem;
> +	u64 ts2, ts_delta;
> +
> +	if (!(flags & CSD_FLAG_LOCK)) {
> +		if (!unlikely(*bug_id))
> +			return true;
> +		cpu = csd_lock_wait_getcpu(csd);
> +		if (cpu >= 0)
> +			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock after all. Phew!\n", *bug_id, raw_smp_processor_id(), cpu);
> +		else
> +			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, the lock was released after all. Phew!\n", *bug_id, raw_smp_processor_id());
> +		return true;
> +	}
> +
> +	ts2 = div_u64_rem(sched_clock(), 1000 * 1000, &rem);
> +	ts_delta = ts2 - *ts1;
> +	if (likely(ts_delta <= CSD_LOCK_TIMEOUT)) {
> +		cpu_relax();
> +		return false;
> +	}
> +
> +	firsttime = !*bug_id;
> +	if (firsttime)
> +		*bug_id = atomic_inc_return(&csd_bug_count);
> +	cpu = csd_lock_wait_getcpu(csd);
> +	smp_mb(); // No stale cur_csd values!
> +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> +		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
> +	else
> +		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
> +	smp_mb(); // No refetching cur_csd values!
> +	quo = div_u64_rem(ts2 - ts0, 1000, &rem);
> +#define CSD_FORMAT_PREFIX "csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu.%03u secs for CPU#%02d %pS(%ps), currently"
> +#define CSD_ARGS_PREFIX firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), \
> +	quo, rem, cpu, csd->func, csd->info
> +	if (cpu_cur_csd && csd != cpu_cur_csd)
> +		pr_alert(CSD_FORMAT_PREFIX " handling prior %pS(%ps) request.\n",
> +			 CSD_ARGS_PREFIX, cpu_cur_csd->func, cpu_cur_csd->info);
> +	else
> +		pr_alert(CSD_FORMAT_PREFIX " %s.\n", CSD_ARGS_PREFIX,
> +			 !cpu_cur_csd ? "unresponsive" : "handling this request");
> +#undef CSD_FORMAT_PREFIX
> +#undef CSD_ARGS_PREFIX
> +	if (cpu >= 0) {
> +		if (!trigger_single_cpu_backtrace(cpu))
> +			dump_cpu_task(cpu);
> +		if (!cpu_cur_csd) {
> +			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
> +			arch_send_call_function_single_ipi(cpu);
> +		}
> +	}
> +	dump_stack();
> +	*ts1 = ts2;
> +	cpu_relax();
> +
> +	return false;
> +}


This thing is just unreadable. Did it want to be something like:
	
	bool warn = false;

	for (;;) {
		while (sched_clock() - t1 < NSEC_PER_MSEC * CSD_TIMO) {
			if (!(READ_ONCE(csd->flags) & CSD_FLAG_LOCK))
				goto out;
		}

		t1 += NSEC_PER_MSEC * CSD_TIMO;

		pr_alert("csd: stuck on %d, waiting on %d\n", csd->src, csd->dst);

		if (!warn) {
			warn = true;
			WARN_ON(1);
		}

		arch_send_call_function_single_ipi(csd->dst);
	}
out:
	smp_acquire__after_ctrl_dep();

	if (warn)
		pr_alert("csd: got unstuck..\n");


> +
>  /*
>   * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
>   *
> @@ -105,7 +212,19 @@ void __init call_function_init(void)
>   */
>  static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
> -	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
> +	int bug_id = 0;
> +	u32 rem;
> +	u64 ts0, ts1;
> +
> +	if (!IS_ENABLED(CONFIG_CSD_LOCK_WAIT_DEBUG)) {
> +		smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
> +		return;
> +	}
> +	ts1 = ts0 = div_u64_rem(sched_clock(), 1000 * 1000, &rem);
> +	for (;;)
> +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> +			break;
> +	smp_acquire__after_ctrl_dep();
>  }

This makes a trainwreck from what was a very simple small function.

I'm thinking you can get rid of that division and simply multiply things
by a 1e6 to get a timeout in ns, that'll be _waaaaay_ faster on
everything that doesn't have an oversized divider.

Anyway, what's wrong with the age old way of:

#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG

static inline void csd_lock_record(call_single_data_t *csd)
{
	/* extra barriers go here */
}

static void csd_lock_wait(call_single_data *csd)
{
	/* giant monster goes here */
}

#else

static __always_inline void csd_lock_record(call_single_data_t *csd)
{
}

static __always_inline void csd_lock_wait(call_single_data_t *csd)
{
	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
}

#endif /* CONFIG_CSD_LOCK_WAIT_DEBUG */


> @@ -375,7 +500,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>  
>  	csd->func = func;
>  	csd->info = info;
> +#ifdef CONFIG_64BIT
> +	csd->src = smp_processor_id();
>  	csd->dst = cpu;
> +#endif
>  
>  	err = generic_exec_single(cpu, csd);
>  
> @@ -541,7 +669,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  			csd->flags |= CSD_TYPE_SYNC;
>  		csd->func = func;
>  		csd->info = info;
> +#ifdef CONFIG_64BIT
> +		csd->src = smp_processor_id();
>  		csd->dst = cpu;
> +#endif
>  		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
>  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
>  	}
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 669f4d3..22443fa3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1332,6 +1332,16 @@ config SCF_TORTURE_TEST
>  	  module may be built after the fact on the running kernel to
>  	  be tested, if desired.
>  
> +config CSD_LOCK_WAIT_DEBUG
> +	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
> +	depends on DEBUG_KERNEL

Would it make sense to put the src,dst members under this config
variable too and make this whole thing

	depends on CONFIG_64BIT

?

> +	default n
> +	help
> +	  This option enables debug prints when CPUs are slow to respond
> +	  to the smp_call_function*() IPI wrappers.  These debug prints
> +	  include the IPI handler function currently executing (if any)
> +	  and relevant stack traces.
> +
>  endmenu # lock debugging
>  
>  config TRACE_IRQFLAGS
> -- 
> 2.9.5
> 
