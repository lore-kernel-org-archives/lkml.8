Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6B7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D20620776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="VF36gC7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgFSArp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgFSAro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:47:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B026C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:47:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so3531657wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSUmoRRwgG54n+dXHVLG7g+3QD6ietfWE7Sc1nJWilA=;
        b=VF36gC7rzlmmpFllwB7XmfOD3rj0Qjlb+6Xqyr5EC9avDZVM6t/m01GDWsT8he5R64
         xFbfR7DIW3ZUy0oClJNFpyePtaFDzMgvExc7mI8KuuOZye7wYH+3sPiYR1KGDagpuGR4
         99fm8PVCja6oeGgtKfTD5MFQwx5qKklJ3CJw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSUmoRRwgG54n+dXHVLG7g+3QD6ietfWE7Sc1nJWilA=;
        b=bcGM/63ZuZ8JZZixj0QkyazONm2jsnpP0h1vKNw1sTMIRJIi/2eJAyRORaNMKME78v
         5wYiwrrxEXFS7INA+ZL1fonoJJCaY1N1Z0u3+EBAfrwoCBD34w9VlG8KgfQhFS9CTTm9
         FZbSJvdwrbswasLsvneQZpof372SNMRrsGO26wMd87qWYLS58Is0wDIfbx+rBf5rKh4Q
         f9BHDTp2D5OA6q3biBFunktZ5LbHdt56YSpygebXzxaeTPrCnyQ3DTr4UfmrUkQON6XW
         4kDMJAWO/7vgXbWqRbpad+OdBqaXNwdpSgSUD/g/vMBIqumVOBiL4i6BCyQIXAjXM3xC
         +Ncg==
X-Gm-Message-State: AOAM531NCfVaTqxCP0X9ZHmlHtRnmqHSSVbzDFDxxAc0IcKqdIGdedXs
        P8qtP4rw5yHga0xvd64r1V4nj8IGDOsR3V0L1E6k
X-Google-Smtp-Source: ABdhPJz9zYdaqyLnH397zu71ZXl/G09ckac2ECxf7ZqVDMAeEIzdHpFygif1q2ViADdhDdE3MQLvGR9Vjf1rUA++Wx4=
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr925037wmu.55.1592527661718;
 Thu, 18 Jun 2020 17:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200603153608.30056-1-alex@ghiti.fr> <20200603153608.30056-3-alex@ghiti.fr>
In-Reply-To: <20200603153608.30056-3-alex@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 18 Jun 2020 17:47:30 -0700
Message-ID: <CAOnJCU+JSuOGbOmZW-vqb-A_qR7CJc=qG16FbgOLWSm1vhJH1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Use PUD/PGDIR entries for linear mapping when possible
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 8:38 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Improve best_map_size so that PUD or PGDIR entries are used for linear
> mapping when possible as it allows better TLB utilization.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 45 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9a5c97e091c1..d275f9f834cf 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -424,13 +424,29 @@ static void __init create_pgd_mapping(pgd_t *pgdp,
>         create_pgd_next_mapping(nextp, va, pa, sz, prot);
>  }
>
> -static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
> +static bool is_map_size_ok(uintptr_t map_size, phys_addr_t base,
> +                          uintptr_t base_virt, phys_addr_t size)
>  {
> -       /* Upgrade to PMD_SIZE mappings whenever possible */
> -       if ((base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
> -               return PAGE_SIZE;
> +       return !((base & (map_size - 1)) || (base_virt & (map_size - 1)) ||
> +                       (size < map_size));
> +}
> +
> +static uintptr_t __init best_map_size(phys_addr_t base, uintptr_t base_virt,
> +                                     phys_addr_t size)
> +{
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       if (is_map_size_ok(PGDIR_SIZE, base, base_virt, size))
> +               return PGDIR_SIZE;
> +
> +       if (pgtable_l4_enabled)
> +               if (is_map_size_ok(PUD_SIZE, base, base_virt, size))
> +                       return PUD_SIZE;
> +#endif
> +
> +       if (is_map_size_ok(PMD_SIZE, base, base_virt, size))
> +               return PMD_SIZE;
>
> -       return PMD_SIZE;
> +       return PAGE_SIZE;
>  }
>
>  /*
> @@ -576,7 +592,7 @@ void create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
>         uintptr_t va, end_va;
> -       uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
> +       uintptr_t map_size;
>
>         load_pa = (uintptr_t)(&_start);
>         load_sz = (uintptr_t)(&_end) - load_pa;
> @@ -587,6 +603,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>
>         kernel_virt_addr = KERNEL_VIRT_ADDR;
>
> +       map_size = best_map_size(load_pa, PAGE_OFFSET, MAX_EARLY_MAPPING_SIZE);
>         va_pa_offset = PAGE_OFFSET - load_pa;
>         va_kernel_pa_offset = kernel_virt_addr - load_pa;
>         pfn_base = PFN_DOWN(load_pa);
> @@ -700,6 +717,8 @@ static void __init setup_vm_final(void)
>
>         /* Map all memory banks */
>         for_each_memblock(memory, reg) {
> +               uintptr_t remaining_size;
> +
>                 start = reg->base;
>                 end = start + reg->size;
>
> @@ -707,15 +726,19 @@ static void __init setup_vm_final(void)
>                         break;
>                 if (memblock_is_nomap(reg))
>                         continue;
> -               if (start <= __pa(PAGE_OFFSET) &&
> -                   __pa(PAGE_OFFSET) < end)
> -                       start = __pa(PAGE_OFFSET);
>
> -               map_size = best_map_size(start, end - start);
> -               for (pa = start; pa < end; pa += map_size) {
> +               pa = start;
> +               remaining_size = reg->size;
> +
> +               while (remaining_size) {
>                         va = (uintptr_t)__va(pa);
> +                       map_size = best_map_size(pa, va, remaining_size);
> +
>                         create_pgd_mapping(swapper_pg_dir, va, pa,
>                                            map_size, PAGE_KERNEL);
> +
> +                       pa += map_size;
> +                       remaining_size -= map_size;
>                 }
>         }
>

This may not work in the RV32 with 2G memory  and if the map_size is
determined to be a page size
for the last memblock. Both pa & remaining_size will overflow and the
loop will try to map memory from zero again.

> --
> 2.20.1
>
>


-- 
Regards,
Atish
