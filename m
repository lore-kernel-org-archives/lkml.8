Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B305DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3B3214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="hQ+wDCVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgCEA5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:57:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41873 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEA5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:57:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so1871251pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 16:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=o9J+supnrYLSUg8HBVX6gCsPDHMxj5Rl4InzzMMgNk4=;
        b=hQ+wDCVa7veVaJOhswZk31E6FovSFwVCXjKkZlGb9+jgYG+l3dTnq4geE0epl3SxRI
         NSnKJfat/3r9aLQUlt3YeW8qEtcAIlpPEvBe/7ZeoGsMa6PE430uieuyq5TFAO5eiFp4
         91JSSEx7G5SiDY4luoBPcluAqk3EL83j0I57DQPd9Hi4FJ/kKRjNybyqAuPzad4ryisR
         98Hr9aU5zKVbnqqMT4bsr+q6HpbCOOrlvqO7tX5Uq086/Yaoact3aTdhiLWuYjhL0aA8
         ivwsIhYpHA7gpkGF24f2+1kjwqtnps6vlbBtH+iR8f8dHX7S2I2gUZRAbhlt/IVdU9/m
         ofFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=o9J+supnrYLSUg8HBVX6gCsPDHMxj5Rl4InzzMMgNk4=;
        b=hWwM+ZyNYK3w48cym9aYLkDJZQoOyGzQ7rUjlSSULJlSO7WLhjOiUmDwXmx0UJ/PHP
         lLUDmVAgZyB2ysQMY7WGQoqjPGrrxVJ1LjnUGGmsneCD2gHVRaGMXofplTjTJ3B8nVOH
         yij5UpL9Pvfwc11G65Z7MrkzQHZZv4ogA5Jq5UBHAog/puSx0CZhngmEjTuthmMTDEIB
         o7HktgwExLVHiI7h0AAQj+ddN3fFgXWM1cTMXxpPC1PiXhQNFv5W991dKF3BhHhIheV7
         0T9PPUXXxhptxUvnQZPpIDdgJBHJbK2T3S58RyBu/nl75jgjcN66+Nd07fnDabVPTUEH
         XoCA==
X-Gm-Message-State: ANhLgQ1cSRvMdnQPVXyq1k211bLRrYJjgbkMumo7vzBMOSXruPQkDJzI
        mWTDAb4Zc8SMd7G4eqTMmt7LyA==
X-Google-Smtp-Source: ADFU+vsWbCh8e7ot3LQGH2zg1bgwU1AUXI8CJL97bju480ETGjnDsCiZtJz6DKw1vk1uawKDcMKYrg==
X-Received: by 2002:a62:e20e:: with SMTP id a14mr5669133pfi.138.1583369864936;
        Wed, 04 Mar 2020 16:57:44 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id d82sm12867200pfd.187.2020.03.04.16.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:57:43 -0800 (PST)
Date:   Wed, 04 Mar 2020 16:57:43 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 16:28:27 PST (-0800)
Subject:     Re: [PATCH 2/8] riscv: add ARCH_HAS_SET_DIRECT_MAP support
In-Reply-To: <20200217083223.2011-3-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-67b20408-35a0-4b4a-97cf-a64b81a69c92@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:17 PST (-0800), zong.li@sifive.com wrote:
> Add set_direct_map_*() functions for setting the direct map alias for
> the page to its default permissions and to an invalid state that cannot
> be cached in a TLB. (See d253ca0c ("x86/mm/cpa: Add set_direct_map_*()
> functions")) Add a similar implementation for RISC-V.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig                  |  1 +
>  arch/riscv/include/asm/set_memory.h |  3 +++
>  arch/riscv/mm/pageattr.c            | 24 ++++++++++++++++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 76ed36543b3a..07bf1a7c0dd2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -60,6 +60,7 @@ config RISCV
>  	select HAVE_EBPF_JIT if 64BIT
>  	select EDAC_SUPPORT
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select SPARSEMEM_STATIC if 32BIT
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 936f08063566..a9783a878dca 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -14,4 +14,7 @@ int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>
> +int set_direct_map_invalid_noflush(struct page *page);
> +int set_direct_map_default_noflush(struct page *page);
> +
>  #endif /* _ASM_RISCV_SET_MEMORY_H */
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index fcd59ef2835b..7be6cd67e2ef 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -148,3 +148,27 @@ int set_memory_nx(unsigned long addr, int numpages)
>  {
>  	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
>  }
> +
> +int set_direct_map_invalid_noflush(struct page *page)
> +{
> +	unsigned long start = (unsigned long)page_address(page);
> +	unsigned long end = start + PAGE_SIZE;
> +	struct pageattr_masks masks = {
> +		.set_mask = __pgprot(0),
> +		.clear_mask = __pgprot(_PAGE_PRESENT)
> +	};
> +
> +	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
> +}
> +
> +int set_direct_map_default_noflush(struct page *page)
> +{
> +	unsigned long start = (unsigned long)page_address(page);
> +	unsigned long end = start + PAGE_SIZE;
> +	struct pageattr_masks masks = {
> +		.set_mask = PAGE_KERNEL,
> +		.clear_mask = __pgprot(0)
> +	};
> +
> +	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
> +}

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
