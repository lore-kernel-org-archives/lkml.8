Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1050C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8537B22B4E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586180146;
	bh=+9OLpbCWgabkd5QGYom6qAzlc/KhMbEWoliL/vpH1kQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zyw8+o7/A4M09i/17CvOSHRao6RFELqLRk9LVI2coWTvdHztkWZCIJxW4+kPIuJCa
	 E6dE7GzyXIdoAJJ/rIXPap+rlk0/YszjSbYrfGc6f6ZpjZKAH4UBC18zvzKSOhQt6b
	 viKglRl35G0uiKEJmOzTbaP7Uy22RzrZFrXIz5VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgDFNfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgDFNfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:35:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D73422B4E;
        Mon,  6 Apr 2020 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586180143;
        bh=+9OLpbCWgabkd5QGYom6qAzlc/KhMbEWoliL/vpH1kQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pz6Up9F+Wk/8hs5Ff9zr/ZX8TQvnp0i11MCUvUVlopIbYAGtabNlnk3PVesofQUfY
         l1U+Do2A9b0VUl7xwkZL0DKwiwo8AVWMfgoHvOw9BfM/mn9kya9Syv6POCq2m5TXHh
         wd3o6bAqTpDjtodTXHeV1l0hgN/YlbUIMcgtdy+k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 250783522726; Mon,  6 Apr 2020 06:35:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 06:35:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
Message-ID: <20200406133543.GB19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200221231027.230147-1-elver@google.com>
 <6A08FE59-AD3B-4209-AF57-D4CEF7E94B56@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A08FE59-AD3B-4209-AF57-D4CEF7E94B56@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:59:58AM -0400, Qian Cai wrote:
> 
> 
> > On Feb 21, 2020, at 6:10 PM, Marco Elver <elver@google.com> wrote:
> > 
> > Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> > Currently information about the reporting task's held locks and IRQ
> > trace events are shown, if they are enabled.
> 
> This patch is no longer in today’s linux-next. I suppose that it is because Paul had sent
> the initial pull request without this one that I had missed dearly.
> 
> Is there a way to get it back there?

It goes back in in seven days, after -rc1 is released.  The fact that
it was there last week was a mistake on my part, and I did eventually
get my hand slapped for it.  ;-)

In the meantime, if it would help, I could group the KCSAN commits
on top of those in -tip to allow you to get them with one "git pull"
command.

							Thanx, Paul

