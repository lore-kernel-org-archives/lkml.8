Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E8420776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="jjNIyjfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2MEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2MEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:04:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:04:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so3201115wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3y7LTD9AD7dxyNaYLN2SnZdb5ROvk4Iq8+UPh7UEJMs=;
        b=jjNIyjfDdBX8IhWI95CzoJFu/QkJ14S3qwoQ2yB9sTd61kHsspVkpnnE+D2DZpk9SF
         W9G+xLk31DBnvVaTBlvcLlj/qW5Ay0xhRt+oq2RoKccBmTq/ru25RFKI9LPOMNKcw9Z6
         bTj1IWg9NhvrEDqtyZbDjuQKiWyDILoOkirAhZBFKIt7GBoODZGwap2X1+Oef3bOAlH3
         pfSWpgY/bMr9sm1EKdKtfUqJytJh1BZhDXmfw/bIsCkxFWU8MykI5zRjozfGtCm90MXx
         3Z8edoPkygb+dSLolXuiRocn+LfHXvGMppA4R5kuCm12OUMVWeFrWWTSgup1V/QcWPzq
         dsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3y7LTD9AD7dxyNaYLN2SnZdb5ROvk4Iq8+UPh7UEJMs=;
        b=XdNWCsJt7+AHQOmR+KJCwWxIb6hq4QwW1fnhLNCvDntU6Ztvwdh1Bih/phw43jJtwp
         WUGTgJ1YB9whSgZTTKd7dFsePHgQ74RQltOJ7MKBl5Q1nsaHxUP+ZXZ/IKJHdS2GfW5Y
         SiVbMAIoEzf35YNpfP4YrJbAr1a2yQkA8YVxl+V68ncfutBEhLyWG9T2mZ8K9IxpaNBb
         7oCbNYvP8x6+XEtQYrF71sTlzxRfM1BiCWdvz61sZXdxOnzN/hOyEWEQ6gBOaSOWV+rG
         K4dAL6La6ODo3jPDaaJMjVDThARHIqk3fdGH4YwHG6UBB3xJ8QUamUqCcMOYi7wDzRXK
         shLg==
X-Gm-Message-State: AOAM530gsslNu+uodxnmmZJUZrjKCbdxYKbVmM3oKuewSCs4sCsZr+3Z
        pBSG2DEMpofpsYujDDowD01BnZy3WTGEEcvvYTeW5Q==
X-Google-Smtp-Source: ABdhPJzg+ym/y98ybnXUfydVlHFoxgm/PTrRkwy7qy7w9T+TbpcEM1hFNm66mrIrKKBKjbD6TgkVe95KZTZnt4T6kfE=
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr9011300wrx.128.1590753892041;
 Fri, 29 May 2020 05:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200524085259.24784-1-alex@ghiti.fr> <20200524085259.24784-3-alex@ghiti.fr>
