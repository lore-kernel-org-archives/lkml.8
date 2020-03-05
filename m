Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E22C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D8720866
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="vRmlQPhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgCEBWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:22:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33611 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:22:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id m5so1912451pgg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JtVY2TbnZYg34ePRXi3izpntJbzbeF3tPdRAvzboEq4=;
        b=vRmlQPhcvEZSPwvwVSbDFH2/f2X9nWaWR7WirMd/AxqNvih88hS3tAuPclvlOztfOd
         NYAANy/g3VOcEsrh6+j4V82J982wL/WYXidaKBfEtcYSuTgXfq8/wl7Y8qakl6zmrREa
         Gb9JEogTJ01Y2gxKBQPhwvWT17JDW1Gjg+GiSqg2WHBdoy37IbDxzs2zNy5JJdA1atA+
         b3lr/JRh3DZO4U/hcAWh0Xn64I2GLzoZcjAlbLgVaj1Ig7eUnId6i2j5QGpz0TQARcpt
         VrLFIVGMEkGyKVcTBuQv/sYNvjF972O74pMspAUZyO5ajds2iONAj6KA70OlKVDsyfhp
         NFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JtVY2TbnZYg34ePRXi3izpntJbzbeF3tPdRAvzboEq4=;
        b=L7gi91OUiBCtBay2uaNv5s/gav8CYwYh8CK5uIpkfbhgzJgMwIN2/KIWa0qAYxKf+v
         Axi7BAYxJK4Hk7Hw11ODwKHFle/MyjsO7sUHtfJI6lKpGgl+V9JFB3BhToI69+qo2qUv
         U+WUVGL9s+7aXXsJ9WgkdpAUXI8lS9x8vHDy8Lg+JMTX07wcGnf3aMel1C2jQx1dI2W5
         JCoyyACnEcL5gm9cxma7qlMpF7x2GAS5WeDD/f70P/ieKkUI6zs+fB4w0k19IBpbCnhU
         TvstZZOCdl53QSC6pEsjq/SkrEK3fIKvARRNLeLlEvH8nbXQv29F3UT6P4k44O+9YB22
         CbWg==
X-Gm-Message-State: ANhLgQ31HUWoJGhNA27VNfxBIk89S1cG9Zka1RK9Gr3U1GUhMFLCqFYG
        DoAyE2uZ78MDlTenSM42jGTuuA==
X-Google-Smtp-Source: ADFU+vu139oi/AXnRI9S2g5bYyVFgxEXHq5dJXwkf/gEh7zlAomdz0ShxEZvQDizftt1c19aePWiKQ==
X-Received: by 2002:a65:5c46:: with SMTP id v6mr5297930pgr.333.1583371318976;
        Wed, 04 Mar 2020 17:21:58 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id 129sm4362349pfw.84.2020.03.04.17.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:21:57 -0800 (PST)
Date:   Wed, 04 Mar 2020 17:21:57 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 17:21:43 PST (-0800)
Subject:     Re: [PATCH 6/8] riscv: add STRICT_KERNEL_RWX support
In-Reply-To: <20200217083223.2011-7-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-5d8ed200-0200-4198-946f-ae41ba71cc06@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:21 PST (-0800), zong.li@sifive.com wrote:
> The commit contains that make text section as non-writable, rodata
> section as read-only, and data section as non-executable.
>
> The init section should be changed to non-executable.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig                  |  1 +
>  arch/riscv/include/asm/set_memory.h |  8 +++++
>  arch/riscv/mm/init.c                | 45 +++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f524d7e60648..308a4dbc0b39 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -62,6 +62,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select SPARSEMEM_STATIC if 32BIT
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index a91f192063c2..d3076087cb34 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -15,6 +15,14 @@ int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
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
> index 965a8cf4829c..09fa643e079c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -12,11 +12,13 @@
>  #include <linux/sizes.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
> +#include <linux/set_memory.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
> +#include <asm/ptdump.h>
>  #include <asm/io.h>
>
>  #include "../kernel/head.h"
> @@ -477,6 +479,49 @@ static void __init setup_vm_final(void)
>  	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>  	local_flush_tlb_all();
>  }
> +
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
> +	unsigned long data_start = (unsigned long)_sdata;
> +	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> +
> +	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> +	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);

Ya, this'll risk barfing because of srodata.

> +	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> +}
> +#endif
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
