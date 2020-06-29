Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD407C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBA6206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/q+PfD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbgF2TeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733217AbgF2Tcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B7BC02A570
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:37:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so8322606pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YTtTdEX8FTCzpnfrCubKRqJx+y/VqQUc/flbZtjjCI=;
        b=e/q+PfD5kE1/yVtUCvQwghyRh/D/e9PW9NdzULRnOh/6jWh+tujy7lrmf8mr6phUqc
         LZOH/WSbi2F3ingzlUgYYQbq81L9ZcHSDuN6KTOdUiHOPKwTUyHfEB2jaTKURhQjp+hJ
         XEquntYXXEjYTUErMrU7XGhRAUSx+TuHz/IixciEJCjX0EekzH49oo2n4vjDUJKjBcsD
         qKfUvWFn1iIA99Uh2r6cic15REOBKoLuEdjUH3XlqMLoJ2OFYG/Dk+r8bRvE/BucnMwf
         6s//Q09NcvHtXI6XHTeHCRUGpTIm7ZzsBHN9d8YmIx4Tdp5tcu6/vocQJfNehaFjTtKG
         eeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YTtTdEX8FTCzpnfrCubKRqJx+y/VqQUc/flbZtjjCI=;
        b=tjHNKFe3vRRhcJtTuDP4U1fujYg/EF8X8xDRDMnplM1VKH+xJpnDjKWqs8Ugp7YVGg
         c4Cg7TG06b/EnHRNmTVyhRny/ePbU6LwK7ay0o209VgCvg5d/iUWNVw9wThi6lHsN17s
         p5gCLu9TS7X9uNNSQzyKDGwi6wPAkwHXwXuPtigRdp6QILIwfKazMpVoPMCIJ11PtVmo
         p6Cl+Akgwqsq7SRM8YQ0SeJH5WvU99mG2/Su/UhcCfF1I5vfg8h2djJHG+XykUXLYjna
         bmE4cq26ujdbpk0lX9mdQtMP1kotuwM3QX1Ktf8LmEwkN7b6SB0IJNTTQE2PBPNe6Nl5
         cdEA==
X-Gm-Message-State: AOAM532O2bVg2VTJ5ehdXmju0rGkXQJD0pFLhaJGwVa0SOa2tqF3J9Hx
        qv1sV406Fp6ECepfomNBWkXhar1KnomnuH9hd+sdyA==
X-Google-Smtp-Source: ABdhPJycqBRPrNS3fS1vuT7eHk+0vIheYFriuEKiCjpMIU+1btpgbGFFY2PzC0Rq8+OEr2b87r/3K1zIuGHkpOLuFDg=
X-Received: by 2002:a65:64d8:: with SMTP id t24mr10733075pgv.286.1593437826864;
 Mon, 29 Jun 2020 06:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200629104157.3242503-1-elver@google.com> <20200629104157.3242503-2-elver@google.com>
In-Reply-To: <20200629104157.3242503-2-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 29 Jun 2020 15:36:55 +0200
Message-ID: <CAAeHK+y=1oocjAMfYd5m2_Zb9Y8M5r0X3K6YYyKvjs+zSAC8tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: Update required compiler versions in documentation
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Axtens <dja@axtens.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:42 PM Marco Elver <elver@google.com> wrote:
>
> Updates the recently changed compiler requirements for KASAN. In
> particular, we require GCC >= 8.3.0, and add a note that Clang 11
> supports OOB detection of globals.
>
> Fixes: 7b861a53e46b ("kasan: Bump required compiler version")
> Fixes: acf7b0bf7dcf ("kasan: Fix required compiler version")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  Documentation/dev-tools/kasan.rst |  7 ++-----
>  lib/Kconfig.kasan                 | 24 +++++++++++++++---------
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..15a2a53e77b0 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -13,11 +13,8 @@ KASAN uses compile-time instrumentation to insert validity checks before every
>  memory access, and therefore requires a compiler version that supports that.
>
>  Generic KASAN is supported in both GCC and Clang. With GCC it requires version
> -4.9.2 or later for basic support and version 5.0 or later for detection of
> -out-of-bounds accesses for stack and global variables and for inline
> -instrumentation mode (see the Usage section). With Clang it requires version
> -7.0.0 or later and it doesn't support detection of out-of-bounds accesses for
> -global variables yet.
> +8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
> +out-of-bounds accesses for global variables is only supported since Clang 11.
>
>  Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 89053defc0d9..047b53dbfd58 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -40,6 +40,7 @@ choice
>           software tag-based KASAN (a version based on software memory
>           tagging, arm64 only, similar to userspace HWASan, enabled with
>           CONFIG_KASAN_SW_TAGS).
> +
>           Both generic and tag-based KASAN are strictly debugging features.
>
>  config KASAN_GENERIC
> @@ -51,16 +52,18 @@ config KASAN_GENERIC
>         select STACKDEPOT
>         help
>           Enables generic KASAN mode.
> -         Supported in both GCC and Clang. With GCC it requires version 4.9.2
> -         or later for basic support and version 5.0 or later for detection of
> -         out-of-bounds accesses for stack and global variables and for inline
> -         instrumentation mode (CONFIG_KASAN_INLINE). With Clang it requires
> -         version 3.7.0 or later and it doesn't support detection of
> -         out-of-bounds accesses for global variables yet.
> +
> +         This mode is supported in both GCC and Clang. With GCC it requires
> +         version 8.3.0 or later. With Clang it requires version 7.0.0 or
> +         later, but detection of out-of-bounds accesses for global variables
> +         is supported only since Clang 11.
> +
>           This mode consumes about 1/8th of available memory at kernel start
>           and introduces an overhead of ~x1.5 for the rest of the allocations.
>           The performance slowdown is ~x3.
> +
>           For better error detection enable CONFIG_STACKTRACE.
> +
>           Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
>           (the resulting kernel does not boot).
>
> @@ -73,15 +76,19 @@ config KASAN_SW_TAGS
>         select STACKDEPOT
>         help
>           Enables software tag-based KASAN mode.
> +
>           This mode requires Top Byte Ignore support by the CPU and therefore
> -         is only supported for arm64.
> -         This mode requires Clang version 7.0.0 or later.
> +         is only supported for arm64. This mode requires Clang version 7.0.0
> +         or later.
> +
>           This mode consumes about 1/16th of available memory at kernel start
>           and introduces an overhead of ~20% for the rest of the allocations.
>           This mode may potentially introduce problems relating to pointer
>           casting and comparison, as it embeds tags into the top byte of each
>           pointer.
> +
>           For better error detection enable CONFIG_STACKTRACE.
> +
>           Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
>           (the resulting kernel does not boot).
>
> @@ -107,7 +114,6 @@ config KASAN_INLINE
>           memory accesses. This is faster than outline (in some workloads
>           it gives about x2 boost over outline instrumentation), but
>           make kernel's .text size much bigger.
> -         For CONFIG_KASAN_GENERIC this requires GCC 5.0 or later.
>
>  endchoice
>
> --
> 2.27.0.212.ge8ba1cc988-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
