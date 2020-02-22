Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E30C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E532420722
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582335540;
	bh=G0371CcVd+WJ7eBCCi6DdMXQkrMrcc32EJ1re/8e9ME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ysC+fCUvT4m5EjO92XgSCA7mefF3ZHVJMZKrXyputJWk8ET6M49FPcgOTN5+gVoWJ
	 ubE3NVb/YSxBHL2q6eFT1ukxWRE3/viW6emiYaYZMdNlD6u438EoFCzuzeDpEmMcBk
	 eEhNSkiEqEj2PUDyL00mYFrQoRUHFmXbPTW4GoV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBVBgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgBVBgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:36:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FBA206EF;
        Sat, 22 Feb 2020 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582335402;
        bh=G0371CcVd+WJ7eBCCi6DdMXQkrMrcc32EJ1re/8e9ME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HYVeR6xCxXf9927ySSRLdX1INaWIPNpXK7zFhZtlZK6SxPd0tjy01BJhJm7T5OaTJ
         js6ShacyvbXX9+RNC3fGbzWQ9oeu6YiXop2uF4axVpWoauNWNtwBpdYsxRwIp8HV4d
         m5OFZ0T/7q9nHahaQMts3XAJ2/8b1cdxrSJH8lCY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 16BD835226DB; Fri, 21 Feb 2020 17:36:42 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:36:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
Message-ID: <20200222013642.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200221231027.230147-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221231027.230147-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:10:27AM +0100, Marco Elver wrote:
> Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> Currently information about the reporting task's held locks and IRQ
> trace events are shown, if they are enabled.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: Qian Cai <cai@lca.pw>

Applied in place of v1, thank you!  Please check -rcu's "dev" branch
to make sure that I have correct ordering and versions.

							Thanx, Paul

