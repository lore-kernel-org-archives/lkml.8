Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ACAC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297D82075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwIFz5K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgDXP5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgDXP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:57:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A08C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:57:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g19so13180322otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCU0zEm2bNycf7DvAmLbUzalJnJrzqnH9qv/4oyQ1dU=;
        b=AwIFz5K7tVTOE6Yt6l5Ln/DRSrnqW54bzJdyn2UXO31svIPwz3zUkuSMOMo8wiZoVM
         N843Az7pA9H9a7n44qO39uXdd2nOIWd6sfAqj4q1aOBxzpk/IK+LH0bjLnA77do5nfoJ
         jwAQNHvAPdhvPDJ1jz17Wu6fcE2MzTKtkc9IjlPqrgajewe5pVai44xNaiFRsxcAnYyo
         I02nBkA2G3+Se9P9PTUFtIicfDRJClCRAzu07GSx+5xFWTmWRutfp0kfNjqqhLg39OXa
         V44HRoU7ZX2gYos4Igzqu+6RTE6EUSE61D846q8a0r+Tr1Fkg4LmmZMnPADXNP5s8LMQ
         ehSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCU0zEm2bNycf7DvAmLbUzalJnJrzqnH9qv/4oyQ1dU=;
        b=aIiJaYlSJ1LzfAAIzLcBXtteTJz4myzmON5v25UZUa1ExYI8tcU4lJOLAdkRHzDfZc
         jv6hgnLlP4fuupDd7B2l6oqvDzVMqnbdY1aO4LmFAHTlrT9vwt9SRz7x3q8dEWERo/Im
         GpXdHC/eb2ILaGcR2lF0aUMf6bMj5nirMoVJBPYtFQfb9atxOb/MG3rhjY5S45nX8cTP
         HEkwHvKIsGLIdqeCf/wYjjons++WDT9ZjhbZypb3stoXQNiHIYaaRfTrofE2NBXZVNdm
         plzJcarG71djpgUnpQ39eBJXYj3aBCQVW0sKSyUKRDkRp3oLLwc3sE1smUmKh6jIvEpv
         DnaA==
X-Gm-Message-State: AGi0Pub40NBIRJsTRWQdWbPcWSSFZsx+8XKMxq46R+AAyHfExU13d9KB
        pKDs+/uLfAqNcYOqhyEXnCrBQlLKMP2nP2CLecN23Yms
X-Google-Smtp-Source: APiQypK61zpjEDwti64OS0v4uLFU2zyueuwLEPuBoJ5lyqauFtaPpjSbw+ReGx1u7/BsQt0gibfzwqQn/66n74Z1mew=
X-Received: by 2002:a9d:7589:: with SMTP id s9mr7701270otk.251.1587743835871;
 Fri, 24 Apr 2020 08:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200424154730.190041-1-elver@google.com>
In-Reply-To: <20200424154730.190041-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 24 Apr 2020 17:57:04 +0200
Message-ID: <CANpmjNOaUc8-Y4MMre5mWLjywTZ+B0B9L-cQijeYEMcw9Vapsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kcsan: Add __kcsan_{enable,disable}_current() variants
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 at 17:47, Marco Elver <elver@google.com> wrote:
>
> The __kcsan_{enable,disable}_current() variants only call into KCSAN if
> KCSAN is enabled for the current compilation unit. Note: This is
> typically not what we want, as we usually want to ensure that even calls
> into other functions still have KCSAN disabled.
>
> These variants may safely be used in header files that are shared
> between regular kernel code and code that does not link the KCSAN
> runtime.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> This is to help with the new READ_ONCE()/WRITE_ONCE():
> https://lkml.kernel.org/r/20200424134238.GE21141@willie-the-truck
>
> These should be using __kcsan_disable_current() and
> __kcsan_enable_current(), instead of the non-'__' variants.
> ---

Paul: These 2 patches may want to be in the set for 5.8, depending on
what Will wants to do.

An alternative would be that Will takes my 2 patches and carries them,
avoiding some complex patch-dependency. That is assuming his set of
patches will go in -tip on top of KCSAN.

Thanks,
-- Marco

>  include/linux/kcsan-checks.h | 17 ++++++++++++++---
>  kernel/kcsan/core.c          |  7 +++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index ef95ddc49182..7b0b9c44f5f3 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -49,6 +49,7 @@ void kcsan_disable_current(void);
>   * Supports nesting.
>   */
>  void kcsan_enable_current(void);
> +void kcsan_enable_current_nowarn(void); /* Safe in uaccess regions. */
>
>  /**
>   * kcsan_nestable_atomic_begin - begin nestable atomic region
> @@ -149,6 +150,7 @@ static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
>
>  static inline void kcsan_disable_current(void)         { }
>  static inline void kcsan_enable_current(void)          { }
> +static inline void kcsan_enable_current_nowarn(void)   { }
>  static inline void kcsan_nestable_atomic_begin(void)   { }
>  static inline void kcsan_nestable_atomic_end(void)     { }
>  static inline void kcsan_flat_atomic_begin(void)       { }
> @@ -165,15 +167,24 @@ static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
>
>  #endif /* CONFIG_KCSAN */
>
> +#ifdef __SANITIZE_THREAD__
>  /*
> - * kcsan_*: Only calls into the runtime when the particular compilation unit has
> - * KCSAN instrumentation enabled. May be used in header files.
> + * Only calls into the runtime when the particular compilation unit has KCSAN
> + * instrumentation enabled. May be used in header files.
>   */
> -#ifdef __SANITIZE_THREAD__
>  #define kcsan_check_access __kcsan_check_access
> +
> +/*
> + * Only use these to disable KCSAN for accesses in the current compilation unit;
> + * calls into libraries may still perform KCSAN checks.
> + */
> +#define __kcsan_disable_current kcsan_disable_current
> +#define __kcsan_enable_current kcsan_enable_current_nowarn
>  #else
>  static inline void kcsan_check_access(const volatile void *ptr, size_t size,
>                                       int type) { }
> +static inline void __kcsan_enable_current(void)  { }
> +static inline void __kcsan_disable_current(void) { }
>  #endif
>
>  /**
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 40919943617b..0a0f018cb154 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -625,6 +625,13 @@ void kcsan_enable_current(void)
>  }
>  EXPORT_SYMBOL(kcsan_enable_current);
>
> +void kcsan_enable_current_nowarn(void)
> +{
> +       if (get_ctx()->disable_count-- == 0)
> +               kcsan_disable_current();
> +}
> +EXPORT_SYMBOL(kcsan_enable_current_nowarn);
> +
>  void kcsan_nestable_atomic_begin(void)
>  {
>         /*
> --
> 2.26.2.303.gf8c07b1a785-goog
>
