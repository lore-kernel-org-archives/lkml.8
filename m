Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB39C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B72820836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBXRA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:00:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:63010 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:00:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 09:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="435965233"
Received: from jbrandeb-desk4.amr.corp.intel.com (HELO localhost) ([10.166.241.50])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2020 09:00:25 -0800
Date:   Mon, 24 Feb 2020 09:00:24 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200224090024.000055ae@intel.com>
In-Reply-To: <20200224095402.GD14897@hirez.programming.kicks-ass.net>
References: <20200222000214.2169531-1-jesse.brandeburg@intel.com>
        <CAHp75Vc=9aSt1DH-LzDHnX1+fnPpkJWHkkh0-ApTL0zm+ZA2oQ@mail.gmail.com>
        <20200224095402.GD14897@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:54:02 +0100 Peter wrote:
> On Sat, Feb 22, 2020 at 11:39:57AM +0200, Andy Shevchenko wrote:
> > On Sat, Feb 22, 2020 at 2:04 AM Jesse Brandeburg  
> 
> > > -#define CONST_MASK(nr)                 (1 << ((nr) & 7))
> > > +#define CONST_MASK(nr)                 ((u8)1 << ((nr) & 7))
> > >
> > >  static __always_inline void
> > >  arch_set_bit(long nr, volatile unsigned long *addr)
> > > @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
> > >         if (__builtin_constant_p(nr)) {
> > >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> > >                         : CONST_MASK_ADDR(nr, addr)
> > > -                       : "iq" ((u8)CONST_MASK(nr))
> > > +                       : "iq" (CONST_MASK(nr))  
> 
> Note how this is not equivalent, the old code actually handed in a u8
> while the new code hands int. By moving the (u8) cast into the parens,
> you casl 1 to u8, which then instantly gets promoted to 'int' due to the
> '<<' operator.

True. Which is why I had decided to use the strongly typed local
variables, which as I recall you mentioned were "sad", so I had tried
to fix it with the simpler changes. Everything is a negotiation with
the compiler and tools here, about how clearly you can communicate the
code's intent and functionality while still keeping it performant.

> > >                         : "memory");
> > >         } else {
> > >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> > > @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
> > >         if (__builtin_constant_p(nr)) {
> > >                 asm volatile(LOCK_PREFIX "andb %1,%0"
> > >                         : CONST_MASK_ADDR(nr, addr)
> > > -                       : "iq" ((u8)~CONST_MASK(nr)));
> > > +                       : "iq" (CONST_MASK(nr) ^ 0xff));  
> > 
> > I'm wondering if the original, by Peter Z, order allows us to drop
> > (u8) casting in the CONST_MASK completely.  
> 
> I'm thinking it's all nonsense anyway :-), the result of either << or ^
> is always promoted to int anyway.

Yeah, I realize this is *all* nonsense, but I *do* see value in making
the code not generate sparse warnings, as long as the end result
doesn't generate code change. It allows you to run more tools to find
bugs with less false positives.

> The sparse complaint was that ~CONST_MASK(nr) had high bits set which
> were lost, which is true, but a copmletely stupid warning IMO.
> 
> By using 0xff ^ CONST_MASK(nr), those bits will not be set and will not
> be lost.
> 
> None of that has anything to do with where we place a pointless cast
> more or less.

Well now that we have the test module, I'll check that the simplest
possible patch of just changing the one line for ~CONST_MASK(nr) to
0xFF ^ CONST_MASK(nr) will fix the issue.
