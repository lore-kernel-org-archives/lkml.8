Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F9C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329D720768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgSUi1SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDGSVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:21:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42573 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:21:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id v2so168055plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NbpMH6Skwho9hvVAqKiUbM06OygWWr7Vk5Zim+uGaqg=;
        b=cgSUi1SAh6agTPfqTbY+5k6q/YsLJGf+XzamQcja0uNiJ6BlWmlYLPRDLsuX2eq8Gy
         mu4deeE2J/KrbhxQrS8ROpVCTWffePnZsFLzDeq91mXwwQm+pcl37YXRP70lEc+Frd5G
         UqQnBC7Uj9lMYSubJbaaL+PQ3eZX/DDue6UNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NbpMH6Skwho9hvVAqKiUbM06OygWWr7Vk5Zim+uGaqg=;
        b=NzqkXSDV6OEVCg6kTlOVIKaprIY9WqxfQom0d6p6bof5O1558bo2g4XPWDDw6au30g
         N1mjiYPyerLxDyxBsy9d+21pN2fvdMK2gMEpVOtyWEGf8j835TYF1bmP9FbiP82u9dWK
         U9Ksujm1+Fkg9avjaLtuUl8zoyjMqkYF9ucOoYkK1ovC4SkJhkkOfGEb6LfgAPOcaeuj
         A9t4WY1VgnPV9pa5zU+RWpUnw5bqSBRjZbgmOgjRV8bp94vTpFe7KTtv6fkSK+1Lqbko
         EewHywCaqnIkNqHzwBRkeBVfTx9A1qyfeFEiJD6WkjVa7b7x/GGpeFkQqfda3VwhoTm9
         jmlw==
X-Gm-Message-State: AGi0PuZ9kS6IBm9D2OHX4fSkz6Ymv53CRAPhJ4atwSjB5M4VyzR+Wgjk
        o3yUvEwDWf8dnCMxtlr4fUjV7Q==
X-Google-Smtp-Source: APiQypJHIYTz7rf9eTepvGJwYp41GdF98+1ART5RK6atMocvqTsk4t25io45qIdjXfUleK2SmQz6ig==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr3665354plo.260.1586283673049;
        Tue, 07 Apr 2020 11:21:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x11sm14631526pfp.204.2020.04.07.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:21:12 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:21:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org,
        x86@kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH v2 1/4] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Message-ID: <202004071121.AE5534C@keescook>
References: <20200406031946.11815-1-sblbir@amazon.com>
 <20200406031946.11815-2-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406031946.11815-2-sblbir@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:19:43PM +1000, Balbir Singh wrote:
> Split out the allocation and free routines to be used in a follow
> up set of patches (to reuse for L1D flushing).
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/cacheflush.h |  3 +++
>  arch/x86/kernel/Makefile          |  1 +
>  arch/x86/kernel/l1d_flush.c       | 36 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c            | 25 +++------------------
>  4 files changed, 43 insertions(+), 22 deletions(-)
>  create mode 100644 arch/x86/kernel/l1d_flush.c
> 
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index 63feaf2a5f93..6419a4cef0e8 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -6,6 +6,9 @@
>  #include <asm-generic/cacheflush.h>
>  #include <asm/special_insns.h>
>  
> +#define L1D_CACHE_ORDER 4
>  void clflush_cache_range(void *addr, unsigned int size);
> +void *alloc_l1d_flush_pages(void);
> +void cleanup_l1d_flush_pages(void *l1d_flush_pages);
>  
>  #endif /* _ASM_X86_CACHEFLUSH_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index d6d61c4455fa..48f443e6c2de 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -160,3 +160,4 @@ ifeq ($(CONFIG_X86_64),y)
>  endif
>  
>  obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
> +obj-y						+= l1d_flush.o
> diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
> new file mode 100644
> index 000000000000..05f375c33423
> --- /dev/null
> +++ b/arch/x86/kernel/l1d_flush.c
> @@ -0,0 +1,36 @@
> +#include <linux/mm.h>
> +#include <asm/cacheflush.h>
> +
> +void *alloc_l1d_flush_pages(void)
> +{
> +	struct page *page;
> +	void *l1d_flush_pages = NULL;
> +	int i;
> +
> +	/*
> +	 * This allocation for l1d_flush_pages is not tied to a VM/task's
> +	 * lifetime and so should not be charged to a memcg.
> +	 */
> +	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
> +	if (!page)
> +		return NULL;
> +	l1d_flush_pages = page_address(page);
> +
> +	/*
> +	 * Initialize each page with a different pattern in
> +	 * order to protect against KSM in the nested
> +	 * virtualization case.
> +	 */
> +	for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
> +		memset(l1d_flush_pages + i * PAGE_SIZE, i + 1,
> +				PAGE_SIZE);
> +	}
> +	return l1d_flush_pages;
> +}
> +EXPORT_SYMBOL_GPL(alloc_l1d_flush_pages);
> +
> +void cleanup_l1d_flush_pages(void *l1d_flush_pages)
> +{
> +	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
> +}
> +EXPORT_SYMBOL_GPL(cleanup_l1d_flush_pages);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9eaccf92d616..209e63798435 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -203,14 +203,10 @@ static const struct {
>  	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
>  };
>  
> -#define L1D_CACHE_ORDER 4
>  static void *vmx_l1d_flush_pages;
>  
>  static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
>  {
> -	struct page *page;
> -	unsigned int i;
> -
>  	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
>  		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
>  		return 0;
> @@ -253,24 +249,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
>  
>  	if (l1tf != VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
>  	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> -		/*
> -		 * This allocation for vmx_l1d_flush_pages is not tied to a VM
> -		 * lifetime and so should not be charged to a memcg.
> -		 */
> -		page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
> -		if (!page)
> +		vmx_l1d_flush_pages = alloc_l1d_flush_pages();
> +		if (!vmx_l1d_flush_pages)
>  			return -ENOMEM;
> -		vmx_l1d_flush_pages = page_address(page);
> -
> -		/*
> -		 * Initialize each page with a different pattern in
> -		 * order to protect against KSM in the nested
> -		 * virtualization case.
> -		 */
> -		for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
> -			memset(vmx_l1d_flush_pages + i * PAGE_SIZE, i + 1,
> -			       PAGE_SIZE);
> -		}
>  	}
>  
>  	l1tf_vmx_mitigation = l1tf;
> @@ -7992,7 +7973,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  static void vmx_cleanup_l1d_flush(void)
>  {
>  	if (vmx_l1d_flush_pages) {
> -		free_pages((unsigned long)vmx_l1d_flush_pages, L1D_CACHE_ORDER);
> +		cleanup_l1d_flush_pages(vmx_l1d_flush_pages);
>  		vmx_l1d_flush_pages = NULL;
>  	}
>  	/* Restore state so sysfs ignores VMX */
> -- 
> 2.17.1
> 

-- 
Kees Cook
