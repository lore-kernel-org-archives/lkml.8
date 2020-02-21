Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDC6C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7E2207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBUKV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:21:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:47081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgBUKV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:21:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 02:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,467,1574150400"; 
   d="scan'208";a="269939696"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2020 02:21:52 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j55RS-003kYn-Iv; Fri, 21 Feb 2020 12:21:54 +0200
Date:   Fri, 21 Feb 2020 12:21:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dan.j.williams@intel.com, peterz@infradead.org
Subject: Re: [PATCH v3 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200221102154.GL10400@smile.fi.intel.com>
References: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:21:54PM -0800, Jesse Brandeburg wrote:
> Fix many sparse warnings when building with C=1.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
> 
> CONST_MASK() is using a signed integer "1" to create the mask which
> is later cast to (u8) when used. Move the cast to the definition and
> clean up the calling sites to prevent sparse from warning.
> 
> The reason the warning was occurring is because certain bitmasks that
> end with a mask next to a natural boundary like 7, 15, 23, 31, end up
> with a mask like 0x7f, which then results in sign extension when doing
> an invert (but I'm not a compiler expert). It was really only
> "clear_bit" that was having problems, and it was only on bit checks next
> to a byte boundary (top bit).
> 
> Verified with a test module (see next patch) and assembly inspection
> that the patch doesn't introduce any change in generated code.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks for fixing this, I have experienced tons of such messages.

> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v3: Clean up
> the header file changes as per peterz.
> 
> v2: use correct CC: list
> ---
>  arch/x86/include/asm/bitops.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 062cdecb2f24..96ef19dcbde6 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -46,7 +46,7 @@
>   * a mask operation on a byte.
>   */
>  #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
> -#define CONST_MASK(nr)			(1 << ((nr) & 7))
> +#define CONST_MASK(nr)			((u8)1 << ((nr) & 7))
>  
>  static __always_inline void
>  arch_set_bit(long nr, volatile unsigned long *addr)
> @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "orb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)CONST_MASK(nr))
> +			: "iq" (CONST_MASK(nr))
>  			: "memory");
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "andb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)~CONST_MASK(nr)));
> +			: "iq" (0xff ^ CONST_MASK(nr)));
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


