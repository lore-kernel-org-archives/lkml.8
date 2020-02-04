Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E455C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ADA2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPVZGvXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBDRW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:22:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46031 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBDRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:22:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so19199622oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdU/+EXQPN08tVx0Omqu46OD1KCs9yfQsxA+mu440FM=;
        b=iPVZGvXGfBh1inJbO0YdK20ZBCVXEMHeler4kSYegphW0CJQi9jbvx1jt3ZM6SZeKc
         gaveKKl/tureoe6x+M6AiRoAZozmqns7F4qDGWiMpz6c3pXH2zVUMuC29D0yiU25WZDl
         eu1YYnT3M3H4Z6xJjLcMN4aYPsG67nl3fmdRSqb7uE9sLm73mvgd4iBkuYklwZsgmrYj
         74jpk8aPh0d2l5aaWMI+ZxUtdyfA2wqx6FHI/7sD/E9OXeZosZGnca0wL+Vceq8jjACH
         jtiFp9tgFv0mJOEcTZSpMDoRInQTe6WOjc4kszR6AMDICueVBnEFu6ZidlwOUir+jUNZ
         7m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdU/+EXQPN08tVx0Omqu46OD1KCs9yfQsxA+mu440FM=;
        b=eChj34sNakg/CwHkrFQ0pe2nBeyvzFdlwKP5OrAK4TXveegEKIDfDEdkbALesBWXh3
         OHUfLb9ivt2wa6XNWuX5Hao80BUQv9+ZelSgcO0NP5EXi483KiwFby54llGsaBbWyOFL
         kKO1YtxlPXWEUYznaSCJCZqqL6qua0K6O7umO9KJVSwS9VX3V8ZE6ByOHbn84vp5S4SS
         klbp4xn67oo3nCoO5MKOyIzk0a1gmaAq5yg1Woa7N26tsn8q3aHi41fFtWDWSTQwlVq/
         gStyz1gYs3lsqBAaVNVh14uuI9kH3eSvNJ4CfsoqxDU97cUUtYZgeaz9sUN82AclL2OS
         FJVg==
X-Gm-Message-State: APjAAAWu2CKSTKVmxftRDvz+Jq6xw9MHqu0sBsCZYlYJHEno8gkzopgi
        LV7RJ22RoE3EmhgxE4j8WHKRY/3WYA/hoF1F3q2bLg==
X-Google-Smtp-Source: APXvYqzyEsKyqfs6ZO6WD2nc5+12Y9GeYZsNPMQ9Yol06XzyAN5/Aa0BMZywEoEU+Umr4RhueIpAsJ0Kb8ZRC/2KV1w=
X-Received: by 2002:aca:2112:: with SMTP id 18mr47816oiz.155.1580836976510;
 Tue, 04 Feb 2020 09:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20200204140353.177797-1-elver@google.com> <CANpmjNMF3LpOUZSKXigxVXaH8imA2O5OvVu4ibPEDhCjwAXk0w@mail.gmail.com>
 <20200204154015.GQ2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200204154015.GQ2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 4 Feb 2020 18:22:45 +0100
Message-ID: <CANpmjNOeHTMtTPFt1b3bzFanYrtswG-GUZgURaJzchgX7E5psA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kcsan: Add option to assume plain writes up to word
 size are atomic
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 at 16:40, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Feb 04, 2020 at 04:28:47PM +0100, Marco Elver wrote:
> > On Tue, 4 Feb 2020 at 15:04, Marco Elver <elver@google.com> wrote:
> > >
> > > This adds option KCSAN_ASSUME_PLAIN_WRITES_ATOMIC. If enabled, plain
> > > writes up to word size are also assumed to be atomic, and also not
> > > subject to other unsafe compiler optimizations resulting in data races.
> >
> > I just realized we should probably also check for alignedness. Would
> > this be fair to add as an additional constraint? It would be my
> > preference.
>
> Checking for alignment makes a lot of sense to me!  Otherwise, write
> tearing is expected behavior on some systems.

