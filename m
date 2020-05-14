Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9610205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbv/fV3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgENHcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgENHcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:32:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08770C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:32:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a68so1571818otb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDd4Rya0WtESVLejzRMWQV2qXkAC8qyHcifrucwzAGY=;
        b=bbv/fV3XZUXpGw+d7/urjYA1UazneWXU7wsbIaZBLiWvFLJsL5TubY/hp3rsi95mSA
         o1zUEhF3Z9cFuurIZZUb7yiqrkPCUYyg+oXq+JsIyofXzC4r24TXk5QbO2KiEFLTcHsB
         dlGdLPvdA+iW+zcdQeN9ASIMStsWRB2IQZPLA/5Fvu4rFokznL+ENSciOhyG8kgidkYv
         i+v8z/26aFwFj7BMD7V65mMMLj1FKk/gFLaZjfwhbakCn8fvxA1/XLeR2s2mqrJ6MbQH
         ecigU5D6eXJ6bZYFY8dNHPTvGrBq1pJWHUfx7BtcJgoACZ+Nr5pl229qNEWrnlJyltrP
         Z2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDd4Rya0WtESVLejzRMWQV2qXkAC8qyHcifrucwzAGY=;
        b=btGTHF4oaxCFvr3A+Fb8R6qHwuOHjiPoSNI1nlaAEoTvA8b/KTnTG2nFp8PdLREuwM
         npnro5xu9zRYcCOYCiIDUmhksvm2bMIFbE+f6WoOZLhOe62FdRIP6S8isW+TJewXinCM
         2qJ9ww4Bm7KNABU5BAJMinPnP76cXuLAm0YvhLxHQ+Sggp0sRI/yakjfctdHPBZo8js/
         Ti3gWY3ZRw0z1s0dKJuvO6UQCK0pJbOHO6bB+2QvVx7l0f8t8kQLvISCqSdg3VE8z793
         qD098DJxcTPj7pSBhtI6Jtdvyr/SP0EoqYL1DCmK6awhXFvJVTGyxRbpGAomKCobo1m5
         SBIA==
X-Gm-Message-State: AOAM531Ore3pd/avX+6KEs9rRe9StoTKcmqol83R/CgY5402qIXOANfk
        NtimcxycURCuqBY8GIhk/Kut/VwZkZVKKuHONJ0ZhA==
X-Google-Smtp-Source: ABdhPJy49TXyLKS76Fgbb71HXjT+M69ADiP8S44hTcqo8BI5i85Oz2jHGYXuq38LuOu3VouKtOcFWYeoscbTATs3KBA=
X-Received: by 2002:a9d:7608:: with SMTP id k8mr2640435otl.233.1589441520853;
 Thu, 14 May 2020 00:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck> <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
In-Reply-To: <20200513212520.GC28594@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 09:31:49 +0200
Message-ID: <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
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