> > Signed-off-by: Marco Elver <elver@google.com>
> > Suggested-by: Qian Cai <cai@lca.pw>
> > ---
> > v3:
> > * Typos
> > v2:
> > * Rework obtaining 'current' for the "other thread" -- it now passes
> >  'current' and ensures that we stall until the report was printed, so
> >  that the lockdep information contained in 'current' is accurate. This
> >  was non-trivial but testing so far leads me to conclude this now
> >  reliably prints the held locks for the "other thread" (please test
> >  more!).
> > ---
> > kernel/kcsan/core.c   |   4 +-
> > kernel/kcsan/kcsan.h  |   3 ++
> > kernel/kcsan/report.c | 103 +++++++++++++++++++++++++++++++++++++++++-
> > lib/Kconfig.kcsan     |  13 ++++++
> > 4 files changed, 120 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index e7387fec66795..065615df88eaa 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -18,8 +18,8 @@
> > #include "kcsan.h"
> > 
> > static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
> > -static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> > -static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> > +unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> > +unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> > static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
> > static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
> > 
> > diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> > index 892de5120c1b6..e282f8b5749e9 100644
> > --- a/kernel/kcsan/kcsan.h
> > +++ b/kernel/kcsan/kcsan.h
> > @@ -13,6 +13,9 @@
> > /* The number of adjacent watchpoints to check. */
> > #define KCSAN_CHECK_ADJACENT 1
> > 
> > +extern unsigned int kcsan_udelay_task;
> > +extern unsigned int kcsan_udelay_interrupt;
> > +
> > /*
> >  * Globally enable and disable KCSAN.
> >  */
> > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > index 11c791b886f3c..7bdb515e3662f 100644
> > --- a/kernel/kcsan/report.c
> > +++ b/kernel/kcsan/report.c
> > @@ -1,5 +1,7 @@
> > // SPDX-License-Identifier: GPL-2.0
> > 
> > +#include <linux/debug_locks.h>
> > +#include <linux/delay.h>
> > #include <linux/jiffies.h>
> > #include <linux/kernel.h>
> > #include <linux/lockdep.h>
> > @@ -31,7 +33,26 @@ static struct {
> > 	int			cpu_id;
> > 	unsigned long		stack_entries[NUM_STACK_ENTRIES];
> > 	int			num_stack_entries;
> > -} other_info = { .ptr = NULL };
> > +
> > +	/*
> > +	 * Optionally pass @current. Typically we do not need to pass @current
> > +	 * via @other_info since just @task_pid is sufficient. Passing @current
> > +	 * has additional overhead.
> > +	 *
> > +	 * To safely pass @current, we must either use get_task_struct/
> > +	 * put_task_struct, or stall the thread that populated @other_info.
> > +	 *
> > +	 * We cannot rely on get_task_struct/put_task_struct in case
> > +	 * release_report() races with a task being released, and would have to
> > +	 * free it in release_report(). This may result in deadlock if we want
> > +	 * to use KCSAN on the allocators.
> > +	 *
> > +	 * Since we also want to reliably print held locks for
> > +	 * CONFIG_KCSAN_VERBOSE, the current implementation stalls the thread
> > +	 * that populated @other_info until it has been consumed.
> > +	 */
> > +	struct task_struct	*task;
> > +} other_info;
> > 
> > /*
> >  * Information about reported races; used to rate limit reporting.
> > @@ -245,6 +266,16 @@ static int sym_strcmp(void *addr1, void *addr2)
> > 	return strncmp(buf1, buf2, sizeof(buf1));
> > }
> > 
> > +static void print_verbose_info(struct task_struct *task)
> > +{
> > +	if (!task)
> > +		return;
> > +
> > +	pr_err("\n");
> > +	debug_show_held_locks(task);
> > +	print_irqtrace_events(task);
> > +}
> > +
> > /*
> >  * Returns true if a report was generated, false otherwise.
> >  */
> > @@ -319,6 +350,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
> > 				  other_info.num_stack_entries - other_skipnr,
> > 				  0);
> > 
> > +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +		    print_verbose_info(other_info.task);
> > +
> > 		pr_err("\n");
> > 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
> > 		       get_access_type(access_type), ptr, size,
> > @@ -340,6 +374,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
> > 	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
> > 			  0);
> > 
> > +	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +		print_verbose_info(current);
> > +
> > 	/* Print report footer. */
> > 	pr_err("\n");
> > 	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> > @@ -357,6 +394,67 @@ static void release_report(unsigned long *flags, enum kcsan_report_type type)
> > 	spin_unlock_irqrestore(&report_lock, *flags);
> > }
> > 
> > +/*
> > + * Sets @other_info.task and awaits consumption of @other_info.
> > + *
> > + * Precondition: report_lock is held.
> > + * Postcondition: report_lock is held.
> > + */
> > +static void
> > +set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
> > +{
> > +	/*
> > +	 * We may be instrumenting a code-path where current->state is already
> > +	 * something other than TASK_RUNNING.
> > +	 */
> > +	const bool is_running = current->state == TASK_RUNNING;
> > +	/*
> > +	 * To avoid deadlock in case we are in an interrupt here and this is a
> > +	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
> > +	 * timeout to ensure this works in all contexts.
> > +	 *
> > +	 * Await approximately the worst case delay of the reporting thread (if
> > +	 * we are not interrupted).
> > +	 */
> > +	int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);
> > +
> > +	other_info.task = current;
> > +	do {
> > +		if (is_running) {
> > +			/*
> > +			 * Let lockdep know the real task is sleeping, to print
> > +			 * the held locks (recall we turned lockdep off, so
> > +			 * locking/unlocking @report_lock won't be recorded).
> > +			 */
> > +			set_current_state(TASK_UNINTERRUPTIBLE);
> > +		}
> > +		spin_unlock_irqrestore(&report_lock, *flags);
> > +		/*
> > +		 * We cannot call schedule() since we also cannot reliably
> > +		 * determine if sleeping here is permitted -- see in_atomic().
> > +		 */
> > +
> > +		udelay(1);
> > +		spin_lock_irqsave(&report_lock, *flags);
> > +		if (timeout-- < 0) {
> > +			/*
> > +			 * Abort. Reset other_info.task to NULL, since it
> > +			 * appears the other thread is still going to consume
> > +			 * it. It will result in no verbose info printed for
> > +			 * this task.
> > +			 */
> > +			other_info.task = NULL;
> > +			break;
> > +		}
> > +		/*
> > +		 * If @ptr nor @current matches, then our information has been
> > +		 * consumed and we may continue. If not, retry.
> > +		 */
> > +	} while (other_info.ptr == ptr && other_info.task == current);
> > +	if (is_running)
> > +		set_current_state(TASK_RUNNING);
> > +}
> > +
> > /*
> >  * Depending on the report type either sets other_info and returns false, or
> >  * acquires the matching other_info and returns true. If other_info is not
> > @@ -388,6 +486,9 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
> > 		other_info.cpu_id		= cpu_id;
> > 		other_info.num_stack_entries	= stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
> > 
> > +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +			set_other_info_task_blocking(flags, ptr);
> > +
> > 		spin_unlock_irqrestore(&report_lock, *flags);
> > 
> > 		/*
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index 081ed2e1bf7b1..0f1447ff8f558 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -20,6 +20,19 @@ menuconfig KCSAN
> > 
> > if KCSAN
> > 
> > +config KCSAN_VERBOSE
> > +	bool "Show verbose reports with more information about system state"
> > +	depends on PROVE_LOCKING
> > +	help
> > +	  If enabled, reports show more information about the system state that
> > +	  may help better analyze and debug races. This includes held locks and
> > +	  IRQ trace events.
> > +
> > +	  While this option should generally be benign, we call into more
> > +	  external functions on report generation; if a race report is
> > +	  generated from any one of them, system stability may suffer due to
> > +	  deadlocks or recursion.  If in doubt, say N.
> > +
> > config KCSAN_DEBUG
> > 	bool "Debugging of KCSAN internals"
> > 
> > -- 
> > 2.25.0.265.gbab2e86ba0-goog
> > 
> 
