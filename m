Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509CBC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF5520771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJDqMlnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgDQSWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730256AbgDQSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:22:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F48C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:22:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d1so1452892pfh.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTzWguc+avRhOZx3vuoNZJuv5gp1dk41dGxek09V0S4=;
        b=AJDqMlnJghcc05jjEq8rvjOUGi5Mucds8GeYBmkKNwk+yUa+bcjsFBxBBA8mvWmCML
         nO8s0uBolgw3PlKBS7tdPMJzGaK4so5UZpN/3hysW6Jvv174B+fzipgAM6hRiwukIJiy
         In4znBRun0x8hrx31UQqKDR4tmAzKgmWGvaRT1aecEt9InpT62FidRX0omCGHoVPT/uv
         H70fm+SSbsfZqX86uPjT16F+7G+YewmMnaMoACHuojwAmhSMJAl36GXNnO1J40/liAXM
         dkk3o/KKQMcJ00Q3ei6hG1BgovFbuJqWSqFkpXv5PSeO0KtBkhL/n+A514h68ZwzoQ1a
         tMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTzWguc+avRhOZx3vuoNZJuv5gp1dk41dGxek09V0S4=;
        b=oeCv6ua1obeL/nBJ+nLMlzVQKfv9ZhC7RVaIV91RO9lNBgLdaPOm3dM6ctM975Uc8q
         5MNXyeAs0NYmhZ2jWI1uEecNL6IopeKx3ZiYyc/TnfDsFLTLNQUbUlCtP19B6z2EUMzA
         JHXJZL3VvfwRC4zHOcU30NN+0wEaTdqTyabGzjtf83/9/UePt+MJ/IqsNErir041DlDs
         HJzoBI3jZlu56gaE+xZJiCfndZvpv6L1y5lNdc5v1Mk5QzG1Q4hYcsMEykh1k5lHh7cs
         1YaFlgPGZPr24FCgvuk0cQonZ2AqgGwQUKTYHO8rvDBIer+7RabGjn2DFOQjOeHa9jOi
         oLNw==
X-Gm-Message-State: AGi0PuaAYrG4znvyRzUlhz9kEeNTG1kiDwhT+ha/BiiAFIOTXfNfLPL2
        ctFTphyaE+NL3AVGzSKESphTnzu04VCvaMAYEkAqAw==
X-Google-Smtp-Source: APiQypKOFFwxzpmxEHRS8vktzW1oz3hZPQvl5KZ2XY6VJv6bNBkBZ++b3ZJ29OEb+awvcoYCvdDyWQt+v7CbLN6PDFc=
X-Received: by 2002:a62:2a85:: with SMTP id q127mr4440579pfq.108.1587147756918;
 Fri, 17 Apr 2020 11:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200328084858.421444-1-slyfox@gentoo.org> <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de> <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de> <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic> <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic> <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic> <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
In-Reply-To: <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Apr 2020 11:22:25 -0700
Message-ID: <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
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

On Fri, Apr 17, 2020 at 11:15 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Apr 17, 2020 at 2:09 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 17, 2020 at 10:58:59AM +0200, Jakub Jelinek wrote:
> > > On Fri, Apr 17, 2020 at 10:42:24AM +0200, Borislav Petkov wrote:
> > > > On Fri, Apr 17, 2020 at 10:07:26AM +0200, Jakub Jelinek wrote:
> > > > > If you want minimal changes, you can as I said earlier either
> > > > > mark cpu_startup_entry noreturn (in the declaration in some header so that
> > > > > smpboot.c sees it), or you could add something after the cpu_startup_entry
> > > > > call to ensure it is not tail call optimized (e.g. just
> > > > >   /* Prevent tail call to cpu_startup_entry because the stack
> > > > >      protector guard has been changed in the middle of this function
> > > > >      and must not be checked before tail calling another function.  */
> > > > >   asm ("");
> > > >
> > > > That sounds ok-ish to me too.
> > > >
> > > > I know you probably can't tell the future :) but what stops gcc from
> > > > doing the tail-call optimization in the future?
> > > >
> > > > Or are optimization decisions behind an inline asm a no-no and will
> > > > pretty much always stay that way?
> > >
> > > GCC intentionally treats asm as a black box, the only thing which it does
>
> Yep, that's how I would describe how LLVM see's inline asm, too.
>
> > > with it is: non-volatile asm (but asm without outputs is implicitly
> > > volatile) can be CSEd, and if the compiler needs to estimate size, it
> > > uses some heuristics by counting ; and newlines.
> > > And it will stay this way.
>
> I recently implemented parsing support for `asm inline` in Clang; I
> could have sworn I saw code in LLVM parsing newlines for a size
> estimate years ago, but when implementing `asm inline`, I couldn't
> find it.  And test cases I wrote that used the C preprocessor to
> create thousand+ line inline asm strings would always be inlined,
> regardless of the `inline` asm qualifier.
>
> Not sure about implied volatility (...inner stock trader had a laugh
> at that...) for output-less asm statements.
>
> > >
> > > > And I hope the clang folks don't come around and say, err, nope, we're
> > > > much more aggressive here.
> > >
> > > Unlike GCC, I think clang uses the builtin assembler to parse the string,
> > > but don't know if it still treats the asms more like black boxes or not.
> > > Certainly there is a lot of code in the wild that uses inline asm
> > > as optimization barriers, so if it doesn't, then it would cause a lot of
> > > problems.
> > >
> > > Or go with the for (;;);, I don't think any compiler optimizes those away;
> > > GCC 10 for C++ can optimize away infinite loops that have some conditional
> > > exit because the language guarantees forward progress, but the C language
> > > rules are different and for unconditional infinite loops GCC doesn't
> > > optimize them away even if explicitly asked to -ffinite-loops.
> >
> > Lemme add Nick for clang for an opinion:
> >
> > Nick, we're discussing what would be the cleanest and future-proof
> > way to disable stack protector for the function in the kernel which
>
> Oh, this reminds me of commit d0a8d9378d16 ("x86/paravirt: Make
> native_save_fl() extern inline"), where the insertion of stack guards
> was also causing some pain.
>
> The cleanest solution would be to have function attributes that say
> "yes, I know I said -fstack-protector*, but for this one lone function
> I really need -fno-stack-protector.  I know what I'm doing and accept
> whatever the consequences are."  But maybe the attribute would be
> shorter than all that? :P
>
> Compared to playing games with each other's inlining heuristics, that

s/inlining/tail call/

> would be the cleanest and future-proof solution.  (Then we can even
> revert d0a8d9378d16, and use such a function attribute.  I somehow
> prefer gnu_inline's semantics to ISO C99's extern inline semantics,
> and simultaneously hate the problems for which it's used.)
>
> > generates the canary value as gcc10 ends up checking that value due to
> > tail-call optimizing the last function called by start_secondary()...
> > upthread are all the details.
> >
> > And question is, can Jakub's suggestions above prevent tail-call
> > optimization on clang too and how reliable and future proof would that
> > be if we end up going that way?
>
> Sorry, I don't quite follow.  The idea is that an empty asm statement
> in foo() should prevent foo() from being inlined into bar()?

s/inlined/tail called/

> https://godbolt.org/z/7xBRGY

-- 
Thanks,
~Nick Desaulniers
