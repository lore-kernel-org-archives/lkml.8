Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3770C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD469206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgBTWcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:32:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:18456 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgBTWcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:32:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 14:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="283540360"
Received: from jbrandeb-desk4.amr.corp.intel.com (HELO localhost) ([10.166.241.50])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2020 14:32:30 -0800
Date:   Thu, 20 Feb 2020 14:32:29 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@rasmusvillemoes.dk>, <andriy.shevchenko@intel.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200220143229.00002d4d@intel.com>
In-Reply-To: <20200220181236.GC18400@hirez.programming.kicks-ass.net>
References: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
        <20200220181236.GC18400@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 19:12:36 +0100 Peter wrote:
> On Thu, Feb 20, 2020 at 09:37:21AM -0800, Jesse Brandeburg wrote:
> > @@ -72,9 +74,11 @@ static __always_inline void
> >  arch_clear_bit(long nr, volatile unsigned long *addr)
> >  {
> >  	if (__builtin_constant_p(nr)) {
> > +		u8 cmaski = ~CONST_MASK(nr);
> > +
> >  		asm volatile(LOCK_PREFIX "andb %1,%0"
> >  			: CONST_MASK_ADDR(nr, addr)
> > -			: "iq" ((u8)~CONST_MASK(nr)));
> > +			: "iq" (cmaski));
> 
> Urgh, that's sad. So why doesn't this still generate a warning, ~ should
> promote your u8 to int, and then you down-cast to u8 on assignment
> again.

My suspicion is that using the right size types on the lvalue causes
the compiler (and sparse) to know that the type and number of bits in
the "iq" statement is unambiguous.

> 
> So now you have more lines, more ugly casts and exactly the same
> generated code; where the win?

The win as I see it is that sparse (C=1) doesn't warn, but you're right,
it wasn't my first choice to do it the way I ended up with (see below) 

> Perhaps you should write it like:
> 
> 		: "iq" (0xFF ^ CONST_MASK(nr))
> 
> hmm?

Thanks! That works, for my tests at least. FWIW, at one point during
review I got some feedback from a build bot (zero day tester) that
certain compilers like gcc 7.5.0 interpret ~CONST_MASK(nr) into needing
32 bits. So I solved that issue by using correctly typed (and width)
local variables, but I didn't try the 0xff^ way at that time.

I'll change back to the simpler version of the changes (without locals)
and with your 0xff^ change, we'll see if anything comes up from build
bots.