Sent v2: http://lkml.kernel.org/r/20200204172112.234455-1-elver@google.com

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> > Thanks,
> > -- Marco
> >
> > > This option has been enabled by default to reflect current kernel-wide
> > > preferences.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  kernel/kcsan/core.c | 20 +++++++++++++++-----
> > >  lib/Kconfig.kcsan   | 26 +++++++++++++++++++-------
> > >  2 files changed, 34 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > > index 64b30f7716a12..3bd1bf8d6bfeb 100644
> > > --- a/kernel/kcsan/core.c
> > > +++ b/kernel/kcsan/core.c
> > > @@ -169,10 +169,19 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
> > >         return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> > >  }
> > >
> > > -static __always_inline bool is_atomic(const volatile void *ptr)
> > > +static __always_inline bool
> > > +is_atomic(const volatile void *ptr, size_t size, int type)
> > >  {
> > > -       struct kcsan_ctx *ctx = get_ctx();
> > > +       struct kcsan_ctx *ctx;
> > > +
> > > +       if ((type & KCSAN_ACCESS_ATOMIC) != 0)
> > > +               return true;
> > >
> > > +       if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
> > > +           (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long))
> > > +               return true; /* Assume all writes up to word size are atomic. */
> > > +
> > > +       ctx = get_ctx();
> > >         if (unlikely(ctx->atomic_next > 0)) {
> > >                 /*
> > >                  * Because we do not have separate contexts for nested
> > > @@ -193,7 +202,8 @@ static __always_inline bool is_atomic(const volatile void *ptr)
> > >         return kcsan_is_atomic(ptr);
> > >  }
> > >
> > > -static __always_inline bool should_watch(const volatile void *ptr, int type)
> > > +static __always_inline bool
> > > +should_watch(const volatile void *ptr, size_t size, int type)
> > >  {
> > >         /*
> > >          * Never set up watchpoints when memory operations are atomic.
> > > @@ -202,7 +212,7 @@ static __always_inline bool should_watch(const volatile void *ptr, int type)
> > >          * should not count towards skipped instructions, and (2) to actually
> > >          * decrement kcsan_atomic_next for consecutive instruction stream.
> > >          */
> > > -       if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
> > > +       if (is_atomic(ptr, size, type))
> > >                 return false;
> > >
> > >         if (this_cpu_dec_return(kcsan_skip) >= 0)
> > > @@ -460,7 +470,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
> > >         if (unlikely(watchpoint != NULL))
> > >                 kcsan_found_watchpoint(ptr, size, type, watchpoint,
> > >                                        encoded_watchpoint);
> > > -       else if (unlikely(should_watch(ptr, type)))
> > > +       else if (unlikely(should_watch(ptr, size, type)))
> > >                 kcsan_setup_watchpoint(ptr, size, type);
> > >  }
> > >
> > > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > > index 3552990abcfe5..08972376f0454 100644
> > > --- a/lib/Kconfig.kcsan
> > > +++ b/lib/Kconfig.kcsan
> > > @@ -91,13 +91,13 @@ config KCSAN_REPORT_ONCE_IN_MS
> > >           limiting reporting to avoid flooding the console with reports.
> > >           Setting this to 0 disables rate limiting.
> > >
> > > -# Note that, while some of the below options could be turned into boot
> > > -# parameters, to optimize for the common use-case, we avoid this because: (a)
> > > -# it would impact performance (and we want to avoid static branch for all
> > > -# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
> > > -# without real benefit. The main purpose of the below options is for use in
> > > -# fuzzer configs to control reported data races, and they are not expected
> > > -# to be switched frequently by a user.
> > > +# The main purpose of the below options is to control reported data races (e.g.
> > > +# in fuzzer configs), and are not expected to be switched frequently by other
> > > +# users. We could turn some of them into boot parameters, but given they should
> > > +# not be switched normally, let's keep them here to simplify configuration.
> > > +#
> > > +# The defaults below are chosen to be very conservative, and may miss certain
> > > +# bugs.
> > >
> > >  config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> > >         bool "Report races of unknown origin"
> > > @@ -116,6 +116,18 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
> > >           the data value of the memory location was observed to remain
> > >           unchanged, do not report the data race.
> > >
> > > +config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
> > > +       bool "Assume that plain writes up to word size are atomic"
> > > +       default y
> > > +       help
> > > +         Assume that plain writes up to word size are atomic by default, and
> > > +         also not subject to other unsafe compiler optimizations resulting in
> > > +         data races. This will cause KCSAN to not report data races due to
> > > +         conflicts where the only plain accesses are writes up to word size:
> > > +         conflicts between marked reads and plain writes up to word size will
> > > +         not be reported as data races; notice that data races between two
> > > +         conflicting plain writes will also not be reported.
> > > +
> > >  config KCSAN_IGNORE_ATOMICS
> > >         bool "Do not instrument marked atomic accesses"
> > >         help
> > > --
> > > 2.25.0.341.g760bfbb309-goog
> > >
