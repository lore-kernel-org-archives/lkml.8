Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F5C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DB220775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chyQVmXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgG1KpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgG1KpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:45:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:45:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h1so14518149otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9qNMY+MaOU7/Uc+GSjibOeYutZuuvmea9JQdtNRlCc=;
        b=chyQVmXVu0+8jleygyi9eT1uxtxKjJ8sE+QFDKHI8MkbA7rnHmKT+HXDKMJxwOGXm0
         2JNYBXycpmPeu9l+Q3wSVa1kYEyvvVBAAmqwP23Srs4Gmh1csl6YmmTzPzSNU14ObJCX
         Jmh1e8P5OKiD8jfdcwwnNCDwBVv3Xo6Cvzo/h/z2EyZoIXAS29F2cLF2cn7BR0goJt27
         ztIaeWJBu7joauhlfb6RgFk9LZC43duFaPy9176i3rfGYFs/45w+R7jcqKa0+Xpxyx4G
         RltIeaQ89z7vHfkZuywLwzlkfw4HqDOVkQY4ZSI3clj/fn0yfKhIRK26xF31XQ+R2RaZ
         MQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9qNMY+MaOU7/Uc+GSjibOeYutZuuvmea9JQdtNRlCc=;
        b=ooXWrDr0BwdJAwOSevwL8yUlNyxE7I65GNMzhvYG9LhyY0ydijUw9ah8ZJZjQhRJUO
         xQbrinqS1Gh1OZu/1qqqOiMAGrC65bKv6MzxfYI60lFTQJGvm8lG6Xyz8mjID1UMg9eR
         HfgnQA7juCI2fttEmUFsZQ98Qn8KOCW6v5r6DUM5hMJBnnt4nVMXHScF6fZ02kws7wUT
         3YIl3c86LgqWoOLPSKwrPCwR6NIUqVos3IzXF54tJL9GxEnxKIZGrgziLlNxry/VyANS
         qsTHnyPs2F2Dal3fFv0bI9uMWEuTGnYjbc2KTzDBhzRNrwUMBwG/jwOa0TL9bXSYgUJH
         mMRQ==
X-Gm-Message-State: AOAM533Gwyv2vP+w3dw5/VFnjgCA+m1dpk5GaRp1jz5cpCPRhBVprk8X
        8FZvd1SxiI5etO60EgvMqQEDlfKmIT74Yg9X+rH6Sg==
X-Google-Smtp-Source: ABdhPJxXnDaV69CLaYerEoMeAmN769TjPWPlbDqSutbAzYSiHYia2EsmI7AIccnCuaVqeGZr3qUUEIImgeVsFbKIaSw=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr8111463otr.251.1595933120306;
 Tue, 28 Jul 2020 03:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200720120348.2406588-1-elver@google.com>
In-Reply-To: <20200720120348.2406588-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jul 2020 12:45:08 +0200
Message-ID: <CANpmjNO7M2gm5=P9Z27_BgT3i=p6=KFBbEUaKm049wtqyBMQcA@mail.gmail.com>
Subject: Re: [PATCH tip/locking/core] kcsan: Improve IRQ state trace reporting
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 at 14:03, Marco Elver <elver@google.com> wrote:
>
> To improve the general usefulness of the IRQ state trace information
> with KCSAN enabled, save and restore the trace information when entering
> and exiting the KCSAN runtime as well as when generating a KCSAN report.
>
> Without this, reporting the IRQ state trace (whether via a KCSAN report
> or outside of KCSAN via a lockdep report) is rather useless due to
> continuously being touched by KCSAN. This is because if KCSAN is
> enabled, every instrumented memory access causes changes to IRQ state
> tracking information (either by KCSAN disabling/enabling interrupts or
> taking report_lock when generating a report).
>
> Before "lockdep: Prepare for NMI IRQ state tracking", KCSAN avoided
> touching the IRQ state trace via raw_local_irq_save/restore() and
> lockdep_off/on().
>
> Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>
>
> Hi, Peter,
>
> If this is reasonable, please take it into the branch that currently has
> the series around "lockdep: Prepare for NMI IRQ state tracking"
> (tip/locking/core?).

Just in case -- checking this one wasn't lost.

Many thanks,
-- Marco