> ---
> v3:
> * Typos
> v2:
> * Rework obtaining 'current' for the "other thread" -- it now passes
>   'current' and ensures that we stall until the report was printed, so
>   that the lockdep information contained in 'current' is accurate. This
>   was non-trivial but testing so far leads me to conclude this now
>   reliably prints the held locks for the "other thread" (please test
>   more!).
> ---
>  kernel/kcsan/core.c   |   4 +-
>  kernel/kcsan/kcsan.h  |   3 ++
>  kernel/kcsan/report.c | 103 +++++++++++++++++++++++++++++++++++++++++-
>  lib/Kconfig.kcsan     |  13 ++++++
>  4 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index e7387fec66795..065615df88eaa 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -18,8 +18,8 @@
>  #include "kcsan.h"
>  
>  static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
> -static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> -static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> +unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> +unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
>  static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
>  static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
>  
> diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> index 892de5120c1b6..e282f8b5749e9 100644
> --- a/kernel/kcsan/kcsan.h
> +++ b/kernel/kcsan/kcsan.h
> @@ -13,6 +13,9 @@
>  /* The number of adjacent watchpoints to check. */
>  #define KCSAN_CHECK_ADJACENT 1
>  
> +extern unsigned int kcsan_udelay_task;
> +extern unsigned int kcsan_udelay_interrupt;
> +
>  /*
>   * Globally enable and disable KCSAN.
>   */
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 11c791b886f3c..7bdb515e3662f 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/debug_locks.h>
> +#include <linux/delay.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/lockdep.h>
> @@ -31,7 +33,26 @@ static struct {
>  	int			cpu_id;
>  	unsigned long		stack_entries[NUM_STACK_ENTRIES];
>  	int			num_stack_entries;
> -} other_info = { .ptr = NULL };
> +
> +	/*
> +	 * Optionally pass @current. Typically we do not need to pass @current
> +	 * via @other_info since just @task_pid is sufficient. Passing @current
> +	 * has additional overhead.
> +	 *
> +	 * To safely pass @current, we must either use get_task_struct/
> +	 * put_task_struct, or stall the thread that populated @other_info.
> +	 *
> +	 * We cannot rely on get_task_struct/put_task_struct in case
> +	 * release_report() races with a task being released, and would have to
> +	 * free it in release_report(). This may result in deadlock if we want
> +	 * to use KCSAN on the allocators.
> +	 *
> +	 * Since we also want to reliably print held locks for
> +	 * CONFIG_KCSAN_VERBOSE, the current implementation stalls the thread
> +	 * that populated @other_info until it has been consumed.
> +	 */
> +	struct task_struct	*task;
> +} other_info;
>  
>  /*
>   * Information about reported races; used to rate limit reporting.
> @@ -245,6 +266,16 @@ static int sym_strcmp(void *addr1, void *addr2)
>  	return strncmp(buf1, buf2, sizeof(buf1));
>  }
>  
> +static void print_verbose_info(struct task_struct *task)
> +{
> +	if (!task)
> +		return;
> +
> +	pr_err("\n");
> +	debug_show_held_locks(task);
> +	print_irqtrace_events(task);
> +}
> +
>  /*
>   * Returns true if a report was generated, false otherwise.
>   */
> @@ -319,6 +350,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>  				  other_info.num_stack_entries - other_skipnr,
>  				  0);
>  
> +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +		    print_verbose_info(other_info.task);
> +
>  		pr_err("\n");
>  		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
>  		       get_access_type(access_type), ptr, size,
> @@ -340,6 +374,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>  	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
>  			  0);
>  
> +	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +		print_verbose_info(current);
> +
>  	/* Print report footer. */
>  	pr_err("\n");
>  	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> @@ -357,6 +394,67 @@ static void release_report(unsigned long *flags, enum kcsan_report_type type)
>  	spin_unlock_irqrestore(&report_lock, *flags);
>  }
>  
> +/*
> + * Sets @other_info.task and awaits consumption of @other_info.
> + *
> + * Precondition: report_lock is held.
> + * Postcondition: report_lock is held.
> + */
> +static void
> +set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
> +{
> +	/*
> +	 * We may be instrumenting a code-path where current->state is already
> +	 * something other than TASK_RUNNING.
> +	 */
> +	const bool is_running = current->state == TASK_RUNNING;
> +	/*
> +	 * To avoid deadlock in case we are in an interrupt here and this is a
> +	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
> +	 * timeout to ensure this works in all contexts.
> +	 *
> +	 * Await approximately the worst case delay of the reporting thread (if
> +	 * we are not interrupted).
> +	 */
> +	int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);
> +
> +	other_info.task = current;
> +	do {
> +		if (is_running) {
> +			/*
> +			 * Let lockdep know the real task is sleeping, to print
> +			 * the held locks (recall we turned lockdep off, so
> +			 * locking/unlocking @report_lock won't be recorded).
> +			 */
> +			set_current_state(TASK_UNINTERRUPTIBLE);
> +		}
> +		spin_unlock_irqrestore(&report_lock, *flags);
> +		/*
> +		 * We cannot call schedule() since we also cannot reliably
> +		 * determine if sleeping here is permitted -- see in_atomic().
> +		 */
> +
> +		udelay(1);
> +		spin_lock_irqsave(&report_lock, *flags);
> +		if (timeout-- < 0) {
> +			/*
> +			 * Abort. Reset other_info.task to NULL, since it
> +			 * appears the other thread is still going to consume
> +			 * it. It will result in no verbose info printed for
> +			 * this task.
> +			 */
> +			other_info.task = NULL;
> +			break;
> +		}
> +		/*
> +		 * If @ptr nor @current matches, then our information has been
> +		 * consumed and we may continue. If not, retry.
> +		 */
> +	} while (other_info.ptr == ptr && other_info.task == current);
> +	if (is_running)
> +		set_current_state(TASK_RUNNING);
> +}
> +
>  /*
>   * Depending on the report type either sets other_info and returns false, or
>   * acquires the matching other_info and returns true. If other_info is not
> @@ -388,6 +486,9 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
>  		other_info.cpu_id		= cpu_id;
>  		other_info.num_stack_entries	= stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
>  
> +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +			set_other_info_task_blocking(flags, ptr);
> +
>  		spin_unlock_irqrestore(&report_lock, *flags);
>  
>  		/*
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 081ed2e1bf7b1..0f1447ff8f558 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -20,6 +20,19 @@ menuconfig KCSAN
>  
>  if KCSAN
>  
> +config KCSAN_VERBOSE
> +	bool "Show verbose reports with more information about system state"
> +	depends on PROVE_LOCKING
> +	help
> +	  If enabled, reports show more information about the system state that
> +	  may help better analyze and debug races. This includes held locks and
> +	  IRQ trace events.
> +
> +	  While this option should generally be benign, we call into more
> +	  external functions on report generation; if a race report is
> +	  generated from any one of them, system stability may suffer due to
> +	  deadlocks or recursion.  If in doubt, say N.
> +
>  config KCSAN_DEBUG
>  	bool "Debugging of KCSAN internals"
>  
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
