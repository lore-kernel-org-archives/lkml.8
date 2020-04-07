Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C72C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F61D2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7cqVk+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDGSZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:25:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37310 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:25:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id u65so1181786pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygAnMoK9ZaSsUWHOuK5PKPpZgadu5R9zemBpkbHj3s8=;
        b=E7cqVk+bO8K6LyZp8VBhIZ4NqWt2n/3FdcKw6Qa5ggS7STrjUXsLTxRvrZbqiwcjKA
         IgitAKaWhENIy/cmBVf4pw/2H1n0iNnxFp7HpWNHfWLjeysDmyy14W4uwzaC2mHGoCk3
         M9W+OV5zVl9jvz4ieBuePwZIA1kfNHXj1JEyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygAnMoK9ZaSsUWHOuK5PKPpZgadu5R9zemBpkbHj3s8=;
        b=i+4ET70xA60PlmKBNABI6naVOnbusZXHr7cQLEt1AiaqKVR2nQVHTYtJbleloX577L
         d9pDdXN9TS88vuFdKPwKr5ZkfdUF4whXsytcye0BtB49m7Eyz/dvpGHAQmOc8ZCwFUaj
         1Jp2iui08Wa9ChvMEAS06N1WU5wvzudQfdAkozWWRxUMVqLhbpfflylQtGlq65mdKo50
         YH9v6nCk+vLcbUmRuGLz+g4ECY7lPYNvIf9mshRZ0/ELrHjhqFAuNveLeE/xixgxyzhS
         /wBTn9E4K+3dXk11QBe6FOQ0ZMOU+tP2rbBisja5VV5jQvnqq2UDZQ/pj3ulBupYgbed
         prEw==
X-Gm-Message-State: AGi0PuaAZAr3LyCfGYjDk7B1TMuGpnuN9ZViEDlCnlO5nVDHGCydx1aX
        6R6kboHEMSiDbX2x1uynEvw0mA==
X-Google-Smtp-Source: APiQypJIgAOfbNeF2eklw3toeYc5LCg9CGJWkMDIPZCsR8uj9+md+jTbzD/IL4X7DfQV9tKd8aiaCw==
X-Received: by 2002:a63:60d:: with SMTP id 13mr3255921pgg.151.1586283902163;
        Tue, 07 Apr 2020 11:25:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q15sm14511332pfn.89.2020.04.07.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:25:01 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:25:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org,
        x86@kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH v2 2/4] arch/x86: Refactor tlbflush and l1d flush
Message-ID: <202004071122.379AB7D@keescook>
References: <20200406031946.11815-1-sblbir@amazon.com>
 <20200406031946.11815-3-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406031946.11815-3-sblbir@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:19:44PM +1000, Balbir Singh wrote:
> Refactor the existing assembly bits into smaller helper functions
> and also abstract L1D_FLUSH into a helper function. Use these
> functions in kvm for L1D flushing.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>  arch/x86/include/asm/cacheflush.h |  3 ++
>  arch/x86/kernel/l1d_flush.c       | 49 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c            | 31 ++++---------------
>  3 files changed, 57 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index 6419a4cef0e8..66a46db7aadd 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -10,5 +10,8 @@
>  void clflush_cache_range(void *addr, unsigned int size);
>  void *alloc_l1d_flush_pages(void);
>  void cleanup_l1d_flush_pages(void *l1d_flush_pages);
> +void populate_tlb_with_flush_pages(void *l1d_flush_pages);
> +void flush_l1d_cache_sw(void *l1d_flush_pages);
> +int flush_l1d_cache_hw(void);
>  
>  #endif /* _ASM_X86_CACHEFLUSH_H */
> diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
> index 05f375c33423..60499f773046 100644
> --- a/arch/x86/kernel/l1d_flush.c
> +++ b/arch/x86/kernel/l1d_flush.c
> @@ -34,3 +34,52 @@ void cleanup_l1d_flush_pages(void *l1d_flush_pages)
>  	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
>  }
>  EXPORT_SYMBOL_GPL(cleanup_l1d_flush_pages);
> +
> +void populate_tlb_with_flush_pages(void *l1d_flush_pages)
> +{
> +	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> +
> +	asm volatile(
> +		/* First ensure the pages are in the TLB */
> +		"xorl	%%eax, %%eax\n"
> +		".Lpopulate_tlb:\n\t"
> +		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> +		"addl	$4096, %%eax\n\t"
> +		"cmpl	%%eax, %[size]\n\t"
> +		"jne	.Lpopulate_tlb\n\t"
> +		"xorl	%%eax, %%eax\n\t"
> +		"cpuid\n\t"
> +		:: [flush_pages] "r" (l1d_flush_pages),
> +		    [size] "r" (size)
> +		: "eax", "ebx", "ecx", "edx");
> +}
> +EXPORT_SYMBOL_GPL(populate_tlb_with_flush_pages);
> +
> +int flush_l1d_cache_hw(void)
> +{
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> +		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +		return 1;
> +	}
> +	return 0;
> +}

