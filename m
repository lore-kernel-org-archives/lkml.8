Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC84124658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579025690;
	bh=qMh1ery7M9FYKnGIXqR8RVhv5V7Xpyo6s7S1NGHlk/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lnJBqK7J0zVQnNCkaEvSAFjXwpjZvDfmDpZyWvwXEhabFONDitiYygMpz90z5zXvo
	 M3i4AVPdyTazzIQWpe63oEFcmUW3A3VIWbxwjAPbqCWboFCI3RY0oMNf2g4zofb6Dp
	 HI4Z8p8JnC+Hh2NCqxBD9h8Ju3nOWYZj+LigiG7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgANSOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANSOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:14:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618E8214AF;
        Tue, 14 Jan 2020 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579025688;
        bh=qMh1ery7M9FYKnGIXqR8RVhv5V7Xpyo6s7S1NGHlk/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUYqmp9E0IHaiBAQLWrMlx4ZGPSx81qOFkn+kt2E0saW/j73vmHShiwgKg0YzhZ7F
         oD++zjnW/suLGyOY9+rp/TuS1Tptv4QU2NAuBwIvQ//5O6dTagWDvZ7qb97H3BSgrh
         54JZ+Cr+Iay9ktvSAb7op3V3/UQTZZDTFvibcHtw=
Date:   Tue, 14 Jan 2020 18:14:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: Re: [PATCH v5 3/6] arm64: remove uaccess_ttbr0 asm macros from cache
 functions
Message-ID: <20200114181440.GH2579@willie-the-truck>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
 <20200102211357.8042-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102211357.8042-4-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:13:54PM -0500, Pavel Tatashin wrote:
> We currently duplicate the logic to enable/disable uaccess via TTBR0,
> with C functions and assembly macros. This is a maintenenace burden
> and is liable to lead to subtle bugs, so let's get rid of the assembly
> macros, and always use the C functions. This requires refactoring
> some assembly functions to have a C wrapper.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 22 ----------------
>  arch/arm64/include/asm/cacheflush.h  | 39 +++++++++++++++++++++++++---
>  arch/arm64/mm/cache.S                | 36 ++++++++++---------------
>  arch/arm64/mm/flush.c                |  2 +-
>  4 files changed, 50 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index f68a0e64482a..fba2a69f7fef 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -34,28 +34,6 @@
>  	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
>  	isb
>  	.endm
> -
> -	.macro	uaccess_ttbr0_disable, tmp1, tmp2
> -alternative_if_not ARM64_HAS_PAN
> -	save_and_disable_irq \tmp2		// avoid preemption
> -	__uaccess_ttbr0_disable \tmp1
> -	restore_irq \tmp2
> -alternative_else_nop_endif
> -	.endm
> -
> -	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
> -alternative_if_not ARM64_HAS_PAN
> -	save_and_disable_irq \tmp3		// avoid preemption
> -	__uaccess_ttbr0_enable \tmp1, \tmp2
> -	restore_irq \tmp3
> -alternative_else_nop_endif
> -	.endm
> -#else
> -	.macro	uaccess_ttbr0_disable, tmp1, tmp2
> -	.endm
> -
> -	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
> -	.endm
>  #endif
>  
>  #endif
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 665c78e0665a..cb00c61e0bde 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -61,16 +61,49 @@
>   *		- kaddr  - page address
>   *		- size   - region size
>   */
> -extern void __flush_icache_range(unsigned long start, unsigned long end);
> -extern int  invalidate_icache_range(unsigned long start, unsigned long end);
> +extern void __asm_flush_icache_range(unsigned long start, unsigned long end);
> +extern long __asm_flush_cache_user_range(unsigned long start,
> +					 unsigned long end);
> +extern int  __asm_invalidate_icache_range(unsigned long start,
> +					  unsigned long end);
>  extern void __flush_dcache_area(void *addr, size_t len);
>  extern void __inval_dcache_area(void *addr, size_t len);
>  extern void __clean_dcache_area_poc(void *addr, size_t len);
>  extern void __clean_dcache_area_pop(void *addr, size_t len);
>  extern void __clean_dcache_area_pou(void *addr, size_t len);
> -extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>  extern void sync_icache_aliases(void *kaddr, unsigned long len);
>  
> +static inline long __flush_cache_user_range(unsigned long start,
> +					    unsigned long end)
> +{
> +	int ret;
> +
> +	uaccess_ttbr0_enable();
> +	ret = __asm_flush_cache_user_range(start, end);
> +	uaccess_ttbr0_disable();
> +
> +	return ret;
> +}
> +
> +static inline void __flush_icache_range(unsigned long start, unsigned long end)
> +{
> +	uaccess_ttbr0_enable();
> +	__asm_flush_icache_range(start, end);
> +	uaccess_ttbr0_disable();
> +}

Interesting... I don't think we should be enabling uaccess here: the
function has a void return type so we can't communicate failure back to the
caller if we fault, so my feeling is that this should only ever be called on
kernel addresses.

> +
> +static inline int invalidate_icache_range(unsigned long start,
> +					  unsigned long end)
> +{
> +	int ret;
> +
> +	uaccess_ttbr0_enable();
> +	ret = __asm_invalidate_icache_range(start, end);
> +	uaccess_ttbr0_disable();
> +
> +	return ret;
> +}

Same here -- I don't think think this is ever called on user addresses.
Can we make the return type void and drop the uaccess toggle?

Will
