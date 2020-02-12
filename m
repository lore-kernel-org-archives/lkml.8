Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9270C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D96C20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yq7kEkwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBLESm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:18:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39207 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLESl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so497235wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 20:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArsqRBwFCDQFmJjaAOG0lbeuON4s+vxOWLsIsCpXzF0=;
        b=yq7kEkwR6yY/A2mPTK/4zRGYThBBXDWZg/iJGRToSHTKqdAufRzywXK14/y36SzTrv
         1DpaVzzpHdTK+mb5VG/P8a7FEYUAWWF+ydzUfOl3LoAIS71WuyJvoiry78POty+r9hTK
         icBPnB5vfdZ0QC88DGUNOjK94JkpswUBn+aLY4XPpiLo4wZhQyELFSskVu9iNv2toorY
         Cme25ynBkxlYdUCl75FT2dOgL2Ep91xryKykdmCsjfNhkBbXpGYZAGE41WqXkU3YwvnR
         zXmoZoIbYhvCsLitQAQdahsUC+s/7V0lfD6wWJlTtB5rFikllQZvpYTtxG+8arZFhMCm
         M4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArsqRBwFCDQFmJjaAOG0lbeuON4s+vxOWLsIsCpXzF0=;
        b=oPDpJDLDv2+tYxKZCXW1Sv44PX9RCciWL1SPcUNp00kxhydpuAaUIySu5SnYM44CI0
         eA8ZeL3K2uPPMP5mEOpPSNIRuo/aTJLQ661bZCcuLl397gIGDFataGutd0z1aUVTMCh2
         UXMkmwzRlnCCml9xGQc+E3UrnPKZ57k37hzLvVZRZP3ZG9FW6e1ZeSg3hs16NPO5vzIw
         IQUFEn6r3LAkMcDb60jkCYkWAaCtwj8/ylfLXpy2SH3D3GljVpo2g8NupF62rchZWrkw
         cl6jpEiM7JMTk4yXeSJ0wb7bTroMmtd/i8oT95H1hH4gWlKjXXvwdas4I+BgIi+wqPI3
         RDYg==
X-Gm-Message-State: APjAAAVBk69Eic6zrr2ym5GywRJbc80H7yH2EVzBjUE9zY1VbFTc9XWO
        VV4brqMJ99lxhgO1AM0nLfZ0tAB3n61Wkh7LOz3jCg==
X-Google-Smtp-Source: APXvYqwpUiS2Lp1rXar8NZkoeRDlVYsmEIzb/nDeNhHXRHRIEhoz9uavRNS4rW+lM4L0mSmDnuWdqhb6m+s/ADOD/gw=
X-Received: by 2002:a1c:6246:: with SMTP id w67mr9682916wmb.141.1581481118704;
 Tue, 11 Feb 2020 20:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-7-atish.patra@wdc.com>
In-Reply-To: <20200212014822.28684-7-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Feb 2020 09:48:27 +0530
Message-ID: <CAAhSdy2YRnmdxYu7zSYOUxMvFDbEz1Cwg69FgnYz3Rd8wEwQfw@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] RISC-V: Move relocate and few other functions
 out of __init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:21 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> The secondary hart booting and relocation code are under .init section.
> As a result, it will be freed once kernel booting is done. However,
> ordered booting protocol and CPU hotplug always requires these sections

I think you meant "... require these functions" here.

> to be present to bringup harts after initial kernel boot.
>
> Move the required sections to a different section and make sure that

Same here, I think you meant "... the required functions to a
different section ..."

