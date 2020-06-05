Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77009C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D31C2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xlk62jXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFEQuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFEQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:50:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08035C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:50:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so3870596plv.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndEcXCs8HGuPHBOdpnF2uLFbc3ITmk/itvLe9IIcUiU=;
        b=Xlk62jXKawdC+etFgmEFosi/YT8NT6D9l2F73XSAZNGxkX2UY9WcpdjfyDofKtxBQf
         jTUPkPxzIcaRaoCR/D8Zny8DRqfbh3kN7xcy02PoPBTh+0q7fmDoJuEPmtuVoOZAB/9L
         SGT3S/HklpUYKV5N155golYzamAdRU2nD8gT0eCtE+I/5pfXVZ4pDnDS04QOd2R3sUqr
         lGKPBwMlmSiJEQIUcI8ud7mbvG7vcpDu4k119MEl3k9qfS533ms9FZF9x5O0F54gzMcc
         UyDVnAk9Mp+Bly4ytTs3qOZgNITrwYnqlV2BVCu1tlfH96IEAztSBvVZTXN5IlF4QqyC
         U+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndEcXCs8HGuPHBOdpnF2uLFbc3ITmk/itvLe9IIcUiU=;
        b=hujlE36HqxiSJP5e/JxiHW3Yf29nveJn07oRmjl7hpnc+VTKcEuBrDGGWuCvkGK5iY
         Y2QpSi94vcAe9pk13Dtl+KM/9g97H38gnlbnEyLsbZFt2B+oKXncxf7J7a4HZ5c1v2jh
         vJE2FvWAf22FySItYcalG9Oot4a/LL669U4NCbOnUVlz6XnGH8qh1wiYk6sOTk7/xxgG
         3XIVnYVUnaeRszJZmUFl8mAisp1YfbBNC3/2IUoGJvpsIsraZr1Mjnj7ibpI2rjuCDIP
         4aeKpshi33+VIL0O8NrvnjFHr1JnFN4NnAO6D4xpfIYEaKkxk+VkyK/JTVthC+XvX/+1
         AqxQ==
X-Gm-Message-State: AOAM533jOHU/dTNwdN/ygfIxamYfEbUk/v310cXLCpVs2KANRHVhIjk/
        YnwmLPnl30w4Y+FeRESolLGFTb9ztApfm3hNASZsow==
X-Google-Smtp-Source: ABdhPJwv+Rw4H3S/iIHOOJaJcaYtpVE9O7+KE2P9K5hP4ONryexsry1kAgoq7JbNH+9g9m7ZsHOyhuxg0GZB54kiJ9U=
X-Received: by 2002:a17:90a:4802:: with SMTP id a2mr3849393pjh.25.1591375831319;
 Fri, 05 Jun 2020 09:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com> <20200605082839.226418-2-elver@google.com>
In-Reply-To: <20200605082839.226418-2-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Jun 2020 09:50:20 -0700
Message-ID: <CAKwvOd=EOQ8g43aC2=aW1kKPmroPCjBJ_1yDwo_zTCgvCuDG5A@mail.gmail.com>
Subject: Re: [PATCH -tip v3 2/2] kcov: Unconditionally add -fno-stack-protector
 to compiler options
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 1:28 AM Marco Elver <elver@google.com> wrote:
>
> Unconditionally add -fno-stack-protector to KCOV's compiler options, as
> all supported compilers support the option. This saves a compiler
> invocation to determine if the option is supported.
>
> Because Clang does not support -fno-conserve-stack, and
> -fno-stack-protector was wrapped in the same cc-option, we were missing
> -fno-stack-protector with Clang. Unconditionally adding this option
> fixes this for Clang.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks for considering the suggestion.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v3:
> * Do not wrap -fno-stack-protector in cc-option, since all KCOV-supported
>   compilers support the option as pointed out by Nick.
> ---
>  kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index ce8716a04d0e..71971eb39ee7 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -35,7 +35,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
>  KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
> -CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>
>  # cond_syscall is currently not LTO compatible
>  CFLAGS_sys_ni.o = $(DISABLE_LTO)
> --
> 2.27.0.278.ge193c7cf3a9-goog
>


-- 
Thanks,
~Nick Desaulniers
