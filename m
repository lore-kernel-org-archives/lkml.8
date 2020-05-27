Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5736C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7A9208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hcywj/S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgE0N5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbgE0N5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:57:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C27DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:57:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d191so21729044oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdFFnED2awUw3pJ4+j8OXoHJjtxYorX0jVxetfYLfoE=;
        b=Hcywj/S6xgdr+01QCctX16boW0TzQPvaqJngOJdoLBzzity6HNUCK9Yi+CI2U5vk2K
         pwVhHWQUMi55LiwSZCScNEPlm8d4HejLpQjErgiZktked3DjVoZUeHstZvJC07dvMEFO
         gucMt9WLC9n3GqFHlUkSi1mHtbbj3K61CqiGUfbIMQ08zU9Ay1VyG5lFNQCvQ1cdNnX0
         De20O2KtRwZM53uVEbJGDFvKdMovS6tClpoiV5xUYTaOJStDoAnpFLDfLsRTDHnqS3pa
         Sk9Vr4hkYSD41yFDrzBh/uLJ27EsqqBwue7kCoqhBMkVXJVoWfsrCHQ+WvtttBlaClRg
         mP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdFFnED2awUw3pJ4+j8OXoHJjtxYorX0jVxetfYLfoE=;
        b=P3fMMVW3Xkv6Mc6EM8dMrSIteprZ07WTZnXBCKZOx0pipwgBDkeym0Y8Ag1+fH2XWH
         rxmpJOxvvdRAhGRasavo1YUTPaLncuAwhzbeY1j90wheGUXFcAXfAiqdQb4FWNIMeFl9
         q/2uiBOGJRg+Nyjxa9rO/rWE33IMu93bYItA2e0ApY8iuXCWV3F7o0RTlMGAr5dsah7T
         b4aE8W26PZBVcYcSCNVbi0W9bwv0KORxyt9580YDLmlf8PnyvZUaeZt9fYQ4kZXsTKI5
         qWguYCh3ZOhdu672LKUQ1+kw9Pxz0pHIuBfoXK2Ia0JUa3AeOTJMsOlJA17gRMXbJYJt
         mkgQ==
X-Gm-Message-State: AOAM533KNchFk4uX0Qy7amETKlJReXCjf3OOEQWA2l5gI41CU5usbfLe
        nKvEJQWbEN0xCIVrfsJzmAI6hRCVjyTbNQ4bVWjKWw==
X-Google-Smtp-Source: ABdhPJxnIBxn9YyypzshT3RUnQm0AIoOvRbJoSh1uEdipPZ4EWrOLoHGMJlkfZPFLsSrCdWybyzpAratJIq5DtyF9ik=
X-Received: by 2002:aca:6747:: with SMTP id b7mr2844571oiy.121.1590587825434;
 Wed, 27 May 2020 06:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
 <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
 <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
 <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
 <CA+icZUWr5xDz5ujBfsXjnDdiBuopaGE6xO5LJQP9_y=YoROb+Q@mail.gmail.com>
 <CANpmjNOtKQAB_3t1G5Da-J1k-9Dk6eQKP+xNozRbmHJXZqXGFw@mail.gmail.com> <CA+icZUWzPMOj+qsDz-5Z3tD-hX5gcowjBkwYyiy8SL36Jg+2Nw@mail.gmail.com>
In-Reply-To: <CA+icZUWzPMOj+qsDz-5Z3tD-hX5gcowjBkwYyiy8SL36Jg+2Nw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 May 2020 15:56:53 +0200
Message-ID: <CANpmjNOPcFSr2n_ro8TqhOBXOBfUY0vZtj_VT7hh3HOhJN4BqQ@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     sedat.dilek@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
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

On Wed, 27 May 2020 at 15:37, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 3:30 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 27 May 2020 at 15:11, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Wed, May 27, 2020 at 2:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Wed, May 27, 2020 at 2:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > On Wed, May 27, 2020 at 2:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> > > > > > > >
> > > > > > > > This gives us back 80% of the performance drop on clang, and 50%
> > > > > > > > of the drop I saw with gcc, compared to current mainline.
> > > > > > > >
> > > > > > > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > >
> > > > > > >
> > > > > > > Hi Arnd,
> > > > > > >
> > > > > > > with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
> > > > > >
> > > > > > I meant v5.7.
> > > > > >
> > > > > > > I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
> > > > > > >
> > > > > > > Is there a speedup benefit also for Linux v5.7?
> > > > > > > Which patches do I need?
> > > > > >
> > > > > > v5.7-rc is the baseline and is the fastest I currently see. On certain files,
> > > > > > I saw an intermittent 10x slowdown that was already fixed earlier, now
> > > > > > linux-next
> > > > > > is more like 2x slowdown for me and 1.2x with this patch on top, so we're
> > > > > > almost back to the speed of linux-5.7.
> > > > > >
> > > > >
> > > > > Which clang version did you use - and have you set KCSAN kconfigs -
> > > > > AFAICS this needs clang-11?
> > > >
> > > > I'm currently using clang-11, but I see the same problem with older
> > > > versions, and both with and without KCSAN enabled. I think the issue
> > > > is mostly the deep nesting of macros that leads to code bloat.
> > > >
> > >
> > > Thanks.
> > >
> > > With clang-10:
> > >
> > > $ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
> > >  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
> > > +HAVE_ARCH_KCSAN y
> >
> > Clang 10 doesn't support KCSAN (HAVE_KCSAN_COMPILER unset).
> >
> > > With clang-11:
> > >
> > > $ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
> > >  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
> > >  CLANG_VERSION 100001 -> 110000
> > > +CC_HAS_ASM_INLINE y
> > > +HAVE_ARCH_KCSAN y
> > > +HAVE_KCSAN_COMPILER y
> > > +KCSAN n
> > >
> > > Which KCSAN kconfigs did you enable?
> >
> > To clarify: as said in [1], KCSAN (or any other instrumentation) is no
> > longer relevant to the issue here, and the compile-time regression is
> > observable with most configs. The problem is due to pre-processing and
> > parsing, which came about due to new READ_ONCE() and the
> > __unqual_scalar_typeof() macro (which this patch optimizes).
> >
> > KCSAN and new ONCEs got tangled up because we first attempted to
> > annotate {READ,WRITE}_ONCE() with data_race(), but that turned out to
> > have all kinds of other issues (explanation in [2]). So we decided to
> > drop all the KCSAN-specific bits from ONCE, and require KCSAN to be
> > Clang 11. Those fixes were applied to the first version of new
> > {READ,WRITE}_ONCE() in -tip, which actually restored the new ONCEs to
> > the pre-KCSAN version (now that KCSAN can deal with them without
> > annotations).
> >
> > Hope this makes more sense now.
> >
> > [1] https://lore.kernel.org/lkml/CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/20200521142047.169334-1-elver@google.com/
> >
>
> Thanks, Marco.
>
> I pulled tip.git#locking/kcsan on top of Linux v5.7-rc7 and applied this patch.
> Just wanted to try KCSAN for the first time and it will also be my
> first building with clang-11.
> That's why I asked.

In general, CONFIG_KCSAN=y and the defaults for the other KCSAN
options should be good. Depending on the size of your system, you
could also tweak KCSAN runtime performance:
https://lwn.net/Articles/816850/#Interacting%20with%20KCSAN%20at%20Runtime
-- the defaults should be good for most systems though.
Hope this helps. Any more questions, do let me know.

Thanks,
-- Marco