> they are in memory within first 2MB offset as trampoline page directory
> only maps first 2MB.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/head.S        | 153 +++++++++++++++++---------------
>  arch/riscv/kernel/vmlinux.lds.S |   5 +-
>  2 files changed, 86 insertions(+), 72 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index a4242be66966..c1be597d22a1 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -14,7 +14,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/image.h>
>
> -__INIT
> +__HEAD
>  ENTRY(_start)
>         /*
>          * Image header expected by Linux boot-loaders. The image header data
> @@ -45,8 +45,85 @@ ENTRY(_start)
>         .ascii RISCV_IMAGE_MAGIC2
>         .word 0
>
> -.global _start_kernel
> -_start_kernel:
> +.align 2
> +#ifdef CONFIG_MMU
> +relocate:
> +       /* Relocate return address */
> +       li a1, PAGE_OFFSET
> +       la a2, _start
> +       sub a1, a1, a2
> +       add ra, ra, a1
> +
> +       /* Point stvec to virtual address of intruction after satp write */
> +       la a2, 1f
> +       add a2, a2, a1
> +       csrw CSR_TVEC, a2
> +
> +       /* Compute satp for kernel page tables, but don't load it yet */
> +       srl a2, a0, PAGE_SHIFT
> +       li a1, SATP_MODE
> +       or a2, a2, a1
> +
> +       /*
> +        * Load trampoline page directory, which will cause us to trap to
> +        * stvec if VA != PA, or simply fall through if VA == PA.  We need a
> +        * full fence here because setup_vm() just wrote these PTEs and we need
> +        * to ensure the new translations are in use.
> +        */
> +       la a0, trampoline_pg_dir
> +       srl a0, a0, PAGE_SHIFT
> +       or a0, a0, a1
> +       sfence.vma
> +       csrw CSR_SATP, a0
> +.align 2
> +1:
> +       /* Set trap vector to spin forever to help debug */
> +       la a0, .Lsecondary_park
> +       csrw CSR_TVEC, a0
> +
> +       /* Reload the global pointer */
> +.option push
> +.option norelax
> +       la gp, __global_pointer$
> +.option pop
> +
> +       /*
> +        * Switch to kernel page tables.  A full fence is necessary in order to
> +        * avoid using the trampoline translations, which are only correct for
> +        * the first superpage.  Fetching the fence is guarnteed to work
> +        * because that first superpage is translated the same way.
> +        */
> +       csrw CSR_SATP, a2
> +       sfence.vma
> +
> +       ret
> +#endif /* CONFIG_MMU */
> +#ifdef CONFIG_SMP
> +       /* Set trap vector to spin forever to help debug */
> +       la a3, .Lsecondary_park
> +       csrw CSR_TVEC, a3
> +
> +       slli a3, a0, LGREG
> +       .global secondary_start_common
> +secondary_start_common:
> +
> +#ifdef CONFIG_MMU
> +       /* Enable virtual memory and relocate to virtual address */
> +       la a0, swapper_pg_dir
> +       call relocate
> +#endif
> +       tail smp_callin
> +#endif /* CONFIG_SMP */
> +
> +.Lsecondary_park:
> +       /* We lack SMP support or have too many harts, so park this hart */
> +       wfi
> +       j .Lsecondary_park
> +
> +END(_start)
> +
> +       __INIT
> +ENTRY(_start_kernel)
>         /* Mask all interrupts */
>         csrw CSR_IE, zero
>         csrw CSR_IP, zero
> @@ -125,59 +202,6 @@ clear_bss_done:
>         call parse_dtb
>         tail start_kernel
>
> -#ifdef CONFIG_MMU
> -relocate:
> -       /* Relocate return address */
> -       li a1, PAGE_OFFSET
> -       la a2, _start
> -       sub a1, a1, a2
> -       add ra, ra, a1
> -
> -       /* Point stvec to virtual address of intruction after satp write */
> -       la a2, 1f
> -       add a2, a2, a1
> -       csrw CSR_TVEC, a2
> -
> -       /* Compute satp for kernel page tables, but don't load it yet */
> -       srl a2, a0, PAGE_SHIFT
> -       li a1, SATP_MODE
> -       or a2, a2, a1
> -
> -       /*
> -        * Load trampoline page directory, which will cause us to trap to
> -        * stvec if VA != PA, or simply fall through if VA == PA.  We need a
> -        * full fence here because setup_vm() just wrote these PTEs and we need
> -        * to ensure the new translations are in use.
> -        */
> -       la a0, trampoline_pg_dir
> -       srl a0, a0, PAGE_SHIFT
> -       or a0, a0, a1
> -       sfence.vma
> -       csrw CSR_SATP, a0
> -.align 2
> -1:
> -       /* Set trap vector to spin forever to help debug */
> -       la a0, .Lsecondary_park
> -       csrw CSR_TVEC, a0
> -
> -       /* Reload the global pointer */
> -.option push
> -.option norelax
> -       la gp, __global_pointer$
> -.option pop
> -
> -       /*
> -        * Switch to kernel page tables.  A full fence is necessary in order to
> -        * avoid using the trampoline translations, which are only correct for
> -        * the first superpage.  Fetching the fence is guarnteed to work
> -        * because that first superpage is translated the same way.
> -        */
> -       csrw CSR_SATP, a2
> -       sfence.vma
> -
> -       ret
> -#endif /* CONFIG_MMU */
> -
>  .Lsecondary_start:
>  #ifdef CONFIG_SMP
>         /* Set trap vector to spin forever to help debug */
> @@ -202,16 +226,10 @@ relocate:
>         beqz tp, .Lwait_for_cpu_up
>         fence
>
> -#ifdef CONFIG_MMU
> -       /* Enable virtual memory and relocate to virtual address */
> -       la a0, swapper_pg_dir
> -       call relocate
> +       tail secondary_start_common
>  #endif
>
> -       tail smp_callin
> -#endif
> -
> -END(_start)
> +END(_start_kernel)
>
>  #ifdef CONFIG_RISCV_M_MODE
>  ENTRY(reset_regs)
> @@ -292,13 +310,6 @@ ENTRY(reset_regs)
>  END(reset_regs)
>  #endif /* CONFIG_RISCV_M_MODE */
>
> -.section ".text", "ax",@progbits
> -.align 2
> -.Lsecondary_park:
> -       /* We lack SMP support or have too many harts, so park this hart */
> -       wfi
> -       j .Lsecondary_park
> -
>  __PAGE_ALIGNED_BSS
>         /* Empty zero page */
>         .balign PAGE_SIZE
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 12f42f96d46e..18c397953bfc 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -10,6 +10,7 @@
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
>
> +#include <linux/sizes.h>
>  OUTPUT_ARCH(riscv)
>  ENTRY(_start)
>
> @@ -20,8 +21,10 @@ SECTIONS
>         /* Beginning of code and text segment */
>         . = LOAD_OFFSET;
>         _start = .;
> -       __init_begin = .;
>         HEAD_TEXT_SECTION
> +       . = ALIGN(PAGE_SIZE);
> +
> +       __init_begin = .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
>         INIT_DATA_SECTION(16)
>         /* we have to discard exit text and such at runtime, not link time */
> --
> 2.24.0
>

Apart from above nit in commit description, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
