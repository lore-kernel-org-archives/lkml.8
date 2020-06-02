Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0028120734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cmj2yrH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFBStX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:49:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B68C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:49:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so1972279pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xlo4rK4g8fnalu7U0lbya/uKNvvM9T5qVFKFRMeKAc=;
        b=Cmj2yrH3qEvNmtyfHon2kKl7S72MckaUFizNRpDYa2PKNa4QFR1gb7MnhKguJRH84w
         hTS1vzbKiXdRyx0i4bWrJYJyRj7ry4Soppmro6CW+RvUpSWXKSJ3sH810c1zkOhsrukA
         162KUUhbHn3rYn2vlmxII6COL2ffUg2ruVQH5TAUuyYhZIzv2hFNo64oX8grE+oKOe8O
         zAVw2A8hmOOVlhAsruoYkmT5gR5n+4jQM9qCHdR1qQdhkP96TV8MPM5JAHFbYmfD6UmS
         bu7cdQen0hfX6Lqm6cbTmYQDx2B6Bczq/4jNmwvLjmE7OV5i3qcNCfi/CjSoC0YF48mb
         X3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xlo4rK4g8fnalu7U0lbya/uKNvvM9T5qVFKFRMeKAc=;
        b=A0KIRtgKSTHLu7ubxHTCr7YNkDvlbLPYoDOV78AXQOkVM5XQs3RsLmUSeAgHCcXp25
         Ph5RjyD0X6smLxMEa0zN8fM2Z4zPDbr1t5RIpyrw7rBg6O9K6xi/DMf8nNXPKUP/P8Tp
         Fnk81IyYruooATFwgUKjiFz++ZvkbDBEdD3o3lqWBECdaXnplUGRIijmqMCwOwTxJYsR
         HQ7xqjeZf6oY3zCh1JuC31Zwy/4thQ9JtG1CNlA7Ib0oQddrcIUSqGbahLZm+0oe3kVg
         mGuloI6AF1Mkp/9srL95SGqOnoUiEdyPRXtRaaU/Co5+LVY/sijFr3C4CCQK6DMYROk/
         v0CQ==
X-Gm-Message-State: AOAM531/jR0S2XStxvYz+obCx9EnR6OGhe29X6HhmGO8iK1N2yz274qh
        TPIOcRpUoShoEgVPpr6WQ3ve7AYE/PMaZbjpVctM8A==
X-Google-Smtp-Source: ABdhPJyrThF1j+tAlirsbtuBW4BMmc23K4JZ0qfLQQN7aP4qY3TfzZdJdINqE30HlIZvqQtlkhao6mys0kzCfXt7uxw=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr601098pjb.101.1591123761720;
 Tue, 02 Jun 2020 11:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <20200602184409.22142-2-elver@google.com>
In-Reply-To: <20200602184409.22142-2-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jun 2020 11:49:10 -0700
Message-ID: <CAKwvOdkXVcZa5UwnoZqX7_FytabYn2ZRi=zQy_DyzduVmyQNMA@mail.gmail.com>
Subject: Re: [PATCH -tip 2/2] compiler_types.h: Add __no_sanitize_{address,undefined}
 to noinstr
To:     Marco Elver <elver@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 11:44 AM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Adds the portable definitions for __no_sanitize_address, and
> __no_sanitize_undefined, and subsequently changes noinstr to use the
> attributes to disable instrumentation via KASAN or UBSAN.
>
> Link: https://lore.kernel.org/lkml/000000000000d2474c05a6c938fe@google.com/
> Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
> Signed-off-by: Marco Elver <elver@google.com>

Currently most of our compiler attribute detection is done in
include/linux/compiler_attributes.h; I think this should be handled
there. +Miguel Ojeda

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

-- 
Thanks,
~Nick Desaulniers
