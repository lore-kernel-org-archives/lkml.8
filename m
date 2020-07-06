Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA85C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2622070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGFRGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:06:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbgGFRGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:06:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1A31FB;
        Mon,  6 Jul 2020 10:06:01 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A0A3F68F;
        Mon,  6 Jul 2020 10:05:59 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:05:57 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>, kernel-team@android.com,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200706170556.GE10992@arm.com>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706163455.GV9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:34:55AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 06, 2020 at 05:00:23PM +0100, Dave Martin wrote:
> > On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> > > On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > > > On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> > > > > When building with LTO, there is an increased risk of the compiler
> > > > > converting an address dependency headed by a READ_ONCE() invocation
> > > > > into a control dependency and consequently allowing for harmful
> > > > > reordering by the CPU.
> > > > > 
> > > > > Ensure that such transformations are harmless by overriding the generic
> > > > > READ_ONCE() definition with one that provides acquire semantics when
> > > > > building with LTO.
> > > > > 
> > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > ---
> > > > >  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
> > > > >  arch/arm64/kernel/vdso/Makefile   |  2 +-
> > > > >  arch/arm64/kernel/vdso32/Makefile |  2 +-
> > > > >  3 files changed, 65 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 arch/arm64/include/asm/rwonce.h
> > > > > 
> > > > > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > > > > new file mode 100644
> > > > > index 000000000000..515e360b01a1
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/include/asm/rwonce.h
> > > > > @@ -0,0 +1,63 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +/*
> > > > > + * Copyright (C) 2020 Google LLC.
> > > > > + */
> > > > > +#ifndef __ASM_RWONCE_H
> > > > > +#define __ASM_RWONCE_H
> > > > > +
> > > > > +#ifdef CONFIG_CLANG_LTO
> > > > 
> > > > Don't we have a generic option for LTO that's not specific to Clang.
> > > 
> > > /me looks at the LTO series some more
> > > 
> > > Oh yeah, there's CONFIG_LTO which is selected by CONFIG_LTO_CLANG, which is
> > > the non-typoed version of the above. I can switch this to CONFIG_LTO.
> > > 
> > > > Also, can you illustrate code that can only be unsafe with Clang LTO?
> > > 
> > > I don't have a concrete example, but it's an ongoing concern over on the LTO
> > > thread [1], so I cooked this to show one way we could deal with it. The main
> > > concern is that the whole-program optimisations enabled by LTO may allow the
> > > compiler to enumerate possible values for a pointer at link time and replace
> > > an address dependency between two loads with a control dependency instead,
> > > defeating the dependency ordering within the CPU.
> > 
> > Why can't that happen without LTO?
> 
> Because without LTO, the compiler cannot see all the pointers all at
> the same time due to their being in different translation units.
> 
> But yes, if the compiler could see all the pointer values and further
> -know- that it was seeing all the pointer values, these optimizations
> could happen even without LTO.  But it is quite easy to make sure that
> the compiler thinks that there are additional pointer values that it
> does not know about.

Yes of course, but even without LTO the compiler can still apply this
optimisation to everything visible in the translation unit, and that can
drift as people refactor code over time.

Convincing the compiler there are other possible values doesn't help.
Even in

int foo(int *p)
{
	asm ("" : "+r" (p));
	return *p;
}

Can't the compiler still generate something like this:

	switch (p) {
	case &foo:
		return foo;

	case &bar:
		return bar;

	default:
		return *p;
	}

...in which case we still have the same lost ordering guarantee that
we were trying to enforce.

If foo and bar already happen to be in registers and profiling shows
that &foo and &bar are the most likely value of p then this might be
a reasonable optimisation in some situations, irrespective of LTO.

The underlying problem here seems to be that the necessary ordering
rule is not part of what passes for the C memory model prior to C11.
If we want to control the data flow, don't we have to wrap the entire
dereference in a macro?

> > > We likely won't realise if/when this goes wrong, other than impossible to
> > > debug, subtle breakage that crops up seemingly randomly. Ideally, we'd be
> > > able to detect this sort of thing happening at build time, and perhaps
> > > even prevent it with compiler options or annotations, but none of that is
> > > close to being available and I'm keen to progress the LTO patches in the
> > > meantime because they are a requirement for CFI.
> > 
> > My concern was not so much why LTO makes things dangerous, as why !LTO
> > makes things safe...
> 
> Because ignorant compilers are safe compilers!  ;-)

AFAICT ignorance is no gurantee of ordering in general -- the compiler
is free to speculatively invent knowledge any place that the language
spec allows it to.  !LTO doesn't stop this happening.

Hopefully some of the knowledge I invented in my reply is valid...

Cheers
---Dave
