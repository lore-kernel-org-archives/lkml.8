Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2935920734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY81CrGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFBSxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:53:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B7C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:53:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so1873281pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcbY1VrV57GqPoFo7ptDB2znFdFUv0Mj9KOWNzaUW2E=;
        b=iY81CrGfmojXqpZOwyWc5FJulkMA+MB1PD+DNvpbGMwLjk7EYSts9ax8jyweSuxnOg
         L1+M2+C3ihJ82bHBfyap8X7f3NG70bmLnsr8DMinGcXbaH0O5E9eF/m3NsmINlBfIdTX
         AGWgLaj3tjCGuDPCnVzA0fSIvFfH/n/9TFFtMaJAPlTkWQJySbKn6dJ+ejCxuClfTIhf
         04dpsphQqr8AXP2CIoyfADPkQvuHgQBIvZDx6WWLohI8DG5Q8xx+oh18PBRXNHspMMhB
         5E49XHTWn7hBb/IFXbQzOASEnpD2TMwhBzXf7Rkdp1KgmtTfH6Haq0y+J3dO0L0Ngj5U
         tzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcbY1VrV57GqPoFo7ptDB2znFdFUv0Mj9KOWNzaUW2E=;
        b=XuphZP3/Tmy7YCiCF3npuM7Tbu00KySM51Vwgycyhes9kYzvlCSpMbOyTp4IVInRy9
         k0DR/MKP6l6xfEmbc69csboxybBf7Hx0lfQ7JsQ2R0Vfnve8h/vkkkfjc7B/a15Ws4Hq
         JoKd3dRHEsiTopXvDDOcW8UA82LHq/4s2YSrK30L8QtJxf8y4rBG3dHP8gFZzwiIY46E
         OAByNIoIHJEOkXTRKhhEI2I7mY7avUNd5NSHxp7rKUvdljpsafISQazQYAUzTZ58AsLU
         VsJvR7hrIWQekwQObMfPMxAw6KZFMHm7bZGLEJc4oM2bR0hRstMHMgVmPDFUXGm+34qu
         ko/w==
X-Gm-Message-State: AOAM533XOSSJtELIgSGnROA6TFTKKQDuUBAPoHT/oHqAFR6VG/zZL7Ii
        8aYo4PaqJaE1V38GVbggrLbtBFkHqyQp3kPww9EGqw==
X-Google-Smtp-Source: ABdhPJycuMM6aHGbe0O2CrOSJTyrPXJsQw8afAcdxwgAWCtimO+5JAU8UDgC7cj//wqbciDlzyiy8kZXnyMtEmSbJlo=
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr627704pjd.136.1591124010835;
 Tue, 02 Jun 2020 11:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com>
In-Reply-To: <20200602184409.22142-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Jun 2020 20:53:19 +0200
Message-ID: <CAAeHK+wh-T4aGDeQM5Z9tTgZM+Y4xkOavjT7QuR+FHQkY-CHuw@mail.gmail.com>
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

Could you also update KASAN docs to mention this requirement? As a
separate patch or in v2, up to you.

>
> For KCSAN this is a non-functional change, however, we should add it in
> case this variable changes in future.
>
> Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
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
