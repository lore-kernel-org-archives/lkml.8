Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F467C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD3A2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0hFgAey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbgEMSyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387525AbgEMSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:54:16 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:54:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i13so22354023oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaU1piNgtu2SnvMnz//vmEc1f66dlNmjBvEN+0PEHtg=;
        b=R0hFgAeyslYP/KBoLPSYjihXUMsjMvEhlWusOFRj3SR52srntiNCJTaZoi0aQC1iLd
         cOrp78ecrbafjsnPiqY9eaXzpbVebDVSURlZY5TxO5E6FgdDLaHHKid1yrP6CBjdRrH3
         Yktx2O8kkll93miR9MtbPmpxdBu7g3zmH1hGrqWxE5QtJiTV6S8fJrRs4F7kkkTtiEB/
         gQQgQ1L8piLwz5+xXqX6+QRy4qpGS7PI4vtXf9KMo4C0AhGF9RmOvMSBGZMqSO8ilMMA
         oWcTcYGIfre7QK7nGO0unRCzhVqj2C7UeFZcp0ePsKsKuBcSX3+PtpbJSqMza+HAdwl7
         eS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaU1piNgtu2SnvMnz//vmEc1f66dlNmjBvEN+0PEHtg=;
        b=GfFMrsG8nC5fl6neXAFr67phFaSrBBFDO9kThV6XvWkr8ovDDsC70GKNcYa7oDnEZ+
         cM732ByYmFCiSCLnKw4F1/g0sMJrDKW6NjoM1o9qv4IdDrHXvIVZ5nX5pjPL6u/AAaov
         eolbvSwGJ86qm8k/enLkLkXxe+NqS8rjapGpl1QIAvwg41HMHGs09DPFIu3hHOQ3b6iU
         B1zc1D8M2uSfuOc7aEPJzlzm0Yuc5/oCAlTL934BtPZDPJsb9k5LHP1MkG3kYckoQ8mK
         zjYq+IcIQ0E6ql/BaBR6sSht+TtrZiqHHaJ2xmdjelBNHRIyICRPR4gu7evwaXpeAuPS
         l1kA==
X-Gm-Message-State: AGi0PuYLYXJVTP2KXT0nh5aPuiFEtMOzLcTULm/NBT6OfhCz0bAU4mh6
        8R8kR6zFsTp5ePzlsHUlOd1xwhef2x23s4FOHV01dQ==
X-Google-Smtp-Source: APiQypJkzOj/zyGSkg6+YqmuBJ/FEim+Uxp+Hp1WvVonhL9el+FfCXq4IIGT/nyBNkj1QxZadjLVkYElzPd5XfAuDf4=
X-Received: by 2002:aca:c646:: with SMTP id w67mr28927106oif.70.1589396055633;
 Wed, 13 May 2020 11:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net> <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