In-Reply-To: <20200524085259.24784-3-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 May 2020 17:34:39 +0530
Message-ID: <CAAhSdy0XX8dAa8Ebm7CBgjxCejqA=GN_3n04K3hsNiwCrW7U3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] riscv: Introduce CONFIG_RELOCATABLE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Zong Li <zong.li@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 2:25 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This config allows to compile the kernel as PIE and to relocate it at
> any virtual address at runtime: this paves the way to KASLR and to 4-level
> page table folding at runtime. Runtime relocation is possible since
> relocation metadata are embedded into the kernel.
>
> Note that relocating at runtime introduces an overhead even if the
> kernel is loaded at the same address it was linked at and that the compiler
> options are those used in arm64 which uses the same RELA relocation
> format.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig              | 12 +++++++
>  arch/riscv/Makefile             |  5 ++-
>  arch/riscv/kernel/vmlinux.lds.S |  6 ++--
>  arch/riscv/mm/Makefile          |  4 +++
>  arch/riscv/mm/init.c            | 63 +++++++++++++++++++++++++++++++++
>  5 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a31e1a41913a..93127d5913fe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -170,6 +170,18 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
>
> +config RELOCATABLE
> +       bool
> +       depends on MMU
> +       help
> +          This builds a kernel as a Position Independent Executable (PIE),
> +          which retains all relocation metadata required to relocate the
> +          kernel binary at runtime to a different virtual address than the
> +          address it was linked at.
> +          Since RISCV uses the RELA relocation format, this requires a
> +          relocation pass at runtime even if the kernel is loaded at the
> +          same address it was linked at.
> +
>  source "arch/riscv/Kconfig.socs"
>
>  menu "Platform type"
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index fb6e37db836d..1406416ea743 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -9,7 +9,10 @@
>  #
>
>  OBJCOPYFLAGS    := -O binary
> -LDFLAGS_vmlinux :=
> +ifeq ($(CONFIG_RELOCATABLE),y)
> +LDFLAGS_vmlinux := -shared -Bsymbolic -z notext -z norelro
> +KBUILD_CFLAGS += -fPIE
> +endif
>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>         LDFLAGS_vmlinux := --no-relax
>  endif
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index a9abde62909f..e8ffba8c2044 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -85,8 +85,10 @@ SECTIONS
>
>         BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>
> -       .rel.dyn : {
> -               *(.rel.dyn*)
> +       .rela.dyn : ALIGN(8) {
> +               __rela_dyn_start = .;
> +               *(.rela .rela*)
> +               __rela_dyn_end = .;
>         }
>
>         _end = .;
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 363ef01c30b1..dc5cdaa80bc1 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -1,6 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  CFLAGS_init.o := -mcmodel=medany
> +ifdef CONFIG_RELOCATABLE
> +CFLAGS_init.o += -fno-pie
> +endif
> +
>  ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_init.o = -pg
>  endif
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 17f108baec4f..7074522d40c6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -13,6 +13,9 @@
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
>  #include <linux/set_memory.h>
> +#ifdef CONFIG_RELOCATABLE
> +#include <linux/elf.h>
> +#endif
>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
> @@ -379,6 +382,53 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
>  #endif
>
> +#ifdef CONFIG_RELOCATABLE
> +extern unsigned long __rela_dyn_start, __rela_dyn_end;
> +
> +#ifdef CONFIG_64BIT
> +#define Elf_Rela Elf64_Rela
> +#define Elf_Addr Elf64_Addr
> +#else
> +#define Elf_Rela Elf32_Rela
> +#define Elf_Addr Elf32_Addr
> +#endif
> +
> +void __init relocate_kernel(uintptr_t load_pa)
> +{
> +       Elf_Rela *rela = (Elf_Rela *)&__rela_dyn_start;
> +       /*
> +        * This holds the offset between the linked virtual address and the
> +        * relocated virtual address.
> +        */
> +       uintptr_t reloc_offset = kernel_virt_addr - KERNEL_LINK_ADDR;
> +       /*
> +        * This holds the offset between kernel linked virtual address and
> +        * physical address.
> +        */
> +       uintptr_t va_kernel_link_pa_offset = KERNEL_LINK_ADDR - load_pa;
> +
> +       for ( ; rela < (Elf_Rela *)&__rela_dyn_end; rela++) {
> +               Elf_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
> +               Elf_Addr relocated_addr = rela->r_addend;
> +
> +               if (rela->r_info != R_RISCV_RELATIVE)
> +                       continue;
> +
> +               /*
> +                * Make sure to not relocate vdso symbols like rt_sigreturn
> +                * which are linked from the address 0 in vmlinux since
> +                * vdso symbol addresses are actually used as an offset from
> +                * mm->context.vdso in VDSO_OFFSET macro.
> +                */
> +               if (relocated_addr >= KERNEL_LINK_ADDR)
> +                       relocated_addr += reloc_offset;
> +
> +               *(Elf_Addr *)addr = relocated_addr;
> +       }
> +}
> +
> +#endif
> +
>  static uintptr_t load_pa, load_sz;
>
>  void create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
> @@ -405,6 +455,19 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>
>         pfn_base = PFN_DOWN(load_pa);
>
> +#ifdef CONFIG_RELOCATABLE
> +#ifdef CONFIG_64BIT
> +       /*
> +        * Early page table uses only one PGDIR, which makes it possible
> +        * to map PGDIR_SIZE aligned on PGDIR_SIZE: if the relocation offset
> +        * makes the kernel cross over a PGDIR_SIZE boundary, raise a bug
> +        * since a part of the kernel would not get mapped.
> +        * This cannot happen on rv32 as we use the entire page directory level.
> +        */
> +       BUG_ON(PGDIR_SIZE - (kernel_virt_addr & (PGDIR_SIZE - 1)) < load_sz);
> +#endif
> +       relocate_kernel(load_pa);
> +#endif
>         /*
>          * Enforce boot alignment requirements of RV32 and
>          * RV64 by only allowing PMD or PGD mappings.
> --
> 2.20.1
>
>

Looks good to me as well.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
