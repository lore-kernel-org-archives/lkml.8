Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2161206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="peGeYEPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEOJUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbgEOJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:20:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78720C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PwLPxTgU7MVgOEj1sQDsMs7u6MdEPxf7jvTyirXInfQ=; b=peGeYEPFb/+g6JS0ALE7mDaYs6
        4yCuDKhjmqdXuGgjsgxBsXSC7aZuzRZpNBmBuHlOlN5g6zRURkvP+nutuJn1i7cepMFMxqb8wxU2y
        EW2P4lGoWXTB71NFmVasUZ1tedkvj5Li9RHQKS8Y7QXw3jWp6ypN/QWJAwpEG1dVwUNs2AYDzxCdA
        tazMkyjyqFNkdX9cfix4ffq6ueT4jiXftB0VeWGh7rxXLh+LMrN2XnGLnQwsx7tdrozeZkVartpK/
        nU+SJoFz+BhgWlBOdVkTjEIAKYlfXu7lrSYSlXvVXn0lyqK70t1lkNPYMdt7zeJoYEEFkIiRuFr4C
        0Fpo0L0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZWVh-0008Bs-SM; Fri, 15 May 2020 09:20:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DF42300261;
        Fri, 15 May 2020 11:20:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C7D020267E66; Fri, 15 May 2020 11:20:03 +0200 (CEST)
Date:   Fri, 15 May 2020 11:20:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200515092003.GR2957@hirez.programming.kicks-ass.net>
References: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514141344.GB2978@hirez.programming.kicks-ass.net>
 <CANpmjNPb0nr+PGRhogySdm1ixdSRTF_Xi5P8pn_8er+mDtt3kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPb0nr+PGRhogySdm1ixdSRTF_Xi5P8pn_8er+mDtt3kQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:20:42PM +0200, Marco Elver wrote:
> On Thu, 14 May 2020 at 16:13, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 13, 2020 at 03:58:30PM +0200, Marco Elver wrote:
> > > On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Also, could not this compiler instrumentation live as a kernel specific
> > > > GCC-plugin instead of being part of GCC proper? Because in that case,
> > > > we'd have much better control over it.
> > >
> > > I'd like it if we could make it a GCC-plugin for GCC, but how? I don't
> > > see a way to affect TSAN instrumentation. FWIW Clang already has
> > > distinguish-volatile support (unreleased Clang 11).
> >
> > Ah, I figured not use the built-in TSAN at all, do a complete
> > replacement of the instrumentation with a plugin. AFAIU plugins are able
> > to emit instrumentation, but this isn't something I know a lot about.
> 
> Interesting option. But it will likely not solve the no_sanitize and
> inlining problem, because those are deeply tied to the optimization
> pipelines.

So I'm imagining adding the instrumentation is done at a very late pass,
after all, all we want is to add instrumentation to any memops. I
imagine this is done right before doing register allocation and emitting
asm.

At this point we can look if the current function has a no_sanitize
attribute, no?

That is, this is done after all the optimization and inlining stages
anyway; why would we care about that?

Maybe I'm too naive of compiler internals; this really isn't my area :-)
