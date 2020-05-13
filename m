Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BA820659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589405129;
	bh=p+DtAyykbmsDurp1X8w3ClCu6UejbGI3qCjwbRbb8gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n42cHuItCAW55fEjImpHW0HHL4ojJqT5EFcExx+sUE/lLi0rSS1heC8GpZGG+h9yC
	 2JDO87xySkrc8jXpror2jQvIWzHkRaRVI9fCudMRV/uaRAg8dUYvjijewh5Ky/7CEL
	 7zQU0qovRoyQeXouMz9voutBcXy97aKh+Ww+E1qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgEMVZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgEMVZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:25:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7035E204EF;
        Wed, 13 May 2020 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589405125;
        bh=p+DtAyykbmsDurp1X8w3ClCu6UejbGI3qCjwbRbb8gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bga7kRO2Eff+WJhrRlXfx2JTqeQNS8myjiDUu2qRz4HzI6d2rGK2ZogsivCu26OId
         d5ve47R83uxe30uHEWiuNoaZfj+C/jkRVfbi9KUl1GxIduXGddHzLGmrvWkPEr/OD0
         IHn1gGKp1FEuOreqeKQyOHltSAcqI0abgovjviyg=
Date:   Wed, 13 May 2020 22:25:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513212520.GC28594@willie-the-truck>
References: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 08:54:03PM +0200, Marco Elver wrote:
> On Wed, 13 May 2020 at 19:47, Will Deacon <will@kernel.org> wrote:
> > On Wed, May 13, 2020 at 07:32:58PM +0200, Marco Elver wrote:
> > > - We do *not* want the call to __read_once_word_nocheck if we have
> > > __no_sanitize_or_inline. AFAIK that's the main problem -- this applies
> > > to both KASAN and KCSAN.
> >
> > Sorry, I should've been more explicit. The code above, with KASAN enabled,
> > compiles to:
> >
> > ffffffff810a2d50 <foo>:
> > ffffffff810a2d50:       48 8b 07                mov    (%rdi),%rax
> > ffffffff810a2d53:       c3                      retq
> >
> > but with KCSAN enabled, compiles to:
> >
> > ffffffff8109ecd0 <foo>:
> > ffffffff8109ecd0:       53                      push   %rbx
> > ffffffff8109ecd1:       48 89 fb                mov    %rdi,%rbx
> > ffffffff8109ecd4:       48 8b 7c 24 08          mov    0x8(%rsp),%rdi
> > ffffffff8109ecd9:       e8 52 9c 1a 00          callq  ffffffff81248930 <__tsan_func_entry>
> > ffffffff8109ecde:       48 89 df                mov    %rbx,%rdi
> > ffffffff8109ece1:       e8 1a 00 00 00          callq  ffffffff8109ed00 <__read_once_word_nocheck>
> > ffffffff8109ece6:       48 89 c3                mov    %rax,%rbx
> > ffffffff8109ece9:       e8 52 9c 1a 00          callq  ffffffff81248940 <__tsan_func_exit>
> > ffffffff8109ecee:       48 89 d8                mov    %rbx,%rax
> > ffffffff8109ecf1:       5b                      pop    %rbx
> > ffffffff8109ecf2:       c3                      retq
> >
> > Is that expected? There don't appear to be any more annotations to throw
> > at it.
> 
> Right, so this is expected.

Fair enough, I just found it weird since it's different to the usual
"disable instrumentation/trace" function annotations.

> We can definitely make __tsan_func_entry/exit disappear with Clang, with
> GCC it's going to be a while if we want to fix it.
> 
> If we remove 'noinline' from __no_kcsan_or_inline, we no longer get
> the call to __read_once_word_nocheck above! But...
> 
> For KCSAN we force 'noinline' because older compilers still inline and
> then instrument small functions even if we just have the no_sanitize
> attribute (without inline mentioned). The same is actually true for
> KASAN, so KASAN's READ_ONCE_NOCHECK might be broken in a few places,
> but nobody seems to have noticed [1]. KASAN's __no_kasan_or_inline
> should also have a 'noinline' I think. I just tested
> __no_kcsan_or_inline without 'noinline', and yes, GCC 9 still decided
> to inline a small function and then instrument the accesses.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59600
> 
> The good news is that Clang does the right thing when removing
> 'noinline' from __no_kcsan_or_inline:
> 1. doesn't inline into functions that are instrumented, and
> 2. your above example doesn't do the call to __read_once_word_nocheck.
> 
> The obvious solution to this is: restrict which compiler we want to support?

I would be in favour of that, but I defer to the x86 folks since this
affects them much more than it does me. On the arm64 side, we've got patches
queued for 5.8 that require GCC 10.0.1 or later, and that thing is only a
week old. I think it's reasonable to require a recent toolchain for optional
features like this that inherently rely on compiler support.

> > > From what I gather, we want to just compile the function as if the
> > > sanitizer was never enabled. One reason for why this doesn't quite
> > > work is because of the preprocessor.
> > >
> > > Note that the sanitizers won't complain about these accesses, which
> > > unfortunately is all these attributes ever were documented to do. So
> > > the attributes aren't completely useless. Why doesn't
> > > K[AC]SAN_SANITIZE := n work?
> >
> > I just don't get the point in having a function annotation if you then have to
> > pass flags at the per-object level. That also then necessitates either weird
> > refactoring and grouping of code into "noinstrument.c" type files, or blanket
> > disabling of instrumentation for things like arch/x86/
> 
> If you want a solution now, here is one way to get us closer to where
> we want to be:
> 
> 1. Peter's patch to add data_race around __READ_ONCE/__WRITE_ONCE.
> 2. Patch to make __tsan_func_entry/exit disappear with Clang.
> 3. Remove 'noinline' from __no_kcsan_or_inline.
> 4. Patch to warn users that KCSAN may have problems with GCC and
> should use Clang >= 7.
> 
> But this is probably only half a solution.

At this point, I think that if READ_ONCE_NOCHECK() works as expected, and
calling __{READ,WRITE}_ONCE from functions tagged with __no_sanitize doesn't
result in instrumentation, then we're good.

Will
