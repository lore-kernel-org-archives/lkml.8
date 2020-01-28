Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CB524683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="YboDIDpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgA1T2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:28:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41571 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgA1T2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:28:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so17427266wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mH5y6YiIyxSkei3AW5LWOH5PaZMdK9wtI99Lnamilso=;
        b=YboDIDpTYXjirb8Va1F68jVcJv6OSokeWZ+CO2/E3ACUlT+N2hkMdTe4wH8u3PlYdU
         ZveBW0hY05cboYjStAr9Y874ew34lBTln+mrysJtmvFpFAQjt5lojuGNNrjfYVoFSzLh
         gtNLn24rNz5DY+fK3GU6c54G/ZRATD1eyme1Mk/PMz5vnBl1ZzfoiSKXmAmJg5vT6qzk
         68c9b8KAXq1M3/9CAEqmUuI9sI8KeGRP/w+nQ8e8SuAng7xghqlFyQOHYoAWcyCoEaig
         zFUD3tEAs9HzNYnN27bew/Ddn78RT3N9oxNFRzkCAcnZAhJ8d3bYWXyMlcFgG9G3xa8J
         5GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mH5y6YiIyxSkei3AW5LWOH5PaZMdK9wtI99Lnamilso=;
        b=lVOybardzARFwlNXpGsLjkE45HcTFoSHBgCXWLLk+qVMz9x+K5zrMi/tj327IcAHSE
         zFoAnZK9WSLBwy1VoXs/aTXxgx4cPR37S5Fjupljn0pdQNjfUDETf3CphbkSWa4vgdeo
         Kvj8N/zj3RNu4OctQgHKX5W3PIg35kQEATG/MpxoU3hgfDKmTiuWUopBzjl/EaihNzwY
         7M5g5nJkoGpwdt56Uf4g+icrLNTtDcXFheaFmrSHsdqUmplzFI83AihV4SYZQe6jrOxd
         Ir8emYzoBj3PQDh3TUZdaCROCoZUckPcCb70/QfSOO2FaYOKrzRgRVQG4QW8ryDPlwbV
         fdTg==
X-Gm-Message-State: APjAAAVCQHwd4cZ63KIaYiK/sehibvpXUD1FSiisKp18TqeU5YcZQS+B
        0Z+MH9pMjFNcTiGw4KCx7lkMLfqU5BAHtmYaooae
X-Google-Smtp-Source: APXvYqwdE3ea5URqzv7jLRqdTvSN3ycHh5DckOm0CA07+G0BD6Gu7n9QZy6qBSoKfS2LslIVbTFFak2PQaLfxerkZuk=
X-Received: by 2002:a5d:534d:: with SMTP id t13mr31828062wrv.77.1580239724973;
 Tue, 28 Jan 2020 11:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20200128022737.15371-1-atish.patra@wdc.com> <20200128022737.15371-8-atish.patra@wdc.com>
 <CAAhSdy3oktrDNZ01Um5wE8cy2PC5SZdeNDMWjRTmm7k1aHkk_A@mail.gmail.com>
In-Reply-To: <CAAhSdy3oktrDNZ01Um5wE8cy2PC5SZdeNDMWjRTmm7k1aHkk_A@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 28 Jan 2020 11:28:34 -0800
Message-ID: <CAOnJCUKy+Nya-grseL+6Etkmzy=PGfRHJR53+vAhe7Ne5Ur1ig@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] RISC-V: Move relocate and few other functions
 out of __init
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Abner Chang <abner.chang@hpe.com>, nickhu@andestech.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chester Lin <clin@suse.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mao Han <han_mao@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 8:38 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Jan 28, 2020 at 7:58 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > The secondary hart booting and relocation code are under .init section.
> > As a result, it will be freed once kernel booting is done. However,
> > ordered booting protocol and CPU hotplug always requires these sections
> > to be present to bringup harts after initial kernel boot.
> >
> > Move the required sections to a different section and make sure that
> > they are in memory within first 2MB offset as trampoline page directory
> > only maps first 2MB.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/kernel/head.S        | 73 +++++++++++++++++++--------------
> >  arch/riscv/kernel/vmlinux.lds.S |  9 +++-
> >  2 files changed, 50 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index a4242be66966..9d7f084a50cc 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -14,7 +14,7 @@
> >  #include <asm/hwcap.h>
> >  #include <asm/image.h>
> >
> > -__INIT
> > +__HEAD
> >  ENTRY(_start)
> >         /*
> >          * Image header expected by Linux boot-loaders. The image header data
> > @@ -44,9 +44,10 @@ ENTRY(_start)
> >         .balign 4
> >         .ascii RISCV_IMAGE_MAGIC2
> >         .word 0
> > +END(_start)
> >
> > -.global _start_kernel
> > -_start_kernel:
> > +       __INIT
> > +ENTRY(_start_kernel)
> >         /* Mask all interrupts */
> >         csrw CSR_IE, zero
> >         csrw CSR_IP, zero
> > @@ -125,6 +126,37 @@ clear_bss_done:
> >         call parse_dtb
> >         tail start_kernel
> >
> > +.Lsecondary_start:
> > +#ifdef CONFIG_SMP
> > +       /* Set trap vector to spin forever to help debug */
> > +       la a3, .Lsecondary_park
> > +       csrw CSR_TVEC, a3
> > +
> > +       slli a3, a0, LGREG
> > +       la a1, __cpu_up_stack_pointer
> > +       la a2, __cpu_up_task_pointer
> > +       add a1, a3, a1
> > +       add a2, a3, a2
> > +
> > +       /*
> > +        * This hart didn't win the lottery, so we wait for the winning hart to
> > +        * get far enough along the boot process that it should continue.
> > +        */
> > +.Lwait_for_cpu_up:
> > +       /* FIXME: We should WFI to save some energy here. */
> > +       REG_L sp, (a1)
> > +       REG_L tp, (a2)
> > +       beqz sp, .Lwait_for_cpu_up
> > +       beqz tp, .Lwait_for_cpu_up
> > +       fence
> > +
> > +       tail secondary_start_common
> > +#endif
> > +
> > +END(_start_kernel)
> > +
> > +.section ".noinit.text","ax",@progbits
> > +.align 2
>
> Try to use __HEAD here (if possible).
>