This return value is backwards from the kernel's normal use of "int". I
would expect 0 to mean "success" and non-zero to mean "failure". How
about:

int flush_l1d_cache_hw(void)
{
     if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
             wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
             return 0;
     }
     return -ENOTSUPP;
}


> +EXPORT_SYMBOL_GPL(flush_l1d_cache_hw);
> +
> +void flush_l1d_cache_sw(void *l1d_flush_pages)
> +{
> +	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> +
> +	asm volatile(
> +			/* Fill the cache */
> +			"xorl	%%eax, %%eax\n"
> +			".Lfill_cache:\n"
> +			"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> +			"addl	$64, %%eax\n\t"
> +			"cmpl	%%eax, %[size]\n\t"
> +			"jne	.Lfill_cache\n\t"
> +			"lfence\n"
> +			:: [flush_pages] "r" (l1d_flush_pages),
> +			[size] "r" (size)
> +			: "eax", "ecx");
> +}
> +EXPORT_SYMBOL_GPL(flush_l1d_cache_sw);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 209e63798435..29dc5a5bb6ab 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5956,8 +5956,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>   */
>  static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>  {
> -	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> -
>  	/*
>  	 * This code is only executed when the the flush mode is 'cond' or
>  	 * 'always'
> @@ -5986,32 +5984,13 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>  
>  	vcpu->stat.l1d_flush++;
>  
> -	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> -		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +	if (flush_l1d_cache_hw())
>  		return;
> -	}

Then this becomes:

	if (flush_l1d_cache_hw() == 0)
		return;

(Or change it to a "bool" with and use true/false and leave the above
call as-is.)

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
> -	asm volatile(
> -		/* First ensure the pages are in the TLB */
> -		"xorl	%%eax, %%eax\n"
> -		".Lpopulate_tlb:\n\t"
> -		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> -		"addl	$4096, %%eax\n\t"
> -		"cmpl	%%eax, %[size]\n\t"
> -		"jne	.Lpopulate_tlb\n\t"
> -		"xorl	%%eax, %%eax\n\t"
> -		"cpuid\n\t"
> -		/* Now fill the cache */
> -		"xorl	%%eax, %%eax\n"
> -		".Lfill_cache:\n"
> -		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> -		"addl	$64, %%eax\n\t"
> -		"cmpl	%%eax, %[size]\n\t"
> -		"jne	.Lfill_cache\n\t"
> -		"lfence\n"
> -		:: [flush_pages] "r" (vmx_l1d_flush_pages),
> -		    [size] "r" (size)
> -		: "eax", "ebx", "ecx", "edx");
> +	preempt_disable();
> +	populate_tlb_with_flush_pages(vmx_l1d_flush_pages);
> +	flush_l1d_cache_sw(vmx_l1d_flush_pages);
> +	preempt_enable();
>  }
>  
>  static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
> -- 
> 2.17.1
> 


-- 
Kees Cook
