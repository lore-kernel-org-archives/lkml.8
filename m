Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B1BC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0481D2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgDQNDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729845AbgDQNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:03:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D6BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:03:34 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPQeU-0008Ta-Qk; Fri, 17 Apr 2020 15:03:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 49758104096; Fri, 17 Apr 2020 15:03:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 2/5] arch/x86: Refactor tlbflush and l1d flush
In-Reply-To: <20200408090229.16467-3-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com> <20200408090229.16467-3-sblbir@amazon.com>
Date:   Fri, 17 Apr 2020 15:03:26 +0200
Message-ID: <87y2qul0wx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:
> +void populate_tlb_with_flush_pages(void *l1d_flush_pages);
> +void flush_l1d_cache_sw(void *l1d_flush_pages);
> +int flush_l1d_cache_hw(void);

l1d_flush_populate_pages();
l1d_flush_sw()
l1d_flush_hw()

Hmm?

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

I probably missed the fine print in the change log why this is separate
from the SW flush function.

> +int flush_l1d_cache_hw(void)
> +{
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> +		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +		return 0;
> +	}
> +	return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(flush_l1d_cache_hw);

along with the explanation why this needs to be two functions.

> -	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> -		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +	if (flush_l1d_cache_hw() == 0)
>  		return;
> -	}

	if (!l1d_flush_hw())
		return;

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

The preempt_disable/enable was not there before, right? Why do we need
that now? If this is a fix, then that should be a separate patch.

Thanks,

        tglx
