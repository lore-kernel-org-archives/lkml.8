Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C085DC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859F620730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQ0OsNu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgBDP3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:29:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45889 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgBDP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:29:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so17431654otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNS0/F/vPTaGhHs2E+Os0bqOMJct5E1nmxxVhGRFeMM=;
        b=LQ0OsNu+WHVVnRyCFKsNBMaR+I2QWI4eYl6K3ntcYhh/QLTiS7/YlFqY+F29HU/xLY
         Sbrw5CxAx5ndLoHeGdCSRyKc2eVYs50fam6cx3NkqXDCPjTWM8d+sMV1QvqVeFO/tx7f
         HoNKkWoHf+DSlT7NqlLqTRgZzbbR1rfPFYU2pJoPRS5EI/s5YQ7fOSDsu3WR73xp8qmI
         AS8KrF+TiQxkRSJPvFYuLZPACz6Uz8pxJ7nHxNnWBBzSsB4xhNNfgjfMsHHjxLBGUymy
         tRD5NZvl/10qP89p4I5K+KDakQpjxcmn6e+cFGYBPfs207J1/MWFnNPgPHb/qlWc47cy
         hNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNS0/F/vPTaGhHs2E+Os0bqOMJct5E1nmxxVhGRFeMM=;
        b=KVsXYrmvtFZc5r2QDuRniIgUu56yYell16CE5Kzn6wo2al+VMdN1/+f3onT/YvvSeq
         AFl7L8mV5icoVF8IvFHnDI0ZrqOdwUe99u7KvCZMN8sMsqBD17eL1Hrl7aqA7rI0/fvn
         AbMzVKZ4DD8CSxR384MxIOkxEercQtG6/10c0pw0KGQzhpp/n/cTTOIzrwKzrPS3Mi7w
         3DtQcfpojmBFbwZku0kqUCvl4DZUZM3BGEjAuPlYSaMU0N8yQRQvBo/kKlwBRwWyEFBl
         llatUebvM/iZF12PnmBtHtX/kPmVC6znpmhU2xBugnfGTFXocic24+YaVN4cfmmpNFdx
         zFuA==
X-Gm-Message-State: APjAAAUgUXnSq+p1h6bJ5wcijjeRh/0nqfJADHQrVNMeH6D0evFUXNrD
        SaNj+oVUrj7kUM76IJ1/qDIYd3/uHqsdYp2uP4RS9g==
X-Google-Smtp-Source: APXvYqwsM5tlXqWXZRQDvt0ylqlzAJRWVbI8jBgM2F1mjWI+klciOIBcbNXYjpn/z+5Wzj2MAMDSMOOGJJ8WCcvPhc8=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr23290235otk.23.1580830138835;
 Tue, 04 Feb 2020 07:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20200204140353.177797-1-elver@google.com>
In-Reply-To: <20200204140353.177797-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 4 Feb 2020 16:28:47 +0100
Message-ID: <CANpmjNMF3LpOUZSKXigxVXaH8imA2O5OvVu4ibPEDhCjwAXk0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kcsan: Add option to assume plain writes up to word
 size are atomic
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

On Tue, 4 Feb 2020 at 15:04, Marco Elver <elver@google.com> wrote:
>
> This adds option KCSAN_ASSUME_PLAIN_WRITES_ATOMIC. If enabled, plain
> writes up to word size are also assumed to be atomic, and also not
> subject to other unsafe compiler optimizations resulting in data races.

I just realized we should probably also check for alignedness. Would
this be fair to add as an additional constraint? It would be my
preference.

Thanks,
-- Marco

> This option has been enabled by default to reflect current kernel-wide
> preferences.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/kcsan/core.c | 20 +++++++++++++++-----
>  lib/Kconfig.kcsan   | 26 +++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 64b30f7716a12..3bd1bf8d6bfeb 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -169,10 +169,19 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
>         return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
>  }
>
> -static __always_inline bool is_atomic(const volatile void *ptr)
> +static __always_inline bool
> +is_atomic(const volatile void *ptr, size_t size, int type)
>  {
> -       struct kcsan_ctx *ctx = get_ctx();
> +       struct kcsan_ctx *ctx;
> +
> +       if ((type & KCSAN_ACCESS_ATOMIC) != 0)
> +               return true;
>
> +       if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
> +           (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long))
> +               return true; /* Assume all writes up to word size are atomic. */
> +
> +       ctx = get_ctx();
>         if (unlikely(ctx->atomic_next > 0)) {
>                 /*
>                  * Because we do not have separate contexts for nested
> @@ -193,7 +202,8 @@ static __always_inline bool is_atomic(const volatile void *ptr)
>         return kcsan_is_atomic(ptr);
>  }
>
> -static __always_inline bool should_watch(const volatile void *ptr, int type)
> +static __always_inline bool
> +should_watch(const volatile void *ptr, size_t size, int type)
>  {
>         /*
>          * Never set up watchpoints when memory operations are atomic.
> @@ -202,7 +212,7 @@ static __always_inline bool should_watch(const volatile void *ptr, int type)
>          * should not count towards skipped instructions, and (2) to actually
>          * decrement kcsan_atomic_next for consecutive instruction stream.
>          */
> -       if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
> +       if (is_atomic(ptr, size, type))
>                 return false;
>
>         if (this_cpu_dec_return(kcsan_skip) >= 0)
> @@ -460,7 +470,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
>         if (unlikely(watchpoint != NULL))
>                 kcsan_found_watchpoint(ptr, size, type, watchpoint,
>                                        encoded_watchpoint);
> -       else if (unlikely(should_watch(ptr, type)))
> +       else if (unlikely(should_watch(ptr, size, type)))
>                 kcsan_setup_watchpoint(ptr, size, type);
>  }
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 3552990abcfe5..08972376f0454 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -91,13 +91,13 @@ config KCSAN_REPORT_ONCE_IN_MS
>           limiting reporting to avoid flooding the console with reports.
>           Setting this to 0 disables rate limiting.
>
> -# Note that, while some of the below options could be turned into boot
> -# parameters, to optimize for the common use-case, we avoid this because: (a)
> -# it would impact performance (and we want to avoid static branch for all
> -# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
> -# without real benefit. The main purpose of the below options is for use in
> -# fuzzer configs to control reported data races, and they are not expected
> -# to be switched frequently by a user.
> +# The main purpose of the below options is to control reported data races (e.g.
> +# in fuzzer configs), and are not expected to be switched frequently by other
> +# users. We could turn some of them into boot parameters, but given they should
> +# not be switched normally, let's keep them here to simplify configuration.
> +#
> +# The defaults below are chosen to be very conservative, and may miss certain
> +# bugs.
>
>  config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
>         bool "Report races of unknown origin"
> @@ -116,6 +116,18 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
>           the data value of the memory location was observed to remain
>           unchanged, do not report the data race.
>
> +config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
> +       bool "Assume that plain writes up to word size are atomic"
> +       default y
> +       help
> +         Assume that plain writes up to word size are atomic by default, and
> +         also not subject to other unsafe compiler optimizations resulting in
> +         data races. This will cause KCSAN to not report data races due to
> +         conflicts where the only plain accesses are writes up to word size:
> +         conflicts between marked reads and plain writes up to word size will
> +         not be reported as data races; notice that data races between two
> +         conflicting plain writes will also not be reported.
> +
>  config KCSAN_IGNORE_ATOMICS
>         bool "Do not instrument marked atomic accesses"
>         help
> --
> 2.25.0.341.g760bfbb309-goog
>
