Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBFC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4002072C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582334927;
	bh=y6N8w+xrdyGVYTFR7OqIceNq1k0EAmEqYchevMvLdkA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Cgq+YnpeqQf+CZyl1NcrGb4MTd1AnWjkw/Rh/r4owiQ7/Jf+5n3FpFeQnPOZJ1KLA
	 7sYRtFRCMezxVKbtcw3AyleSMVHo5d8m8Oyi4zFiuRO8PExX3QJTaTsKR4ZtSpl29x
	 LPTPeYEMb6NIAu2z6vRfJkrQV/8l3FSVg+bxH8zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBVB2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgBVB2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:28:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B631320722;
        Sat, 22 Feb 2020 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582334924;
        bh=y6N8w+xrdyGVYTFR7OqIceNq1k0EAmEqYchevMvLdkA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xjKM7DAIRFQCoVLg4kU5UuMIzgG1eaQ25EZp/MDcRLo4N1p+3fEzxoow0T+Z6g4zy
         BR+pPVlpth4xpKUV/7tV4G+hnoYrZOnZy9utcE1JxTTZCWiMWuBGlZIK/oQBAmCgKg
         eobmFZaBazmDjMJKiKRN2M4g+PJm5pD8eay4drkc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 56BA835226DB; Fri, 21 Feb 2020 17:28:44 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:28:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcsan: Add option to allow watcher interruptions
Message-ID: <20200222012844.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200221220209.164772-1-elver@google.com>
 <CANpmjNOnXhX_Edc7=7L072TB5-uv-4nivPEUYNh-=-1EFkYJbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOnXhX_Edc7=7L072TB5-uv-4nivPEUYNh-=-1EFkYJbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:58:30PM +0100, Marco Elver wrote:
> On Fri, 21 Feb 2020 at 23:02, Marco Elver <elver@google.com> wrote:
> >
> > Add option to allow interrupts while a watchpoint is set up. This can be
> > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > parameter 'kcsan.interrupt_watcher=1'.
> >
> > Note that, currently not all safe per-CPU access primitives and patterns
> > are accounted for, which could result in false positives. For example,
> > asm-generic/percpu.h uses plain operations, which by default are
> > instrumented. On interrupts and subsequent accesses to the same
> > variable, KCSAN would currently report a data race with this option.
> >
> > Therefore, this option should currently remain disabled by default, but
> > may be enabled for specific test scenarios.
> >
> > To avoid new warnings, changes all uses of smp_processor_id() to use the
> > raw version (as already done in kcsan_found_watchpoint()). The exact SMP
> > processor id is for informational purposes in the report, and
> > correctness is not affected.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Change smp_processor_id() to raw_smp_processor_id() as already used in
> >   kcsan_found_watchpoint() to avoid warnings.
> 
> Just noticed this one should probably go before v2 of "kcsan: Add
> option for verbose reporting" as otherwise there may be a minor
> conflict (adjacent lines touched). (Sorry)

Not a problem, "git revert" followed by applying the patches in the
requested order.  ;-)

							Thanx, Paul

> Thanks,
> -- Marco
> 
> > ---
> >  kernel/kcsan/core.c | 34 ++++++++++------------------------
> >  lib/Kconfig.kcsan   | 11 +++++++++++
> >  2 files changed, 21 insertions(+), 24 deletions(-)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 589b1e7f0f253..e7387fec66795 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -21,6 +21,7 @@ static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
> >  static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> >  static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> >  static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
> > +static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
> >
> >  #ifdef MODULE_PARAM_PREFIX
> >  #undef MODULE_PARAM_PREFIX
> > @@ -30,6 +31,7 @@ module_param_named(early_enable, kcsan_early_enable, bool, 0);
> >  module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
> >  module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
> >  module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
> > +module_param_named(interrupt_watcher, kcsan_interrupt_watcher, bool, 0444);
> >
> >  bool kcsan_enabled;
> >
> > @@ -354,7 +356,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> >         unsigned long access_mask;
> >         enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
> >         unsigned long ua_flags = user_access_save();
> > -       unsigned long irq_flags;
> > +       unsigned long irq_flags = 0;
> >
> >         /*
> >          * Always reset kcsan_skip counter in slow-path to avoid underflow; see
> > @@ -370,26 +372,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> >                 goto out;
> >         }
> >
> > -       /*
> > -        * Disable interrupts & preemptions to avoid another thread on the same
> > -        * CPU accessing memory locations for the set up watchpoint; this is to
> > -        * avoid reporting races to e.g. CPU-local data.
> > -        *
> > -        * An alternative would be adding the source CPU to the watchpoint
> > -        * encoding, and checking that watchpoint-CPU != this-CPU. There are
> > -        * several problems with this:
> > -        *   1. we should avoid stealing more bits from the watchpoint encoding
> > -        *      as it would affect accuracy, as well as increase performance
> > -        *      overhead in the fast-path;
> > -        *   2. if we are preempted, but there *is* a genuine data race, we
> > -        *      would *not* report it -- since this is the common case (vs.
> > -        *      CPU-local data accesses), it makes more sense (from a data race
> > -        *      detection point of view) to simply disable preemptions to ensure
> > -        *      as many tasks as possible run on other CPUs.
> > -        *
> > -        * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
> > -        */
> > -       raw_local_irq_save(irq_flags);
> > +       if (!kcsan_interrupt_watcher)
> > +               /* Use raw to avoid lockdep recursion via IRQ flags tracing. */
> > +               raw_local_irq_save(irq_flags);
> >
> >         watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
> >         if (watchpoint == NULL) {
> > @@ -507,7 +492,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> >                 if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
> >                         kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
> >
> > -               kcsan_report(ptr, size, type, value_change, smp_processor_id(),
> > +               kcsan_report(ptr, size, type, value_change, raw_smp_processor_id(),
> >                              KCSAN_REPORT_RACE_SIGNAL);
> >         } else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
> >                 /* Inferring a race, since the value should not have changed. */
> > @@ -518,13 +503,14 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> >
> >                 if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
> >                         kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
> > -                                    smp_processor_id(),
> > +                                    raw_smp_processor_id(),
> >                                      KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
> >         }
> >
> >         kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
> >  out_unlock:
> > -       raw_local_irq_restore(irq_flags);
> > +       if (!kcsan_interrupt_watcher)
> > +               raw_local_irq_restore(irq_flags);
> >  out:
> >         user_access_restore(ua_flags);
> >  }
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index f0b791143c6ab..081ed2e1bf7b1 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -88,6 +88,17 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
> >           KCSAN_WATCH_SKIP. If false, the chosen value is always
> >           KCSAN_WATCH_SKIP.
> >
> > +config KCSAN_INTERRUPT_WATCHER
> > +       bool "Interruptible watchers"
> > +       help
> > +         If enabled, a task that set up a watchpoint may be interrupted while
> > +         delayed. This option will allow KCSAN to detect races between
> > +         interrupted tasks and other threads of execution on the same CPU.
> > +
> > +         Currently disabled by default, because not all safe per-CPU access
> > +         primitives and patterns may be accounted for, and therefore could
> > +         result in false positives.
> > +
> >  config KCSAN_REPORT_ONCE_IN_MS
> >         int "Duration in milliseconds, in which any given race is only reported once"
> >         default 3000
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
