Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F6EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCEB20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNY9dMzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgEUJsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgEUJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:48:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBEC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 02:48:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o24so5737837oic.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQALpX3tKawurBrPQADjT0//A1CRuxacWFTx+oaYIXo=;
        b=qNY9dMzQdcDhjQ3VHBlqcb6Cj8/VzxzHdd9/6jHSrnSid+j/1lIwuzWtZmg2QjJoDA
         /E99FONeG+YdnGB8CFWae0+yydwqggFONMbCg7rHvVUAmRR7XFGLuuv0g236ClaTLsFc
         8eG8ZFtfYmdkXZJPL3RIQTkgMkL4YhqhnvOleOnzmb5fVS9ytCilkAVFwLEbfWtVfNt3
         BatvNSXTcPvDXfUwrquLaRq//hvVdTGBUjpEMo6e+WxHPeCNUcek0KleVJ+x6du4Axjc
         WbEPoPXG9W5UttcnwG3hPQikffDm6oqdS++NHqJVOcIjdf20TrApJsB9bnTxT0DgjbbM
         U+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQALpX3tKawurBrPQADjT0//A1CRuxacWFTx+oaYIXo=;
        b=XBDsJsw0tclwRqJnsIpYP0OU7+bG79nQlMDf+EA/9tY9oW5VSQlHlKZVQOnpKJbQzI
         r47Iesp4vpnayFlO0xKrfomAjkKaeF+ar944QdmH5kc/Ibc4rN8klK8YrmO+oSDrEuW/
         ZKGpecUDfxemRFIfNGIx7RMUCWW6GAFd4yyC3BTFfGPd34fGO40L7wpxdCNlybJulxoO
         CbmspFDEc+4zQGAai61KTI0oyaUkGl+pRHp97pzP30cmrXkvQXOci6b6c2YOKWgoJt2D
         R6tjJEkX5WMBXWQxUgQzuMd3inm9tFsdqqwwC/BWMIyMJfjNzZNAf0/B/ur6WbNtGzLq
         8stA==
X-Gm-Message-State: AOAM530hz6PRunoX++vy2lkezyUDhTegimH0uVAR8Tbz9cMvyqZ2LMYm
        FateJaLERcrCyXI9QBnLeIn4dQOc6mO4dBdNv9368A==
X-Google-Smtp-Source: ABdhPJxJVbnY26Kljg2hwBzw6DNo4a3qJBKcl+y4SNKBg9CkbrgNyb5uwdMbm6Upm5CUD0gPl8+GZE/jjWz9OY/HOeQ=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr6229196oih.70.1590054486120;
 Thu, 21 May 2020 02:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200515150338.190344-1-elver@google.com> <20200515150338.190344-9-elver@google.com>
In-Reply-To: <20200515150338.190344-9-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 11:47:54 +0200
Message-ID: <CANpmjNNdBrO=dJ1gL+y0w2zBFdB7G1E9g4uk7oDDEt_X9FaRVA@mail.gmail.com>
Subject: Re: [PATCH -tip 08/10] READ_ONCE, WRITE_ONCE: Remove data_race() wrapping
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
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 17:04, Marco Elver <elver@google.com> wrote:
>
> The volatile access no longer needs to be wrapped in data_race(),
> because we require compilers that emit instrumentation distinguishing
> volatile accesses.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/compiler.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 17c98b215572..fce56402c082 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -229,7 +229,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #define __READ_ONCE_SCALAR(x)                                          \
>  ({                                                                     \
>         typeof(x) *__xp = &(x);                                         \
> -       __unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));  \
> +       __unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);             \
>         kcsan_check_atomic_read(__xp, sizeof(*__xp));                   \

Some self-review: We don't need kcsan_check_atomic anymore, and this
should be removed.

I'll send v2 to address this (together with fix to data_race()
removing nested statement expressions).

>         smp_read_barrier_depends();                                     \
>         (typeof(x))__x;                                                 \
> @@ -250,7 +250,7 @@ do {                                                                        \
>  do {                                                                   \
>         typeof(x) *__xp = &(x);                                         \
>         kcsan_check_atomic_write(__xp, sizeof(*__xp));                  \

Same.

> -       data_race(({ __WRITE_ONCE(*__xp, val); 0; }));                  \
> +       __WRITE_ONCE(*__xp, val);                                       \
>  } while (0)
>
>  #define WRITE_ONCE(x, val)                                             \
> --
> 2.26.2.761.g0e0b3e54be-goog
>
