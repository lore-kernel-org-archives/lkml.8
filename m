Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F1C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379D20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1bBNyI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBXTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:17:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39646 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:17:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so7073504oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwV+u3WOm9LRc51C8OUh4HjW6YnKJQYbrX5gdSJFQPg=;
        b=M1bBNyI8DdOUCkQRYPRr1f7VEpubmZhuMLCMOqvXRXJ97uk9QJX4A8X3SO4tvcGM7/
         jrVM/jxGlNcQeQvN8rumnaE87Pd2f7GyFq0aIxVbO6LBPnBvVHQP2D3sCNBnGQPhX8Kv
         fXVjtjkSvPVISpSw+9PPOV61+WKzRpitkPq1qyFkGa28lOKGFACNqRC397AzO0775MsZ
         iX7Ulp7VRKK4cVeNT1G82IRX2cdyXvQoma55Skx6PGHcoHrh7sA3wqS0x2A/HILsDZp6
         C+JD6+yPLDMd2reywGQ8B5k1hVpokSBIL/Ejeo0WzWMQX/UA7qkz47ddm/sYfrBI184T
         s7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwV+u3WOm9LRc51C8OUh4HjW6YnKJQYbrX5gdSJFQPg=;
        b=Xas5VgB+MvbQPPGvANZCGP3GA58HogNG5KOqxz/n4P6cW2NFVCzUwNAj78GYLrEQqS
         JO8ZVPSxpii4ScxnLa7NcJM5YQZKFT7RqxB62W7ZWZw/hshd2nRV8MNcLjN1zgYvPIAF
         FpCA444a43YbOUf+PSJkQGrD69rM7D/OVNNmuu6nDlUd0X1GQkt792BZrnB9L3a78v1R
         o2fg/gJpFk4OH/YJxrky5Xn0zB5dvWCNBQjtfxA1T6FkHDGjLRn76KILz9an4Ma8x45H
         +PlQ9EXTRooNGorblkHd499bXHDcKWOOyThBc6ExFMWc96Z9qEYLtxm8X/5P/RZ7HHgW
         Zh/w==
X-Gm-Message-State: APjAAAV5faJ5A+EHmPV394obDNoYeUfxH9JPy5R4BFqIPbMlPSamaiCy
        yKw3OEOFc+DDVPWG6ENHMgFbYr6lRZjrilUvuNStgQ==
X-Google-Smtp-Source: APXvYqzROexC+r5Qkukn5Vm4o44tIgdihc8RdU1ZtRYdSsIHUCAX5xfFtKN65lPVHC+RIMVYSUvgd7T7a4DXEAKsQSY=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr480740oig.172.1582571819031;
 Mon, 24 Feb 2020 11:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20200221231027.230147-1-elver@google.com> <20200222013642.GQ2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200222013642.GQ2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Feb 2020 20:16:47 +0100
Message-ID: <CANpmjNMVczXfr98LTTd4hYBXakq1uGZ14Wfs66pDB=e4JPGjwA@mail.gmail.com>
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 at 02:36, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Feb 22, 2020 at 12:10:27AM +0100, Marco Elver wrote:
> > Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> > Currently information about the reporting task's held locks and IRQ
> > trace events are shown, if they are enabled.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Suggested-by: Qian Cai <cai@lca.pw>
>
> Applied in place of v1, thank you!  Please check -rcu's "dev" branch
> to make sure that I have correct ordering and versions.

(Missed this.) Checked, and all looks good. Thank you!

I hope the new version of this patch now does what you'd expect.

Thanks,
-- Marco

