Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B71FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1A520719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="QtYjUzf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgCZGMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:12:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCZGMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:12:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so6275812wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iVJEBE2l6FzbfPyR2ep6scPrGoajxaZ4h+lpNzkdaU=;
        b=QtYjUzf2P1l3aZ5ViM0AXCBNEOmeCg7YkcK9AKPKQkAxtoYvAEzhuiIGxUC93SLGJB
         SWZqn9Ip8CnObGCYhZoyKQ6goFeZwS7ZgT7qoZOiKXCWz+KNIXTIvJ8f3OcziFoDm/lU
         vJGeYXQgq/Ps18Q/m+RuVGx5YNIfnC/f4RM7oC878jRwQB1vsHXtwP9leiPXy0rLwpff
         15FG4NQCoU9Ro8TgJW5sDX099+gN/CyeFtLaDZgFUQ8309kCFYwo2zptEO5qkEB85zP8
         X37hqA59dosccmGC/Hr+EXMwCl1Y0dgSPT5K4y8vQbZyxjhxyU+draLsHUjksR7BRXnW
         7V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iVJEBE2l6FzbfPyR2ep6scPrGoajxaZ4h+lpNzkdaU=;
        b=LLU1k+9QGFd2uHPbntDCuU35pBOi4b3Y9pQ3RrWiQNHJTu/cUE6y/mfU+fgSIrt64z
         zadK0wgf5wXaHyJxUe7AgUp+OMiNl3YD09d33IyD/hm2TZtzZrUR3i3TMJtAAPtL7u8o
         343DjWzz+KJiHNm+nEZ/RaychbuAAkWws6LPDoga/B9yaTptsl2i0GbiI8kGgoAvjopu
         b4OP2zGTVse9V7O9GEc3bDN7COnUPAivuXojmDI79R60k67C2oDmMUToja2zIl5s6pwg
         g4TdgQQi0kUzmz7WLbTGObOGVVbnTjxVh1oWSPTcpckja3IAj3U2nfc6iloPkJ9M+iRA
         +CPg==
X-Gm-Message-State: ANhLgQ0c8xVFdoog7CwLjryxR122HsFFzje1dAI9IMuC1CthYHVeodP+
        ycM7RwtHXhwveBUvvH9qB7Att3tsMnMHaRHwprTVXOwgZ2w=
X-Google-Smtp-Source: ADFU+vsGBcgrtymYA34TGX39gbGyDbIzJbSU5IUH9Cuy+Iq3wu9SECnH/1EMq8qEeGQG6GaxjYtwW03efdZ5dyifAf8=
X-Received: by 2002:adf:f309:: with SMTP id i9mr7987326wro.0.1585203140990;
 Wed, 25 Mar 2020 23:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200322110028.18279-1-alex@ghiti.fr> <20200322110028.18279-3-alex@ghiti.fr>
In-Reply-To: <20200322110028.18279-3-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Mar 2020 11:42:07 +0530
Message-ID: <CAAhSdy2er5y4xTBFFsR3Sx2Jffn=5Pn3KHXopwdOTCC5UJRmDA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] riscv: Allow to dynamically define VA_BITS
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 4:32 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
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
>         bool
>         default y if 64BIT
>
> -config VA_BITS
> -       int
> -       default 32 if 32BIT
> -       default 39 if 64BIT
> -
> -config PA_BITS
> -       int
> -       default 34 if 32BIT
> -       default 56 if 64BIT
> -
>  config PAGE_OFFSET
>         hex
>         default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 185ffe3723ec..dce401eed1d3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -26,6 +26,14 @@
>  #endif /* CONFIG_64BIT */
>
>  #ifdef CONFIG_MMU
> +#ifdef CONFIG_64BIT
> +#define VA_BITS                39
> +#define PA_BITS                56
> +#else
> +#define VA_BITS                32
> +#define PA_BITS                34
> +#endif
> +
>  /* Number of entries in the page global directory */
>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>  /* Number of entries in the page table */
> @@ -108,7 +116,7 @@ extern pgd_t swapper_pg_dir[];
>   * position vmemmap directly below the VMALLOC region.
>   */
>  #define VMEMMAP_SHIFT \
> -       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +       (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>  #define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
>  #define VMEMMAP_END    (VMALLOC_START - 1)
>  #define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
> index 45a7018a8118..f08d72155bc8 100644
> --- a/arch/riscv/include/asm/sparsemem.h
> +++ b/arch/riscv/include/asm/sparsemem.h
> @@ -4,7 +4,7 @@
>  #define _ASM_RISCV_SPARSEMEM_H
>
>  #ifdef CONFIG_SPARSEMEM
> -#define MAX_PHYSMEM_BITS       CONFIG_PA_BITS
> +#define MAX_PHYSMEM_BITS       PA_BITS
>  #define SECTION_SIZE_BITS      27
>  #endif /* CONFIG_SPARSEMEM */
>
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
