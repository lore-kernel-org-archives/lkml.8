Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8973EC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A8021739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="YUiQw1hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBLS7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:59:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLS7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:59:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so3711198wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iWpjS84iXuZKMy6ZUtTecttvvwiEglLKnXkpaETIX4=;
        b=YUiQw1hmb0MdD9htXyE7jU5pynWAVmivpNXH4tuPdrqeisAZUhAKzcEgZiBMfUOBiE
         91EKvU5ZYR5yY98VUkYUmylI5porAO83ZhoNvh3ZD7X+z0NLzm+QIcizro8jdkpY+qj8
         UO7a3Q9RRKUpoCNzKzZOp5HxNZ3hTUmOgARcuDGMK6esrF+io8cRjMeDMHtvPkhymmpn
         4Cz4RtLXcpAIHwhsRBMsYrNcIbsb1G3sYADnadb/qMGnAiJPYQH4yiJ6+QFcOCRS5xDl
         woLTOWSyDvDZr9nwP4h0K+5ZiUTf6EIT7D1/0UBeiWWIEwz6funXEfZvJ/8h7nGQEIK8
         6PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iWpjS84iXuZKMy6ZUtTecttvvwiEglLKnXkpaETIX4=;
        b=E7bw2jiF5OX/EeIySjg85MxLfScJj4qD591oQPnErY1MRP3cQcoYuCEv9ZHY03W/za
         AK5+5uOexPaNvNXgcqi3lZ+QC+WzWwEfNHReyZ//0Kvd1l5AnkS/1LCd6QvrcA4cdXiO
         83R02/OUSs+znjVWy2wIRFuXQiAPlho0Pljvwp8GIPf2paCnzgnaa/ds88qI3qzSlJYn
         eBOKfVxmV6DBGgG6+3HOjJ6Azf8Y9C9jyuPv8vl2gXGQ9ep25wiOJzNRURG5dq9OAZFA
         YyC77+ceeV8OZdByXwcaA3N0+Z70JJ3kqWP+49J1mH2coceGuWA1SfRW9ig2sp9ctJTg
         64GA==
X-Gm-Message-State: APjAAAVero3Mp+/2I5lLub1AIa/IvozIL1hQMt22wI/Zl2rG87mtmvdb
        nIUL+2zs1yLUEXli5KsqChAt+LxYI6Q81mC2J/3q
X-Google-Smtp-Source: APXvYqw4PbZ5JrNpOUH7XCkVriDHuZ28rg8GWkMouNDbsdGI/2lP+oarZ2Yg1FNoUyCpQWDgQ3Reb/5bW+SxuLPIYts=
X-Received: by 2002:adf:f507:: with SMTP id q7mr16342704wro.384.1581533945683;
 Wed, 12 Feb 2020 10:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-7-atish.patra@wdc.com>
 <CAAhSdy2YRnmdxYu7zSYOUxMvFDbEz1Cwg69FgnYz3Rd8wEwQfw@mail.gmail.com>
In-Reply-To: <CAAhSdy2YRnmdxYu7zSYOUxMvFDbEz1Cwg69FgnYz3Rd8wEwQfw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 12 Feb 2020 10:58:54 -0800
Message-ID: <CAOnJCULR1AwC=4sf5WZJN77OHymdbfn75R-EGnJyBw_DeJacgg@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] RISC-V: Move relocate and few other functions
 out of __init
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Mao Han <han_mao@c-sky.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 8:18 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Feb 12, 2020 at 7:21 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > The secondary hart booting and relocation code are under .init section.
> > As a result, it will be freed once kernel booting is done. However,
> > ordered booting protocol and CPU hotplug always requires these sections
>
> I think you meant "... require these functions" here.
>
> > to be present to bringup harts after initial kernel boot.
> >
> > Move the required sections to a different section and make sure that
>
> Same here, I think you meant "... the required functions to a
> different section ..."
>

My bad. Thanks for pointing out. Fixed.

