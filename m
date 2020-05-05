Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF764C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA57E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgEEPOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:14:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:40163 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbgEEPOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:14:41 -0400
IronPort-SDR: JKryZtc8l1bPpYDRIFu/cy6d4J8W+5/B06ldcmSx96Df9gO8bCphO+811jOX0+TUGBPcZGWDCA
 R6huOFYf5iTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:14:40 -0700
IronPort-SDR: zng81o4v8IKpU257eJBNo3kaVx2sJYMwg/4+kHYAgGPF+QsTRTaJuA03IHu0Z+Rk0yFZDmY8e9
 fnjpSJd/thoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="277908030"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 08:14:36 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jVzHK-004pvA-Ra; Tue, 05 May 2020 18:14:38 +0300
Date:   Tue, 5 May 2020 18:14:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, bp@alien8.de,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, ilie.halip@gmail.com,
        natechancellor@gmail.com
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200505151438.GP185537@smile.fi.intel.com>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
 <20200504193524.GA221287@google.com>
 <20200504181443.00007a3d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504181443.00007a3d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 06:14:43PM -0700, Jesse Brandeburg wrote:
> On Mon, 4 May 2020 12:51:12 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
> > Sorry for the very late report.  It turns out that if your config
> > tickles __builtin_constant_p just right, this now produces invalid
> > assembly:
> > 
> > $ cat foo.c
> > long a(long b, long c) {
> >   asm("orb\t%1, %0" : "+q"(c): "r"(b));
> >   return c;
> > }
> > $ gcc foo.c
> > foo.c: Assembler messages:
> > foo.c:2: Error: `%rax' not allowed with `orb'
> > 
> > The "q" constraint only has meanting on -m32 otherwise is treated as
> > "r".
> > 
> > Since we have the mask (& 0xff), can we drop the `b` suffix from the
> > instruction? Or is a revert more appropriate? Or maybe another way to
> > skin this cat?
> 
> Figures that such a small change can create problems :-( Sorry for the
> thrash!
> 
> The patches in the link below basically add back the cast, but I'm
> interested to see if any others can come up with a better fix that
> a) passes the above code generation test
> b) still keeps sparse happy
> c) passes the test module and the code inspection
> 
> If need be I'm OK with a revert of the original patch to fix the issue
> in the short term, but it seems to me there must be a way to satisfy
> both tools.  We went through several iterations on the way to the final
> patch that we might be able to pluck something useful from.

For me the below seems to work:


diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b392571c1f1d1..139122e5b25b1 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) & 0xff)
+			: "iq" ((u8)(CONST_MASK(nr) & 0xff))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) ^ 0xff));
+			: "iq" ((u8)(CONST_MASK(nr) ^ 0xff)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");


-- 
With Best Regards,
Andy Shevchenko