On Wed, 13 May 2020 at 23:25, Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 08:54:03PM +0200, Marco Elver wrote:
> > On Wed, 13 May 2020 at 19:47, Will Deacon <will@kernel.org> wrote:
> > > On Wed, May 13, 2020 at 07:32:58PM +0200, Marco Elver wrote:
> > > > - We do *not* want the call to __read_once_word_nocheck if we have
> > > > __no_sanitize_or_inline. AFAIK that's the main problem -- this applies
> > > > to both KASAN and KCSAN.
> > >
> > > Sorry, I should've been more explicit. The code above, with KASAN enabled,
> > > compiles to:
> > >
> > > ffffffff810a2d50 <foo>:
> > > ffffffff810a2d50:       48 8b 07                mov    (%rdi),%rax
> > > ffffffff810a2d53:       c3                      retq
> > >
> > > but with KCSAN enabled, compiles to:
> > >
> > > ffffffff8109ecd0 <foo>:
> > > ffffffff8109ecd0:       53                      push   %rbx
> > > ffffffff8109ecd1:       48 89 fb                mov    %rdi,%rbx
> > > ffffffff8109ecd4:       48 8b 7c 24 08          mov    0x8(%rsp),%rdi
> > > ffffffff8109ecd9:       e8 52 9c 1a 00          callq  ffffffff81248930 <__tsan_func_entry>
> > > ffffffff8109ecde:       48 89 df                mov    %rbx,%rdi
> > > ffffffff8109ece1:       e8 1a 00 00 00          callq  ffffffff8109ed00 <__read_once_word_nocheck>
> > > ffffffff8109ece6:       48 89 c3                mov    %rax,%rbx
> > > ffffffff8109ece9:       e8 52 9c 1a 00          callq  ffffffff81248940 <__tsan_func_exit>
> > > ffffffff8109ecee:       48 89 d8                mov    %rbx,%rax
> > > ffffffff8109ecf1:       5b                      pop    %rbx
> > > ffffffff8109ecf2:       c3                      retq
> > >
> > > Is that expected? There don't appear to be any more annotations to throw
> > > at it.
> >
> > Right, so this is expected.
>
> Fair enough, I just found it weird since it's different to the usual
> "disable instrumentation/trace" function annotations.
>
> > We can definitely make __tsan_func_entry/exit disappear with Clang, with
> > GCC it's going to be a while if we want to fix it.
> >
> > If we remove 'noinline' from __no_kcsan_or_inline, we no longer get
> > the call to __read_once_word_nocheck above! But...
> >
> > For KCSAN we force 'noinline' because older compilers still inline and
> > then instrument small functions even if we just have the no_sanitize
> > attribute (without inline mentioned). The same is actually true for
> > KASAN, so KASAN's READ_ONCE_NOCHECK might be broken in a few places,
> > but nobody seems to have noticed [1]. KASAN's __no_kasan_or_inline
> > should also have a 'noinline' I think. I just tested
> > __no_kcsan_or_inline without 'noinline', and yes, GCC 9 still decided
> > to inline a small function and then instrument the accesses.
> >
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59600
> >
> > The good news is that Clang does the right thing when removing
> > 'noinline' from __no_kcsan_or_inline:
> > 1. doesn't inline into functions that are instrumented, and
> > 2. your above example doesn't do the call to __read_once_word_nocheck.
> >
> > The obvious solution to this is: restrict which compiler we want to support?
>
> I would be in favour of that, but I defer to the x86 folks since this
> affects them much more than it does me. On the arm64 side, we've got patches
> queued for 5.8 that require GCC 10.0.1 or later, and that thing is only a
> week old. I think it's reasonable to require a recent toolchain for optional
> features like this that inherently rely on compiler support.
>
> > > > From what I gather, we want to just compile the function as if the
> > > > sanitizer was never enabled. One reason for why this doesn't quite
> > > > work is because of the preprocessor.
> > > >
> > > > Note that the sanitizers won't complain about these accesses, which
> > > > unfortunately is all these attributes ever were documented to do. So
> > > > the attributes aren't completely useless. Why doesn't
> > > > K[AC]SAN_SANITIZE := n work?
> > >
> > > I just don't get the point in having a function annotation if you then have to
> > > pass flags at the per-object level. That also then necessitates either weird
> > > refactoring and grouping of code into "noinstrument.c" type files, or blanket
> > > disabling of instrumentation for things like arch/x86/
> >
> > If you want a solution now, here is one way to get us closer to where
> > we want to be:
> >
> > 1. Peter's patch to add data_race around __READ_ONCE/__WRITE_ONCE.
> > 2. Patch to make __tsan_func_entry/exit disappear with Clang.
> > 3. Remove 'noinline' from __no_kcsan_or_inline.
> > 4. Patch to warn users that KCSAN may have problems with GCC and
> > should use Clang >= 7.
> >
> > But this is probably only half a solution.
>
> At this point, I think that if READ_ONCE_NOCHECK() works as expected, and
> calling __{READ,WRITE}_ONCE from functions tagged with __no_sanitize doesn't
> result in instrumentation, then we're good.

Ouch. With the __{READ,WRITE}_ONCE requirement, we're going to need
Clang 11 though.

Because without the data_race() around __*_ONCE,
arch_atomic_{read,set} will be broken for KCSAN, but we can't have
data_race() because it would still add
kcsan_{enable,disable}_current() calls to __no_sanitize functions (if
compilation unit is instrumented). We can't make arch_atomic functions
__no_sanitize_or_inline, because even in code that we want to
sanitize, they should remain __always_inline (so they work properly in
__no_sanitize functions). Therefore, Clang 11 with support for
distinguishing volatiles will be the compiler that will satisfy all
the constraints.

If this is what we want, let me prepare a series on top of
-tip/locking/kcsan with all the things I think we need.

Thanks,
-- Marco
