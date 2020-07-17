Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6932B206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Um6lylkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGQFVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGQFVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:21:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F72C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:21:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so9699305wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Txl23SYhqU4CFJgNmtRHcmqgdOnnkrGVMry+7+SHVI0=;
        b=Um6lylknChyL1OR7eW5Cr5ane6YZUWnV0SXE4vqFXu/ELh4Z7b3fyrNThjGCL0nlwl
         kuu20mdky7crrzFpwpWiAqj1XCA4BueQSsqfbqaOGn6E1cJ+NDYeJaz3cE8w6cv+w9qE
         s8R8niwltE0xyz8reBTW1YRDB2reXu4Et0CIoT+qEli3AyaKlvNV6qXSIHkhUtsasM2x
         s5myGeDLhawzzEWwHoi/dG/4JO5qSc/sC58gphwGEJ8vK3JfZDPIwUAeFzRIb3JdL+nP
         XQVaf743301pUga7sYiWzothWYzJVdoiGHWfhKXYlWGALc0XzrtvAewI4sSBjE2JkKeX
         lfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Txl23SYhqU4CFJgNmtRHcmqgdOnnkrGVMry+7+SHVI0=;
        b=MQ14v+c9Fi7G08qTvKErjuH4MhGIvbG7Xw2rOKQS/dtmezX99aKpbjidLfroWQTCxN
         TMkzUUcL8uNywbJ/ku3rWKlrvxj8/ZBHwuJZmXsVlYUkF03TRfnKBF/SmjKjjc9UaVMS
         xAMVew9j8pbiOAhyq2eDP2IE2KRp0xL1vNt5FuW1qZgQ5s0gr6cpSLaBXf5we+7MxxYo
         Agyz0wnd9t5B9w/o0uYZHpoHRzknwB8FJhqGBI++XXq8kkccTP0fgVDMAi+0aWr9SgS7
         0Fjw9O4aDmXXUn1qrTGRrD/oHghQgSuO9sF+f6n+ewDLn3zL5sWxQ0Rqi8m6n3rFSDCx
         KyVw==
X-Gm-Message-State: AOAM530f6fi8oE2N5vA4I2mx1lTYgPwbbGbJFURcDyzfayGQFfXe1Von
        7XHW4oOBIrAuzDSVuwJQLj0Z1OTw2lw0jtxKntsd5g==
X-Google-Smtp-Source: ABdhPJybDCXcZ50/toMOuo5zRNW4SflJKE6iLzPyyHW1LE2nGkJvcPBvXVKS3c2n0ukmR1x5G6LOQdUVlYPD8+EA3S4=
X-Received: by 2002:adf:b190:: with SMTP id q16mr8608059wra.356.1594963282019;
 Thu, 16 Jul 2020 22:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200715071506.10994-1-anup.patel@wdc.com> <20200715071506.10994-3-anup.patel@wdc.com>
 <9a36824c-ef23-de47-b52c-bf680067be6c@linaro.org>
In-Reply-To: <9a36824c-ef23-de47-b52c-bf680067be6c@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Jul 2020 10:51:10 +0530
Message-ID: <CAAhSdy3iurBWELjrjKr4mWdueZqw3xmf2e6AD_Km0PE+5TZHWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clocksource/drivers: Add CLINT timer driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Anup,
>
>
> On 15/07/2020 09:15, Anup Patel wrote:
> > The TIME CSR and SBI calls are not available in RISC-V M-mode so we
> > separate add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU
> > kernel).
>
> The description is confusing, please reword it and give a bit more
> information about the timer itself, especially, the IPI thing.

Okay, will update.

>
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  drivers/clocksource/Kconfig       |  10 ++
> >  drivers/clocksource/Makefile      |   1 +
> >  drivers/clocksource/timer-clint.c | 229 ++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h        |   1 +
> >  4 files changed, 241 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-clint.c
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 91418381fcd4..eabcf1cfb0c0 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -658,6 +658,16 @@ config RISCV_TIMER
> >         is accessed via both the SBI and the rdcycle instruction.  This=
 is
> >         required for all RISC-V systems.
> >
> > +config CLINT_TIMER
> > +     bool "Timer for the RISC-V platform"
> > +     depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> > +     default y
> > +     select TIMER_PROBE
> > +     select TIMER_OF
> > +     help
> > +       This option enables the CLINT timer for RISC-V systems. The CLI=
NT
> > +       driver is usually used for NoMMU RISC-V systems.
>
> For the timer, we do silent option and let the platform config select
> it. Please refer to other timer option below as reference.

Okay, I will use "default RISCV" instead of "default y" (just like other
timer Kconfig options).

