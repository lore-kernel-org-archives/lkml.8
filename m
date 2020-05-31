Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C0C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 05:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853FF20723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 05:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="m/YHb9Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgEaFxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 01:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 01:53:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203FC05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 22:53:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so8120827wrr.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 22:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOsp7syKOPdYJNF2qEn+8kNUrg72Kaa15t7iFX6GTsg=;
        b=m/YHb9Bv4Z7kRpAFa+VntBXixZPryMWBfKAJPV6iXasbRHsnJEGI9GjaMXgp9prHz6
         CUjz1w33eS5kE0b9huXrxEthWDn2jEF6BQ0BZ7Eo1enAxhmMKVqzC3GMN0wE6x0R2TKn
         CSw5rXr3VNGKiOFfXZ/ZhzgmLb32WccroxO2X+8Pb3ByPJQZHlwGFlW0jv7ZbxN86Vil
         1oJvN42r7yrTCDErY1l14+RmVd2UWGgnYnWSLdKz7/8F0BNK53UgfbOs8tTHiHoxWR1c
         VYRGFz3wHf3tA4iTJ5VFdtd1P8hsqPgw0uWN8R1FBJOi4o0JXrB8YLRAyX48bayYINhB
         BrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOsp7syKOPdYJNF2qEn+8kNUrg72Kaa15t7iFX6GTsg=;
        b=Yv5UeietDQBRJeXOpcOcV1nNzIK1Iv2N5kIyIF5de+/UY3yjT8sgyyAp+a3T72HbUG
         bQ++WoCdrT6nevwK6+5yLhK8H4Z0urzlDabrnUSyhTn2RLW9zLyH26QRFyToM166IeF6
         Lz1INq4aVt2tpdaOHrLjWzy/cFCtXeGSybsZJEq/rUlbC4KuYDnqetxklEB0ZagMRGG6
         NW0XDB1ZkH4mS3NUrP0D9fh9cTf+mKH2Hhxv/b002AYXIQIOXhErQf7AWGpCLpPU72ly
         7aeHt9Vg2ZgUuZ6mPzutwrIEGhNKl80Uqxo0NOBKcEFySLNgwgvDGP2O38RVqWSj/4Ss
         N0Sg==
X-Gm-Message-State: AOAM532tBX49K2Y393+CTPPOZs4b6dufiCCk7az5OyJ4zGv3RoozbgFh
        k3h2ISx+zx32yIqVDQKQfBpxvu9cbu/jAmirWwAd8g==
X-Google-Smtp-Source: ABdhPJyJam0xFtqZTAiytblPOEobRI+WU5+EzZ+a8mOLNRLeGnunjCjlPP1fJD4LcIdCubtBzLKYlz0ho71ox23rgSA=
X-Received: by 2002:adf:f707:: with SMTP id r7mr17260253wrp.390.1590904389497;
 Sat, 30 May 2020 22:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200530100725.265481-1-anup.patel@wdc.com> <20200530100725.265481-5-anup.patel@wdc.com>
 <e9a832ec748671b4daef398ecf784db2@kernel.org>
In-Reply-To: <e9a832ec748671b4daef398ecf784db2@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 31 May 2020 11:22:58 +0530
Message-ID: <CAAhSdy3dhPgHxcKiy8kNiNpiT_G+CAkGeGFUO+ReWby2COr2gA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 5:11 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-05-30 11:07, Anup Patel wrote:
> > Instead of directly calling RISC-V timer interrupt handler from
> > RISC-V local interrupt conntroller driver, this patch implements
> > RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
> > of Linux IRQ subsystem.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/irq.h      |  2 --
> >  drivers/clocksource/timer-riscv.c | 41 ++++++++++++++++++++++++++++---
> >  drivers/irqchip/irq-riscv-intc.c  |  8 ------
> >  3 files changed, 38 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/irq.h
> > b/arch/riscv/include/asm/irq.h
> > index a9e5f07a7e9c..9807ad164015 100644
> > --- a/arch/riscv/include/asm/irq.h
> > +++ b/arch/riscv/include/asm/irq.h
> > @@ -10,8 +10,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/linkage.h>
> >
> > -void riscv_timer_interrupt(void);
> > -
> >  #include <asm-generic/irq.h>
> >
> >  #endif /* _ASM_RISCV_IRQ_H */
> > diff --git a/drivers/clocksource/timer-riscv.c
> > b/drivers/clocksource/timer-riscv.c
> > index c4f15c4068c0..1fe847983f50 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -12,8 +12,11 @@
> >  #include <linux/cpu.h>
> >  #include <linux/delay.h>
> >  #include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> >  #include <linux/sched_clock.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_irq.h>
> >  #include <asm/smp.h>
> >  #include <asm/sbi.h>
> >
> > @@ -39,6 +42,7 @@ static int riscv_clock_next_event(unsigned long
> > delta,
> >       return 0;
> >  }
> >
> > +static unsigned int riscv_clock_event_irq;
> >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =
> > {
> >       .name                   = "riscv_timer_clockevent",
> >       .features               = CLOCK_EVT_FEAT_ONESHOT,
> > @@ -74,30 +78,36 @@ static int riscv_timer_starting_cpu(unsigned int
> > cpu)
> >       struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
> >
> >       ce->cpumask = cpumask_of(cpu);
> > +     ce->irq = riscv_clock_event_irq;
> >       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> >
> > -     csr_set(CSR_IE, IE_TIE);
> > +     enable_percpu_irq(riscv_clock_event_irq,
> > +                       irq_get_trigger_type(riscv_clock_event_irq));
> >       return 0;
> >  }
> >
> >  static int riscv_timer_dying_cpu(unsigned int cpu)
> >  {
> > -     csr_clear(CSR_IE, IE_TIE);
> > +     disable_percpu_irq(riscv_clock_event_irq);
> >       return 0;
> >  }
> >
> >  /* called directly from the low-level interrupt handler */
> > -void riscv_timer_interrupt(void)
> > +static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
> >  {
> >       struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
> >
> >       csr_clear(CSR_IE, IE_TIE);
> >       evdev->event_handler(evdev);
> > +
> > +     return IRQ_HANDLED;
> >  }
> >
> >  static int __init riscv_timer_init_dt(struct device_node *n)
> >  {
> >       int cpuid, hartid, error;
> > +     struct device_node *child;
> > +     struct irq_domain *domain;
> >
> >       hartid = riscv_of_processor_hartid(n);
> >       if (hartid < 0) {
> > @@ -115,6 +125,23 @@ static int __init riscv_timer_init_dt(struct
> > device_node *n)
> >       if (cpuid != smp_processor_id())
> >               return 0;
> >
> > +     domain = NULL;
> > +     for_each_child_of_node(n, child) {
> > +             domain = irq_find_host(child);
> > +             if (domain)
> > +                     break;
> > +     }
>
> This is a bit clumsy, and probably better written as:
>
>          child = of_get_compatible(n, "riscv,cpu-intc");
>          if (!child) { error out }
>          domain = irq_find_host(child);

I thought of not hard-coding INTC compatible string here but
both RISC-V INTC and RISC-V Timer are RISC-V specific so
I guess it's simpler to use of_get_compatible() directly.

I will update.

>
> It would be even better if each CPU would have its per-CPU interrupt
> controller designated as such (with an interrupt-parent property),
> meaning that you wouldn't have to do anything at all.
>
> Too late for that anyway.

Yes, too late now.

Regards,
Anup
