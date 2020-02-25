Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A6C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9855521927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgBYKav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:30:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:21797 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbgBYKav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:30:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 02:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230108009"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2020 02:30:48 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j6XUI-004dNp-0i; Tue, 25 Feb 2020 12:30:50 +0200
Date:   Tue, 25 Feb 2020 12:30:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dan.j.williams@intel.com, peterz@infradead.org
Subject: Re: [PATCH v5 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200225103050.GD10400@smile.fi.intel.com>
References: <20200224225020.2212544-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224225020.2212544-1-jesse.brandeburg@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:50:19PM -0800, Jesse Brandeburg wrote:
> Fix many sparse warnings when building with C=1.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
> 
> CONST_MASK() is using a signed integer "1" to create the mask which
> is later cast to (u8) when used, in order to yield an 8-bit value
> for the assembly instructions to use. Simplify the expressions used to
> clearly indicate they are working on 8-bit values only, which still
> keeps sparse happy without an accidental promotion to a 32 bit integer.
> 

> The reason the warning was occurring is because certain bitmasks that
> end with a mask next to a natural boundary like 7, 15, 23, 31, end up
> with a mask like 0x7f, which then results in sign extension when doing
> an invert (but I'm not a compiler expert). It was really only
> "clear_bit" that was having problems, and it was only on bit checks next
> to a byte boundary (top bit).

I guess this describes it incorrectly.
The problem is integer promotion of negation operation for any bit basically.

For example, if we have bit 3 (nr = 3) and got it in the clear bit we will
get (according to what I see in the warnings) 0xfffffff7. Which is simple
~(1 << 3) promoted to integer.

I think it is a C standard which dictates this, compiler just follows.

> Verified with a test module (see next patch) and assembly inspection
> that the patch doesn't introduce any change in generated code.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v5: changed code to use simple AND and XOR, updated commit message
> v4: reverse argument order as suggested by David Laight, added reviewed-by
> v3: Clean up the header file changes as per peterz.
> v2: use correct CC: list
> ---
>  arch/x86/include/asm/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 062cdecb2f24..53f246e9df5a 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "orb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)CONST_MASK(nr))
> +			: "iq" (CONST_MASK(nr) & 0xff)
>  			: "memory");
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "andb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)~CONST_MASK(nr)));
> +			: "iq" (CONST_MASK(nr) ^ 0xff));
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> 
> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


