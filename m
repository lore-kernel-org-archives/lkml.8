Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AABC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809692076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="TJAxg6Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRAak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 20:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgDRAak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 20:30:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ADAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:30:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u9so1837557pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0AfeFitryBiJJWIKCCwY7N0WlSHnDG6Y0BrOA9pYIjg=;
        b=TJAxg6Nj7mvYe9W1fv1qsO7mUzp9flRqxmoqk6bQImYJehU7tMbjjTy3GYG7Ve8abr
         ZhQ+lm4D3jFNcbv8/DP4L8GEWXfMvR2rODm0wJtp9r+UXsaXAwrwIN9Cl33l9WJCSbCt
         NdY8K1h6whKlji5c2LAlvnwF3y+pMkt5FwHeW7vg+e4uPyQokPV3tPQKjjM7PeDGKVTc
         YDguumzHMQZlK00MzNp39F2pNMNuFRqo7VyIzwlChH6/nYHAqZt6itpF9vdwQAj9nCAB
         9sSBfMw3IH6UpronKtIWKd80yXcjPiEc9DlSS7camZjQWhmFra0AvLCCfjUHPgoefSbi
         YTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0AfeFitryBiJJWIKCCwY7N0WlSHnDG6Y0BrOA9pYIjg=;
        b=tadzSPIYs+qg2/QXWnxEgPNGEcNEjNsJRDBT4sB3COTyTofg+3f7kzwJepvRrBwDOe
         g2NQQF6s9bhAAx62UBXl4CWI9mVtCF0FLV51Ap8wx9q1pBDOMjBsLlOG6tJP/BoxBzgg
         mLJLl2Vti7NIlNv8S3fjEe+idthcvJrOZc58r1wV/mchjVFSiCuCTe3wvGmOO073wJ7V
         tUKCohlem3o2HiQ9EVrZ1mpnNZ+CBqpKZya9R5qcjpk6P8Xvd3A9c+S/de+1ixj2usxO
         X4+mBvohtHR6T5f0x+IIwOvNc0A8y7JdsDetKS1LDsbzek7EIdQp23aCBKsyP92u9pgd
         pIfw==
X-Gm-Message-State: AGi0PuZJpkCYpfbqgMStgFxvWT6/qJ8JnGIsorwLbh5Fs3xCvRSF6rx7
        50gfeDB7tOh5KNGtuQjeoeSTgw==
X-Google-Smtp-Source: APiQypKUElb866HEHEtPLanFvP/5xIzuLq3qC6Q5JBOUeVvdZeVNhGXGCLpmMGvSEMhaHzmc/riFIg==
X-Received: by 2002:aa7:9722:: with SMTP id k2mr5789777pfg.147.1587169839258;
        Fri, 17 Apr 2020 17:30:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t103sm6764185pjb.46.2020.04.17.17.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 17:30:38 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:30:38 -0700 (PDT)
X-Google-Original-Date: Fri, 17 Apr 2020 17:30:37 PDT (-0700)
Subject:     Re: [PATCH v5 9/9] riscv: add STRICT_KERNEL_RWX support
In-Reply-To: <100e739c5fd722a96fcc640c8ee0c82fe34fcb6a.1586332296.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-09f91ec8-5821-41ad-a743-3842ca10f9e2@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020 00:57:04 PDT (-0700), zong.li@sifive.com wrote:
> The commit contains that make text section as non-writable, rodata
> section as read-only, and data section as non-executable.
>
> The init section should be changed to non-executable.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig                  |  1 +
>  arch/riscv/include/asm/set_memory.h |  8 ++++++
>  arch/riscv/mm/init.c                | 44 +++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1e1efc998baf..58b556167d59 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -61,6 +61,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select SPARSEMEM_STATIC if 32BIT
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 4c5bae7ca01c..c38df4771c09 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -22,6 +22,14 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +void set_kernel_text_ro(void);
> +void set_kernel_text_rw(void);
> +#else
> +static inline void set_kernel_text_ro(void) { }
> +static inline void set_kernel_text_rw(void) { }
> +#endif
> +
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fab855963c73..b55be44ff9bd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -12,6 +12,7 @@
>  #include <linux/sizes.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
> +#include <linux/set_memory.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
> @@ -477,6 +478,17 @@ static void __init setup_vm_final(void)
>  	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>  	local_flush_tlb_all();
>  }
> +
> +void free_initmem(void)
> +{
> +	unsigned long init_begin = (unsigned long)__init_begin;
> +	unsigned long init_end = (unsigned long)__init_end;
> +
> +	/* Make the region as non-execuatble. */
> +	set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
> +	free_initmem_default(POISON_FREE_INITMEM);
> +}
> +
>  #else
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> @@ -488,6 +500,38 @@ static inline void setup_vm_final(void)
>  }
>  #endif /* CONFIG_MMU */
>
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +void set_kernel_text_rw(void)
> +{
> +	unsigned long text_start = (unsigned long)_text;
> +	unsigned long text_end = (unsigned long)_etext;
> +
> +	set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
> +}
> +
> +void set_kernel_text_ro(void)
> +{
> +	unsigned long text_start = (unsigned long)_text;
> +	unsigned long text_end = (unsigned long)_etext;
> +
> +	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> +}
> +
> +void mark_rodata_ro(void)
> +{
> +	unsigned long text_start = (unsigned long)_text;
> +	unsigned long text_end = (unsigned long)_etext;
> +	unsigned long rodata_start = (unsigned long)__start_rodata;
> +	unsigned long data_start = (unsigned long)_data;
> +	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> +
> +	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> +	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> +	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> +}
> +#endif
> +
>  void __init paging_init(void)
>  {
>  	setup_vm_final();

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