>
> >  config CSKY_MP_TIMER
> >       bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
> >       depends on CSKY
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
> > index bdda1a2e4097..18e700e703a0 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -87,6 +87,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)         +=3D clksrc_st_lp=
c.o
> >  obj-$(CONFIG_X86_NUMACHIP)           +=3D numachip.o
> >  obj-$(CONFIG_ATCPIT100_TIMER)                +=3D timer-atcpit100.o
> >  obj-$(CONFIG_RISCV_TIMER)            +=3D timer-riscv.o
> > +obj-$(CONFIG_CLINT_TIMER)            +=3D timer-clint.o
> >  obj-$(CONFIG_CSKY_MP_TIMER)          +=3D timer-mp-csky.o
> >  obj-$(CONFIG_GX6605S_TIMER)          +=3D timer-gx6605s.o
> >  obj-$(CONFIG_HYPERV_TIMER)           +=3D hyperv_timer.o
> > diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/ti=
mer-clint.c
> > new file mode 100644
> > index 000000000000..bfc38bb5a589
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-clint.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> > + *
> > + * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
> > + * CLINT MMIO timer device.
> > + */
> > +
> > +#define pr_fmt(fmt) "clint: " fmt
> > +#include <linux/bitops.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/cpu.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/sched_clock.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/smp.h>
> > +
> > +#define CLINT_IPI_OFF                0
> > +#define CLINT_TIMER_CMP_OFF  0x4000
> > +#define CLINT_TIMER_VAL_OFF  0xbff8
> > +
> > +/* CLINT manages IPI and Timer for RISC-V M-mode  */
> > +static u32 __iomem *clint_ipi_base;
> > +static u64 __iomem *clint_timer_cmp;
> > +static u64 __iomem *clint_timer_val;
> > +static unsigned long clint_timer_freq;
> > +static unsigned int clint_timer_irq;
> > +
> > +static void clint_send_ipi(const struct cpumask *target)
> > +{
> > +     unsigned int cpu;
> > +
> > +     for_each_cpu(cpu, target)
> > +             writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
> > +}
> > +
> > +static void clint_clear_ipi(void)
> > +{
> > +     writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()=
));
> > +}
> > +
> > +static struct riscv_ipi_ops clint_ipi_ops =3D {
> > +     .ipi_inject =3D clint_send_ipi,
> > +     .ipi_clear =3D clint_clear_ipi,
> > +};
> > +
> > +#ifdef CONFIG_64BIT
> > +#define clint_get_cycles()   readq_relaxed(clint_timer_val)
> > +#else
> > +#define clint_get_cycles()   readl_relaxed(clint_timer_val)
> > +#define clint_get_cycles_hi()        readl_relaxed(((u32 *)clint_timer=
_val) + 1)
> > +#endif
> > +
> > +#ifdef CONFIG_64BIT
> > +static u64 clint_get_cycles64(void)
> > +{
> > +     return clint_get_cycles();
> > +}
> > +#else /* CONFIG_64BIT */
> > +static u64 clint_get_cycles64(void)
> > +{
> > +     u32 hi, lo;
> > +
> > +     do {
> > +             hi =3D clint_get_cycles_hi();
> > +             lo =3D clint_get_cycles();
> > +     } while (hi !=3D clint_get_cycles_hi());
> > +
> > +     return ((u64)hi << 32) | lo;
> > +}
> > +#endif /* CONFIG_64BIT */
> > +static int clint_clock_next_event(unsigned long delta,
> > +                                struct clock_event_device *ce)
> > +{
> > +     void __iomem *r =3D clint_timer_cmp +
> > +                       cpuid_to_hartid_map(smp_processor_id());
> > +
> > +     csr_set(CSR_IE, IE_TIE);
> > +     writeq_relaxed(clint_get_cycles64() + delta, r);
> > +     return 0;
> > +}
> > +
> > +static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) =
=3D {
> > +     .name                   =3D "clint_clockevent",
> > +     .features               =3D CLOCK_EVT_FEAT_ONESHOT,
> > +     .rating         =3D 100,
> > +     .set_next_event =3D clint_clock_next_event,
> > +};
> > +
> > +static u64 clint_rdtime(struct clocksource *cs)
> > +{
> > +     return readq_relaxed(clint_timer_val);
> > +}
> > +
> > +static u64 notrace clint_sched_clock(void)
> > +{
> > +     return readq_relaxed(clint_timer_val);
> > +}
> > +
> > +static struct clocksource clint_clocksource =3D {
> > +     .name           =3D "clint_clocksource",
> > +     .rating =3D 300,
> > +     .mask           =3D CLOCKSOURCE_MASK(64),
> > +     .flags          =3D CLOCK_SOURCE_IS_CONTINUOUS,
> > +     .read           =3D clint_rdtime,
>
> What if !CONFIG_64BIT

The CLINT counter is 64bit for both 32bit and 64bit systems
but I should have used clint_get_cycles64() in clint_rdtime().
I will update it.

>
> > +};
> > +
> > +static int clint_timer_starting_cpu(unsigned int cpu)
> > +{
> > +     struct clock_event_device *ce =3D per_cpu_ptr(&clint_clock_event,=
 cpu);
> > +
> > +     ce->cpumask =3D cpumask_of(cpu);
> > +     clockevents_config_and_register(ce, clint_timer_freq, 200, ULONG_=
MAX);
>
> The function is not immune against registering the same clockevents. If
> the CPU is hotplugged several times, this function will be called again
> and again. Why not rely on a for_each_possible_cpu loop in the init
> function ?
>
> > +     enable_percpu_irq(clint_timer_irq,
> > +                       irq_get_trigger_type(clint_timer_irq));
>
> Why do you want to enable / disable the interrrupts ? The should be
> already handle by the hotplug framework no ?

The perCPU interrupts are not enabled by default. We have to
explicitly enable/disable perCPU interrupts in CPU hotplug callbacks.

>
> > +     return 0;
> > +}
> > +
> > +static int clint_timer_dying_cpu(unsigned int cpu)
> > +{
> > +     disable_percpu_irq(clint_timer_irq);
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
> > +{
> > +     struct clock_event_device *evdev =3D this_cpu_ptr(&clint_clock_ev=
ent);
> > +
> > +     csr_clear(CSR_IE, IE_TIE);
> > +     evdev->event_handler(evdev);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int __init clint_timer_init_dt(struct device_node *np)
> > +{
> > +     int rc;
> > +     u32 i, nr_irqs;
> > +     void __iomem *base;
> > +     struct of_phandle_args oirq;
> > +
> > +     /*
> > +      * Ensure that CLINT device interrupts are either RV_IRQ_TIMER or
> > +      * RV_IRQ_SOFT. If it's anything else then we ignore the device.
> > +      */
> > +     nr_irqs =3D of_irq_count(np);
> > +     for (i =3D 0; i < nr_irqs; i++) {
> > +             if (of_irq_parse_one(np, i, &oirq)) {
> > +                     pr_err("%pOFP: failed to parse irq %d.\n", np, i)=
;
> > +                     continue;
> > +             }
> > +
> > +             if ((oirq.args_count !=3D 1) ||
> > +                 (oirq.args[0] !=3D RV_IRQ_TIMER &&
> > +                  oirq.args[0] !=3D RV_IRQ_SOFT)) {
> > +                     pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
> > +                            np, i, oirq.args[0]);
> > +                     return -ENODEV;
> > +             }
> > +
> > +             /* Find parent irq domain and map timer irq */
> > +             if (!clint_timer_irq &&
> > +                 oirq.args[0] =3D=3D RV_IRQ_TIMER &&
> > +                 irq_find_host(oirq.np))
> > +                     clint_timer_irq =3D irq_of_parse_and_map(np, i);
> > +     }
> > +
> > +     /* If CLINT timer irq not found then fail */
> > +     if (!clint_timer_irq) {
> > +             pr_err("%pOFP: timer irq not found\n", np);
> > +             return -ENODEV;
> > +     }
> > +
> > +     base =3D of_iomap(np, 0);
> > +     if (!base) {
> > +             pr_err("%pOFP: could not map registers\n", np);
> > +             return -ENODEV;
> > +     }
> > +
> > +     clint_ipi_base =3D base + CLINT_IPI_OFF;
> > +     clint_timer_cmp =3D base + CLINT_TIMER_CMP_OFF;
> > +     clint_timer_val =3D base + CLINT_TIMER_VAL_OFF;
> > +     clint_timer_freq =3D riscv_timebase;
> > +
> > +     pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq)=
;
> > +
> > +     rc =3D clocksource_register_hz(&clint_clocksource, clint_timer_fr=
eq);
> > +     if (rc) {
> > +             iounmap(base);
> > +             pr_err("%pOFP: clocksource register failed [%d]\n", np, r=
c);
> > +             return rc;
> > +     }
> > +
> > +     sched_clock_register(clint_sched_clock, 64, clint_timer_freq);
> > +
> > +     rc =3D request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
> > +                              "clint-timer", &clint_clock_event);
> > +     if (rc) {
> > +             iounmap(base);
> > +             pr_err("registering percpu irq failed [%d]\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
> > +                             "clockevents/clint/timer:starting",
> > +                             clint_timer_starting_cpu,
> > +                             clint_timer_dying_cpu);
> > +     if (rc) {
> > +             free_irq(clint_timer_irq, &clint_clock_event);
> > +             iounmap(base);
> > +             pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
> > +             return rc;
> > +     }
> > +
> > +     riscv_set_ipi_ops(&clint_ipi_ops);
> > +     clint_clear_ipi();
> > +
> > +     return 0;
> > +}
> > +
> > +TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
> > +TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 191772d4a4d7..1451f4625833 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -132,6 +132,7 @@ enum cpuhp_state {
> >       CPUHP_AP_MIPS_GIC_TIMER_STARTING,
> >       CPUHP_AP_ARC_TIMER_STARTING,
> >       CPUHP_AP_RISCV_TIMER_STARTING,
> > +     CPUHP_AP_CLINT_TIMER_STARTING,
> >       CPUHP_AP_CSKY_TIMER_STARTING,
> >       CPUHP_AP_HYPERV_TIMER_STARTING,
> >       CPUHP_AP_KVM_STARTING,
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

Regards,
Anup
