Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B848C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713AC206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHJRR/6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFCNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:35:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0EC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:35:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t7so1791615pgt.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffoWRsiIdmktI0Aa3BFBPpp+Z+t9ruAh+fRHAhTsS0U=;
        b=dHJRR/6wW+Z9VxUy02A1GbkhTGTpdITLLiCNP7SrObYzLb2S4UcftYeN0g86M61f4V
         9x2840KTpC1zvmT+VG0/6g3qrYGrsW4xEjdcMgfuBwnQOvkqui4A+p5CdUzrp6j2qQUS
         4AsDihJgUNR/sjxWvBc50WS2cv9BWq58otSVwvur6PGLHP8gxVKHWdJo/ChR6ubvYrG/
         b/GqAp0Be36KQLIxdGiGeULgmTYMw2R35Ksyf/IqBkm5Hs2OKIS2JlGZ5wc2yIImStR7
         uFJ6AjRmyaZCpzBuw4UPMXCfsnsklPyREr5g6XGa9OS4i98f38rEPo6E8Sys9TVFcrsB
         4fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffoWRsiIdmktI0Aa3BFBPpp+Z+t9ruAh+fRHAhTsS0U=;
        b=Fnw7bAmOFWO+7941wL9xw+/LGO02R0diq/lIad6fZtuJOtliyBkjrCTlqE3Y/NWNbW
         pNdBMH8m8vNpu+NiOvEv3opKA2W8/EKC+2+G6XyUxT4x2Ol1jwDnSbmTC2kt80vS+dCs
         eZKF308J9jGvmglDraTCydGuyN72LVLsqNztG7mojFoXTDo/Yc34c58q+6fOkNm8bshR
         zYP/hfOV4GwMQhXQDEYCy2ZMkEbvqs054BjJWHolvJCETb69uBCqsYDvOoYNeIReN+FN
         AyUGJpYnntUzfoIWEQbQmv2ICv4/YIJ0MpWi7YPE6qQCluvtQHBeGAjUBh6HgR3TeThZ
         bvXg==
X-Gm-Message-State: AOAM533exck1ejXWFImylcppb81lndDoHbnMWUmUL/7M3ys1jZvRYtvT
        50ts6Hm654DTTY3TC3uez/cxzu4N5DhUjltzT1eDag==
X-Google-Smtp-Source: ABdhPJyvjC3bqxFUI8Qm2pczJ8KpqvTJM3sK/pWQRCIjW9KvGJsPIuXrTRnHzqqHUo1IkIqbzJ+y0NwjSti3x3JyUu8=
X-Received: by 2002:a17:90b:1244:: with SMTP id gx4mr2285007pjb.136.1591191316071;
 Wed, 03 Jun 2020 06:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com>
In-Reply-To: <20200602184409.22142-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 3 Jun 2020 15:35:05 +0200
Message-ID: <CAAeHK+yNmGB6mEQoogGhUh_F1fXFF_baA14G3=4NyYv=oz8Fdw@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 8:44 PM Marco Elver <elver@google.com> wrote:
>
> Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
> have a compiler that does not fail builds due to no_sanitize functions.
> This does not yet mean they work as intended, but for automated
> build-tests, this is the minimum requirement.
>
> For example, we require that __always_inline functions used from
> no_sanitize functions do not generate instrumentation. On GCC <= 7 this
> fails to build entirely, therefore we make the minimum version GCC 8.
>
> For KCSAN this is a non-functional change, however, we should add it in
> case this variable changes in future.
>
> Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by:  Andrey Konovalov <andreyknvl@google.com>

> ---
> Apply after:
> https://lkml.kernel.org/r/20200602173103.931412766@infradead.org
> ---
>  init/Kconfig      | 3 +++
>  lib/Kconfig.kasan | 1 +
>  lib/Kconfig.kcsan | 1 +
>  lib/Kconfig.ubsan | 1 +
>  4 files changed, 6 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 0f72eb4ffc87..3e8565bc8376 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -39,6 +39,9 @@ config TOOLS_SUPPORT_RELR
>  config CC_HAS_ASM_INLINE
>         def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
>
> +config CC_HAS_WORKING_NOSANITIZE
> +       def_bool !CC_IS_GCC || GCC_VERSION >= 80000
> +
>  config CONSTRUCTORS
>         bool
>         depends on !UML
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 81f5464ea9e1..15e6c4b26a40 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -20,6 +20,7 @@ config KASAN
>         depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
>                    (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
>         depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> +       depends on CC_HAS_WORKING_NOSANITIZE
>         help
>           Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
>           designed to find out-of-bounds accesses and use-after-free bugs.
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 5ee88e5119c2..2ab4a7f511c9 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -5,6 +5,7 @@ config HAVE_ARCH_KCSAN
>
>  config HAVE_KCSAN_COMPILER
>         def_bool CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)
> +       depends on CC_HAS_WORKING_NOSANITIZE
>         help
>           For the list of compilers that support KCSAN, please see
>           <file:Documentation/dev-tools/kcsan.rst>.
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index a5ba2fd51823..f725d126af7d 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -4,6 +4,7 @@ config ARCH_HAS_UBSAN_SANITIZE_ALL
>
>  menuconfig UBSAN
>         bool "Undefined behaviour sanity checker"
> +       depends on CC_HAS_WORKING_NOSANITIZE
>         help
>           This option enables the Undefined Behaviour sanity checker.
>           Compile-time instrumentation is used to detect various undefined
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