>
> > ---
> > v3:
> > * Typos
> > v2:
> > * Rework obtaining 'current' for the "other thread" -- it now passes
> >   'current' and ensures that we stall until the report was printed, so
> >   that the lockdep information contained in 'current' is accurate. This
> >   was non-trivial but testing so far leads me to conclude this now
> >   reliably prints the held locks for the "other thread" (please test
> >   more!).
> > ---
> >  kernel/kcsan/core.c   |   4 +-
> >  kernel/kcsan/kcsan.h  |   3 ++
> >  kernel/kcsan/report.c | 103 +++++++++++++++++++++++++++++++++++++++++-
> >  lib/Kconfig.kcsan     |  13 ++++++
> >  4 files changed, 120 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index e7387fec66795..065615df88eaa 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -18,8 +18,8 @@
> >  #include "kcsan.h"
> >
> >  static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
> > -static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> > -static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> > +unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> > +unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> >  static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
> >  static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
> >
> > diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> > index 892de5120c1b6..e282f8b5749e9 100644
> > --- a/kernel/kcsan/kcsan.h
> > +++ b/kernel/kcsan/kcsan.h
> > @@ -13,6 +13,9 @@
> >  /* The number of adjacent watchpoints to check. */
> >  #define KCSAN_CHECK_ADJACENT 1
> >
> > +extern unsigned int kcsan_udelay_task;
> > +extern unsigned int kcsan_udelay_interrupt;
> > +
> >  /*
> >   * Globally enable and disable KCSAN.
> >   */
> > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > index 11c791b886f3c..7bdb515e3662f 100644
> > --- a/kernel/kcsan/report.c
> > +++ b/kernel/kcsan/report.c
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/debug_locks.h>
> > +#include <linux/delay.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> >  #include <linux/lockdep.h>
> > @@ -31,7 +33,26 @@ static struct {
> >       int                     cpu_id;
> >       unsigned long           stack_entries[NUM_STACK_ENTRIES];
> >       int                     num_stack_entries;
> > -} other_info = { .ptr = NULL };
> > +
> > +     /*
> > +      * Optionally pass @current. Typically we do not need to pass @current
> > +      * via @other_info since just @task_pid is sufficient. Passing @current
> > +      * has additional overhead.
> > +      *
> > +      * To safely pass @current, we must either use get_task_struct/
> > +      * put_task_struct, or stall the thread that populated @other_info.
> > +      *
> > +      * We cannot rely on get_task_struct/put_task_struct in case
> > +      * release_report() races with a task being released, and would have to
> > +      * free it in release_report(). This may result in deadlock if we want
> > +      * to use KCSAN on the allocators.
> > +      *
> > +      * Since we also want to reliably print held locks for
> > +      * CONFIG_KCSAN_VERBOSE, the current implementation stalls the thread
> > +      * that populated @other_info until it has been consumed.
> > +      */
> > +     struct task_struct      *task;
> > +} other_info;
> >
> >  /*
> >   * Information about reported races; used to rate limit reporting.
> > @@ -245,6 +266,16 @@ static int sym_strcmp(void *addr1, void *addr2)
> >       return strncmp(buf1, buf2, sizeof(buf1));
> >  }
> >
> > +static void print_verbose_info(struct task_struct *task)
> > +{
> > +     if (!task)
> > +             return;
> > +
> > +     pr_err("\n");
> > +     debug_show_held_locks(task);
> > +     print_irqtrace_events(task);
> > +}
> > +
> >  /*
> >   * Returns true if a report was generated, false otherwise.
> >   */
> > @@ -319,6 +350,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
> >                                 other_info.num_stack_entries - other_skipnr,
> >                                 0);
> >
> > +             if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +                 print_verbose_info(other_info.task);
> > +
> >               pr_err("\n");
> >               pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
> >                      get_access_type(access_type), ptr, size,
> > @@ -340,6 +374,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
> >       stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
> >                         0);
> >
> > +     if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +             print_verbose_info(current);
> > +
> >       /* Print report footer. */
> >       pr_err("\n");
> >       pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> > @@ -357,6 +394,67 @@ static void release_report(unsigned long *flags, enum kcsan_report_type type)
> >       spin_unlock_irqrestore(&report_lock, *flags);
> >  }
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
> > +     /*
> > +      * We may be instrumenting a code-path where current->state is already
> > +      * something other than TASK_RUNNING.
> > +      */
> > +     const bool is_running = current->state == TASK_RUNNING;
> > +     /*
> > +      * To avoid deadlock in case we are in an interrupt here and this is a
> > +      * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
> > +      * timeout to ensure this works in all contexts.
> > +      *
> > +      * Await approximately the worst case delay of the reporting thread (if
> > +      * we are not interrupted).
> > +      */
> > +     int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);
> > +
> > +     other_info.task = current;
> > +     do {
> > +             if (is_running) {
> > +                     /*
> > +                      * Let lockdep know the real task is sleeping, to print
> > +                      * the held locks (recall we turned lockdep off, so
> > +                      * locking/unlocking @report_lock won't be recorded).
> > +                      */
> > +                     set_current_state(TASK_UNINTERRUPTIBLE);
> > +             }
> > +             spin_unlock_irqrestore(&report_lock, *flags);
> > +             /*
> > +              * We cannot call schedule() since we also cannot reliably
> > +              * determine if sleeping here is permitted -- see in_atomic().
> > +              */
> > +
> > +             udelay(1);
> > +             spin_lock_irqsave(&report_lock, *flags);
> > +             if (timeout-- < 0) {
> > +                     /*
> > +                      * Abort. Reset other_info.task to NULL, since it
> > +                      * appears the other thread is still going to consume
> > +                      * it. It will result in no verbose info printed for
> > +                      * this task.
> > +                      */
> > +                     other_info.task = NULL;
> > +                     break;
> > +             }
> > +             /*
> > +              * If @ptr nor @current matches, then our information has been
> > +              * consumed and we may continue. If not, retry.
> > +              */
> > +     } while (other_info.ptr == ptr && other_info.task == current);
> > +     if (is_running)
> > +             set_current_state(TASK_RUNNING);
> > +}
> > +
> >  /*
> >   * Depending on the report type either sets other_info and returns false, or
> >   * acquires the matching other_info and returns true. If other_info is not
> > @@ -388,6 +486,9 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
> >               other_info.cpu_id               = cpu_id;
> >               other_info.num_stack_entries    = stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
> >
> > +             if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +                     set_other_info_task_blocking(flags, ptr);
> > +
> >               spin_unlock_irqrestore(&report_lock, *flags);
> >
> >               /*
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index 081ed2e1bf7b1..0f1447ff8f558 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -20,6 +20,19 @@ menuconfig KCSAN
> >
> >  if KCSAN
> >
> > +config KCSAN_VERBOSE
> > +     bool "Show verbose reports with more information about system state"
> > +     depends on PROVE_LOCKING
> > +     help
> > +       If enabled, reports show more information about the system state that
> > +       may help better analyze and debug races. This includes held locks and
> > +       IRQ trace events.
> > +
> > +       While this option should generally be benign, we call into more
> > +       external functions on report generation; if a race report is
> > +       generated from any one of them, system stability may suffer due to
> > +       deadlocks or recursion.  If in doubt, say N.
> > +
> >  config KCSAN_DEBUG
> >       bool "Debugging of KCSAN internals"
> >
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
