Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD8AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C1F20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0O+txBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgEUUVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:21:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D44C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:21:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so3988834pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0yJ3RFZMM+B9sO1n4irEzcjxiMNA5r+ntERLJo+fSQ=;
        b=e0O+txBUJGYrfPgR2xthzQdUJc8pC36pQDrM0fuRm9WbBJWyWtvsXaC2KwzR4ajS6K
         xYN3msgWqyZr4AoS+jJWaTurxDKT7GK3ZlOvHuxduLIUJ/QFJ62EKW/w2xtKAeJLhmIh
         52Or+ErhLPs6F2ZX5I6fq/g3zm+UM5BRg7HSNiqkGGPAPqQ+0q8JfscesxksCV81JYg7
         VrGNE1vUDW0dhFDApbQFBy78fxe19buadmFV8YUly3mDfL/RW26VwpysvkSmY3D48hY/
         y8z3g9zqWmQonq6O8GDMbSgy2WTl9F0ftVpTHAZz8n6yk0jlWhTQbXRcSkjKRygFW5oV
         SJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0yJ3RFZMM+B9sO1n4irEzcjxiMNA5r+ntERLJo+fSQ=;
        b=tZD4Fk47OKZVosk0SN2ieDSEBT5+GbyriqUnsuHazS4zTRE4+TgFUPulWFEue9qVTa
         7IWj8cF8TTijtkEQhtd5nXnf+XuWsIOPZhPpRDvoRjN4z1AFWD7BlMgdDJbIuYA08zzT
         IlpEHxx88sIlt3Daxzuv6jmhZOZKmSlUdfstbP/OjjFO1SP2M+tmQtpZFzfoETynd+kE
         P5FjaCYNXj6IQ2a5aN195J4VXSsW2/aK/Sd7U/kT2zSA5NnU6wGqtuTnipFCzQaxIM8l
         6uRBoAZHUbvoB27FuaHCU9YvBPOd6e0G0w2m/Ml/J/6BmH17tV255WILOLZeXvPxV8ng
         4PFw==
X-Gm-Message-State: AOAM533GptUksF8iE+3sJ6BuiB0hEIOy4RzDqXiUBbiTREK0faXDPcmN
        q616KFmvXackay85SpGQ7Efj/n4Fhtv4KtxTA1Bz0w==
X-Google-Smtp-Source: ABdhPJwy+KX56rCo7w3/wW1w3syMVi0Hn7+zsyF5QXU3PhqSkrcl0rcIrtFXPn6Mvwgub/r6QiX79jia6rovddhlY8I=
X-Received: by 2002:a63:d010:: with SMTP id z16mr10089185pgf.381.1590092481542;
 Thu, 21 May 2020 13:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
In-Reply-To: <20200521142047.169334-10-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 May 2020 13:21:09 -0700
Message-ID: <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 7:22 AM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> It appears that compilers have trouble with nested statement
> expressions. Therefore remove one level of statement expression nesting
> from the data_race() macro. This will help us avoid potential problems
> in future as its usage increases.
>
> Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks Marco, I can confirm this series fixes the significant build
time regressions.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

More measurements in: https://github.com/ClangBuiltLinux/linux/issues/1032

Might want:
Reported-by: Borislav Petkov <bp@suse.de>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
too.

> ---
> v3:
> * Fix for 'const' non-scalar expressions.
> v2:
> * Add patch to series in response to above linked discussion.
> ---
>  include/linux/compiler.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7444f026eead..379a5077e9c6 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -211,12 +211,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   */
>  #define data_race(expr)                                                        \
>  ({                                                                     \
> -       __kcsan_disable_current();                                      \
> -       ({                                                              \
> -               __unqual_scalar_typeof(({ expr; })) __v = ({ expr; });  \
> -               __kcsan_enable_current();                               \
> -               __v;                                                    \
> +       __unqual_scalar_typeof(({ expr; })) __v = ({                    \
> +               __kcsan_disable_current();                              \
> +               expr;                                                   \
>         });                                                             \
> +       __kcsan_enable_current();                                       \
> +       __v;                                                            \
>  })
>
>  /*
> --
> 2.26.2.761.g0e0b3e54be-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200521142047.169334-10-elver%40google.com.



-- 
Thanks,
~Nick Desaulniers
