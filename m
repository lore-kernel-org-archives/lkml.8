Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D210C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE0A2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582225138;
	bh=zcCx5HV82hy+hQvB+tfsctbkp54FJ0p1IwceVc+Lxp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RbZjYcWGeHd/gAFdMt0FpWWGhqJonFttVw6beiRMUy9bgN5+pSIvpWHqmmCfacLN0
	 idJ/XOOh3F2RvzyeP3R/bNi+V27RjJmlKd76ZZw/lJO/e9d6z8k25r4AHgXbHQhahv
	 bXfFGA2b1vCniQuuiNe3NAeMixbgPgw5Qg7D6ALw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBTS65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgBTS64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:58:56 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29C92467A;
        Thu, 20 Feb 2020 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582225135;
        bh=zcCx5HV82hy+hQvB+tfsctbkp54FJ0p1IwceVc+Lxp0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gBqcqMbNDW17go95BOOtcLtGXRyV/npt/dj13CN3iB0Nqj0tcYSnd7JJ6dOKLXEoT
         /nKw5L7T4ApGOIVLK49P8REQagPNNzL8iWA926s97AKZlkjzQe/YzGGP9nu243uUWR
         e0aDWP5MMSuoV2Qpnbb/3yJfImvBnBJ8BCSKlymg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BADBF352034E; Thu, 20 Feb 2020 10:58:55 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:58:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200220185855.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200220141551.166537-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220141551.166537-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:15:51PM +0100, Marco Elver wrote:
> Add option to allow interrupts while a watchpoint is set up. This can be
> enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> parameter 'kcsan.interrupt_watcher=1'.
> 
> Note that, currently not all safe per-CPU access primitives and patterns
> are accounted for, which could result in false positives. For example,
> asm-generic/percpu.h uses plain operations, which by default are
> instrumented. On interrupts and subsequent accesses to the same
> variable, KCSAN would currently report a data race with this option.
> 
> Therefore, this option should currently remain disabled by default, but
> may be enabled for specific test scenarios.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued for review and testing, thank you!

> ---
> 
> As an example, the first data race that this found:
> 
> write to 0xffff88806b3324b8 of 4 bytes by interrupt on cpu 0:
>  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]
>  __rcu_read_lock+0x3c/0x50 kernel/rcu/tree_plugin.h:373
>  rcu_read_lock include/linux/rcupdate.h:599 [inline]
>  cpuacct_charge+0x36/0x80 kernel/sched/cpuacct.c:347
>  cgroup_account_cputime include/linux/cgroup.h:773 [inline]
>  update_curr+0xe2/0x1d0 kernel/sched/fair.c:860
>  enqueue_entity+0x130/0x5d0 kernel/sched/fair.c:4005
>  enqueue_task_fair+0xb0/0x420 kernel/sched/fair.c:5260
>  enqueue_task kernel/sched/core.c:1302 [inline]
>  activate_task+0x6d/0x110 kernel/sched/core.c:1324
>  ttwu_do_activate.isra.0+0x40/0x60 kernel/sched/core.c:2266
>  ttwu_queue kernel/sched/core.c:2411 [inline]
>  try_to_wake_up+0x3be/0x6c0 kernel/sched/core.c:2645
>  wake_up_process+0x10/0x20 kernel/sched/core.c:2669
>  hrtimer_wakeup+0x4c/0x60 kernel/time/hrtimer.c:1769
>  __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
>  __hrtimer_run_queues+0x274/0x5f0 kernel/time/hrtimer.c:1579
>  hrtimer_interrupt+0x22d/0x490 kernel/time/hrtimer.c:1641
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1119 [inline]
>  smp_apic_timer_interrupt+0xdc/0x280 arch/x86/kernel/apic/apic.c:1144
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>  delay_tsc+0x38/0xc0 arch/x86/lib/delay.c:68                   <--- interrupt while delayed
>  __delay arch/x86/lib/delay.c:161 [inline]
>  __const_udelay+0x33/0x40 arch/x86/lib/delay.c:175
>  __udelay+0x10/0x20 arch/x86/lib/delay.c:181
>  kcsan_setup_watchpoint+0x17f/0x400 kernel/kcsan/core.c:428
>  check_access kernel/kcsan/core.c:550 [inline]
>  __tsan_read4+0xc6/0x100 kernel/kcsan/core.c:685               <--- Enter KCSAN runtime
>  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  <---+
>  __rcu_read_lock+0x2a/0x50 kernel/rcu/tree_plugin.h:373            |
>  rcu_read_lock include/linux/rcupdate.h:599 [inline]               |
>  lock_page_memcg+0x31/0x110 mm/memcontrol.c:1972                   |
>                                                                    |
> read to 0xffff88806b3324b8 of 4 bytes by task 6131 on cpu 0:       |
>  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  ----+
>  __rcu_read_lock+0x2a/0x50 kernel/rcu/tree_plugin.h:373
>  rcu_read_lock include/linux/rcupdate.h:599 [inline]
>  lock_page_memcg+0x31/0x110 mm/memcontrol.c:1972
> 
> The writer is doing 'current->rcu_read_lock_nesting++'. The read is as
> vulnerable to compiler optimizations and would therefore conclude this
> is a valid data race.

