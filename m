Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D862207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1YBq2nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgE0Lgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgE0Lgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:36:50 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F89C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:36:49 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so12435512ila.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=z6go2Pe/0xHx8Ur0HnZIKTJ47Wq/ilnSzd2NqpRkWGw=;
        b=L1YBq2nYL/jTkOPYDhIKkn6zmKuK7UFF9qeB/1ogdHqnN+IpWi07rXvId5L6YeWSC7
         CWSjhp959giwzN/B1C7SPZSYBP1iCCYDKjEnJPZ/J1nqfSa0bqnUC4nY9q98tV/GqltA
         hqyacD7MuaOXlBgaLqgLsNIqI6jApL+chkIVBvUwJO2isRB+Lf340oB1laD/sV0HaxQ9
         LqdOjnfAsFKjGJA0oGsmQGxeNKyeUXQs7CDD4t6/a+zRj/LeWWo18YDYC8cpmTn752hu
         VVGiJk+JXkZVG0v8hpokgwrolvfPtevcq5Sm9k6p/Dd/Toji8Zso/rzCMnUtinyp3BDu
         eryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=z6go2Pe/0xHx8Ur0HnZIKTJ47Wq/ilnSzd2NqpRkWGw=;
        b=ZnZKRtp9ygjHlWGy02mSqscB0JmDim/5+JkttbKvgfDP0X3Yi4XQDXyv0zNZ/24lY7
         RI6BWOUQzcK4Q+yiwDi+VL1ihZvRXcQJDlshmnWv2B2FnG3Y6zV/tusA3HrOYytg0bg5
         cdMaSFYTQk3f7jN2pe1N6weXZAWmsv0EW+9clcMKrODkVsyIMyo/zXiBS76SERqdtRaH
         i36rb9ZybO7KtPN0j5qKulaRMXFWP+BlBppV1NIzgFFdy7J6zjovg+3wbEDcUzkRc0h8
         Qijd1NbBHBqEhP5F0juwAdcFxL6DpwN8rUjFsF7PlUcnDfE7TkCv8m/jw3f4GBGXyM8f
         FT8Q==
X-Gm-Message-State: AOAM533YKgaIUnTmtg46ruhnTd8rbAdpfNTuBp/hdrAZxOQvfPG6eMr1
        FvI1xx+/7RbNFGzOYJH991PekpO1jz7CJr/qm+S5NC8YK+AINA==
X-Google-Smtp-Source: ABdhPJwB+mlfql2WHcQXhCifPFDYtsAy/Xr6osuhagLy++BiiUrBpvsqG3x3l04er/kd4/cGO4nKI7FeqTa+/9eUlz0=
X-Received: by 2002:a92:6608:: with SMTP id a8mr5465508ilc.204.1590579409205;
 Wed, 27 May 2020 04:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
In-Reply-To: <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 May 2020 13:36:41 +0200
Message-ID: <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> >
> > If the compiler supports C11's _Generic, use it to speed up compilation
> > times of __unqual_scalar_typeof(). GCC version 4.9 or later and
> > all supported versions of Clang support the feature (the oldest
> > supported compiler that doesn't support _Generic is GCC 4.8, for which
> > we use the slower alternative).
> >
> > The non-_Generic variant relies on multiple expansions of
> > __pick_integer_type -> __pick_scalar_type -> __builtin_choose_expr,
> > which increases pre-processed code size, and can cause compile times to
> > increase in files with numerous expansions of READ_ONCE(), or other
> > users of __unqual_scalar_typeof().
> >
> > Summary of compile-time benchmarking done by Arnd Bergmann [1]:
> >
> >         <baseline normalized time>  clang-11   gcc-9
> >         this patch                      0.78    0.91
> >         ideal                           0.76    0.86
> >
> > [1] https://lkml.kernel.org/r/CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com
> >
> > Further compile-testing done with:
> >         gcc 4.8, 4.9, 5.5, 6.4, 7.5, 8.4;
> >         clang 9, 10.
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> This gives us back 80% of the performance drop on clang, and 50%
> of the drop I saw with gcc, compared to current mainline.
>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
>

Hi Arnd,

with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.

Is there a speedup benefit also for Linux v5.7?
Which patches do I need?

Thanks.

Regards,
- Sedat -
