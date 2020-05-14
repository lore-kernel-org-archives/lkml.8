Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B256CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD2820728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589470687;
	bh=HADDSEvSYM4zw3vcg0WmzS8cBrkvJ1Cn20fR5PKx28I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dGhKxB2lalotESMZQmtsXK6irem2RMXgYzNO5ydArS9g/eRdxzKtPL0l/FOcQzkED
	 TGe5siral04HbKFhI1ez3e4/hPq2M+Di/e/LqnpgVPINJBifbBU/HYE3eqhE4FC165
	 +grFBH6vTFioz0QqUjbATnr+I8zRZlUy3rwWpcX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgENPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:38:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEA42065D;
        Thu, 14 May 2020 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589470685;
        bh=HADDSEvSYM4zw3vcg0WmzS8cBrkvJ1Cn20fR5PKx28I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sxhaAf1C2SZlk1NHPF1Rf1P/CHYE5ge7SrNYxcQWAkpzd6FOv+FB0MBvKJRKCPYkI
         /6oRf4lvfrf2KnMoZr9TiGnXJge1FevW8SEEAjcsjt01d/jO+TX36bRV4+VYjBuJXo
         3WNFggHHiHV6qVvQ8E0uAIIm4mmkfUwulqKx9wtw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5620435229C5; Thu, 14 May 2020 08:38:05 -0700 (PDT)
Date:   Thu, 14 May 2020 08:38:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514153805.GK2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
 <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:35:58PM +0200, Marco Elver wrote:
> On Thu, 14 May 2020 at 13:05, Will Deacon <will@kernel.org> wrote:
> >
> > Hi Marco,
> >
> > On Thu, May 14, 2020 at 09:31:49AM +0200, Marco Elver wrote:
> > > Ouch. With the __{READ,WRITE}_ONCE requirement, we're going to need
> > > Clang 11 though.
> > >
> > > Because without the data_race() around __*_ONCE,
> > > arch_atomic_{read,set} will be broken for KCSAN, but we can't have
> > > data_race() because it would still add
> > > kcsan_{enable,disable}_current() calls to __no_sanitize functions (if
> > > compilation unit is instrumented). We can't make arch_atomic functions
> > > __no_sanitize_or_inline, because even in code that we want to
> > > sanitize, they should remain __always_inline (so they work properly in
> > > __no_sanitize functions). Therefore, Clang 11 with support for
> > > distinguishing volatiles will be the compiler that will satisfy all
> > > the constraints.
> > >
> > > If this is what we want, let me prepare a series on top of
> > > -tip/locking/kcsan with all the things I think we need.
> >
> > Stepping back a second, the locking/kcsan branch is at least functional at
> > the moment by virtue of KCSAN_SANITIZE := n being used liberally in
> > arch/x86/. However, I still think we want to do better than that because (a)
> > it would be good to get more x86 coverage and (b) enabling this for arm64,
> > where objtool is not yet available, will be fragile if we have to whitelist
> > object files. There's also a fair bit of arm64 low-level code spread around
> > drivers/, so it feels like we'd end up with a really bad case of whack-a-mole.
> >
> > Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
> > and the behaviour for __always_inline is:
> >
> >   * An __always_inline function inlined into a __no_sanitize function is
> >     not instrumented
> >   * An __always_inline function inlined into an instrumented function is
> >     instrumented
> >   * You can't mark a function as both __always_inline __no_sanitize, because
> >     __no_sanitize functions are never inlined
> >
> > GCC, on the other hand, may still inline __no_sanitize functions and then
> > subsequently instrument them.
> >
> > So if were willing to make KCSAN depend on Clang >= 7, then we could:
> >
> >   - Remove the data_race() from __{READ,WRITE}_ONCE()
> >   - Wrap arch_atomic*() in data_race() when called from the instrumented
> >     atomic wrappers
> >
> > At which point, I *think* everything works as expected. READ_ONCE_NOCHECK()
> > won't generate any surprises, and Peter can happily use arch_atomic()
> > from non-instrumented code.
> >
> > Thoughts? I don't see the need to support buggy compilers when enabling
> > a new debug feature.
> 
> This is also a reply to
> https://lkml.kernel.org/r/20200514122038.GH3001@hirez.programming.kicks-ass.net
> -- the problem with __READ_ONCE would be solved with what Will
> proposed above.
> 
> Let me try to spell out the requirements I see so far (this is for
> KCSAN only though -- other sanitizers might be similar):
> 
>   1. __no_kcsan functions should not call anything, not even
> kcsan_{enable,disable}_current(), when using __{READ,WRITE}_ONCE.
> [Requires leaving data_race() off of these.]
> 
>   2. __always_inline functions inlined into __no_sanitize function is
> not instrumented. [Has always been satisfied by GCC and Clang.]
> 
>   3. __always_inline functions inlined into instrumented function is
> instrumented. [Has always been satisfied by GCC and Clang.]
> 
>   4. __no_kcsan functions should never be spuriously inlined into
> instrumented functions, causing the accesses of the __no_kcsan
> function to be instrumented. [Satisfied by Clang >= 7. All GCC
> versions are broken.]
> 
>   5. we should not break atomic_{read,set} for KCSAN. [Because of #1,
> we'd need to add data_race() around the arch-calls in
> atomic_{read,set}; or rely on Clang 11's -tsan-distinguish-volatile
> support (GCC 11 might get this as well).]
> 
>   6. never emit __tsan_func_{entry,exit}. [Clang supports disabling
> this, GCC doesn't.]
> 
>   7. kernel is supported by compiler. [Clang >= 9 seems to build -tip
> for me, anything below complains about lack of asm goto. GCC trivial.]
> 
> So, because of #4 & #6 & #7 we're down to Clang >= 9. Because of #5
> we'll have to make a choice between Clang >= 9 or Clang >= 11
> (released in ~June). In an ideal world we might even fix GCC in
> future.
> 
> That's not even considering the problems around UBSan and KASAN. But
> maybe one step at a time?
> 
> Any preferences?

I am already having to choose where I run KCSAN based on what compiler
is available, so I cannot argue too hard against a dependency on a
specific compiler.  I reserve the right to ask for help installing it,
if need be though.  ;-)

							Thanx, Paul
