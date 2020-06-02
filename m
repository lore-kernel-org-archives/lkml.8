Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC7C20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZTwU0Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFBS51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgFBS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:57:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A92C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:57:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so5509812pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBeXDiXpaNYSmdLg+CEOi/2SkM043Ho1hEbW/kRa2lU=;
        b=IZTwU0Bw0+6fSqRCv9Rb1hqZukeW0A2CInQU+QYtnhyF1FAVac4O0yQM/pIpj/D/QY
         Xb0giNjIoUl84sIu2MIZGSYm9j/hXtkTet9KUmat8ZzBCX9UWJCBccVSEQ5qsYyTcrEb
         VZIrDp0CpLW/RfWYmgTHbQLaUn4Nm2ItOpsejrGP1ApXi1a03KODEgCxoD4PwIPtU2Rt
         oSYdWzl5vLYs8TqE/SvPHJBZuNHfJv9KtMrToXzBs1HbGBH1bWSdEpieEeWAYl+dkWdD
         1izyx4zjkDbMKf0J/+mNVTL9AgnrrvwGKVl4dx2pmGF2VK4RGOr02U9jCcUhwaNzV/oV
         T+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBeXDiXpaNYSmdLg+CEOi/2SkM043Ho1hEbW/kRa2lU=;
        b=Y4cHpd2USg78+6joE3QGfr9z7M6eAflssLJBlfwLvfQcnjg27VDUiRCy5FQ3IcWfV4
         kh3XIhni0Coz125LW7/zM4S/Y+o5YsJ3hKHf5T///En9INFz0MrZb812xBGhStPYp5Et
         o17atP6hCQwKM9LcY1ToYZry3ooRw90g6K/tVIuhfrPydGSaiepjawxIsIiqJ+kN1Ze7
         mzmRn1dFJOZ+7EHu1JegTuiy7m21qOzTdS+uHF7KKTbqQFjUhjFFXslLu73CEwvYLCH1
         rNR8V9f0ny98XmR/+jE4si8jzUXrsfECAvyLv2vTMsULCWtdySeNrqLE8PRccI3H2ZwA
         TvXw==
X-Gm-Message-State: AOAM533HhoC3y6eFp2yk2+fY3GZ6QJ96bxG+uLpqoBi0urjIkWx2ZtQt
        /7oTYlxVFVs6Vow6jtKmnH9eM02T7A1tW+Jx2ISNHg==
X-Google-Smtp-Source: ABdhPJwGXylQl9yW2rw0tsduvX3osVxH6X59NpC/sYYIFeyfjwWrX0X/KWdU0Kn06TTa7u+MdCvsiQMU181S9JerHio=
X-Received: by 2002:a63:5644:: with SMTP id g4mr24385954pgm.381.1591124246486;
 Tue, 02 Jun 2020 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com>
In-Reply-To: <20200602184409.22142-1-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jun 2020 11:57:15 -0700
Message-ID: <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 11:44 AM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
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

Is this a problem only for x86?  If so, that's quite a jump in minimal
compiler versions for a feature that I don't think is currently
problematic for other architectures?  (Based on
https://lore.kernel.org/lkml/20200529171104.GD706518@hirez.programming.kicks-ass.net/
)

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

-- 
Thanks,
~Nick Desaulniers