Heh!  That one is a fun one!  It is on a very hot fastpath.  READ_ONCE()
and WRITE_ONCE() are likely to be measurable at the system level.

Thoughts on other options?

							Thanx, Paul

> ---
>  kernel/kcsan/core.c | 30 ++++++++----------------------
>  lib/Kconfig.kcsan   | 11 +++++++++++
>  2 files changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 589b1e7f0f253..43eb5f850c68e 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -21,6 +21,7 @@ static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
>  static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
>  static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
>  static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
> +static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
>  
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
> @@ -30,6 +31,7 @@ module_param_named(early_enable, kcsan_early_enable, bool, 0);
>  module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
>  module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
>  module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
> +module_param_named(interrupt_watcher, kcsan_interrupt_watcher, bool, 0444);
>  
>  bool kcsan_enabled;
>  
> @@ -354,7 +356,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  	unsigned long access_mask;
>  	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
>  	unsigned long ua_flags = user_access_save();
> -	unsigned long irq_flags;
> +	unsigned long irq_flags = 0;
>  
>  	/*
>  	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
> @@ -370,26 +372,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  		goto out;
>  	}
>  
> -	/*
> -	 * Disable interrupts & preemptions to avoid another thread on the same
> -	 * CPU accessing memory locations for the set up watchpoint; this is to
> -	 * avoid reporting races to e.g. CPU-local data.
> -	 *
> -	 * An alternative would be adding the source CPU to the watchpoint
> -	 * encoding, and checking that watchpoint-CPU != this-CPU. There are
> -	 * several problems with this:
> -	 *   1. we should avoid stealing more bits from the watchpoint encoding
> -	 *      as it would affect accuracy, as well as increase performance
> -	 *      overhead in the fast-path;
> -	 *   2. if we are preempted, but there *is* a genuine data race, we
> -	 *      would *not* report it -- since this is the common case (vs.
> -	 *      CPU-local data accesses), it makes more sense (from a data race
> -	 *      detection point of view) to simply disable preemptions to ensure
> -	 *      as many tasks as possible run on other CPUs.
> -	 *
> -	 * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
> -	 */
> -	raw_local_irq_save(irq_flags);
> +	if (!kcsan_interrupt_watcher)
> +		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
> +		raw_local_irq_save(irq_flags);
>  
>  	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
>  	if (watchpoint == NULL) {
> @@ -524,7 +509,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  
>  	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
>  out_unlock:
> -	raw_local_irq_restore(irq_flags);
> +	if (!kcsan_interrupt_watcher)
> +		raw_local_irq_restore(irq_flags);
>  out:
>  	user_access_restore(ua_flags);
>  }
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index ba9268076cfbc..0f1447ff8f558 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -101,6 +101,17 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
>  	  KCSAN_WATCH_SKIP. If false, the chosen value is always
>  	  KCSAN_WATCH_SKIP.
>  
> +config KCSAN_INTERRUPT_WATCHER
> +	bool "Interruptible watchers"
> +	help
> +	  If enabled, a task that set up a watchpoint may be interrupted while
> +	  delayed. This option will allow KCSAN to detect races between
> +	  interrupted tasks and other threads of execution on the same CPU.
> +
> +	  Currently disabled by default, because not all safe per-CPU access
> +	  primitives and patterns may be accounted for, and therefore could
> +	  result in false positives.
> +
>  config KCSAN_REPORT_ONCE_IN_MS
>  	int "Duration in milliseconds, in which any given race is only reported once"
>  	default 3000
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
