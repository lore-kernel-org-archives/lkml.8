Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34BAC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119724670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582135317;
	bh=yicJpUKBY2lCa9DYQFX7OM+15TFASg4m1KjhxR4TRrg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FMUcn0rB2zqOelhJ8ltlvyquuJsP0q9jW1aF8uCGQRM9LOYgtgXTu+S+iLoY78hQ5
	 tCSBEuv3faqYKLYhViTSY4z1Qiz6SGBgjDVV189YU2wmUvFEtUWVtr5+WG/tPLNHnd
	 /9YRMjfgLvq9ae4HobA+tb8KLicUkcbMqyuJVGa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBSSB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:01:56 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DE924656;
        Wed, 19 Feb 2020 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582135315;
        bh=yicJpUKBY2lCa9DYQFX7OM+15TFASg4m1KjhxR4TRrg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PC5SIEBReGWN148eb6cKbeEnEH8xCSoQLAR4zMnI7g8CMFnTHpY5MTzTD9vvKt0u2
         6Xp1txu9xJjZ60zf7UuDW7tef7+0WSiyZPUaYB9Wh/EyalgypJ97aEqhtBa7Uixhy6
         GpjopJBrcLEV0y6zMVkAgpg3BKT6wavjwTCy1YXc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2AFF335209B0; Wed, 19 Feb 2020 10:01:55 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:01:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] kcsan: Add option for verbose reporting
Message-ID: <20200219180155.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219151531.161515-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219151531.161515-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:15:31PM +0100, Marco Elver wrote:
> Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> Currently information about the reporting task's held locks and IRQ
> trace events are shown, if they are enabled.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: Qian Cai <cai@lca.pw>

Queued for testing and review, thank you!

							Thanx, Paul

> ---
>  kernel/kcsan/report.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.kcsan     | 13 ++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 11c791b886f3c..f14becb6f1537 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -1,10 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/debug_locks.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/lockdep.h>
>  #include <linux/preempt.h>
>  #include <linux/printk.h>
> +#include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/stacktrace.h>
> @@ -245,6 +247,29 @@ static int sym_strcmp(void *addr1, void *addr2)
>  	return strncmp(buf1, buf2, sizeof(buf1));
>  }
>  
> +static void print_verbose_info(struct task_struct *task)
> +{
> +	if (!task)
> +		return;
> +
> +	if (task != current && task->state == TASK_RUNNING)
> +		/*
> +		 * Showing held locks for a running task is unreliable, so just
> +		 * skip this. The printed locks are very likely inconsistent,
> +		 * since the stack trace was obtained when the actual race
> +		 * occurred and the task has since continued execution. Since we
> +		 * cannot display the below information from the racing thread,
> +		 * but must print it all from the watcher thread, bail out.
> +		 * Note: Even if the task is not running, there is a chance that
> +		 * the locks held may be inconsistent.
> +		 */
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
> @@ -319,6 +344,26 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>  				  other_info.num_stack_entries - other_skipnr,
>  				  0);
>  
> +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE) && other_info.task_pid != -1) {
> +			struct task_struct *other_task;
> +
> +			/*
> +			 * Rather than passing @current from the other task via
> +			 * @other_info, obtain task_struct here. The problem
> +			 * with passing @current via @other_info is that, we
> +			 * would have to get_task_struct/put_task_struct, and if
> +			 * we race with a task being released, we would have to
> +			 * release it in release_report(). This may result in
> +			 * deadlock if we want to use KCSAN on the allocators.
> +			 * Instead, make this best-effort, and if the task was
> +			 * already released, we just do not print anything here.
> +			 */
> +			rcu_read_lock();
> +			other_task = find_task_by_pid_ns(other_info.task_pid, &init_pid_ns);
> +			print_verbose_info(other_task);
> +			rcu_read_unlock();
> +		}
> +
>  		pr_err("\n");
>  		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
>  		       get_access_type(access_type), ptr, size,
> @@ -340,6 +385,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>  	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
>  			  0);
>  
> +	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +		print_verbose_info(current);
> +
>  	/* Print report footer. */
>  	pr_err("\n");
>  	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index f0b791143c6ab..ba9268076cfbc 100644
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
