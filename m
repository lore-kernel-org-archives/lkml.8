Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C578C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71B82076C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CtfasOda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgFGEOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 00:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFGEOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 00:14:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3304C08C5C3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 21:14:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r15so13106310wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVc4yhBjX64RmWB7JPsVL5b7vYsNR1j+6MV6XcBMtDw=;
        b=CtfasOdaLXASDTrfjslQSlb2cqhb29HcfYBxMM5gwUNZwgYhjFVOJJt3EsqsRRj8Mq
         MPsUtDcpnNJR0Lf2iFnRRD0haPlkB0y2BDkNmMA3zxG+nHPLIiLLMsosbxi8SYy3mOjQ
         SINXa/N2/2XmgVa8M1cuIZqX1q9TQ+1hdr+Qxoyl+O7U2sM9PfYNmbnk5KUhIXG1wRm9
         N6HVew6cfN66BUbc6+MqB98EHNkB1KPb8G7BhL7d4jaq251q+IX1fMMosOyuy5PA1O6a
         /D6k6s+0y7JYtMzhpsDI8BvoHN3LKwNA8abau/aFJaUjfYMHtWhFZWMwFUmOp/7xhWS9
         Xqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVc4yhBjX64RmWB7JPsVL5b7vYsNR1j+6MV6XcBMtDw=;
        b=Y7tgb1TYPEKR6ywCsEt5P01fJMpAQ7OLZ1XRFmmzRlB29VXzL4WPmt5otUrOJole71
         oDPfFTWMseOstEtKXC/aV0EcTm5LILVHHSxGouBnMkeU180ZCobFs096bkjOI8rlFb3U
         mbf/Xve4eeBqAjVRF+3Pz1bJBwL55l6dDjxpvBQgKBfJHi3JepGWRWPiUE9tild/PcAK
         N8vHrf+K0Io97I3Rf5Xog51N2J+mnh2ISEMskkl93x8lQcoocJEAdJVjr8J8vYur8rsm
         JhQXuRxs2A+enqkjSfw8RSDrAkBD0ax5gBpB4TzdWKXzi+NBHVMmcMdE17k1eFSpm0dj
         V9Gg==
X-Gm-Message-State: AOAM532mIj3+kMox9pxvG+mBBMQ/6eDXaHwzknYt0EezgQAB1vvbdktN
        AYg56vDlNvuNRvrmFvIFnL5T9Ag1q/j+mMSI6AOtSQ==
X-Google-Smtp-Source: ABdhPJychvNagwd9pRSBrMuYZSEdRL4y5AjtJjKM/sVc4PCGcM28zvbKJvFO+RX1RbUql0gkNv/GYaFg/b988AIlbrY=
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr9875982wmb.3.1591503251213;
 Sat, 06 Jun 2020 21:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200521134544.816918-3-anup.patel@wdc.com> <mhng-f2e4aecb-a19b-4d20-9a48-9640bd9d264d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-f2e4aecb-a19b-4d20-9a48-9640bd9d264d@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 Jun 2020 09:43:59 +0530
Message-ID: <CAAhSdy1yUWoQ_YYi=XdAO79EVQxvTHR87FuBmq477opaaTveuw@mail.gmail.com>
Subject: Re: [PATCH 2/5] RISC-V: Remove CLINT related code
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:10 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 21 May 2020 06:45:41 PDT (-0700), Anup Patel wrote:
> > We will be having separate CLINT timer driver which will also
> > provide CLINT based IPI operations so let's remove CLINT related
> > code from arch/riscv directory.
>
> This will leave the system unbootable, which breaks bisecting.

This only affects the NoMMU kernel where userspace FPDPIC work
is still in-progress so NoMMU kernel is anyway not 100% complete
without upstreamed userspace support.

Are you suggesting to squash PATCH2, PATCH3, and PATCH4 for
preserving bistability ?

Regards,
Anup


