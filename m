Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37AAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EB220748
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="z8yCE4yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFGEPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 00:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgFGEPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 00:15:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCFC08C5C3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 21:15:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so13838306wrw.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoxt6Yva9F352PkyE4qaDfMaCfCL2S0dxZ3JOT5UNPQ=;
        b=z8yCE4yzXeIeXsWocMFnYV8yJO0awdJ7eCsbTpV/DL4MxST3MzeUpuWlZbfwCjVl7D
         fkmxfj8wNKwLFwzIlzUsvPDGzauHVZLZ8NV2sjPh4epjFsNeupkL7o+ImKfWp/b8SIIR
         9+/GfY23XdgAq2NYZmngevZ82i8UxQBlcIsaK+BPeZsqyo9/RPsakk0HaBdqX4ZIrSP+
         Z1co4sPD1oceoiJdgwM7hDP71n4T9AvP3gOS7ThbZIi8blZaY3oPj0mu7UjtEXKSpYM7
         /Rseo7P0x7Ov1AE7nJp0jZetMxpKXXR8ynMhLmgxE3kPu/pjvrhH47VADyQmYjlg96x+
         hFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoxt6Yva9F352PkyE4qaDfMaCfCL2S0dxZ3JOT5UNPQ=;
        b=YRquUUvJmiJ5ik2uwvEhQSLZI93TyfPxUS/zYk8uUcqM8XMRX5IKAzCN9swCk4Tv5E
         +GVV8FRgCnRtJ4UZQ2RuvTJ6yv3T2B1wN3UqDpShgeUIROTnUjxYigJ5Sg5RQ7hjfLBH
         vilhGuOvt9oLTB3Z2CEAGCQxIrS+2dqdxiXkKeGmXbRH1Vh+VWQO5i+1P7xOtHX/p76o
         x4QarLnjqd0+aGzyuZS+B1voCwg+ml+lzCmL8MpUd1Rpv8U0W+MgB0BodOTWDG99aYAX
         SqxH5owyCif+cJ09vRyEYPvFfIth/VyHew4re5FRH4bKTrDB1pJYL8rQADvDCBf62lhs
         QDSw==
X-Gm-Message-State: AOAM532wpwDVEblD+n7MaITzesHSk4F1rULFtbh+OIQDzcXQCZFHJ90E
        4ES7LkojLNe3Zp/UPI3qXrhih5SA7ZFpB2SEUvaDng==
X-Google-Smtp-Source: ABdhPJy1TKsmYnFmt1mhxGAm4vlPpWHuwaVoX/KNGOVKxSiGC5cDNzFiySvasFRatsFCjGdiJcM+SYfXyRWRlCzbUqk=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr16823734wrq.325.1591503332327;
 Sat, 06 Jun 2020 21:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200521134544.816918-4-anup.patel@wdc.com> <mhng-c95851de-d021-4272-aa99-6e9b492091ea@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-c95851de-d021-4272-aa99-6e9b492091ea@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 Jun 2020 09:45:21 +0530
Message-ID: <CAAhSdy3Y08HEJBeib22GwyL0eFE7QeQ5Tbd3EX20M7yriErdsg@mail.gmail.com>
Subject: Re: [PATCH 3/5] clocksource/drivers/timer-riscv: Remove MMIO related stuff
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
> On Thu, 21 May 2020 06:45:42 PDT (-0700), Anup Patel wrote:
> > Right now the RISC-V timer is convoluted to support:
> > 1. Linux RISC-V S-mode (with MMU) where it will use TIME CSR
> >    for clocksource and SBI timer calls for clockevent device.
> > 2. Linux RISC-V M-mode (without MMU) where it will use CLINT
> >    MMIO counter register for clocksource and CLINT MMIO compare
> >    register for clockevent device.
> >
> > This patch removes MMIO related stuff from RISC-V timer driver
> > so that we can have a separate CLINT timer driver.
>
> This one will also break bisecting for the K210.

Same comments as PATCH2. This only affects the NoMMU kernel
which is still not 100 % complete due to on-going userspace work.

Regards,
Anup

