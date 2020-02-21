Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623AC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51CA20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+NTz+bB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgBUW6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:58:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42999 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgBUW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:58:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so3521549otd.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbyeYRXgDIes5s9xa5B9SEl5uluy49ubtkBwGsyY6g4=;
        b=I+NTz+bBo+uvu8AgD3o1Ed0ZkhVAyO6067/WjoZPthGEC+AbPmkicjKjh7WFC/LWTC
         zLhc/ZzsqF5r1CjPumkkYgNFyJUz1BX77cOm7X8W4vbV7bpzhcEBT8wEbsc2bD1y0cu4
         oDSQbLoEpCgEQRFiPp1nOePCkxqLLUh3IoOXJxyrg+FvQIvVeCq0U9DwqR2zR/2QrgWP
         dP9Kup3Bwb4kR5bY+iGN6oX0GQpeHrHmVq7t1shMXZIGE78pRqJTOlf5UHcdJW+8kCEi
         CWr3vlGqhS6x29OjO1xuxVRGmTiMRWdRue6jA2GLz93Yvo613YNPiO00Kg4ot9jCv+Br
         Wuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbyeYRXgDIes5s9xa5B9SEl5uluy49ubtkBwGsyY6g4=;
        b=MnIHO37IeZJorsfv0L2ELDCLh5CumurSDFIFNGtoFHlMihl41z0s7noo6+UpIlHh9c
         5s+3Opk85E5/SD0MNpvHCtxds7XGhobj2KhIvSms53aYnqSdZbnqLpZFHWKfB7yvMC+f
         zlAwogJxBX1hbHIYVN9GiLNpougQjwqBMt+UKSqNIBXgCae8OwTSfLLPdpAGnNc0GN/5
         8yRKcxTxZlWC9AjvycXgtoP8X0mxXoCP8anX1THmZGAp5MsW26YZ9OQOmJd+cemb30QD
         xKt/A51JlaMbf1zt+R6frvw68kPSu+GTK/hJ80syCzjoqu7CwNE8NZvfUKB4rexMRYBx
         +dFw==
X-Gm-Message-State: APjAAAUjsjF2NE66HUkUxRYu4e1zAqcUzwW5Zz3lyPA9sT4gKdYSgjJs
        KNSLDUikoYz1upUS4oHf8fwAwRWbdmjzcuuTTy9B/g==
X-Google-Smtp-Source: APXvYqwQibNo2tV3qDVf0XNxOjyXO35AkwnWIcERF3tsqib7nwFhaRPZg/0whFtmO+zjcx/Lv6x+zXFFldtdQ3rbYl8=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr31177927otk.23.1582325921271;
 Fri, 21 Feb 2020 14:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20200221220209.164772-1-elver@google.com>
In-Reply-To: <20200221220209.164772-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Feb 2020 23:58:30 +0100
Message-ID: <CANpmjNOnXhX_Edc7=7L072TB5-uv-4nivPEUYNh-=-1EFkYJbw@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: Add option to allow watcher interruptions
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 23:02, Marco Elver <elver@google.com> wrote:
>
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
> To avoid new warnings, changes all uses of smp_processor_id() to use the
> raw version (as already done in kcsan_found_watchpoint()). The exact SMP
> processor id is for informational purposes in the report, and
> correctness is not affected.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Change smp_processor_id() to raw_smp_processor_id() as already used in
>   kcsan_found_watchpoint() to avoid warnings.

Just noticed this one should probably go before v2 of "kcsan: Add
option for verbose reporting" as otherwise there may be a minor
conflict (adjacent lines touched). (Sorry)

Thanks,
-- Marco

> ---
>  kernel/kcsan/core.c | 34 ++++++++++------------------------
>  lib/Kconfig.kcsan   | 11 +++++++++++
>  2 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 589b1e7f0f253..e7387fec66795 100644
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
>         unsigned long access_mask;
>         enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
>         unsigned long ua_flags = user_access_save();
> -       unsigned long irq_flags;
> +       unsigned long irq_flags = 0;
>
>         /*
>          * Always reset kcsan_skip counter in slow-path to avoid underflow; see
> @@ -370,26 +372,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>                 goto out;
>         }
>
> -       /*
> -        * Disable interrupts & preemptions to avoid another thread on the same
> -        * CPU accessing memory locations for the set up watchpoint; this is to
> -        * avoid reporting races to e.g. CPU-local data.
> -        *
> -        * An alternative would be adding the source CPU to the watchpoint
> -        * encoding, and checking that watchpoint-CPU != this-CPU. There are
> -        * several problems with this:
> -        *   1. we should avoid stealing more bits from the watchpoint encoding
> -        *      as it would affect accuracy, as well as increase performance
> -        *      overhead in the fast-path;
> -        *   2. if we are preempted, but there *is* a genuine data race, we
> -        *      would *not* report it -- since this is the common case (vs.
> -        *      CPU-local data accesses), it makes more sense (from a data race
> -        *      detection point of view) to simply disable preemptions to ensure
> -        *      as many tasks as possible run on other CPUs.
> -        *
> -        * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
> -        */
> -       raw_local_irq_save(irq_flags);
> +       if (!kcsan_interrupt_watcher)
> +               /* Use raw to avoid lockdep recursion via IRQ flags tracing. */
> +               raw_local_irq_save(irq_flags);
>
>         watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
>         if (watchpoint == NULL) {
> @@ -507,7 +492,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>                 if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
>                         kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
>
> -               kcsan_report(ptr, size, type, value_change, smp_processor_id(),
> +               kcsan_report(ptr, size, type, value_change, raw_smp_processor_id(),
>                              KCSAN_REPORT_RACE_SIGNAL);
>         } else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
>                 /* Inferring a race, since the value should not have changed. */
> @@ -518,13 +503,14 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>
>                 if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
>                         kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
> -                                    smp_processor_id(),
> +                                    raw_smp_processor_id(),
>                                      KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
>         }
>
>         kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
>  out_unlock:
> -       raw_local_irq_restore(irq_flags);
> +       if (!kcsan_interrupt_watcher)
> +               raw_local_irq_restore(irq_flags);
>  out:
>         user_access_restore(ua_flags);
>  }
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index f0b791143c6ab..081ed2e1bf7b1 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -88,6 +88,17 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
>           KCSAN_WATCH_SKIP. If false, the chosen value is always
>           KCSAN_WATCH_SKIP.
>
> +config KCSAN_INTERRUPT_WATCHER
> +       bool "Interruptible watchers"
> +       help
> +         If enabled, a task that set up a watchpoint may be interrupted while
> +         delayed. This option will allow KCSAN to detect races between
> +         interrupted tasks and other threads of execution on the same CPU.
> +
> +         Currently disabled by default, because not all safe per-CPU access
> +         primitives and patterns may be accounted for, and therefore could
> +         result in false positives.
> +
>  config KCSAN_REPORT_ONCE_IN_MS
>         int "Duration in milliseconds, in which any given race is only reported once"
>         default 3000
> --
> 2.25.0.265.gbab2e86ba0-goog
>
