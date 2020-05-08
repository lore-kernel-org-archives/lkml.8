Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34973C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B5821775
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uz6CQxh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEHRWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEHRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:22:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5412C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 10:22:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so4630008pjw.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDmOxQMCuaw5F6/Weoldmrv8lAutINkccOcvV//08Lo=;
        b=uz6CQxh4gx44MIkOb4uoPsulQcoadM4lvLN8PW4twq6GXEyiBPwb4BpfSqGisSWHU8
         KgUz23Sy4OHg4McVtDGkn1shgfffYfuSoTyYAp3cSjJqjMzB/uChi69dqKS3z0+CIhSX
         DpqZWBMvLuY6Yy9OqKHgQOFn+0nNEXzJKOl4XRO+5kH9YpeoVN2u+KziL+wT3kg7kobt
         8HspgqpP3STPysPB9h+RHLEusRGic/V2t62HNpOYC6ZiqEU3ZLZp0oRdcKkmTrdWrNjD
         yEU6b7VACRfdgG7SsFhLBl9kmiNt3HJy5MaLxj3VP16jk5qCLTutzRyTzSlcDNAOnAEQ
         qndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDmOxQMCuaw5F6/Weoldmrv8lAutINkccOcvV//08Lo=;
        b=iIPs3BPt+2rMO1zs0NQyaut7c3l3nG5fJbqEqM3A2w/3EOaPmCYNmRumQ8AAG8mXWO
         No4kwXP6mq3XyOWMs60JxM6B/w1dFV2B5HlAMVmS83Q4FV31gLpw70uR5WmP4ymc9AJC
         551WQwyUJU6pY4woz8PRyMZ8A+L8qSuTd0+lbkE7Wx7cjgI8l7fEvibrfe2jfDa7QZ6n
         MaZfu+s1CB3ZbkrXPiRgOhvs/CHl2pNmQFuwaWHqWdLmjYUtT6U9rHLTHrXjGuUhHPMo
         3HHzGj/8vBj8FSjH7Zgwj614ULQmFXXyexxJdWrv8ayXkiP1WNboIJyKqK24lPpyZFg5
         +FSQ==
X-Gm-Message-State: AGi0PuaUqBKzCs/IB6ET1McHsWUcWBcf/Db/0o2UmACwevFkxxm+NGsr
        td3XfjdOfSqu9dl9MzpEZSrupvo/IEfLO3WEu7MvAQ==
X-Google-Smtp-Source: APiQypISgtnD5NDGHv3g6yn5klP9hv3kXnvW9OyaSiLskvc+++YwjPnOVL60aWHLauimVX8osi0SRQ8ElmR15zyuNn0=
X-Received: by 2002:a17:90b:2302:: with SMTP id mt2mr3301097pjb.25.1588958519887;
 Fri, 08 May 2020 10:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com>
 <8A776DBC-03AF-485B-9AA6-5920E3C4ACB2@zytor.com> <20200507113422.GA3762@hirez.programming.kicks-ass.net>
 <CAMzpN2hXUYvLuTA63N56ef4DEzyWXt_uVVq6PV0r8YQT-YN42g@mail.gmail.com>
 <CAKwvOd=a3MR7osKBpbq=d41ieo7G9FtOp5Kok5por1P5ZS9s4g@mail.gmail.com>
 <CAKwvOd=Ogbp0oVgmF2B9cePjyWnvLLFRSp2EnaonA-ZFN3K7Dg@mail.gmail.com> <CAMzpN2gu4stkRKTsMTVxyzckO3SMhfA+dmCnSu6-aMg5QAA_JQ@mail.gmail.com>
In-Reply-To: <CAMzpN2gu4stkRKTsMTVxyzckO3SMhfA+dmCnSu6-aMg5QAA_JQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 May 2020 10:21:48 -0700
Message-ID: <CAKwvOd=hVKrFU+imSGeX+MEKMpW97gE7bzn1C637qdns9KSnUA@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        stable <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 6:57 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Thu, May 7, 2020 at 6:29 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Thu, May 7, 2020 at 12:19 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Thu, May 7, 2020 at 7:00 AM Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > This change will make sparse happy and allow these cleanups:
> > > > #define CONST_MASK(nr)                 ((u8)1 << ((nr) & 7))
> > >
> > > yep, this is more elegant, IMO.  Will send a v3 later with this
> > > change.  Looking at the uses of CONST_MASK, I noticed
> > > arch_change_bit() currently has the (u8) cast from commit
> > > 838e8bb71dc0c ("x86: Implement change_bit with immediate operand as
> > > "lock xorb""), so that instance can get cleaned up with the above
> > > suggestion.
> >
> > Oh, we need the cast to be the final operation.  The binary AND and
> > XOR in 2 of the 3 uses of CONST_MASK implicitly promote the operands
> > of the binary operand to int, so the type of the evaluated
> > subexpression is int.
> > https://wiki.sei.cmu.edu/confluence/display/c/EXP14-C.+Beware+of+integer+promotion+when+performing+bitwise+operations+on+integer+types+smaller+than+int
> > So I think this version (v2) is most precise fix, and would be better
> > than defining more macros or (worse) using metaprogramming.
>
> One last suggestion.  Add the "b" modifier to the mask operand: "orb
> %b1, %0".  That forces the compiler to use the 8-bit register name
> instead of trying to deduce the width from the input.

Ah right: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers

Looks like that works for both compilers.  In that case, we can likely
drop the `& 0xff`, too.  Let me play with that, then I'll hopefully
send a v3 today.
-- 
Thanks,
~Nick Desaulniers
