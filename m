Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267B520772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECLofNCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFCNfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:35:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB8C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:35:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so1627134pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzgEpVCSH7j0u78t2npqiORwBbG9mOLC23VmgaWMcFo=;
        b=ECLofNCH7i+cIDW5jy4tA+xf9SFcjMlXzeqL0/Ao+Vl6TKXjvRBa2ipwaDwIv7fhOL
         /ImqoSGDCkVIXmzM53YUFCnPUET9KkM8gaDnFVXGHiUyyFWQGHgQuKn9IMelqYO0GtzL
         HV6fF4cA0pOzr3HmdsK2a9n2kX8r06neqj9aPq4AJ0m8Y+Glu+9pNBwRwDXv08vyrpRk
         eV0V/1JBcPU2TW7F+OFc59F/Yohdmv4PCgjKdFvDWSz4nyA6Sgp6/I9VcmAsjShvktys
         8cOicfrwsTS/cX1dLGmP4lNlnXoNUxmc3OP/ED8B+LQ9YE9nLS5/7YzMGJJoHzkRAgNZ
         BLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzgEpVCSH7j0u78t2npqiORwBbG9mOLC23VmgaWMcFo=;
        b=rG+P6Y4TBJ/PT4U9Sd8AE+YR7KQICXY4mm+EWKFU4zIDcbYm43XEc6G0RNybWdXSCm
         Mi5Hwpw74q8E6AQvWGD3OkcefpBcw281yNpVX4uM0VKrnrToUNkUCEWEZI4ezarIi3Lg
         pPIs1F6AQ8eGLY4wHCbaUYtR/7nW2kbsDh0PslYtvcTfTiqnF5UyEnxuKLAP8z5PHKy3
         94oTjxim0trQdqJsHOi2DtAgHlnd6L2PbCSaO0bXHUhpbNJPmZxb2nvsMnFm3IaSu9VQ
         hxhWxtpWvSytdY2kIuRUt5H7vFBP4lRt66yMn7pSoAkGdLpOpHClDPlNCUZwUJpZGtkB
         ismg==
X-Gm-Message-State: AOAM533nN6ud/JRYC1iVE/9hcLOXZnUJbKSFmjcu/5h3Y+yDFUG/MKTB
        8sASE5Z4moALlu+LXXd9kVIM0Kfu0F/7L1pZCLAItw==
X-Google-Smtp-Source: ABdhPJxJT4RzBTCBCeM1cMukdc2KxZ/uZOJoxjd1t7G8Bo3RASzlxvAHp6ahPsaGanHIe2lcdJ5YuwjCaLEcqZwLsxU=
X-Received: by 2002:a17:90b:1981:: with SMTP id mv1mr5878381pjb.41.1591191347177;
 Wed, 03 Jun 2020 06:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <20200602184409.22142-2-elver@google.com>
In-Reply-To: <20200602184409.22142-2-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 3 Jun 2020 15:35:36 +0200
Message-ID: <CAAeHK+wZegLFPms5_TkBgkoQMeT14UDkY63YoJKmkMaMYnUWQg@mail.gmail.com>
Subject: Re: [PATCH -tip 2/2] compiler_types.h: Add __no_sanitize_{address,undefined}
 to noinstr
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
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 8:44 PM Marco Elver <elver@google.com> wrote:
>
> Adds the portable definitions for __no_sanitize_address, and
> __no_sanitize_undefined, and subsequently changes noinstr to use the
> attributes to disable instrumentation via KASAN or UBSAN.
>
> Link: https://lore.kernel.org/lkml/000000000000d2474c05a6c938fe@google.com/
> Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by:  Andrey Konovalov <andreyknvl@google.com>

> ---
>
> Note: __no_sanitize_coverage (for KCOV) isn't possible right now,
> because neither GCC nor Clang support such an attribute. This means
> going and changing the compilers again (for Clang it's fine, for GCC,
> it'll take a while).
>
> However, it looks like that KCOV_INSTRUMENT := n is currently in all the
> right places. Short-term, this should be reasonable.
> ---
>  include/linux/compiler-clang.h | 8 ++++++++
>  include/linux/compiler-gcc.h   | 6 ++++++
>  include/linux/compiler_types.h | 3 ++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 2cb42d8bdedc..c0e4b193b311 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -33,6 +33,14 @@
>  #define __no_sanitize_thread
>  #endif
>
> +#if __has_feature(undefined_behavior_sanitizer)
> +/* GCC does not have __SANITIZE_UNDEFINED__ */
> +#define __no_sanitize_undefined \
> +               __attribute__((no_sanitize("undefined")))
> +#else
> +#define __no_sanitize_undefined
> +#endif
> +
>  /*
>   * Not all versions of clang implement the the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 7dd4e0349ef3..1c74464c80c6 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -150,6 +150,12 @@
>  #define __no_sanitize_thread
>  #endif
>
> +#if __has_attribute(__no_sanitize_undefined__)
> +#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
> +#else
> +#define __no_sanitize_undefined
> +#endif
> +
>  #if GCC_VERSION >= 50100
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 02becd21d456..89b8c1ae18a1 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -198,7 +198,8 @@ struct ftrace_likely_data {
>
>  /* Section for code which can't be instrumented at all */
>  #define noinstr                                                                \
> -       noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
> +       noinline notrace __attribute((__section__(".noinstr.text")))    \
> +       __no_kcsan __no_sanitize_address __no_sanitize_undefined
>
>  #endif /* __KERNEL__ */
>
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
