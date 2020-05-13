Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A77C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979522053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MACjcKxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgEMRdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732731AbgEMRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:33:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CFC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:33:11 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so22142320oij.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5URQDVJ0OJgkUBVgo9LJHhrcH0w9H6w22wE2jqHP2I=;
        b=MACjcKxYEpiW1qu6nTHgoiRVE3Xv0EC8F+Fvf+T+VDnmCttoLWMRwHuNCVRd9EHL3n
         IG4+f5l4PgLFx1zKZl7eaDV9UcijtO6Bu7gkSKPJBksdpnlho4TybxwNL4V0FXURXtfI
         rrD5fUCV4JMs51FLuYXnQzCChUd1MBL36sRWLX9hw2JqLZ8RlADh7MPCcRkGSi9fRHaB
         QXkbiozoMZugIugaW45l3XnKcyRWbFORkCHGWoiJPRru+X3Bm4m2uj77tdtLPMXScXq6
         AC8gzqSWhNv4/ALlQkC84sVi+k9Hhg0K+8kKUDQ2pSqYEUE/gHHYsXbat6q9b//2cTXH
         x8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5URQDVJ0OJgkUBVgo9LJHhrcH0w9H6w22wE2jqHP2I=;
        b=TXp35aB240cj5hYBc5z5gnPXGaWv909YxrammQNbjAyeBFZVBOyl64rcoF8yLbO8Iw
         oNR8nRco0PvCN+bd7cRdVTPMbvveJa/iKwUfcejoGxeVyOaQcpwxjtNGH4ckMtFKd9BR
         cyfR/1SFVAeJu1bPvLph3yhl1Xi0kRClSwVKpskIwmT6qD1mYa5eCcRDwmFSxjayDdDm
         W9u1tTFXeuFJjVXv4kjrAnbwHE12+V9CUGS+iLzMk2zYrTE4GrjZeXwenUiOUFB3NcuO
         1KkXVBTVxoe/koAWOHLZ2gHHS+lpOekHq8ckJ44LCLXfTDpwYb62KBqHBkR31LLrEwpp
         g87g==
X-Gm-Message-State: AGi0PubBclCONk1xBpOQjyc1JFntdJqlDo51py5X6sBcsEji95H9Nu8D
        VuQj/2pn8KLQSkVAkXC1iB9UXycSOCakvVtFjPs7s1uvVCI=
X-Google-Smtp-Source: APiQypL96rxMFrjaxTn+hcNwpFZkeMNO3R8zvJa3WCuaRSmr2beh2j2JM3rciMH3rjJpN5Jf6V9BSN3dJYZFDQfg/+k=
X-Received: by 2002:aca:3254:: with SMTP id y81mr7875547oiy.172.1589391190705;
 Wed, 13 May 2020 10:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net> <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com> <20200513165008.GA24836@willie-the-truck>
In-Reply-To: <20200513165008.GA24836@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 May 2020 19:32:58 +0200
Message-ID: <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
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

On Wed, 13 May 2020 at 18:50, Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > On Wed, 13 May 2020 at 14:40, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> > > > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> > > >
> > > > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > > > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > > > > compiler-friendlier version).
> > > > >
> > > > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > > > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > > > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > > > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > > > > now.
> > >
> > > I agree that Peter's patch is the right thing to do for now. I was hoping we
> > > could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
> > > __no_sanitize_or_inline doesn't seem to do anything.
> > >
> > > > Right, if/when people want sanitize crud enabled for x86 I need
> > > > something that:
> > > >
> > > >  - can mark a function 'no_sanitize' and all code that gets inlined into
> > > >    that function must automagically also not get sanitized. ie. make
> > > >    inline work like macros (again).
> > > >
> > > > And optionally:
> > > >
> > > >  - can mark a function explicitly 'sanitize', and only when an explicit
> > > >    sanitize and no_sanitize mix in inlining give the current
> > > >    incompatible attribute splat.
> > > >
> > > > That way we can have the noinstr function attribute imply no_sanitize
> > > > and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
> > > > helper instead of __always_inline for __##func().
> > >
> > > Sounds like a good plan to me, assuming the compiler folks are onboard.
> > > In the meantime, can we kill __no_sanitize_or_inline and put it back to
> > > the old __no_kasan_or_inline, which I think simplifies compiler.h and
> > > doesn't mislead people into using the function annotation to avoid KCSAN?
> > >
> > > READ_ONCE_NOCHECK should also probably be READ_ONCE_NOKASAN, but I
> > > appreciate that's a noisier change.
> >
> > So far so good, except: both __no_sanitize_or_inline and
> > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > just doesn't avoid explicit kcsan_check calls, like those in
> > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > just because macros won't be redefined just for __no_sanitize
> > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > access is unchecked.
> >
> > This will have the expected result:
> > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> >
> > This will not work as expected:
> > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > races are reported
>
> But the problem is that *this* does not work as expected:
>
> unsigned long __no_sanitize_or_inline foo(unsigned long *ptr)
> {
>         return READ_ONCE_NOCHECK(*ptr);
> }
>
> which I think means that the function annotation is practically useless.

Let me understand the problem better:

- We do not want __tsan_func_entry/exit (looking at the disassembly,
these aren't always generated).
- We do not want kcsan_disable/enable calls (with the new __READ_ONCE version).
- We do *not* want the call to __read_once_word_nocheck if we have
__no_sanitize_or_inline. AFAIK that's the main problem -- this applies
to both KASAN and KCSAN.

From what I gather, we want to just compile the function as if the
sanitizer was never enabled. One reason for why this doesn't quite
work is because of the preprocessor.

Note that the sanitizers won't complain about these accesses, which
unfortunately is all these attributes ever were documented to do. So
the attributes aren't completely useless. Why doesn't
K[AC]SAN_SANITIZE := n work?

Thanks,
-- Marco