>
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/include/asm/clint.h | 39 ------------------------------
> >  arch/riscv/kernel/Makefile     |  2 +-
> >  arch/riscv/kernel/clint.c      | 44 ----------------------------------
> >  arch/riscv/kernel/setup.c      |  2 --
> >  arch/riscv/kernel/smp.c        |  1 -
> >  arch/riscv/kernel/smpboot.c    |  1 -
> >  6 files changed, 1 insertion(+), 88 deletions(-)
> >  delete mode 100644 arch/riscv/include/asm/clint.h
> >  delete mode 100644 arch/riscv/kernel/clint.c
> >
> > diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> > deleted file mode 100644
> > index a279b17a6aad..000000000000
> > --- a/arch/riscv/include/asm/clint.h
> > +++ /dev/null
> > @@ -1,39 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _ASM_RISCV_CLINT_H
> > -#define _ASM_RISCV_CLINT_H 1
> > -
> > -#include <linux/io.h>
> > -#include <linux/smp.h>
> > -
> > -#ifdef CONFIG_RISCV_M_MODE
> > -extern u32 __iomem *clint_ipi_base;
> > -
> > -void clint_init_boot_cpu(void);
> > -
> > -static inline void clint_send_ipi_single(unsigned long hartid)
> > -{
> > -     writel(1, clint_ipi_base + hartid);
> > -}
> > -
> > -static inline void clint_send_ipi_mask(const struct cpumask *mask)
> > -{
> > -     int cpu;
> > -
> > -     for_each_cpu(cpu, mask)
> > -             clint_send_ipi_single(cpuid_to_hartid_map(cpu));
> > -}
> > -
> > -static inline void clint_clear_ipi(unsigned long hartid)
> > -{
> > -     writel(0, clint_ipi_base + hartid);
> > -}
> > -#else /* CONFIG_RISCV_M_MODE */
> > -#define clint_init_boot_cpu()        do { } while (0)
> > -
> > -/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
> > -void clint_send_ipi_single(unsigned long hartid);
> > -void clint_send_ipi_mask(const struct cpumask *hartid_mask);
> > -void clint_clear_ipi(unsigned long hartid);
> > -#endif /* CONFIG_RISCV_M_MODE */
> > -
> > -#endif /* _ASM_RISCV_CLINT_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index d8bbd3207100..529cda705cfe 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -31,7 +31,7 @@ obj-y       += cacheinfo.o
> >  obj-y        += patch.o
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >
> > -obj-$(CONFIG_RISCV_M_MODE)   += clint.o traps_misaligned.o
> > +obj-$(CONFIG_RISCV_M_MODE)   += traps_misaligned.o
> >  obj-$(CONFIG_FPU)            += fpu.o
> >  obj-$(CONFIG_SMP)            += smpboot.o
> >  obj-$(CONFIG_SMP)            += smp.o
> > diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
> > deleted file mode 100644
> > index 3647980d14c3..000000000000
> > --- a/arch/riscv/kernel/clint.c
> > +++ /dev/null
> > @@ -1,44 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * Copyright (c) 2019 Christoph Hellwig.
> > - */
> > -
> > -#include <linux/io.h>
> > -#include <linux/of_address.h>
> > -#include <linux/types.h>
> > -#include <asm/clint.h>
> > -#include <asm/csr.h>
> > -#include <asm/timex.h>
> > -#include <asm/smp.h>
> > -
> > -/*
> > - * This is the layout used by the SiFive clint, which is also shared by the qemu
> > - * virt platform, and the Kendryte KD210 at least.
> > - */
> > -#define CLINT_IPI_OFF                0
> > -#define CLINT_TIME_CMP_OFF   0x4000
> > -#define CLINT_TIME_VAL_OFF   0xbff8
> > -
> > -u32 __iomem *clint_ipi_base;
> > -
> > -void clint_init_boot_cpu(void)
> > -{
> > -     struct device_node *np;
> > -     void __iomem *base;
> > -
> > -     np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
> > -     if (!np) {
> > -             panic("clint not found");
> > -             return;
> > -     }
> > -
> > -     base = of_iomap(np, 0);
> > -     if (!base)
> > -             panic("could not map CLINT");
> > -
> > -     clint_ipi_base = base + CLINT_IPI_OFF;
> > -     riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
> > -     riscv_time_val = base + CLINT_TIME_VAL_OFF;
> > -
> > -     clint_clear_ipi(boot_cpu_hartid);
> > -}
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 145128a7e560..b07a583bf53b 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -18,7 +18,6 @@
> >  #include <linux/swiotlb.h>
> >  #include <linux/smp.h>
> >
> > -#include <asm/clint.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/setup.h>
> >  #include <asm/sections.h>
> > @@ -76,7 +75,6 @@ void __init setup_arch(char **cmdline_p)
> >       setup_bootmem();
> >       paging_init();
> >       unflatten_device_tree();
> > -     clint_init_boot_cpu();
> >
> >  #ifdef CONFIG_SWIOTLB
> >       swiotlb_init(1);
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index 8375cc5970f6..8a23f1eb5400 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -17,7 +17,6 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/delay.h>
> >
> > -#include <asm/clint.h>
> >  #include <asm/sbi.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/cacheflush.h>
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 5fe849791bf0..a6cfa9842d4b 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -24,7 +24,6 @@
> >  #include <linux/of.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/sched/mm.h>
> > -#include <asm/clint.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/irq.h>
> >  #include <asm/mmu_context.h>