> >  #ifdef CONFIG_MMU
> >  relocate:
> >         /* Relocate return address */
> > @@ -177,41 +209,27 @@ relocate:
> >
> >         ret
> >  #endif /* CONFIG_MMU */
> > -
> > -.Lsecondary_start:
> >  #ifdef CONFIG_SMP
> >         /* Set trap vector to spin forever to help debug */
> >         la a3, .Lsecondary_park
> >         csrw CSR_TVEC, a3
> >
> >         slli a3, a0, LGREG
> > -       la a1, __cpu_up_stack_pointer
> > -       la a2, __cpu_up_task_pointer
> > -       add a1, a3, a1
> > -       add a2, a3, a2
> > -
> > -       /*
> > -        * This hart didn't win the lottery, so we wait for the winning hart to
> > -        * get far enough along the boot process that it should continue.
> > -        */
> > -.Lwait_for_cpu_up:
> > -       /* FIXME: We should WFI to save some energy here. */
> > -       REG_L sp, (a1)
> > -       REG_L tp, (a2)
> > -       beqz sp, .Lwait_for_cpu_up
> > -       beqz tp, .Lwait_for_cpu_up
> > -       fence
> > +       .global secondary_start_common
> > +secondary_start_common:
> >
> >  #ifdef CONFIG_MMU
> >         /* Enable virtual memory and relocate to virtual address */
> >         la a0, swapper_pg_dir
> >         call relocate
> >  #endif
> > -
> >         tail smp_callin
> > -#endif
> > +#endif /* CONFIG_SMP */
> >
> > -END(_start)
> > +.Lsecondary_park:
> > +       /* We lack SMP support or have too many harts, so park this hart */
> > +       wfi
> > +       j .Lsecondary_park
> >
> >  #ifdef CONFIG_RISCV_M_MODE
> >  ENTRY(reset_regs)
> > @@ -292,13 +310,6 @@ ENTRY(reset_regs)
> >  END(reset_regs)
> >  #endif /* CONFIG_RISCV_M_MODE */
> >
> > -.section ".text", "ax",@progbits
> > -.align 2
> > -.Lsecondary_park:
> > -       /* We lack SMP support or have too many harts, so park this hart */
> > -       wfi
> > -       j .Lsecondary_park
> > -
> >  __PAGE_ALIGNED_BSS
> >         /* Empty zero page */
> >         .balign PAGE_SIZE
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index 12f42f96d46e..c8a88326df9e 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -10,6 +10,7 @@
> >  #include <asm/cache.h>
> >  #include <asm/thread_info.h>
> >
> > +#include <linux/sizes.h>
> >  OUTPUT_ARCH(riscv)
> >  ENTRY(_start)
> >
> > @@ -20,8 +21,14 @@ SECTIONS
> >         /* Beginning of code and text segment */
> >         . = LOAD_OFFSET;
> >         _start = .;
> > -       __init_begin = .;
> >         HEAD_TEXT_SECTION
> > +       .noinit.text :
> > +       {
> > +               *(.noinit.text)
> > +       }
>
> Can we try using HEAD_TEXT_SECTION for SMP booting
> related functions instead of new ".noinit.text" section ??
>

Yeah. That is much cleaner as well. I will update it in v2.

> > +       . = ALIGN(SZ_4K);
>
> Change this to PAGE aligned:
>     . = ALIGN(PAGE_SIZE)
>

Sure. Will do that.

> > +
> > +       __init_begin = .;
> >         INIT_TEXT_SECTION(PAGE_SIZE)
> >         INIT_DATA_SECTION(16)
> >         /* we have to discard exit text and such at runtime, not link time */
> > --
> > 2.24.0
> >
>
> Regards,
> Anup
>


-- 
Regards,
Atish
