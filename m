Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC87C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC17207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jEsDtFvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgGWN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGWN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:56:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89BC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OKnWPXhKK/ImykNQZOuXNTzT4NqgyVCCOABx7DsyXC8=; b=jEsDtFvxDm0K4KpYEOX6fXKHoD
        DOrCE2HqGVpCxJcsA7Bxz10Ic03ZMGEkw7SH0aONp7KFh5d+EYWJ5zeS/H8Kn64C411+vB1wlT0D1
        Ia+BLkl3X3sOkaOCHFCATCeu7SsMF1yALaJWzQXgXD2d1VFymOnJLjZJVdGASyzcN+V7Nr9HOTL8A
        QKoglTfUwtpxPF/U0L1VjBn/F+xQoQ20W9A5KnPt45l/Td3hJujYygUgFsu1PZYNzf3sH2GZE/Z2D
        LbQ1qm0BmuaDooGcRfpFOj8BQgPDnIVy4OyBBF6jQ/WFSRf155Y4xeFiQDTcXsfbN/qOaXpzxG7oS
        LXC68A0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jybhZ-0003QH-3q; Thu, 23 Jul 2020 13:56:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80116983422; Thu, 23 Jul 2020 15:55:56 +0200 (CEST)
Date:   Thu, 23 Jul 2020 15:55:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org
Subject: Re: [PATCH smp 2/2] kernel/smp: Provide CSD lock timeout diagnostics
Message-ID: <20200723135556.GQ5523@worktop.programming.kicks-ass.net>
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
 <20200709235557.21080-2-paulmck@kernel.org>
 <20200710103227.GD4800@hirez.programming.kicks-ass.net>
 <20200710212834.GL9247@paulmck-ThinkPad-P72>
 <20200710225849.GA6004@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710225849.GA6004@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:58:49PM -0700, Paul E. McKenney wrote:
> Sadly, the code creating the 32-bit VDSO became unhappy:
> 
> ------------------------------------------------------------------------
> 
> In file included from ././include/linux/compiler_types.h:59:0,
>                  from <command-line>:0:
> ./include/linux/smp.h:40:26: error: requested alignment is not a positive power of 2
>   __aligned(sizeof(struct __call_single_data));
>                           ^
> ./include/linux/compiler_attributes.h:57:68: note: in definition of macro ‘__aligned’
>  #define __aligned(x)                    __attribute__((__aligned__(x)))
>                                                                     ^
> scripts/Makefile.build:280: recipe for target 'arch/x86/entry/vdso/vdso32/vclock_gettime.o' failed
> make[3]: *** [arch/x86/entry/vdso/vdso32/vclock_gettime.o] Error 1
> 

*groan*, we have BUILD_VDSO* for that, but yeah, not pretty.

>  Thoughts?

The biggest one is C++ comments and excessively long lines but let me go
stare at more detail :-)