> > they are in memory within first 2MB offset as trampoline page directory
> > only maps first 2MB.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/kernel/head.S        | 153 +++++++++++++++++---------------
> >  arch/riscv/kernel/vmlinux.lds.S |   5 +-
> >  2 files changed, 86 insertions(+), 72 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index a4242be66966..c1be597d22a1 100644
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
> > @@ -45,8 +45,85 @@ ENTRY(_start)
> >         .ascii RISCV_IMAGE_MAGIC2
> >         .word 0
> >
> > -.global _start_kernel
> > -_start_kernel:
> > +.align 2
> > +#ifdef CONFIG_MMU
> > +relocate:
> > +       /* Relocate return address */
> > +       li a1, PAGE_OFFSET
> > +       la a2, _start
> > +       sub a1, a1, a2
> > +       add ra, ra, a1
> > +
> > +       /* Point stvec to virtual address of intruction after satp write */
> > +       la a2, 1f
> > +       add a2, a2, a1
> > +       csrw CSR_TVEC, a2
> > +
> > +       /* Compute satp for kernel page tables, but don't load it yet */
> > +       srl a2, a0, PAGE_SHIFT
> > +       li a1, SATP_MODE
> > +       or a2, a2, a1
> > +
> > +       /*
> > +        * Load trampoline page directory, which will cause us to trap to
> > +        * stvec if VA != PA, or simply fall through if VA == PA.  We need a
> > +        * full fence here because setup_vm() just wrote these PTEs and we need
> > +        * to ensure the new translations are in use.
> > +        */
> > +       la a0, trampoline_pg_dir
> > +       srl a0, a0, PAGE_SHIFT
> > +       or a0, a0, a1
> > +       sfence.vma
> > +       csrw CSR_SATP, a0
> > +.align 2
> > +1:
> > +       /* Set trap vector to spin forever to help debug */
> > +       la a0, .Lsecondary_park
> > +       csrw CSR_TVEC, a0
> > +
> > +       /* Reload the global pointer */
> > +.option push
> > +.option norelax
> > +       la gp, __global_pointer$
> > +.option pop
> > +
> > +       /*
> > +        * Switch to kernel page tables.  A full fence is necessary in order to
> > +        * avoid using the trampoline translations, which are only correct for
> > +        * the first superpage.  Fetching the fence is guarnteed to work
> > +        * because that first superpage is translated the same way.
> > +        */
> > +       csrw CSR_SATP, a2
> > +       sfence.vma
> > +
> > +       ret
> > +#endif /* CONFIG_MMU */
> > +#ifdef CONFIG_SMP
> > +       /* Set trap vector to spin forever to help debug */
> > +       la a3, .Lsecondary_park
> > +       csrw CSR_TVEC, a3
> > +
> > +       slli a3, a0, LGREG
> > +       .global secondary_start_common
> > +secondary_start_common:
> > +
> > +#ifdef CONFIG_MMU
> > +       /* Enable virtual memory and relocate to virtual address */
> > +       la a0, swapper_pg_dir
> > +       call relocate
> > +#endif
> > +       tail smp_callin
> > +#endif /* CONFIG_SMP */
> > +
> > +.Lsecondary_park:
> > +       /* We lack SMP support or have too many harts, so park this hart */
> > +       wfi
> > +       j .Lsecondary_park
> > +
> > +END(_start)
> > +
> > +       __INIT
> > +ENTRY(_start_kernel)
> >         /* Mask all interrupts */
> >         csrw CSR_IE, zero
> >         csrw CSR_IP, zero
> > @@ -125,59 +202,6 @@ clear_bss_done:
> >         call parse_dtb
> >         tail start_kernel
> >
> > -#ifdef CONFIG_MMU
> > -relocate:
> > -       /* Relocate return address */
> > -       li a1, PAGE_OFFSET
> > -       la a2, _start
> > -       sub a1, a1, a2
> > -       add ra, ra, a1
> > -
> > -       /* Point stvec to virtual address of intruction after satp write */
> > -       la a2, 1f
> > -       add a2, a2, a1
> > -       csrw CSR_TVEC, a2
> > -
> > -       /* Compute satp for kernel page tables, but don't load it yet */
> > -       srl a2, a0, PAGE_SHIFT
> > -       li a1, SATP_MODE
> > -       or a2, a2, a1
> > -
> > -       /*
> > -        * Load trampoline page directory, which will cause us to trap to
> > -        * stvec if VA != PA, or simply fall through if VA == PA.  We need a
> > -        * full fence here because setup_vm() just wrote these PTEs and we need
> > -        * to ensure the new translations are in use.
> > -        */
> > -       la a0, trampoline_pg_dir
> > -       srl a0, a0, PAGE_SHIFT
> > -       or a0, a0, a1
> > -       sfence.vma
> > -       csrw CSR_SATP, a0
> > -.align 2
> > -1:
> > -       /* Set trap vector to spin forever to help debug */
> > -       la a0, .Lsecondary_park
> > -       csrw CSR_TVEC, a0
> > -
> > -       /* Reload the global pointer */
> > -.option push
> > -.option norelax
> > -       la gp, __global_pointer$
> > -.option pop
> > -
> > -       /*
> > -        * Switch to kernel page tables.  A full fence is necessary in order to
> > -        * avoid using the trampoline translations, which are only correct for
> > -        * the first superpage.  Fetching the fence is guarnteed to work
> > -        * because that first superpage is translated the same way.
> > -        */
> > -       csrw CSR_SATP, a2
> > -       sfence.vma
> > -
> > -       ret
> > -#endif /* CONFIG_MMU */
> > -
> >  .Lsecondary_start:
> >  #ifdef CONFIG_SMP
> >         /* Set trap vector to spin forever to help debug */
> > @@ -202,16 +226,10 @@ relocate:
> >         beqz tp, .Lwait_for_cpu_up
> >         fence
> >
> > -#ifdef CONFIG_MMU
> > -       /* Enable virtual memory and relocate to virtual address */
> > -       la a0, swapper_pg_dir
> > -       call relocate
> > +       tail secondary_start_common
> >  #endif
> >
> > -       tail smp_callin
> > -#endif
> > -
> > -END(_start)
> > +END(_start_kernel)
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
> > index 12f42f96d46e..18c397953bfc 100644
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
> > @@ -20,8 +21,10 @@ SECTIONS
> >         /* Beginning of code and text segment */
> >         . = LOAD_OFFSET;
> >         _start = .;
> > -       __init_begin = .;
> >         HEAD_TEXT_SECTION
> > +       . = ALIGN(PAGE_SIZE);
> > +
> > +       __init_begin = .;
> >         INIT_TEXT_SECTION(PAGE_SIZE)
> >         INIT_DATA_SECTION(16)
> >         /* we have to discard exit text and such at runtime, not link time */
> > --
> > 2.24.0
> >
>
> Apart from above nit in commit description, looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
>


-- 
Regards,
Atish
