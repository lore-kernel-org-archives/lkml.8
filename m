Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0344020659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388617;
	bh=YGRvVL8aAyOn6idLHv0UO1R432FmpUQvKhCBlb8e6zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtS6FzFgERE2jPw60n5iKl9zBkyOzj9ZV1y8XqgGHXezuD6lRXYwTPMYvNPsiWaw4
	 s0cW8nHMosE0MTgmZ14Hp4kKQCF7mlQks+pOOLm9cbhuFCXBvxrF0FSRSA72J4WIuw
	 R4yuzxmY9swhpIaaHl4reKSJOhdR8HI+LhvUVABo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbgEMQuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732510AbgEMQuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:50:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79231205CB;
        Wed, 13 May 2020 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388614;
        bh=YGRvVL8aAyOn6idLHv0UO1R432FmpUQvKhCBlb8e6zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/oWxrwQaLK49Zdv9sE0aBOZ65sZ+5m7zbqJa0vdt8+i0lbkmzcqxOFt76M/16ixm
         vsDmPApPer85k11OXQf+/yaoVHTKe4wWlCwntYEZikvMvStJIcCn3hK2mcJseOxmPX
         l0oeDl9mnU4SSLpRjIJCW223sTpOW1uK5qw7aQeE=
Date:   Wed, 13 May 2020 17:50:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513165008.GA24836@willie-the-truck>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> On Wed, 13 May 2020 at 14:40, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> > > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> > >
> > > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > > > compiler-friendlier version).
> > > >
> > > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > > > now.
> >
> > I agree that Peter's patch is the right thing to do for now. I was hoping we
> > could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
> > __no_sanitize_or_inline doesn't seem to do anything.
> >
> > > Right, if/when people want sanitize crud enabled for x86 I need
> > > something that:
> > >
> > >  - can mark a function 'no_sanitize' and all code that gets inlined into
> > >    that function must automagically also not get sanitized. ie. make
> > >    inline work like macros (again).
> > >
> > > And optionally:
> > >
> > >  - can mark a function explicitly 'sanitize', and only when an explicit
> > >    sanitize and no_sanitize mix in inlining give the current
> > >    incompatible attribute splat.
> > >
> > > That way we can have the noinstr function attribute imply no_sanitize
> > > and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
> > > helper instead of __always_inline for __##func().
> >
> > Sounds like a good plan to me, assuming the compiler folks are onboard.
> > In the meantime, can we kill __no_sanitize_or_inline and put it back to
> > the old __no_kasan_or_inline, which I think simplifies compiler.h and
> > doesn't mislead people into using the function annotation to avoid KCSAN?
> >
> > READ_ONCE_NOCHECK should also probably be READ_ONCE_NOKASAN, but I
> > appreciate that's a noisier change.
> 
> So far so good, except: both __no_sanitize_or_inline and
> __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> just doesn't avoid explicit kcsan_check calls, like those in
> READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> just because macros won't be redefined just for __no_sanitize
> functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> access is unchecked.
> 
> This will have the expected result:
> __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> 
> This will not work as expected:
> __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> races are reported

But the problem is that *this* does not work as expected:

unsigned long __no_sanitize_or_inline foo(unsigned long *ptr)
{
	return READ_ONCE_NOCHECK(*ptr);
}

which I think means that the function annotation is practically useless.

Will
