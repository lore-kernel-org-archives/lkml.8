Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6611C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C3020870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRJdY9jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgEGQvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:51:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34460C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:51:00 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t199so5797008oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMWnRRDjjsl8pcwIzMkXZpSdECOOZg3cVfKKxGE9IxU=;
        b=dRJdY9jA+xNPFSRPPjeN/lm3++Ov86g8r/vn3O7ODiV3PQfGdKJ5FakS1sLEu+fQBT
         29yv5RduYMLG2LOH6TcwA96XBs+ctHUAl/KeTIW60QJD4J0Co6397LQHc861Ek5yBeP7
         Y75wMHIerqbMmwWmuXKjhFsCTn+QTBiEzzPew51QZIKyvjjWtuJFwwcm9HlvKv8Rqxu8
         gKEVKBGdE9/J6QuoZF1rsgInmlrf/YhYcV2Gpuo45HlgFwHIS7Y2WZuhPTKybLxYjGvL
         GciCFvU/SJmDby3zsUoeD/+RBR6ndKLKoAKQwHUv9fSqwVkzFmTcItKulo6eor1cy4EC
         oEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMWnRRDjjsl8pcwIzMkXZpSdECOOZg3cVfKKxGE9IxU=;
        b=OLlxEi3psc61ahsC459Gooy6lk4UxlMhZ+CqBu/SK//RzhV3qjTILlMeeNmT2KWX5U
         +QRhurpzZQo3Or6gZsvPx+0hVwNQQCYfCGMMt7WEuOz7QeGxfpXfXjnDqm5k19P4t8/m
         j97AqDRb6vaWYxE8gli6hFfiIozwTA5HZ87JbAa1tRT+aZG2EogmQyeGQe+HxfKann6c
         T8bhnKfKxbpD6ZtbwbL1uYXO8i0uHf2FGNuEbVNBjUTfZb1PKkyE+TwDorbkHdMptCGk
         iOyngdprQin2xUg91jPr5n/jK/hwlZgLxwOs9BhPOZkeVVf7yvCPuZeHiOXUfEf79U9D
         NnLA==
X-Gm-Message-State: AGi0PuZB9ZIn1Hw2yYzYlscYiRLlrFgbCbREwJKx8Kr+ToZbuOb2iMCs
        dkgX96dtUe9QvIPWrqFefjPutfyLpeRWOoIm7ReE5A==
X-Google-Smtp-Source: APiQypJImJ49afgLk0pP4NB8LDfNUhM5qhGqPYLHutBzFRxjQ6Ry0xTvAFLNn/pBw2LLCXTKqdRft+Ws1iZ8QR0rvxA=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr7227783oic.172.1588870259205;
 Thu, 07 May 2020 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPCZ2r9V7t50_yy+F_-roBWJdiQWgmvvcqTFxzdzOwKhg@mail.gmail.com>
 <20200507162617.2472578-1-arnd@arndb.de>
In-Reply-To: <20200507162617.2472578-1-arnd@arndb.de>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 May 2020 18:50:47 +0200
Message-ID: <CANpmjNObn6aXUe95e9UpuVwxHQ5ubMx_n3LLEgh=pe4rJd-Qyw@mail.gmail.com>
Subject: Re: [PATCH] [v2] ubsan, kcsan: don't combine sanitizer with kcov on clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 18:26, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
> with -fsanitize=bounds or with ubsan:
>
> clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
> clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]
>
> To avoid the warning, check whether clang can handle this correctly
> or disallow ubsan and kcsan when kcov is enabled.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=45831
> Link: https://lore.kernel.org/lkml/20200505142341.1096942-1-arnd@arndb.de
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: this implements Marco's suggestion to check what the compiler
> actually supports, and references the bug report I now opened.
>
> Let's wait for replies on that bug report before this gets applied,
> in case the feedback there changes the conclusion.

Waiting makes sense, if this is not very urgent.

Acked-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  lib/Kconfig.kcsan | 11 +++++++++++
>  lib/Kconfig.ubsan | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index ea28245c6c1d..a7276035ca0d 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -3,9 +3,20 @@
>  config HAVE_ARCH_KCSAN
>         bool
>
> +config KCSAN_KCOV_BROKEN
> +       def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
> +       depends on CC_IS_CLANG
> +       depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
> +       help
> +         Some versions of clang support either KCSAN and KCOV but not the
> +         combination of the two.
> +         See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
> +         in newer releases.
> +
>  menuconfig KCSAN
>         bool "KCSAN: dynamic data race detector"
>         depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
> +       depends on !KCSAN_KCOV_BROKEN
>         select STACKTRACE
>         help
>           The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 929211039bac..a5ba2fd51823 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -26,9 +26,20 @@ config UBSAN_TRAP
>           the system. For some system builders this is an acceptable
>           trade-off.
>
> +config UBSAN_KCOV_BROKEN
> +       def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
> +       depends on CC_IS_CLANG
> +       depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=bounds -fsanitize-coverage=trace-pc)
> +       help
> +         Some versions of clang support either UBSAN or KCOV but not the
> +         combination of the two.
> +         See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
> +         in newer releases.
> +
>  config UBSAN_BOUNDS
>         bool "Perform array index bounds checking"
>         default UBSAN
> +       depends on !UBSAN_KCOV_BROKEN
>         help
>           This option enables detection of directly indexed out of bounds
>           array accesses, where the array size is known at compile time.
> --
> 2.26.0
>
