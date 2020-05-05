Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A88C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB58B2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLnOYtAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEEOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729123AbgEEOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:36:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:36:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so1829710otu.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKuEOwL1JP6YyFDs25REhPwIl6Gu+3wkdYT2D/cl688=;
        b=TLnOYtAOG4Y7uu0NOTg0Q0pk+2CMWffSGs65Dp9rkQw2diewM1KGNgrkU3L8+FdRcD
         z1dnKk7rXueHZjBVWXeO/uZMmAM82AQALL3ml4tIaSZPrWIGvq6KAnzjUYoyPym4TlhF
         bXVPRCsETApQGphBWb/Xct6/Yc5XsEwCFtQVg2v42mkvTuTvuKrJBRQ6mRNL+xalnvzo
         0WiPFo+shfNnq90R+ioFCpnIWvFalbkCckVsseahqZcnyjBNVGodWJdWmFYiPnzd6xBr
         RYBGpDPYywRtCgGsB6NtyChOh6XkCx2zRV6fS/s3QXl1EdREQdoWcV6vb0myOFrRwqnu
         WUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKuEOwL1JP6YyFDs25REhPwIl6Gu+3wkdYT2D/cl688=;
        b=YbBs16v1II74Gc4fVMrT2g4dsaTJ7j54EK/DbTVOn0SGFdcv+eAzdCiYzVNcqZfJok
         nMWM2h07zf6IR+sYk3vRsJh78/5u7iQx7MIUGchLGzfUwNQyFGqR9n96c/wD89AbxG65
         2ya2hFWc63LEnhUuuOKiYA1Z5Ibvy7MflNAeouUCsgHwspZDoTMoOn05FLUMz3rWkvxQ
         OFpJ3eQxemhzJFVv2jx1Jwmyk1jYX0IH2q0FtLIqCuh27K7lB3IPrFtG1KNJeNUDTxyp
         E+NC8yu8KbIkWv4gMb+rVfcZP5mpRC52HD6tmEKVVZRbKcF1jsLmipJhgGn9p7tUytAp
         7oyw==
X-Gm-Message-State: AGi0PuZMjKdolWOtRZ8hPcAkHt3VUzYAnuSgQI8Szvilyg/SrZJWHpj8
        e1Es/kkuy47AVh0kwArJOSe7Fl+QCi4kv8wq9WzYQA==
X-Google-Smtp-Source: APiQypKkgvcH6ljvRGEvMRI8ua+05T+uiDPWvPBVOae+OAGATDk+JL/zrgldD8HBeEqQ2xTwEVNKWasR42TORfRvS1A=
X-Received: by 2002:a9d:7589:: with SMTP id s9mr2280188otk.251.1588689413307;
 Tue, 05 May 2020 07:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142341.1096942-1-arnd@arndb.de>
In-Reply-To: <20200505142341.1096942-1-arnd@arndb.de>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 May 2020 16:36:40 +0200
Message-ID: <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
Subject: Re: [PATCH] ubsan, kcsan: don't combine sanitizer with kcov
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 16:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
> with -fsanitize=bounds or with ubsan:
>
> clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
> clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]
>
> To avoid that case, add a Kconfig dependency. The dependency could
> go either way, disabling CONFIG_KCOV or CONFIG_UBSAN_BOUNDS when the
> other is set. I picked the second option here as this seems to have
> a smaller impact on the resulting kernel.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Kconfig.kcsan | 2 +-
>  lib/Kconfig.ubsan | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index ea28245c6c1d..8f856c8828d5 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN
>
>  menuconfig KCSAN
>         bool "KCSAN: dynamic data race detector"
> -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
> +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV

This also disables KCOV with GCC. Why does this not work with KCSAN?

This is a huge problem for us, since syzbot requires KCOV. In fact
I've always been building KCSAN kernels with CONFIG_KCOV=y (with GCC
or Clang) and cannot reproduce the problem.

>         select STACKTRACE
>         help
>           The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 929211039bac..f98ef029553e 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -29,6 +29,7 @@ config UBSAN_TRAP
>  config UBSAN_BOUNDS
>         bool "Perform array index bounds checking"
>         default UBSAN
> +       depends on !(CC_IS_CLANG && KCOV)

Ditto, we really need KCOV for all sanitizers. I also just tried to
reproduce the problem but can't.

Which version of clang is causing this? I'm currently using Clang 9.
My guess is that we should not fix this by disallowing KCOV, but
rather make Clang work with these configs.

Dmitry, can you comment?

Thanks,
-- Marco

>         help
>           This option enables detection of directly indexed out of bounds
>           array accesses, where the array size is known at compile time.
> --
> 2.26.0
>
