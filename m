Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62338C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322B72072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3fbfIYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgEUKS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgEUKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:18:27 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23504C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:18:27 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id c83so1340564oob.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izKU/C7ocKPbE+164Qwv+Ka88gTqLAT8wcuVjIle3sU=;
        b=g3fbfIYDmteotAWw/bjWCYDjaheiIAQEfGL/+hafpV/ATUY5RLY/o6nMZ0fSknCgGr
         +dT2UbEKYxcwhFB9uc0y1pEpa61tVhPIjWQsQEnPEnJVCJSmtfl+8/Xm0hYlQvjqZXMM
         UgPTI95Mi7d74zH+uprHWNZb7m58RIWfVTFqtGMbvCTAlr1Ws8e51Z7hb2H+wDRH+cYF
         zxq6iz61o5dmoX+LhtTY9dK/wwxjT/HeqyiRYp6Ep+URKGtzcJPCgP583+p1HzKZdCcF
         Z7gqaqb7kRGkXKjMDECq9lz2xE7IkLkULklD2jve3wfvHeaRixF+k33kQF0ExtRaODMo
         SOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izKU/C7ocKPbE+164Qwv+Ka88gTqLAT8wcuVjIle3sU=;
        b=pg2UcQdRpof+Uz9TRzq6SV9OMUT1L1lSIr6qZ1Yq+xOtd5yZRr+HliwY3uoSJCK9MZ
         BwSXGyCITKt+BXQPAwXvVjcm10zhpst3mTSM1kcExZU7ATA8/pfS2Ym+rwjpOacKBiOx
         7mbrCiDyWrDcLUkG1N6y6U2BYU+T1gLduRjncgjk5Ts29/WPfGqD6Z7ZpdTkc0Ww8g3V
         FGv/bhNz0tDMK3Rf3h09LrLXToOjlcwMwiKwUXbt8ZMFl7gCT0pkkr9zzN8tDnovGGaN
         Vd1AYEjUGV0MTMSQewWxiKzwaLW6tTIeD73XcThDeDKRy0d7HE2tigKup1C5bvEqd2Aa
         iiaw==
X-Gm-Message-State: AOAM533ITa3UCrwO4AVQkO+sds+cet5/b/Y4cNQ0oetIPEaCTL33yAma
        BokLW1RWcsVOGqxET+lRWg3cD1rsdPNevFczphgOMA==
X-Google-Smtp-Source: ABdhPJxZvCx0JWtZbZqsUfEIceqhBGZltNJoKN6yXw5OJ/KMft7+bQdfPCgJKZpgDfWqNkK69p83xReU8Fsx8t/rNUU=
X-Received: by 2002:a4a:6241:: with SMTP id y1mr4526981oog.14.1590056306345;
 Thu, 21 May 2020 03:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200515150338.190344-1-elver@google.com> <20200515150338.190344-9-elver@google.com>
 <CANpmjNNdBrO=dJ1gL+y0w2zBFdB7G1E9g4uk7oDDEt_X9FaRVA@mail.gmail.com>
In-Reply-To: <CANpmjNNdBrO=dJ1gL+y0w2zBFdB7G1E9g4uk7oDDEt_X9FaRVA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 12:18:14 +0200
Message-ID: <CANpmjNPLVMTSUAARL94Pug21ab4+zNikO1HYN2fVO3LfM4aMuQ@mail.gmail.com>
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

On Thu, 21 May 2020 at 11:47, Marco Elver <elver@google.com> wrote:
>
> On Fri, 15 May 2020 at 17:04, Marco Elver <elver@google.com> wrote:
> >
> > The volatile access no longer needs to be wrapped in data_race(),
> > because we require compilers that emit instrumentation distinguishing
> > volatile accesses.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/compiler.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 17c98b215572..fce56402c082 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -229,7 +229,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  #define __READ_ONCE_SCALAR(x)                                          \
> >  ({                                                                     \
> >         typeof(x) *__xp = &(x);                                         \
> > -       __unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));  \
> > +       __unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);             \
> >         kcsan_check_atomic_read(__xp, sizeof(*__xp));                   \
>
> Some self-review: We don't need kcsan_check_atomic anymore, and this
> should be removed.
>
> I'll send v2 to address this (together with fix to data_race()
> removing nested statement expressions).

The other thing here is that we no longer require __xp, and can just
pass x into __READ_ONCE.

> >         smp_read_barrier_depends();                                     \
> >         (typeof(x))__x;                                                 \
> > @@ -250,7 +250,7 @@ do {                                                                        \
> >  do {                                                                   \
> >         typeof(x) *__xp = &(x);                                         \
> >         kcsan_check_atomic_write(__xp, sizeof(*__xp));                  \
>
> Same.

__xp can also be removed.

Note that this effectively aliases __WRITE_ONCE_SCALAR to
__WRITE_ONCE. To keep the API consistent with READ_ONCE, I assume we
want to keep __WRITE_ONCE_SCALAR, in case it is meant to change in
future?

> > -       data_race(({ __WRITE_ONCE(*__xp, val); 0; }));                  \
> > +       __WRITE_ONCE(*__xp, val);                                       \
> >  } while (0)
> >
> >  #define WRITE_ONCE(x, val)                                             \
> > --
> > 2.26.2.761.g0e0b3e54be-goog
> >
