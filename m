Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D8C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 04:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3EE24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 04:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CAVtxB1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA1Eik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:38:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA1Eij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 23:38:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so1013218wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 20:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82xCouEOgXgPfafFApuTdamqdwWO/M5ipkbPri7A61c=;
        b=CAVtxB1BNJdIHFMnLatJjaTjN4FMrHmK93B+RuvgOCQRHWDRsa+D/DhsicZrJKj7Du
         6EpyeNlMr2QH/pd7f9jRmhAA8F8WY4CajMUQc+1m7BuuJC4loIn2E7b+MaxIQY3VByLr
         M5Lx795Lh9A2+gH6zuT3XrI2Uc6mxy+/Br2lKtWBRJJ/tc6wrluyEYIOTDEBDkOrmF7N
         SgC5I612/I+y6bcNvcW7zv8CoG0i5tZrUfkqbIMgWcuj65rJGDixGieyjK4p2WFqtLlM
         HiAzhUFkxHW6s5Ms+rLFqsbmCL57mC/yWX6WjqqfeNU13TLdyUMQ0sGiaKsvSmLBsQvg
         flKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82xCouEOgXgPfafFApuTdamqdwWO/M5ipkbPri7A61c=;
        b=VWHKs37DVdIpVb25LLgkuQ9aQLKEsEzsG2CwKGM7qyRmJweVmjZWCGZ45ga9LmQ0Li
         rLA89LWzNxkEUtIC30qzAxfJ60+RKG5j53P7Q2zEyEvM3R8MpxM0Ipcpl0WNNZ6goqXL
         5H9D8z2Jkpn4e1dkplUylQIDzes9yHjcdebkV3zVy6H6nrI0vDxio5huWsCzStTsOrQV
         pLj+EEK5i8edc2TnYXf+HhCZvz03Dfm01w0vBm1YqZcm2mndVG0O+AKeOYsz7sW+O6Ys
         Q4I5MkMLEmJNrFRZ/UodD/LtOUTUoDnm8gXWZ7gsfyJDPOvT91uDjeA/radm+t3W1+yS
         7VOQ==
X-Gm-Message-State: APjAAAVLneFWBksRpy1kBBv3mAuZviZlxoiEtu4O4nzuzkwbI05EkgyU
        nFwqGSoEznves7MwtCyOrtUEbmDyNER3CMRruKJq/XfAHrE=
X-Google-Smtp-Source: APXvYqx/wXFQrz8wNVMwNwG5fd0Jha10J/uWXlKUsq619TFZrzwtpIZEhcqTgeNb/24uvbt7H/ma4vl+kGx04mxsBFg=
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr2434517wmd.102.1580186315507;
 Mon, 27 Jan 2020 20:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20200128022737.15371-1-atish.patra@wdc.com> <20200128022737.15371-8-atish.patra@wdc.com>
In-Reply-To: <20200128022737.15371-8-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 28 Jan 2020 10:08:24 +0530
Message-ID: <CAAhSdy3oktrDNZ01Um5wE8cy2PC5SZdeNDMWjRTmm7k1aHkk_A@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] RISC-V: Move relocate and few other functions
 out of __init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Abner Chang <abner.chang@hpe.com>, Chester Lin <clin@suse.com>,
        nickhu@andestech.com, Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 7:58 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> The secondary hart booting and relocation code are under .init section.
