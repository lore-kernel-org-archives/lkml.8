Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7340A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMny2DF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgE2ShL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2ShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:37:09 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FCBC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:37:09 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w4so3497686oia.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgm4s52vNNhERtvdEgwZpi9/hHsa34APX0EThyas0Hg=;
        b=ZMny2DF2NBmtRcYhSX7CHk0Bywmqfi5HP0rftPQ/8cwBsP0rFw+v7v3VkO9QDeOfj5
         42roL7TvZp/jwwCX4J223Zty0smJJFgXrlm8o1QuqhGa8LxDqSZ2l8a3NGQZZYaKihUG
         Ldtip+qJpWonx/883hfGjm9fo+e5EjIuVKEWUvB88C+goEDub4gjId/y0AvJ/uIspKxl
         evnyp4MEPdyXjAGhB/NudeAWfu4Z0sKUYWPeDe1VO1OJQ1EwbXyJLOVvm6JR+/7md7kd
         gVqqsvPAd+NFIFKIQePCK6y3/nTl9lELpooyCqoOSCKOCTsNDutLfIwqClLsQ8+tTZR0
         d8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgm4s52vNNhERtvdEgwZpi9/hHsa34APX0EThyas0Hg=;
        b=ZPcJN5DFefbX0wkAokPPcD7e8xFsRrv/RT4riH74hxt6ud/qX2QLFGahSmTkodNLOa
         vY55EOT26lSCANqpRDvdk/JbAUimfQb6ZwDvRmD4YcJCNjaZVKraeTZkHp5B7rLk7o0m
         qM7D+j2ZJu8sZ1DyPFneACeIsnHQYgFbD0EghKlPcnXKgGDEGVWWr4ndXcrbpdi31hdy
         56j6WbxmAeqy9Zw4TjPwX2cudK710E7BvdjdJA61nmZxxtKbjEKkJvQQoXtiLT+HOtX5
         FU+sWi4Xji8tvYhy0480TrWtjHuXFt25SjyX9+cPlbvkwpCI37JaT3h0nXqA3wBAI33B
         QxeQ==
X-Gm-Message-State: AOAM530g0yrFiD8PHq1WfMe3zdATnd1b7kEX3VS4A8nnkqe5TAQuiYpH
        Qn5PiBpWygBnNuPly5HKIfF25v0ybStpmop/ouBU7w==
X-Google-Smtp-Source: ABdhPJwSPmcBjhdoyTnfvSzZj1WZkdcgTPSIEsVfZagyp/eQHSg278s5ZbhWp/APU3cSGebjvLPWOcA3zOjfaAo+Ycs=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr6951426oin.172.1590777428688;
 Fri, 29 May 2020 11:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-6-elver@google.com>
 <20200529170755.GN706495@hirez.programming.kicks-ass.net>
In-Reply-To: <20200529170755.GN706495@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Fri, 29 May 2020 20:36:56 +0200
Message-ID: <CANpmjNPaL=HRvaJOC37_Cf4S4kskZezmgRiDSGn460rO2dM4+g@mail.gmail.com>
Subject: Re: [PATCH -tip v3 05/11] kcsan: Remove 'noinline' from __no_kcsan_or_inline
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 19:08, Peter Zijlstra <peterz@infradead.org> wrote:
[...]
>
> Doesn't this mean we can do the below?

If nobody complains about the lack of __no_kcsan_or_inline, let's do
it. See comments below.

> ---
>  Documentation/dev-tools/kcsan.rst |  6 ------
>  arch/x86/include/asm/bitops.h     |  6 +-----
>  include/linux/compiler_types.h    | 14 ++++----------
>  kernel/kcsan/kcsan-test.c         |  4 ++--
>  4 files changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index ce4bbd918648..b38379f06194 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -114,12 +114,6 @@ functions, compilation units, or entire subsystems.  For static blacklisting,
>    To dynamically limit for which functions to generate reports, see the
>    `DebugFS interface`_ blacklist/whitelist feature.
>
> -  For ``__always_inline`` functions, replace ``__always_inline`` with
> -  ``__no_kcsan_or_inline`` (which implies ``__always_inline``)::
> -
> -    static __no_kcsan_or_inline void foo(void) {
> -        ...
> -
>  * To disable data race detection for a particular compilation unit, add to the
>    ``Makefile``::

I suppose, if we say that __no_kcsan_or_inline should just disappear
because '__no_kcsan inline' is now good enough, we can delete it.

I think functions that absolutely must be __always_inline would break
with __no_kcsan_or_inline under KCSAN anyway. So, let's simplify.

> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 35460fef39b8..0367efdc5b7a 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -201,12 +201,8 @@ arch_test_and_change_bit(long nr, volatile unsigned long *addr)
>         return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
>  }
>
> -static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> +static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
>  {
> -       /*
> -        * Because this is a plain access, we need to disable KCSAN here to
> -        * avoid double instrumentation via instrumented bitops.
> -        */

Yes, we should have reverted this eventually.

>         return ((1UL << (nr & (BITS_PER_LONG-1))) &
>                 (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
>  }
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 4e4982d6f3b0..6a2c0f857ac3 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -118,10 +118,6 @@ struct ftrace_likely_data {
>  #define notrace                        __attribute__((__no_instrument_function__))
>  #endif
>
> -/* Section for code which can't be instrumented at all */
> -#define noinstr                                                                \
> -       noinline notrace __attribute((__section__(".noinstr.text")))
> -
>  /*
>   * it doesn't make sense on ARM (currently the only user of __naked)
>   * to trace naked functions because then mcount is called without
> @@ -192,17 +188,15 @@ struct ftrace_likely_data {
>  #endif
>
>  #define __no_kcsan __no_sanitize_thread
> -#ifdef __SANITIZE_THREAD__
> -# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
> -# define __no_sanitize_or_inline __no_kcsan_or_inline

I think we just want to keep __no_sanitize_or_inline, for
READ_ONCE_NOCHECK. Having READ_ONCE_NOCHECK do KCSAN-checking seems
wrong, and I don't know what might break.

> -#else
> -# define __no_kcsan_or_inline __always_inline
> -#endif
>
>  #ifndef __no_sanitize_or_inline
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>
> +/* Section for code which can't be instrumented at all */
> +#define noinstr                                                                \
> +       noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
> +

Will this eventually need __no_sanitize_address?

>  #endif /* __KERNEL__ */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
> index a8c11506dd2a..374263ddffe2 100644
> --- a/kernel/kcsan/kcsan-test.c
> +++ b/kernel/kcsan/kcsan-test.c
> @@ -43,7 +43,7 @@ static struct {
>  };
>
>  /* Setup test checking loop. */
> -static __no_kcsan_or_inline void
> +static __no_kcsan inline void
>  begin_test_checks(void (*func1)(void), void (*func2)(void))
>  {
>         kcsan_disable_current();
> @@ -60,7 +60,7 @@ begin_test_checks(void (*func1)(void), void (*func2)(void))
>  }
>
>  /* End test checking loop. */
> -static __no_kcsan_or_inline bool
> +static __no_kcsan inline bool
>  end_test_checks(bool stop)
>  {
>         if (!stop && time_before(jiffies, end_time)) {

Acked -- if you send a patch, do split the test-related change, so
that Paul can apply it to the test which is currently only in -rcu.

Thanks,
-- Marco