In-Reply-To: <20200513174747.GB24836@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 May 2020 20:54:03 +0200
Message-ID: <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 19:47, Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 07:32:58PM +0200, Marco Elver wrote:
> > On Wed, 13 May 2020 at 18:50, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > > > On Wed, 13 May 2020 at 14:40, Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> > > > > > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> > > > > >
> > > > > > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > > > > > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > > > > > > compiler-friendlier version).
> > > > > > >
> > > > > > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > > > > > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > > > > > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > > > > > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > > > > > > now.
> > > > >
> > > > > I agree that Peter's patch is the right thing to do for now. I was hoping we
> > > > > could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
> > > > > __no_sanitize_or_inline doesn't seem to do anything.
> > > > >
> > > > > > Right, if/when people want sanitize crud enabled for x86 I need
> > > > > > something that:
> > > > > >
> > > > > >  - can mark a function 'no_sanitize' and all code that gets inlined into
> > > > > >    that function must automagically also not get sanitized. ie. make
> > > > > >    inline work like macros (again).
> > > > > >
> > > > > > And optionally:
> > > > > >
> > > > > >  - can mark a function explicitly 'sanitize', and only when an explicit
> > > > > >    sanitize and no_sanitize mix in inlining give the current
> > > > > >    incompatible attribute splat.
> > > > > >
> > > > > > That way we can have the noinstr function attribute imply no_sanitize
> > > > > > and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
> > > > > > helper instead of __always_inline for __##func().
> > > > >
> > > > > Sounds like a good plan to me, assuming the compiler folks are onboard.
> > > > > In the meantime, can we kill __no_sanitize_or_inline and put it back to
> > > > > the old __no_kasan_or_inline, which I think simplifies compiler.h and
> > > > > doesn't mislead people into using the function annotation to avoid KCSAN?
> > > > >
> > > > > READ_ONCE_NOCHECK should also probably be READ_ONCE_NOKASAN, but I
> > > > > appreciate that's a noisier change.
> > > >
> > > > So far so good, except: both __no_sanitize_or_inline and
> > > > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > > > just doesn't avoid explicit kcsan_check calls, like those in
> > > > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > > > just because macros won't be redefined just for __no_sanitize
> > > > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > > > access is unchecked.
> > > >
> > > > This will have the expected result:
> > > > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> > > >
> > > > This will not work as expected:
> > > > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > > > races are reported
> > >
> > > But the problem is that *this* does not work as expected:
> > >
> > > unsigned long __no_sanitize_or_inline foo(unsigned long *ptr)
> > > {
> > >         return READ_ONCE_NOCHECK(*ptr);
> > > }
> > >
> > > which I think means that the function annotation is practically useless.
> >
> > Let me understand the problem better:
> >
> > - We do not want __tsan_func_entry/exit (looking at the disassembly,
> > these aren't always generated).
> > - We do not want kcsan_disable/enable calls (with the new __READ_ONCE version).
> > - We do *not* want the call to __read_once_word_nocheck if we have
> > __no_sanitize_or_inline. AFAIK that's the main problem -- this applies
> > to both KASAN and KCSAN.
>
> Sorry, I should've been more explicit. The code above, with KASAN enabled,
> compiles to:
>
> ffffffff810a2d50 <foo>:
> ffffffff810a2d50:       48 8b 07                mov    (%rdi),%rax
> ffffffff810a2d53:       c3                      retq
>
> but with KCSAN enabled, compiles to:
>
> ffffffff8109ecd0 <foo>:
> ffffffff8109ecd0:       53                      push   %rbx
> ffffffff8109ecd1:       48 89 fb                mov    %rdi,%rbx
> ffffffff8109ecd4:       48 8b 7c 24 08          mov    0x8(%rsp),%rdi
> ffffffff8109ecd9:       e8 52 9c 1a 00          callq  ffffffff81248930 <__tsan_func_entry>
> ffffffff8109ecde:       48 89 df                mov    %rbx,%rdi
> ffffffff8109ece1:       e8 1a 00 00 00          callq  ffffffff8109ed00 <__read_once_word_nocheck>
> ffffffff8109ece6:       48 89 c3                mov    %rax,%rbx
> ffffffff8109ece9:       e8 52 9c 1a 00          callq  ffffffff81248940 <__tsan_func_exit>
> ffffffff8109ecee:       48 89 d8                mov    %rbx,%rax
> ffffffff8109ecf1:       5b                      pop    %rbx
> ffffffff8109ecf2:       c3                      retq
>
> Is that expected? There don't appear to be any more annotations to throw
> at it.

Right, so this is expected. We can definitely make
__tsan_func_entry/exit disappear with Clang, with GCC it's going to be
a while if we want to fix it.

If we remove 'noinline' from __no_kcsan_or_inline, we no longer get
the call to __read_once_word_nocheck above! But...

For KCSAN we force 'noinline' because older compilers still inline and
then instrument small functions even if we just have the no_sanitize
attribute (without inline mentioned). The same is actually true for
KASAN, so KASAN's READ_ONCE_NOCHECK might be broken in a few places,
but nobody seems to have noticed [1]. KASAN's __no_kasan_or_inline
should also have a 'noinline' I think. I just tested
__no_kcsan_or_inline without 'noinline', and yes, GCC 9 still decided
to inline a small function and then instrument the accesses.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59600

The good news is that Clang does the right thing when removing
'noinline' from __no_kcsan_or_inline:
1. doesn't inline into functions that are instrumented, and
2. your above example doesn't do the call to __read_once_word_nocheck.

The obvious solution to this is: restrict which compiler we want to support?

> > From what I gather, we want to just compile the function as if the
> > sanitizer was never enabled. One reason for why this doesn't quite
> > work is because of the preprocessor.
> >
> > Note that the sanitizers won't complain about these accesses, which
> > unfortunately is all these attributes ever were documented to do. So
> > the attributes aren't completely useless. Why doesn't
> > K[AC]SAN_SANITIZE := n work?
>
> I just don't get the point in having a function annotation if you then have to
> pass flags at the per-object level. That also then necessitates either weird
> refactoring and grouping of code into "noinstrument.c" type files, or blanket
> disabling of instrumentation for things like arch/x86/

If you want a solution now, here is one way to get us closer to where
we want to be:

1. Peter's patch to add data_race around __READ_ONCE/__WRITE_ONCE.
2. Patch to make __tsan_func_entry/exit disappear with Clang.
3. Remove 'noinline' from __no_kcsan_or_inline.
4. Patch to warn users that KCSAN may have problems with GCC and
should use Clang >= 7.

But this is probably only half a solution.

If you *also* want to fix __READ_ONCE etc not adding calls to
__no_sanitize functions:

5. Remove any mention of data_race and kcsan_check calls from
__{READ,WRITE}_ONCE, {READ,WRITE}_ONCE.  [Won't need #1 above.]
6. I'll send a patch to make KCSAN distinguish volatile accesses, and
we will require Clang 11.

That is *if* you insist on __no_sanitize to behave like you suggest.
Note that, at that point, I really don't know how to salvage GCC,
mainly because of fixing __no_sanitize with GCC looking hopeless.

Let me know what you prefer.

Thanks,
-- Marco
