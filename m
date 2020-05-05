Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BCBC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8F120746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ryjj2stn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgEERrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgEERrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:47:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67317C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:47:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so1235000pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E59gdCn7b/m1/us+3FVlm14/hmF9iuj5/6dTwUQ7gS4=;
        b=Ryjj2stnr8r+NJrfxoXOm2874nFlhlTekRuMu1qPScqui7fbLdeDGbs5o0B6vVLi9a
         FjdcgskOu2syyZPhOaOhjw/W+fWi+PKgn9Gv+2N5TX622cO/PVy0g5Mg2GBqoOTOM8P/
         PtDFLIZdaedNB6VgahKUfRfl/y0OGii06I73OFyXg5KY4NJj9fhgQZ/FjkJx0t34C3vK
         nspEhX8fzFh+FM76BAgqIOSS/KH9EWpz62v5QXpSjwAPCMq400dHPnqtYV+zJm9qnxPB
         lUNNOCDnrbCFsPGuG0FdI05KHeQAlyrNwCneDrJmYgguw+ncy15h5TmV7+nZG39rN2xG
         WGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E59gdCn7b/m1/us+3FVlm14/hmF9iuj5/6dTwUQ7gS4=;
        b=WMsZ3Fa8rLEAgCx0kaMAjECHxEXe4J2DBSfX3/XrdI473t3C2yBwtqQyEoUZ/H9hji
         xFIT8U2uS+MqhmVSI2ZdwqPr1J3VJpGt9j7/1M28NcN78oAMFehJf182c8vnGgHujck6
         SuCo9Q1mw0MPkqVf8Yd9DZCXcnAFHtmxasoQiiAIC/D2zw4QvwvhTyY1c/Ei5Kv/zW4a
         jlCvTudTVx93gwm42WerSDvULzYR7AhMQy/dC7U4ZkeU2kYq3s53xRt+HQNE3AM1AgtP
         E5uO8ee458mNXLfkdjJkMJ3AGBRHhc0ToZv8oA64y6x1KPkQrbQll6J7Tape48lkUYlU
         4kmA==
X-Gm-Message-State: AGi0PuY7ooE7pYKsJM6VRlRBcsDseU4/J16UALpCgU5LIqPdxGPRPECa
        muBz7y0FYr1ImoBqZisG7c/U5pO5ZQg+MT5s/1cEQQ==
X-Google-Smtp-Source: APiQypJ4UBjUXmbP9k6xl5SiwMOZpg0ggz/1t2R7Nd+6NK+s3+B4M0Pv22X3OSY1y6bgvXCgr0oW6TquGUrizROaJlc=
X-Received: by 2002:a62:146:: with SMTP id 67mr4221059pfb.169.1588700858460;
 Tue, 05 May 2020 10:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
 <20200504193524.GA221287@google.com> <20200504181443.00007a3d@intel.com>
 <20200505151438.GP185537@smile.fi.intel.com> <CAKwvOdn503VpMu6x5qtmeQrcVnwkAqu6gnoU0Pb99sX98aZPHQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn503VpMu6x5qtmeQrcVnwkAqu6gnoU0Pb99sX98aZPHQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 10:47:28 -0700
Message-ID: <CAKwvOdmPj1jecqD86pT9p6pJYckG5_Q5x0ZWQGyCOj-3J-s=Jw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ilie Halip <ilie.halip@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:29 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, May 5, 2020 at 8:14 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, May 04, 2020 at 06:14:43PM -0700, Jesse Brandeburg wrote:
> > > On Mon, 4 May 2020 12:51:12 -0700
> > > Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > > Sorry for the very late report.  It turns out that if your config
> > > > tickles __builtin_constant_p just right, this now produces invalid
> > > > assembly:
> > > >
> > > > $ cat foo.c
> > > > long a(long b, long c) {
> > > >   asm("orb\t%1, %0" : "+q"(c): "r"(b));
> > > >   return c;
> > > > }
> > > > $ gcc foo.c
> > > > foo.c: Assembler messages:
> > > > foo.c:2: Error: `%rax' not allowed with `orb'
> > > >
> > > > The "q" constraint only has meanting on -m32 otherwise is treated as
> > > > "r".
> > > >
> > > > Since we have the mask (& 0xff), can we drop the `b` suffix from the
> > > > instruction? Or is a revert more appropriate? Or maybe another way to
> > > > skin this cat?
> > >
> > > Figures that such a small change can create problems :-( Sorry for the
> > > thrash!
> > >
> > > The patches in the link below basically add back the cast, but I'm
> > > interested to see if any others can come up with a better fix that
> > > a) passes the above code generation test
> > > b) still keeps sparse happy
> > > c) passes the test module and the code inspection
> > >
> > > If need be I'm OK with a revert of the original patch to fix the issue
> > > in the short term, but it seems to me there must be a way to satisfy
> > > both tools.  We went through several iterations on the way to the final
> > > patch that we might be able to pluck something useful from.
> >
> > For me the below seems to work:
>
> Yep:
> https://github.com/ClangBuiltLinux/linux/issues/961#issuecomment-623785987
> https://github.com/ClangBuiltLinux/linux/issues/961#issuecomment-624162497
> Sedat wrote the same patch 22 days ago; I didn't notice before
> starting this thread.  I will sign off on his patch, add your
> Suggested by tag, and send shortly.

Started a new thread:
https://lore.kernel.org/lkml/20200505174423.199985-1-ndesaulniers@google.com/T/#u

>
> >
> >
> > diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> > index b392571c1f1d1..139122e5b25b1 100644
> > --- a/arch/x86/include/asm/bitops.h
> > +++ b/arch/x86/include/asm/bitops.h
> > @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
> >         if (__builtin_constant_p(nr)) {
> >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> >                         : CONST_MASK_ADDR(nr, addr)
> > -                       : "iq" (CONST_MASK(nr) & 0xff)
> > +                       : "iq" ((u8)(CONST_MASK(nr) & 0xff))
> >                         : "memory");
> >         } else {
> >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> > @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
> >         if (__builtin_constant_p(nr)) {
> >                 asm volatile(LOCK_PREFIX "andb %1,%0"
> >                         : CONST_MASK_ADDR(nr, addr)
> > -                       : "iq" (CONST_MASK(nr) ^ 0xff));
> > +                       : "iq" ((u8)(CONST_MASK(nr) ^ 0xff)));
> >         } else {
> >                 asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
> >                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
