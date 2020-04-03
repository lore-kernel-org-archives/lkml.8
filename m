Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD5C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F2D20678
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="IRQASTuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbgDCPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:17:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37121 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404195AbgDCPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:17:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id r4so2171150pgg.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=SPBXpgOWTzNV/A0U6IcPnBzzrDwIMgsQMzYHIlfsnLw=;
        b=IRQASTuSmjWW6Y+BlyPZT7Uq9ZE4JpmSWIjUZp/1ge5VPQW+2/Ji372WrAe0piZ72m
         TR7/5b8bHGUbZCofmnrGjuSCQ5YQDTbSI/UY7Ine7lDTTK7QSwu/+P8smG9tqVjZjpvp
         i2OR6zI/8TfEfsJenUnc1M6/T4HhoT9nj1Q+GDymeQAAt8vha+8uMBdS2ohiYopZl+mm
         wxNvQNs6r3rLLnJfYpcP+9q0uSIc1YempGo+WzTDU8vY4bSv6QBm5xhCWGQlw5W2j5BT
         m/1hy7kxUVYbZA209biDi2Ign05gYIDqFxYpRUJu76z1Px9+1d7KF2mwEXuALfsHdWmh
         fDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SPBXpgOWTzNV/A0U6IcPnBzzrDwIMgsQMzYHIlfsnLw=;
        b=i8cPmYhE/cXV/fblvmz+DHqwvKnMhxp+W6/QEM7DLdqtkdBQ8MPnh5Ou+yLu4sYo6t
         gmjVxXntnf3wG4DfGFHXUtPrWihuT3n+JcR9pG2NS2DaU9/+kUmqMobn1qg8kiLvnA0z
         NG0p3ZFUa86IdO8E5YuBmrwL0aa4pFrtzL6NVa7dyXS4tXrwtRBygwkQRU/qIXbCSSj5
         lP5hm5sTr1p3Kbi4NpYWaLkK8XwujY4BABZ9BLHvPIQbE2YqwU+oFJggY/ec4OfESSzO
         Qut8qK8JTx9VAQNfgHhuDsrRAq/WsUPQsWm849Y62KMkgIHPZ/hSWFfSfVlD3kbLVzCI
         Retw==
X-Gm-Message-State: AGi0Pubtz1eak0lh81BfZLgyRGPAMKPzLYNPFiwQ+L41Qs01XH/WUHmT
        frd9hhCStVASMTobnzAPj697TA==
X-Google-Smtp-Source: APiQypLZ8H+EuQc4yT+15BG8sGk0hoQxKFyiLT89292JsUfDr+1SpCcKHVabsmr3b8PTT5NQB4HSxQ==
X-Received: by 2002:a62:1c08:: with SMTP id c8mr9294283pfc.80.1585927025235;
        Fri, 03 Apr 2020 08:17:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y9sm6217184pfo.135.2020.04.03.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:17:04 -0700 (PDT)
Date:   Fri, 03 Apr 2020 08:17:04 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 08:14:58 PDT (-0700)
Subject:     Re: [RFC PATCH 2/7] riscv: Allow to dynamically define VA_BITS
In-Reply-To: <20200322110028.18279-3-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-1f8477e3-7cb4-454f-b443-8cf032325385@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:23 PDT (-0700), alex@ghiti.fr wrote:
> With 4-level page table folding at runtime, we don't know at compile time
> the size of the virtual address space so we must set VA_BITS dynamically
> so that sparsemem reserves the right amount of memory for struct pages.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig                 | 10 ----------
>  arch/riscv/include/asm/pgtable.h   | 10 +++++++++-
>  arch/riscv/include/asm/sparsemem.h |  2 +-
>  3 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f5f3d474504d..8e4b1cbcf2c2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -99,16 +99,6 @@ config ZONE_DMA32
>  	bool
>  	default y if 64BIT
>
> -config VA_BITS
> -	int
> -	default 32 if 32BIT
> -	default 39 if 64BIT
> -
> -config PA_BITS
> -	int
> -	default 34 if 32BIT
> -	default 56 if 64BIT
> -
>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 185ffe3723ec..dce401eed1d3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -26,6 +26,14 @@
>  #endif /* CONFIG_64BIT */
>
>  #ifdef CONFIG_MMU
> +#ifdef CONFIG_64BIT
> +#define VA_BITS		39
> +#define PA_BITS		56
> +#else
> +#define VA_BITS		32
> +#define PA_BITS		34

We've moved to 32-bit physical addresses on rv32 in Linux.  The mismatch was
causing too many issues in generic code.

> +#endif
> +
>  /* Number of entries in the page global directory */
>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>  /* Number of entries in the page table */
> @@ -108,7 +116,7 @@ extern pgd_t swapper_pg_dir[];
>   * position vmemmap directly below the VMALLOC region.
>   */
>  #define VMEMMAP_SHIFT \
> -	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>  #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
>  #define VMEMMAP_END	(VMALLOC_START - 1)
>  #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
> index 45a7018a8118..f08d72155bc8 100644
> --- a/arch/riscv/include/asm/sparsemem.h
> +++ b/arch/riscv/include/asm/sparsemem.h
> @@ -4,7 +4,7 @@
>  #define _ASM_RISCV_SPARSEMEM_H
>
>  #ifdef CONFIG_SPARSEMEM
> -#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
> +#define MAX_PHYSMEM_BITS	PA_BITS
>  #define SECTION_SIZE_BITS	27
>  #endif /* CONFIG_SPARSEMEM */

Aside from the 32-bit PA issue:

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