>
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/Kconfig                |  2 +-
> >  arch/riscv/include/asm/timex.h    | 28 +++++++---------------------
> >  drivers/clocksource/Kconfig       |  2 +-
> >  drivers/clocksource/timer-riscv.c | 17 ++---------------
> >  4 files changed, 11 insertions(+), 38 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 2cf0c83c1a47..bbdc37a78f7b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -52,7 +52,7 @@ config RISCV
> >       select PCI_DOMAINS_GENERIC if PCI
> >       select PCI_MSI if PCI
> >       select RISCV_INTC
> > -     select RISCV_TIMER
> > +     select RISCV_TIMER if RISCV_SBI
> >       select GENERIC_IRQ_MULTI_HANDLER
> >       select GENERIC_ARCH_TOPOLOGY if SMP
> >       select ARCH_HAS_PTE_SPECIAL
> > diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> > index bad2a7c2cda5..a3fb85d505d4 100644
> > --- a/arch/riscv/include/asm/timex.h
> > +++ b/arch/riscv/include/asm/timex.h
> > @@ -7,41 +7,27 @@
> >  #define _ASM_RISCV_TIMEX_H
> >
> >  #include <asm/csr.h>
> > -#include <asm/mmio.h>
> >
> >  typedef unsigned long cycles_t;
> >
> > -extern u64 __iomem *riscv_time_val;
> > -extern u64 __iomem *riscv_time_cmp;
> > -
> > -#ifdef CONFIG_64BIT
> > -#define mmio_get_cycles()    readq_relaxed(riscv_time_val)
> > -#else
> > -#define mmio_get_cycles()    readl_relaxed(riscv_time_val)
> > -#define mmio_get_cycles_hi() readl_relaxed(((u32 *)riscv_time_val) + 1)
> > -#endif
> > -
> >  static inline cycles_t get_cycles(void)
> >  {
> > -     if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -             return csr_read(CSR_TIME);
> > -     return mmio_get_cycles();
> > +     return csr_read(CSR_TIME);
> >  }
> >  #define get_cycles get_cycles
> >
> > +static inline u32 get_cycles_hi(void)
> > +{
> > +     return csr_read(CSR_TIMEH);
> > +}
> > +#define get_cycles_hi get_cycles_hi
> > +
> >  #ifdef CONFIG_64BIT
> >  static inline u64 get_cycles64(void)
> >  {
> >       return get_cycles();
> >  }
> >  #else /* CONFIG_64BIT */
> > -static inline u32 get_cycles_hi(void)
> > -{
> > -     if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -             return csr_read(CSR_TIMEH);
> > -     return mmio_get_cycles_hi();
> > -}
> > -
> >  static inline u64 get_cycles64(void)
> >  {
> >       u32 hi, lo;
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index f2142e6bbea3..21950d9e3e9d 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -650,7 +650,7 @@ config ATCPIT100_TIMER
> >
> >  config RISCV_TIMER
> >       bool "Timer for the RISC-V platform"
> > -     depends on GENERIC_SCHED_CLOCK && RISCV
> > +     depends on GENERIC_SCHED_CLOCK && RISCV_SBI
> >       default y
> >       select TIMER_PROBE
> >       select TIMER_OF
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 5fb7c5ba5c91..3e7e0cf5b899 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -19,26 +19,13 @@
> >  #include <linux/of_irq.h>
> >  #include <asm/smp.h>
> >  #include <asm/sbi.h>
> > -
> > -u64 __iomem *riscv_time_cmp;
> > -u64 __iomem *riscv_time_val;
> > -
> > -static inline void mmio_set_timer(u64 val)
> > -{
> > -     void __iomem *r;
> > -
> > -     r = riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id());
> > -     writeq_relaxed(val, r);
> > -}
> > +#include <asm/timex.h>
> >
> >  static int riscv_clock_next_event(unsigned long delta,
> >               struct clock_event_device *ce)
> >  {
> >       csr_set(CSR_IE, IE_TIE);
> > -     if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -             sbi_set_timer(get_cycles64() + delta);
> > -     else
> > -             mmio_set_timer(get_cycles64() + delta);
> > +     sbi_set_timer(get_cycles64() + delta);
> >       return 0;
> >  }