> As a result, it will be freed once kernel booting is done. However,
> ordered booting protocol and CPU hotplug always requires these sections
> to be present to bringup harts after initial kernel boot.
>
> Move the required sections to a different section and make sure that
> they are in memory within first 2MB offset as trampoline page directory
> only maps first 2MB.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/head.S        | 73 +++++++++++++++++++--------------
>  arch/riscv/kernel/vmlinux.lds.S |  9 +++-
>  2 files changed, 50 insertions(+), 32 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index a4242be66966..9d7f084a50cc 100644
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
> @@ -44,9 +44,10 @@ ENTRY(_start)
>         .balign 4
>         .ascii RISCV_IMAGE_MAGIC2
>         .word 0
> +END(_start)
>
> -.global _start_kernel
> -_start_kernel:
> +       __INIT
> +ENTRY(_start_kernel)
>         /* Mask all interrupts */
>         csrw CSR_IE, zero
>         csrw CSR_IP, zero
> @@ -125,6 +126,37 @@ clear_bss_done:
>         call parse_dtb
>         tail start_kernel
>
> +.Lsecondary_start:
> +#ifdef CONFIG_SMP
> +       /* Set trap vector to spin forever to help debug */
> +       la a3, .Lsecondary_park
> +       csrw CSR_TVEC, a3
> +
> +       slli a3, a0, LGREG
> +       la a1, __cpu_up_stack_pointer
> +       la a2, __cpu_up_task_pointer
> +       add a1, a3, a1
> +       add a2, a3, a2
> +
> +       /*
> +        * This hart didn't win the lottery, so we wait for the winning hart to
> +        * get far enough along the boot process that it should continue.
> +        */
> +.Lwait_for_cpu_up:
> +       /* FIXME: We should WFI to save some energy here. */
> +       REG_L sp, (a1)
> +       REG_L tp, (a2)
> +       beqz sp, .Lwait_for_cpu_up
> +       beqz tp, .Lwait_for_cpu_up
> +       fence
> +
> +       tail secondary_start_common
> +#endif
> +
> +END(_start_kernel)
> +
> +.section ".noinit.text","ax",@progbits
> +.align 2

Try to use __HEAD here (if possible).

>  #ifdef CONFIG_MMU
>  relocate:
>         /* Relocate return address */
> @@ -177,41 +209,27 @@ relocate:
>
>         ret
>  #endif /* CONFIG_MMU */
> -
> -.Lsecondary_start:
>  #ifdef CONFIG_SMP
>         /* Set trap vector to spin forever to help debug */
>         la a3, .Lsecondary_park
>         csrw CSR_TVEC, a3
>
>         slli a3, a0, LGREG
> -       la a1, __cpu_up_stack_pointer
> -       la a2, __cpu_up_task_pointer
> -       add a1, a3, a1
> -       add a2, a3, a2
> -
> -       /*
> -        * This hart didn't win the lottery, so we wait for the winning hart to
> -        * get far enough along the boot process that it should continue.
> -        */
> -.Lwait_for_cpu_up:
> -       /* FIXME: We should WFI to save some energy here. */
> -       REG_L sp, (a1)
> -       REG_L tp, (a2)
> -       beqz sp, .Lwait_for_cpu_up
> -       beqz tp, .Lwait_for_cpu_up
> -       fence
> +       .global secondary_start_common
> +secondary_start_common:
>
>  #ifdef CONFIG_MMU
>         /* Enable virtual memory and relocate to virtual address */
>         la a0, swapper_pg_dir
>         call relocate
>  #endif
> -
>         tail smp_callin
> -#endif
> +#endif /* CONFIG_SMP */
>
> -END(_start)
> +.Lsecondary_park:
> +       /* We lack SMP support or have too many harts, so park this hart */
> +       wfi
> +       j .Lsecondary_park
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
> index 12f42f96d46e..c8a88326df9e 100644
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
> @@ -20,8 +21,14 @@ SECTIONS
>         /* Beginning of code and text segment */
>         . = LOAD_OFFSET;
>         _start = .;
> -       __init_begin = .;
>         HEAD_TEXT_SECTION
> +       .noinit.text :
> +       {
> +               *(.noinit.text)
> +       }

Can we try using HEAD_TEXT_SECTION for SMP booting
related functions instead of new ".noinit.text" section ??

> +       . = ALIGN(SZ_4K);

Change this to PAGE aligned:
    . = ALIGN(PAGE_SIZE)

> +
> +       __init_begin = .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
>         INIT_DATA_SECTION(16)
>         /* we have to discard exit text and such at runtime, not link time */
> --
> 2.24.0
>

Regards,
Anup
