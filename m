Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32843C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104E92063B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/LHvFU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgEMNQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgEMNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:16:08 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B4CC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:16:08 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 63so5967510oto.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccPCDIGO/E8Bs4gAGfnutXW1wbp7wpweTm7DNmF97Nw=;
        b=t/LHvFU/22qCKVdWh9xY8l9LFSJBwOw/eZn/HBv6h4Qe2s4rNjQLY2ENX8Jo+NsECz
         r1LThDjUDgu+VJXlpDwLUWuBvhVsMnfYwWkJkGtnkFcF4iDa5CPj0RQCVUSXQ6yIGPWb
         76i5G37gPIlhqXpFEvAOsY5bf86SFFObY3u4phokCQ4bVO4JCg+W0ARwxFug2zG+OH4N
         Ktq8uyXEWvfQFova71p+/rDoK9hzllf+i1DjMkrb7/e4UIuIu91xxz5wAu68OoIZU7Nr
         n8dtiUFuHBnuxx71p9bT52roE/oZTXbX20xKY4NJh6e+NTr1qbXZMlXOCuDYVIAKG2Lf
         RY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccPCDIGO/E8Bs4gAGfnutXW1wbp7wpweTm7DNmF97Nw=;
        b=UKpV5JmeS2BwsbVbv2s0d7RkpgLflyBPlykxZnU0RRZWwNo0ZuwpfP2aMWSbBDZLXE
         uGWbuEf/Ut0Ve88pstDIFbTAMSha3UWrHuojmL3bL54M48OBWEhOcmBRDDyy/N5kXuGW
         jYWkeFXqw5To34zzgotPvMLjVkQ87sKkO5tVB66T1ovSVdyF7pIbKC1HOkuRWMqhiChW
         tXifb80mcNKzWp/EKafAfUvteI7K+qLTcv1MAVX6IVneka9c6zq9Zdfudxa+6Je7ecPm
         SICEX4I9RMaC87Kv7bob8Zoe6nza81u6pZtuw1vL+pJT536iIFTVxqx7r1X0H3XTbPjM
         762Q==
X-Gm-Message-State: AGi0PuYQdafx2/kKRfLOkawSWKW0aW+GjmZagY0YIAyUQUZCo+5Bfzg4
        egsuAeA4sWeYY28MZ29Y4bDNVaf8bh1oEXcxR8hh0g==
X-Google-Smtp-Source: APiQypIMkoCciwZAOXcVOojQKF+oiavenoPo/xqs+F9WhUjaeoopzMjXUIpyUoN9jNkKnBAzfK+a9fIveMXmGFuQemE=
X-Received: by 2002:a9d:4a:: with SMTP id 68mr8825172ota.17.1589375767383;
 Wed, 13 May 2020 06:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net> <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
In-Reply-To: <20200513124021.GB20278@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 May 2020 15:15:55 +0200
Message-ID: <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
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

On Wed, 13 May 2020 at 14:40, Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> >
> > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > > compiler-friendlier version).
> > >
> > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > > now.
>
> I agree that Peter's patch is the right thing to do for now. I was hoping we
> could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
> __no_sanitize_or_inline doesn't seem to do anything.
>
> > Right, if/when people want sanitize crud enabled for x86 I need
> > something that:
> >
> >  - can mark a function 'no_sanitize' and all code that gets inlined into
> >    that function must automagically also not get sanitized. ie. make
> >    inline work like macros (again).
> >
> > And optionally:
> >
> >  - can mark a function explicitly 'sanitize', and only when an explicit
> >    sanitize and no_sanitize mix in inlining give the current
> >    incompatible attribute splat.
> >
> > That way we can have the noinstr function attribute imply no_sanitize
> > and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
> > helper instead of __always_inline for __##func().
>
> Sounds like a good plan to me, assuming the compiler folks are onboard.
> In the meantime, can we kill __no_sanitize_or_inline and put it back to
> the old __no_kasan_or_inline, which I think simplifies compiler.h and
> doesn't mislead people into using the function annotation to avoid KCSAN?
>
> READ_ONCE_NOCHECK should also probably be READ_ONCE_NOKASAN, but I
> appreciate that's a noisier change.

So far so good, except: both __no_sanitize_or_inline and
__no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
just doesn't avoid explicit kcsan_check calls, like those in
READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
just because macros won't be redefined just for __no_sanitize
functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
access is unchecked.

This will have the expected result:
__no_sanitize_or_inline void foo(void) { x++; } // no data races reported

This will not work as expected:
__no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
races are reported

All this could be fixed if GCC devs would finally take my patch to
make -fsanitize=thread distinguish volatile [1], but then we have to
wait ~years for the new compilers to reach us. So please don't hold
your breath for this one any time soon.
[1] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html

Thanks,
-- Marco
