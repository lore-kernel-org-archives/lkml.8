Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B842AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9311020728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzIq+IWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgENNgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:36:12 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B6C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:36:12 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id p127so5040973oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PHyeCO76tbGZ0mePRVZUvflJ0rFtTxZbMOic/9HXzM=;
        b=TzIq+IWZKXT34K6MZNfCK2a7fsUTE1V+Kij8vqp4RsDm4orDA1Cchams2k9m5Q+N1I
         iUaPkEYx/bhBdlTpxJHytp9BeAQRhIlX/asCMKYSiDEzo+OhkYQPqZaCgyO6tdjbjT9W
         nKpsJAK0CL7oHGhnmCcPy1o8cmBcdjGiP1jV++WX7ykjpx/mLVuH97+8G1h/nYRQ7iWE
         /NFVTJNhGeB7u5FWOLYRcUITiXz0Bv4iBmeI4AzQM94pzusBry5ZT09FVgW92TOrC91Z
         5JaZbyEt8DOBnsWBhTK2cuOaqOQbTO2A7X+epBXeDteYHUV4DFlB5Kk4Jz1+MOkRQHDI
         6oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PHyeCO76tbGZ0mePRVZUvflJ0rFtTxZbMOic/9HXzM=;
        b=Nxr2Cr4Kbps1UInrccV3erHsQ2QeDLIEy94KphP0L7bMVBbcn5ny5sy5Dei7NaxJQi
         YHx7WP6pYTpmOHc5d6avhcsbuayLys5jSQ9NMmKldVBFhUJu8WZFY0cojEFV87zcZ5XJ
         zExNjHFqu5FctEErFnOrHbB3pUOj68zni4kdBlGrh1OBrr6khnceNop92okZ5kLc1oLT
         hJrKccMyfVQ8MYOhABwISEbLqT7xZEF1aNHw0ngQ/Op8TNj53B780B9toiPDMgvuMrgE
         hT9GJBBN6HQOtBfc9PH4LEsX7wWr/2VbrBKj2hlliOIb9U31QzMKNtFGWrQYJ1LkCq9r
         gqqw==
X-Gm-Message-State: AOAM5326Lgh4+SCsJrHMZQwhiCvOAX1s2UVMAycEZUPZ1YLftt5Fxu7h
        woEaM8CTts/hjDmOv3gwhgQjtR1g8i7vAWqdr2MvAA==
X-Google-Smtp-Source: ABdhPJy4mVN1kG4sF0jvsu+qYq4LjySp9nA1tJF3fx4WkEwatSMXIe2dt9N5oxcxGSMaObYJhhtySxgrPJU5URAgW2s=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr1520452oih.70.1589463370303;
 Thu, 14 May 2020 06:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck> <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck> <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
In-Reply-To: <20200514110537.GC4280@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 15:35:58 +0200
Message-ID: <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
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

On Thu, 14 May 2020 at 13:05, Will Deacon <will@kernel.org> wrote:
>
> Hi Marco,
>
> On Thu, May 14, 2020 at 09:31:49AM +0200, Marco Elver wrote:
> > Ouch. With the __{READ,WRITE}_ONCE requirement, we're going to need
> > Clang 11 though.
> >
> > Because without the data_race() around __*_ONCE,
> > arch_atomic_{read,set} will be broken for KCSAN, but we can't have
> > data_race() because it would still add
> > kcsan_{enable,disable}_current() calls to __no_sanitize functions (if
> > compilation unit is instrumented). We can't make arch_atomic functions
> > __no_sanitize_or_inline, because even in code that we want to
> > sanitize, they should remain __always_inline (so they work properly in
> > __no_sanitize functions). Therefore, Clang 11 with support for
> > distinguishing volatiles will be the compiler that will satisfy all
> > the constraints.
> >
> > If this is what we want, let me prepare a series on top of
> > -tip/locking/kcsan with all the things I think we need.
>
> Stepping back a second, the locking/kcsan branch is at least functional at
> the moment by virtue of KCSAN_SANITIZE := n being used liberally in
> arch/x86/. However, I still think we want to do better than that because (a)
> it would be good to get more x86 coverage and (b) enabling this for arm64,
> where objtool is not yet available, will be fragile if we have to whitelist
> object files. There's also a fair bit of arm64 low-level code spread around
> drivers/, so it feels like we'd end up with a really bad case of whack-a-mole.
>
> Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
> and the behaviour for __always_inline is:
>
>   * An __always_inline function inlined into a __no_sanitize function is
>     not instrumented
>   * An __always_inline function inlined into an instrumented function is
>     instrumented
>   * You can't mark a function as both __always_inline __no_sanitize, because
>     __no_sanitize functions are never inlined
>
> GCC, on the other hand, may still inline __no_sanitize functions and then
> subsequently instrument them.
>
> So if were willing to make KCSAN depend on Clang >= 7, then we could:
>
>   - Remove the data_race() from __{READ,WRITE}_ONCE()
>   - Wrap arch_atomic*() in data_race() when called from the instrumented
>     atomic wrappers
>
> At which point, I *think* everything works as expected. READ_ONCE_NOCHECK()
> won't generate any surprises, and Peter can happily use arch_atomic()
> from non-instrumented code.
>
> Thoughts? I don't see the need to support buggy compilers when enabling
> a new debug feature.

This is also a reply to
https://lkml.kernel.org/r/20200514122038.GH3001@hirez.programming.kicks-ass.net
-- the problem with __READ_ONCE would be solved with what Will
proposed above.

Let me try to spell out the requirements I see so far (this is for
KCSAN only though -- other sanitizers might be similar):

  1. __no_kcsan functions should not call anything, not even
kcsan_{enable,disable}_current(), when using __{READ,WRITE}_ONCE.
[Requires leaving data_race() off of these.]

  2. __always_inline functions inlined into __no_sanitize function is
not instrumented. [Has always been satisfied by GCC and Clang.]

  3. __always_inline functions inlined into instrumented function is
instrumented. [Has always been satisfied by GCC and Clang.]

  4. __no_kcsan functions should never be spuriously inlined into
instrumented functions, causing the accesses of the __no_kcsan
function to be instrumented. [Satisfied by Clang >= 7. All GCC
versions are broken.]

  5. we should not break atomic_{read,set} for KCSAN. [Because of #1,
we'd need to add data_race() around the arch-calls in
atomic_{read,set}; or rely on Clang 11's -tsan-distinguish-volatile
support (GCC 11 might get this as well).]

  6. never emit __tsan_func_{entry,exit}. [Clang supports disabling
this, GCC doesn't.]

  7. kernel is supported by compiler. [Clang >= 9 seems to build -tip
for me, anything below complains about lack of asm goto. GCC trivial.]

So, because of #4 & #6 & #7 we're down to Clang >= 9. Because of #5
we'll have to make a choice between Clang >= 9 or Clang >= 11
(released in ~June). In an ideal world we might even fix GCC in
future.

That's not even considering the problems around UBSan and KASAN. But
maybe one step at a time?

Any preferences?

Thanks,
-- Marco
