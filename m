Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E7BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE4C2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580830818;
	bh=XjO/rypf4gOojGf0oXOQkll6+73OmV+xBEcS+uJX0Ac=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=u9aJwnpWMG8CpWCpEnOMaQPT17FlKHF2WMIj4fcVEIyxlkzs+npnJvshSKyaXIAVE
	 3NuhvRBP+P7GHidM7OkiiDkRXTMRPIo40EqQJKqI7EhbOjM1R4eLb/RwHCIiqpr8s8
	 2MJQuDUWanbwpc96pBkq93CRmBaUR0DZKdK3Pk2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBDPkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgBDPkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:40:16 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB1720674;
        Tue,  4 Feb 2020 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580830815;
        bh=XjO/rypf4gOojGf0oXOQkll6+73OmV+xBEcS+uJX0Ac=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vodTEsLi+gyzU1kEcPqnqOzgfXe7tDAP6mg488qR+wwKflCraZFaf1nRX5gBLiPlM
         k0WOtxiHHQaY/qHSKZUlBbYzEXNWfj4Sf+cN8xFNPXXu87KVUUJ/nMXXpK5Qc8k7nw
         RO7JNt9amNpSfJw3V4ttf203mW86CZPqL5u0Bx9Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5D8DD352270F; Tue,  4 Feb 2020 07:40:15 -0800 (PST)
Date:   Tue, 4 Feb 2020 07:40:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] kcsan: Add option to assume plain writes up to word
 size are atomic
Message-ID: <20200204154015.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200204140353.177797-1-elver@google.com>
 <CANpmjNMF3LpOUZSKXigxVXaH8imA2O5OvVu4ibPEDhCjwAXk0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMF3LpOUZSKXigxVXaH8imA2O5OvVu4ibPEDhCjwAXk0w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:28:47PM +0100, Marco Elver wrote:
> On Tue, 4 Feb 2020 at 15:04, Marco Elver <elver@google.com> wrote:
> >
> > This adds option KCSAN_ASSUME_PLAIN_WRITES_ATOMIC. If enabled, plain
> > writes up to word size are also assumed to be atomic, and also not
> > subject to other unsafe compiler optimizations resulting in data races.
> 
> I just realized we should probably also check for alignedness. Would
> this be fair to add as an additional constraint? It would be my
> preference.

Checking for alignment makes a lot of sense to me!  Otherwise, write
tearing is expected behavior on some systems.

							Thanx, Paul

> Thanks,
> -- Marco
> 
> > This option has been enabled by default to reflect current kernel-wide
> > preferences.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  kernel/kcsan/core.c | 20 +++++++++++++++-----
> >  lib/Kconfig.kcsan   | 26 +++++++++++++++++++-------
> >  2 files changed, 34 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 64b30f7716a12..3bd1bf8d6bfeb 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -169,10 +169,19 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
> >         return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> >  }
> >
> > -static __always_inline bool is_atomic(const volatile void *ptr)
> > +static __always_inline bool
> > +is_atomic(const volatile void *ptr, size_t size, int type)
> >  {
> > -       struct kcsan_ctx *ctx = get_ctx();
> > +       struct kcsan_ctx *ctx;
> > +
> > +       if ((type & KCSAN_ACCESS_ATOMIC) != 0)
> > +               return true;
> >
> > +       if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
> > +           (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long))
> > +               return true; /* Assume all writes up to word size are atomic. */
> > +
> > +       ctx = get_ctx();
> >         if (unlikely(ctx->atomic_next > 0)) {
> >                 /*
> >                  * Because we do not have separate contexts for nested
> > @@ -193,7 +202,8 @@ static __always_inline bool is_atomic(const volatile void *ptr)
> >         return kcsan_is_atomic(ptr);
> >  }
> >
> > -static __always_inline bool should_watch(const volatile void *ptr, int type)
> > +static __always_inline bool
> > +should_watch(const volatile void *ptr, size_t size, int type)
> >  {
> >         /*
> >          * Never set up watchpoints when memory operations are atomic.
> > @@ -202,7 +212,7 @@ static __always_inline bool should_watch(const volatile void *ptr, int type)
> >          * should not count towards skipped instructions, and (2) to actually
> >          * decrement kcsan_atomic_next for consecutive instruction stream.
> >          */
> > -       if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
> > +       if (is_atomic(ptr, size, type))
> >                 return false;
> >
> >         if (this_cpu_dec_return(kcsan_skip) >= 0)
> > @@ -460,7 +470,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
> >         if (unlikely(watchpoint != NULL))
> >                 kcsan_found_watchpoint(ptr, size, type, watchpoint,
> >                                        encoded_watchpoint);
> > -       else if (unlikely(should_watch(ptr, type)))
> > +       else if (unlikely(should_watch(ptr, size, type)))
> >                 kcsan_setup_watchpoint(ptr, size, type);
> >  }
> >
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index 3552990abcfe5..08972376f0454 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -91,13 +91,13 @@ config KCSAN_REPORT_ONCE_IN_MS
> >           limiting reporting to avoid flooding the console with reports.
> >           Setting this to 0 disables rate limiting.
> >
> > -# Note that, while some of the below options could be turned into boot
> > -# parameters, to optimize for the common use-case, we avoid this because: (a)
> > -# it would impact performance (and we want to avoid static branch for all
> > -# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
> > -# without real benefit. The main purpose of the below options is for use in
> > -# fuzzer configs to control reported data races, and they are not expected
> > -# to be switched frequently by a user.
> > +# The main purpose of the below options is to control reported data races (e.g.
> > +# in fuzzer configs), and are not expected to be switched frequently by other
> > +# users. We could turn some of them into boot parameters, but given they should
> > +# not be switched normally, let's keep them here to simplify configuration.
> > +#
> > +# The defaults below are chosen to be very conservative, and may miss certain
> > +# bugs.
> >
> >  config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> >         bool "Report races of unknown origin"
> > @@ -116,6 +116,18 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
> >           the data value of the memory location was observed to remain
> >           unchanged, do not report the data race.
> >
> > +config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
> > +       bool "Assume that plain writes up to word size are atomic"
> > +       default y
> > +       help
> > +         Assume that plain writes up to word size are atomic by default, and
> > +         also not subject to other unsafe compiler optimizations resulting in
> > +         data races. This will cause KCSAN to not report data races due to
> > +         conflicts where the only plain accesses are writes up to word size:
> > +         conflicts between marked reads and plain writes up to word size will
> > +         not be reported as data races; notice that data races between two
> > +         conflicting plain writes will also not be reported.
> > +
> >  config KCSAN_IGNORE_ATOMICS
> >         bool "Do not instrument marked atomic accesses"
> >         help
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
