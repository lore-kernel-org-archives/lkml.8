Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B693C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5C4206F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZEIBK4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgDQSQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730374AbgDQSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:16:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:16:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m21so1409529pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4fHilet2XhDAMF+As9jlarIXgW0hTCmpDKp2MtvP2w=;
        b=QZEIBK4eSGPV8YN8MlsB7I71KNXN2ok9chBy+4GrBVtAKYdqSf4pha5kW+khP77sOC
         F3z8z/BjMv4ZjIOEchErTeyMN1Syni0eXUfKoHV2TpqvCc96yM5VU3zWJ9+5Df2jZt9w
         nTF7H3V08tYe2JdQ9b+D8BTy1d1ozl9R6V+l/WSNrqAOJQyZuB5SNEtEMu/7WaxiArj6
         YOZ+E9WNT3NpmpPJIw1cNRaElB/yF6h2DtP+iHM8fc8r1UyFLfroRfppqSr1qs7eYc2v
         jKWtX/v8WFQwDCJp1qIdhS5RGgtDoiNRpSTGsjHvfzOdwLYZuOH1OHMnj0Z0qvafTjOb
         nrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4fHilet2XhDAMF+As9jlarIXgW0hTCmpDKp2MtvP2w=;
        b=daVjsTMnkFxhys8Ij/4ltaPduZMhFwAsN6CQWhFMOYEQYYDPHm5k6Im9L+hL0mhNmK
         S+23PJvEzO+8MGMz+yG136Y5M10D6TVNxAiaq9O+4Zypzg0CCiVOGHi3y9TXvE9h0pzI
         6fMod4IJyAQ6Mon4qx2u1H6DPcBqgl5GrKlWe0shayNnI+hEp2qSumgKgEhGx9iQydsf
         WcOG8GRK3wzefwqma1f01WHvD59jGPRsZTKqO4v/TVG6irsQnqhVH0MvHJzRXos17OSB
         60FmJw/oRnPPQrQACzh+2ki6eBD4vXo6eClRvKSE7v4VjBA+QXKgFth4yDkStJrIrNCV
         ezkA==
X-Gm-Message-State: AGi0PuZ/l2pF7CzlC0rdp1O3DIkWXNiq+RV7ncfys+CTvsLbnEF4QGqd
        ShjTVP9YNpQCmf/PMUqX3ENnQ8rzmRmFaAWRSt1o9g==
X-Google-Smtp-Source: APiQypIDccu/Yea2pq9i34OAQolt3UlwyzWAw7mQCmyi065788M5BzHUkQLDeKduEa1DDRYoMNDH8f8tYsXnFyS7FII=
X-Received: by 2002:a63:6604:: with SMTP id a4mr4037225pgc.381.1587147368501;
 Fri, 17 Apr 2020 11:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200328084858.421444-1-slyfox@gentoo.org> <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de> <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de> <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic> <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic> <20200417085859.GU2424@tucnak> <20200417090909.GC7322@zn.tnic>
In-Reply-To: <20200417090909.GC7322@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Apr 2020 11:15:56 -0700
Message-ID: <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 2:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 17, 2020 at 10:58:59AM +0200, Jakub Jelinek wrote:
> > On Fri, Apr 17, 2020 at 10:42:24AM +0200, Borislav Petkov wrote:
> > > On Fri, Apr 17, 2020 at 10:07:26AM +0200, Jakub Jelinek wrote:
> > > > If you want minimal changes, you can as I said earlier either
> > > > mark cpu_startup_entry noreturn (in the declaration in some header so that
> > > > smpboot.c sees it), or you could add something after the cpu_startup_entry
> > > > call to ensure it is not tail call optimized (e.g. just
> > > >   /* Prevent tail call to cpu_startup_entry because the stack
> > > >      protector guard has been changed in the middle of this function
> > > >      and must not be checked before tail calling another function.  */
> > > >   asm ("");
> > >
> > > That sounds ok-ish to me too.
> > >
> > > I know you probably can't tell the future :) but what stops gcc from
> > > doing the tail-call optimization in the future?
> > >
> > > Or are optimization decisions behind an inline asm a no-no and will
> > > pretty much always stay that way?
> >
> > GCC intentionally treats asm as a black box, the only thing which it does

Yep, that's how I would describe how LLVM see's inline asm, too.

> > with it is: non-volatile asm (but asm without outputs is implicitly
> > volatile) can be CSEd, and if the compiler needs to estimate size, it
> > uses some heuristics by counting ; and newlines.
> > And it will stay this way.

I recently implemented parsing support for `asm inline` in Clang; I
could have sworn I saw code in LLVM parsing newlines for a size
estimate years ago, but when implementing `asm inline`, I couldn't
find it.  And test cases I wrote that used the C preprocessor to
create thousand+ line inline asm strings would always be inlined,
regardless of the `inline` asm qualifier.

Not sure about implied volatility (...inner stock trader had a laugh
at that...) for output-less asm statements.

> >
> > > And I hope the clang folks don't come around and say, err, nope, we're
> > > much more aggressive here.
> >
> > Unlike GCC, I think clang uses the builtin assembler to parse the string,
> > but don't know if it still treats the asms more like black boxes or not.
> > Certainly there is a lot of code in the wild that uses inline asm
> > as optimization barriers, so if it doesn't, then it would cause a lot of
> > problems.
> >
> > Or go with the for (;;);, I don't think any compiler optimizes those away;
> > GCC 10 for C++ can optimize away infinite loops that have some conditional
> > exit because the language guarantees forward progress, but the C language
> > rules are different and for unconditional infinite loops GCC doesn't
> > optimize them away even if explicitly asked to -ffinite-loops.
>
> Lemme add Nick for clang for an opinion:
>
> Nick, we're discussing what would be the cleanest and future-proof
> way to disable stack protector for the function in the kernel which

Oh, this reminds me of commit d0a8d9378d16 ("x86/paravirt: Make
native_save_fl() extern inline"), where the insertion of stack guards
was also causing some pain.

The cleanest solution would be to have function attributes that say
"yes, I know I said -fstack-protector*, but for this one lone function
I really need -fno-stack-protector.  I know what I'm doing and accept
whatever the consequences are."  But maybe the attribute would be
shorter than all that? :P

Compared to playing games with each other's inlining heuristics, that
would be the cleanest and future-proof solution.  (Then we can even
revert d0a8d9378d16, and use such a function attribute.  I somehow
prefer gnu_inline's semantics to ISO C99's extern inline semantics,
and simultaneously hate the problems for which it's used.)

> generates the canary value as gcc10 ends up checking that value due to
> tail-call optimizing the last function called by start_secondary()...
> upthread are all the details.
>
> And question is, can Jakub's suggestions above prevent tail-call
> optimization on clang too and how reliable and future proof would that
> be if we end up going that way?

Sorry, I don't quite follow.  The idea is that an empty asm statement
in foo() should prevent foo() from being inlined into bar()?
https://godbolt.org/z/7xBRGY
-- 
Thanks,
~Nick Desaulniers