> ------------------------------------------------------------------------
> 
> commit aba04e2ce05fbc6bb90e6fa238c22e491f6b95e3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 30 13:22:54 2020 -0700
> 
>     kernel/smp: Provide CSD lock timeout diagnostics
>     
>     This commit causes csd_lock_wait() to emit diagnostics when a CPU
>     fails to respond quickly enough to one of the smp_call_function()
>     family of function calls.  These diagnostics are enabled by a new
>     CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.
>     
>     This commit was inspired by an earlier patch by Josef Bacik.
>     
>     [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
>     [ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
>     [ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
>     [ paulmck: More #ifdef per Peter Zijlstra. ]
>     [ paulmck: Print delays in ns rather than ms per Peter Zijlstra. ]
>     [ paulmck: Use more CONFIG_CSD_LOCK_WAIT_DEBUG per Peter Zijlstra. ]
>     Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
>     Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ingo Molnar <mingo@kernel.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 148d991..e1d8e52 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -20,6 +20,9 @@
>  #include <linux/sched.h>
>  #include <linux/sched/idle.h>
>  #include <linux/hypervisor.h>
> +#include <linux/sched/clock.h>
> +#include <linux/nmi.h>
> +#include <linux/sched/debug.h>
>  
>  #include "smpboot.h"
>  #include "sched/smp.h"
> @@ -34,6 +37,12 @@ struct call_function_data {
>  
>  static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
>  
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
> +static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> +static DEFINE_PER_CPU(void *, cur_csd_info);
> +#endif

None of these are used before the other #ifdef block below, perhaps
merge them into one?

>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
>  
>  static void flush_smp_call_function_queue(bool warn_cpu_offline);
> @@ -96,6 +105,103 @@ void __init call_function_init(void)
>  	smpcfd_prepare_cpu(smp_processor_id());
>  }
>  
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +
> +#define CSD_LOCK_TIMEOUT (5 * 1000ULL * 1000ULL * 1000ULL) /* Nanoseconds. */

NSEC_PER_SEC, that also instantly obviates the comment

> +atomic_t csd_bug_count = ATOMIC_INIT(0);
> +
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
> +	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
> +		return csd->dst; // Other CSD_TYPE_ values might not have ->dst.
> +	return -1;
> +}
> +
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
> +	u64 ts2, ts_delta;

x-mas tree ?

> +
> +	if (!(flags & CSD_FLAG_LOCK)) {
> +		if (!unlikely(*bug_id))
> +			return true;
> +		cpu = csd_lock_wait_getcpu(csd);
> +		if (cpu >= 0)
> +			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock after all. Phew!\n", *bug_id, raw_smp_processor_id(), cpu);
> +		else
> +			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, the lock was released after all. Phew!\n", *bug_id, raw_smp_processor_id());

Excessively long line.

Why not a single:
		pr_alert("csd: CSD lock (%d) got unstuck on CPU%d, CPU%d released the lock.\n",
			 *bug_id, raw_smp_processor_id(), cpu);

Yes, it'll print CPU-1, but given you have to more or less know this
code intimately to make sense of this stuff, that seems like a fair
trade-off.

> +		return true;
> +	}
> +
> +	ts2 = sched_clock();
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

This is a potential user-after-free, func() may free the csd when async.
Although I don't believe anybody does so.

> +	smp_mb(); // No refetching cur_csd values!

The READ_ONCE() already ensures things aren't re-fetched, don't see why
we'd need smp_mb() for that.

The below is unreadable... espescially when smashed together without
whitespace, also due to the stupid long lines it wraps and becomes a
mangled mess of letters.

> +#define CSD_FORMAT_PREFIX "csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps), currently"
> +#define CSD_ARGS_PREFIX firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), \
> +	ts2 - ts0, cpu, csd->func, csd->info
> +	if (cpu_cur_csd && csd != cpu_cur_csd)
> +		pr_alert(CSD_FORMAT_PREFIX " handling prior %pS(%ps) request.\n",
> +			 CSD_ARGS_PREFIX, cpu_cur_csd->func, cpu_cur_csd->info);
> +	else
> +		pr_alert(CSD_FORMAT_PREFIX " %s.\n", CSD_ARGS_PREFIX,
> +			 !cpu_cur_csd ? "unresponsive" : "handling this request");

definitely missing {}

> +#undef CSD_FORMAT_PREFIX
> +#undef CSD_ARGS_PREFIX

Aside from it being unreadable, I've also completely lost the plot on
what it's doing.

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

I was expecting:

	*ts1 += CSD_LOCK_TIMEOUT;

Not that it matters a great deal..

> +	cpu_relax();
> +
> +	return false;
> +}
> +
>  /*
>   * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
>   *
> @@ -105,8 +211,26 @@ void __init call_function_init(void)
>   */
>  static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
> +	int bug_id = 0;
> +	u64 ts0, ts1;
> +
> +	ts1 = ts0 = sched_clock();
> +	for (;;)
> +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> +			break;

This is lacking {}, also I think you can stick (at least) the
cpu_relax() in this loop.

	for (;;) {
		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
			break;

		cpu_relax();
	}

And possible even the wait loop itself:

	for (;;) {
		if (csd_got_unlocked(csd, ...))
			break;

		now = sched_clock();
		if (now - ts1 > CSD_LOCK_TIMEOUT) {
			csd_held_too_long(csd, ts0, ts1, now, ...);
			ts1 += CSD_LOCK_TIMEOUT;
		}

		cpu_relax();
	}

that also allows breaking up that unreadable monster a bit.

> +	smp_acquire__after_ctrl_dep();
> +}
