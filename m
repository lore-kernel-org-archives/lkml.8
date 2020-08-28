Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC58420872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwSk+QOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgH1LD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgH1LBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:01:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A3C061234
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:54:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t9so468771pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhcvo1n+CsYdI8OH67mOVUpzZUMHRybLogH+vvrmtQs=;
        b=FwSk+QOEwpmwMFOoywfLT/+2bJceyMtZXet2C1AMWtwW3s6qZCMu0HjZPeY0DZ1yLk
         Tg96kygIN8rSOY+i7AiPT+J0042frtmo1SqBqHXKQAwzGOBip7+WoaZymZtzlWiEU55X
         qodqG9yf4CZsdtUGTG5Sd9fJJtT5A/Pgv/yrGGsZHI7IH676imoYcmoINtfsz6Oocr4o
         bC4fsuACX6jcuM4oNu0Cd5JAV5lSmby7vAx5pT1YTcGXvvrF0aobHyEJGMfJdZsecmvf
         lUpLfF1skl6oElBhFVfCNo62Ou82oQfUOX7adtdyJPaSEzIsaOV6OQX+PKUh8pTLTBcX
         d66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhcvo1n+CsYdI8OH67mOVUpzZUMHRybLogH+vvrmtQs=;
        b=WmG4MzAWpDLYl3dydE7AYab33FDmfhfAk3tKC9nOFcYUp9eA/sTHlDpUi+9v2VMiC/
         /MOZ6U0cE+sI0XI6V27wh8ph3dj7n3ICUEjiUVlsA/uYmwMkVqnhRGkNPiELMVrm3F33
         cyiV2OlDLidPRQomSNKDf1VyFef4O1N2bGMqFgXz6NAOqXnrB4gX6O361HiDgqoDL69s
         /bVqntXvJFtd3jdklBNXMObT2dfiWIWyljUrS5x2nWwpajgztwVScUYIjwOHDZHOAd5+
         NhL0NK+ZDYSjuPhIcEoYsQOCMaOK++2pJYse0m7pJdlB/TQGA/GE7UTNWHuk9iNOTjFH
         FFtw==
X-Gm-Message-State: AOAM5302ndgcUonvmUq2hX3M0TwwVsxd9aeL2cTKD7eYuQQyUpjDAYDu
        X2ZKNc2Lo/c/jqbgnPbwOUEIr6D19zP3ShGqLGBKgQ==
X-Google-Smtp-Source: ABdhPJw8pypePukEK0vS4XNEe8uxvJs9NntGAggpPmMOwU0fcfpoDp4x7PlyIPIJw3cN6pb7j3rX+HijCx9y79yN0V8=
X-Received: by 2002:aa7:8c0f:: with SMTP id c15mr784835pfd.135.1598612066279;
 Fri, 28 Aug 2020 03:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com>
 <20200826214228.GB1005132@ubuntu-n2-xlarge-x86> <20200827190217.GA3610840@elver.google.com>
In-Reply-To: <20200827190217.GA3610840@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 28 Aug 2020 12:54:15 +0200
Message-ID: <CAAeHK+zyjKWrSU-udVuqLN1i2c0bxNTMVirGjaRfXN=opn6spw@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Marco Elver <elver@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 9:02 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, Aug 26, 2020 at 02:42PM -0700, Nathan Chancellor wrote:
> > On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> > > During Plumbers 2020, we voted to just support the latest release of
> > > Clang for now.  Add a compile time check for this.
> > >
> > > Older clang's may work, but we will likely drop workarounds for older
> > > versions.
> >
> > I think this part of the commit message is a little wishy-washy. If we
> > are breaking the build for clang < 10.0.1, we are not saying "may work",
> > we are saying "won't work". Because of this, we should take the
> > opportunity to clean up behind us and revert/remove parts of:
> >
> > 87e0d4f0f37f ("kbuild: disable clang's default use of -fmerge-all-constants")
> > b0fe66cf0950 ("ARM: 8905/1: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer")
> > b9249cba25a5 ("arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support")
> > 3acf4be23528 ("arm64: vdso: Fix compilation with clang older than 8")
> >
> > This could be a series or a part of this commit, I do not have a
> > strong preference. If we are not going to clean up behind us, this
> > should be a warning and not an error.
>
> There are also some other documentation that would go stale. We probably
> have to change KASAN docs to look something like the below.
>
> I wish we could also remove the "but detection of out-of-bounds accesses
> for global variables is only supported since Clang 11", but Clang 10 is
> a vast improvement so I'm not complaining. :-)
>
> Acked-by: Marco Elver <elver@google.com>
>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> From 13d03b55c69dec813d94c1481dcb294971f164ef Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Thu, 27 Aug 2020 20:56:34 +0200
> Subject: [PATCH] kasan: Remove mentions of unsupported Clang versions
>
> Since the kernel now requires at least Clang 10.0.1, remove any mention
> of old Clang versions and simplify the documentation.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 4 ++--
>  lib/Kconfig.kasan                 | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 38fd5681fade..4abc84b1798c 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -13,10 +13,10 @@ KASAN uses compile-time instrumentation to insert validity checks before every
>  memory access, and therefore requires a compiler version that supports that.
>
>  Generic KASAN is supported in both GCC and Clang. With GCC it requires version
> -8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
> +8.3.0 or later. Any supported Clang version is compatible, but detection of
>  out-of-bounds accesses for global variables is only supported since Clang 11.
>
> -Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
> +Tag-based KASAN is only supported in Clang.
>
>  Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
>  riscv architectures, and tag-based KASAN is supported only for arm64.
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 047b53dbfd58..033a5bc67ac4 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -54,9 +54,9 @@ config KASAN_GENERIC
>           Enables generic KASAN mode.
>
>           This mode is supported in both GCC and Clang. With GCC it requires
> -         version 8.3.0 or later. With Clang it requires version 7.0.0 or
> -         later, but detection of out-of-bounds accesses for global variables
> -         is supported only since Clang 11.
> +         version 8.3.0 or later. Any supported Clang version is compatible,
> +         but detection of out-of-bounds accesses for global variables is
> +         supported only since Clang 11.
>
>           This mode consumes about 1/8th of available memory at kernel start
>           and introduces an overhead of ~x1.5 for the rest of the allocations.
> @@ -78,8 +78,7 @@ config KASAN_SW_TAGS
>           Enables software tag-based KASAN mode.
>
>           This mode requires Top Byte Ignore support by the CPU and therefore
> -         is only supported for arm64. This mode requires Clang version 7.0.0
> -         or later.
> +         is only supported for arm64. This mode requires Clang.
>
>           This mode consumes about 1/16th of available memory at kernel start
>           and introduces an overhead of ~20% for the rest of the allocations.
> --
> 2.28.0.297.g1956fa8f8d-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