> ---
>  include/linux/sched.h | 13 +++++++++++++
>  kernel/kcsan/core.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  kernel/kcsan/kcsan.h  |  7 +++++++
>  kernel/kcsan/report.c |  3 +++
>  4 files changed, 62 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 692e327d7455..ca5324b1657c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1199,6 +1199,19 @@ struct task_struct {
>  #endif
>  #ifdef CONFIG_KCSAN
>         struct kcsan_ctx                kcsan_ctx;
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       struct {
> +               unsigned int            irq_events;
> +               unsigned long           hardirq_enable_ip;
> +               unsigned long           hardirq_disable_ip;
> +               unsigned int            hardirq_enable_event;
> +               unsigned int            hardirq_disable_event;
> +               unsigned long           softirq_disable_ip;
> +               unsigned long           softirq_enable_ip;
> +               unsigned int            softirq_disable_event;
> +               unsigned int            softirq_enable_event;
> +       } kcsan_save_irqtrace;
> +#endif
>  #endif
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 732623c30359..7e8347c14530 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -291,6 +291,36 @@ static inline unsigned int get_delay(void)
>                                 0);
>  }
>
> +void kcsan_save_irqtrace(struct task_struct *task)
> +{
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       task->kcsan_save_irqtrace.irq_events = task->irq_events;
> +       task->kcsan_save_irqtrace.hardirq_enable_ip = task->hardirq_enable_ip;
> +       task->kcsan_save_irqtrace.hardirq_disable_ip = task->hardirq_disable_ip;
> +       task->kcsan_save_irqtrace.hardirq_enable_event = task->hardirq_enable_event;
> +       task->kcsan_save_irqtrace.hardirq_disable_event = task->hardirq_disable_event;
> +       task->kcsan_save_irqtrace.softirq_disable_ip = task->softirq_disable_ip;
> +       task->kcsan_save_irqtrace.softirq_enable_ip = task->softirq_enable_ip;
> +       task->kcsan_save_irqtrace.softirq_disable_event = task->softirq_disable_event;
> +       task->kcsan_save_irqtrace.softirq_enable_event = task->softirq_enable_event;
> +#endif
> +}
> +
> +void kcsan_restore_irqtrace(struct task_struct *task)
> +{
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       task->irq_events = task->kcsan_save_irqtrace.irq_events;
> +       task->hardirq_enable_ip = task->kcsan_save_irqtrace.hardirq_enable_ip;
> +       task->hardirq_disable_ip = task->kcsan_save_irqtrace.hardirq_disable_ip;
> +       task->hardirq_enable_event = task->kcsan_save_irqtrace.hardirq_enable_event;
> +       task->hardirq_disable_event = task->kcsan_save_irqtrace.hardirq_disable_event;
> +       task->softirq_disable_ip = task->kcsan_save_irqtrace.softirq_disable_ip;
> +       task->softirq_enable_ip = task->kcsan_save_irqtrace.softirq_enable_ip;
> +       task->softirq_disable_event = task->kcsan_save_irqtrace.softirq_disable_event;
> +       task->softirq_enable_event = task->kcsan_save_irqtrace.softirq_enable_event;
> +#endif
> +}
> +
>  /*
>   * Pull everything together: check_access() below contains the performance
>   * critical operations; the fast-path (including check_access) functions should
> @@ -336,9 +366,11 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
>         flags = user_access_save();
>
>         if (consumed) {
> +               kcsan_save_irqtrace(current);
>                 kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
>                              KCSAN_REPORT_CONSUMED_WATCHPOINT,
>                              watchpoint - watchpoints);
> +               kcsan_restore_irqtrace(current);
>         } else {
>                 /*
>                  * The other thread may not print any diagnostics, as it has
> @@ -396,6 +428,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>                 goto out;
>         }
>
> +       /*
> +        * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
> +        * runtime is entered for every memory access, and potentially useful
> +        * information is lost if dirtied by KCSAN.
> +        */
> +       kcsan_save_irqtrace(current);
>         if (!kcsan_interrupt_watcher)
>                 local_irq_save(irq_flags);
>
> @@ -539,6 +577,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  out_unlock:
>         if (!kcsan_interrupt_watcher)
>                 local_irq_restore(irq_flags);
> +       kcsan_restore_irqtrace(current);
>  out:
>         user_access_restore(ua_flags);
>  }
> diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> index 763d6d08d94b..29480010dc30 100644
> --- a/kernel/kcsan/kcsan.h
> +++ b/kernel/kcsan/kcsan.h
> @@ -9,6 +9,7 @@
>  #define _KERNEL_KCSAN_KCSAN_H
>
>  #include <linux/kcsan.h>
> +#include <linux/sched.h>
>
>  /* The number of adjacent watchpoints to check. */
>  #define KCSAN_CHECK_ADJACENT 1
> @@ -22,6 +23,12 @@ extern unsigned int kcsan_udelay_interrupt;
>   */
>  extern bool kcsan_enabled;
>
> +/*
> + * Save/restore IRQ flags state trace dirtied by KCSAN.
> + */
> +void kcsan_save_irqtrace(struct task_struct *task);
> +void kcsan_restore_irqtrace(struct task_struct *task);
> +
>  /*
>   * Initialize debugfs file.
>   */
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 6b2fb1a6d8cd..9d07e175de0f 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -308,6 +308,9 @@ static void print_verbose_info(struct task_struct *task)
>         if (!task)
>                 return;
>
> +       /* Restore IRQ state trace for printing. */
> +       kcsan_restore_irqtrace(task);
> +
>         pr_err("\n");
>         debug_show_held_locks(task);
>         print_irqtrace_events(task);
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>
