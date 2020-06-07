Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E66C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CDC2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ws3lEb0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFGE0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 00:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgFGE0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 00:26:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B88C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 21:26:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so13844638wrn.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 21:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKf532rI1kowr+ozO7qOCyMJ10kBW15/+nHK9KoUflE=;
        b=ws3lEb0WwpH0mha57kXyxQSn1YUeIT+LbwUigmLBft+ggY5+CxQF/q7SHw2R2j5V78
         tAuy2vI4rT1OgFUCI3pAQ+DyqRhOmTCgOJTwbj+CX5sKE1WBmFLe5xKij7DowVz0nywc
         BRjtMZbjmpdM/uIEWo9NDsxpX2AEUs0dFHYE3YMCnrQ/8pjGL+DAIhmPsBVsFgSg8C4U
         +mG0MROAMfv/H5hgedgdYE2XDU3EiKB1MYdVtZM30BNU4tbNcwHFLjhCcnQHb1E+9CL2
         MOBnN59tHr+WjjcLiqQ6xOsfEZHc/ZQu6lKsGWX/3x50gdcaEImzDGQIWXXtYDZMJe3u
         2t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKf532rI1kowr+ozO7qOCyMJ10kBW15/+nHK9KoUflE=;
        b=XM2WOV/rTsHZrbsOcmA7K/ldAkPddZofH3t9j7mi3g+nipnkjoJfIvhqRlDtwdEHYu
         /kdKte8M3m7yV6d5FFL34lT6lFJmIp+yZAciPpXumXsDi+ixCk5HB1AfhDn5AT3CEBKW
         irwnqyHarCOjtxqBypJSaeeZTPSxfGasAIY8NZYzotoglq5COLQzrtd0Y7IbjABbBco1
         nBUcL9AZW6VAaHIOOs7E2Tle2vyPm033t5QVAQi5qOYXBzJC0WrIWzpl5YMNtk/RoMmY
         bmCpiP5CStwAXDMG66wNWwCDe4rkgLH47qDytE8RSST5AqJlYxGFIcH6/YzlSAYPl8s9
         lU3w==
X-Gm-Message-State: AOAM531VgAs+mirIjYZsm6nK5oIqSsflt9m5/GGRsCDveliXSyb1GMfy
        UtDsJiqEWzZTlVt7hLExRreayGQgjywsR3QbeUJyyw==
X-Google-Smtp-Source: ABdhPJxA2IouWQF4QmGR4Qh4t55eC+0p7nmBoSrpesZI+HFCnn4zLMs3blXTC5wVhxEy+BQghh47YBVhO+yOU9AS0Wg=
X-Received: by 2002:adf:f707:: with SMTP id r7mr18189283wrp.390.1591504002218;
 Sat, 06 Jun 2020 21:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200521134544.816918-5-anup.patel@wdc.com> <mhng-a3c3bd81-fd8f-4975-8a33-41e40cf2b341@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-a3c3bd81-fd8f-4975-8a33-41e40cf2b341@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 Jun 2020 09:56:30 +0530
Message-ID: <CAAhSdy12kRDzfSfU_XFOHZtBDtWFGWPC73ypju4uoxVFC_qvLA@mail.gmail.com>
Subject: Re: [PATCH 4/5] clocksource/drivers: Add CLINT timer driver
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
> On Thu, 21 May 2020 06:45:43 PDT (-0700), Anup Patel wrote:
> > The TIME CSR and SBI calls are not available in RISC-V M-mode so we
> > add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU kernel).
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  drivers/clocksource/Kconfig       |  10 ++
> >  drivers/clocksource/Makefile      |   1 +
> >  drivers/clocksource/timer-clint.c | 226 ++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h        |   1 +
> >  4 files changed, 238 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-clint.c
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 21950d9e3e9d..ea97bf0eb09f 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -659,6 +659,16 @@ config RISCV_TIMER
> >         is accessed via both the SBI and the rdcycle instruction.  This is
> >         required for all RISC-V systems.
> >
> > +config CLINT_TIMER
> > +     bool "Timer for the RISC-V platform"
> > +     depends on GENERIC_SCHED_CLOCK && RISCV
>
> Presumably this also depends on RISCV_M_MODE?

Ahh, good catch. I will update in v2.

>
> > +     default y
> > +     select TIMER_PROBE
> > +     select TIMER_OF
> > +     help
> > +       This option enables the CLINT timer for RISC-V systems. The CLINT
> > +       driver is usually used for NoMMU RISC-V systems.
> > +
> >  config CSKY_MP_TIMER
> >       bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
> >       depends on CSKY
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index 641ba5383ab5..dca308b5ff98 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -86,6 +86,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)         += clksrc_st_lpc.o
> >  obj-$(CONFIG_X86_NUMACHIP)           += numachip.o
> >  obj-$(CONFIG_ATCPIT100_TIMER)                += timer-atcpit100.o
> >  obj-$(CONFIG_RISCV_TIMER)            += timer-riscv.o
> > +obj-$(CONFIG_CLINT_TIMER)            += timer-clint.o
> >  obj-$(CONFIG_CSKY_MP_TIMER)          += timer-mp-csky.o
> >  obj-$(CONFIG_GX6605S_TIMER)          += timer-gx6605s.o
> >  obj-$(CONFIG_HYPERV_TIMER)           += hyperv_timer.o
> > diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> > new file mode 100644
> > index 000000000000..7fc4f145da65
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-clint.c
> > @@ -0,0 +1,226 @@
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
> > +#include <linux/irqchip/irq-riscv-intc.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/smp.h>
> > +
> > +#define CLINT_IPI_OFF                0
> > +#define CLINT_TIME_CMP_OFF   0x4000
> > +#define CLINT_TIME_VAL_OFF   0xbff8
> > +
> > +/* CLINT manages IPI and Timer for RISC-V M-mode  */
> > +static u32 __iomem *clint_ipi_base;
>
> It seems odd to have IPIs in the timer driver.  I know the CLINT handles both
> of them, but these really feel like two separate drivers.

AFAIK, there are no dedicated APIs in the kernel/irq subsystem for
IPI injections. Every architecture have their own way of registering
IPI injection mechanism. In ARM/ARM64, the arch code provides
set_smp_cross_call() API which drivers use to register IPI injections
mechanism. The PATCH1 of this series adds riscv_set_ipi_ops()
for this purpose.

Generally for most architectures (e.g. ARM, ARM64, MIPS, etc),
the IPI injections mechanism is registered from the irqchip driver
but for Linux RISC-V NoMMU the  IPI injection mechanism is
part of CLINT hence part of this CLINT driver.

Regards,
Anup

>
> > +static u64 __iomem *clint_time_cmp;
> > +static u64 __iomem *clint_time_val;
> > +static unsigned long clint_freq;
> > +static unsigned int clint_irq;
> > +
> > +static void clint_send_ipi(const unsigned long *hart_mask)
> > +{
> > +     u32 hartid;
> > +
> > +     for_each_set_bit(hartid, hart_mask, NR_CPUS)
> > +             writel(1, clint_ipi_base + hartid);
> > +}
> > +
> > +static void clint_clear_ipi(void)
> > +{
> > +     writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
> > +}
> > +
> > +static struct riscv_ipi_ops clint_ipi_ops = {
> > +     .ipi_inject = clint_send_ipi,
> > +     .ipi_clear = clint_clear_ipi,
> > +};
> > +
> > +#ifdef CONFIG_64BIT
> > +#define clint_get_cycles()   readq_relaxed(clint_time_val)
> > +#else
> > +#define clint_get_cycles()   readl_relaxed(clint_time_val)
> > +#define clint_get_cycles_hi()        readl_relaxed(((u32 *)clint_time_val) + 1)
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
> > +             hi = clint_get_cycles_hi();
> > +             lo = clint_get_cycles();
> > +     } while (hi != clint_get_cycles_hi());
> > +
> > +     return ((u64)hi << 32) | lo;
> > +}
> > +#endif /* CONFIG_64BIT */
> > +
> > +static int clint_clock_next_event(unsigned long delta,
> > +                                struct clock_event_device *ce)
> > +{
> > +     void __iomem *r = clint_time_cmp +
> > +                       cpuid_to_hartid_map(smp_processor_id());
> > +
> > +     csr_set(CSR_IE, IE_TIE);
> > +     writeq_relaxed(clint_get_cycles64() + delta, r);
> > +     return 0;
> > +}
> > +
> > +static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
> > +     .name                   = "clint_clockevent",
> > +     .features               = CLOCK_EVT_FEAT_ONESHOT,
> > +     .rating         = 100,
> > +     .set_next_event = clint_clock_next_event,
> > +};
> > +
> > +static u64 clint_rdtime(struct clocksource *cs)
> > +{
> > +     return readq_relaxed(clint_time_val);
> > +}
> > +
> > +static u64 notrace clint_sched_clock(void)
> > +{
> > +     return readq_relaxed(clint_time_val);
> > +}
> > +
> > +static struct clocksource clint_clocksource = {
> > +     .name           = "clint_clocksource",
> > +     .rating = 300,
> > +     .mask           = CLOCKSOURCE_MASK(64),
> > +     .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> > +     .read           = clint_rdtime,
> > +};
> > +
> > +static int clint_timer_starting_cpu(unsigned int cpu)
> > +{
> > +     struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> > +
> > +     ce->cpumask = cpumask_of(cpu);
> > +     clockevents_config_and_register(ce, clint_freq, 200, ULONG_MAX);
> > +
> > +     enable_percpu_irq(clint_irq, irq_get_trigger_type(clint_irq));
> > +     return 0;
> > +}
> > +
> > +static int clint_timer_dying_cpu(unsigned int cpu)
> > +{
> > +     disable_percpu_irq(clint_irq);
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
> > +{
> > +     struct clock_event_device *evdev = this_cpu_ptr(&clint_clock_event);
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
> > +     nr_irqs = of_irq_count(np);
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             if (of_irq_parse_one(np, i, &oirq)) {
> > +                     pr_err("%pOFP: failed to parse irq %d.\n", np, i);
> > +                     continue;
> > +             }
> > +
> > +             if ((oirq.args_count != 1) ||
> > +                 (oirq.args[0] != RV_IRQ_TIMER &&
> > +                  oirq.args[0] != RV_IRQ_SOFT)) {
> > +                     pr_info("%pOFP: invalid irq %d (hwirq %d)\n",
> > +                             np, i, oirq.args[0]);
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     oirq.np = riscv_of_intc_domain_node();
> > +     oirq.args_count = 1;
> > +     oirq.args[0] = RV_IRQ_TIMER;
> > +     clint_irq = irq_create_of_mapping(&oirq);
> > +     if (!clint_irq) {
> > +             pr_err("%pOFP: could not map hwirq %d\n", np, RV_IRQ_TIMER);
> > +             return -ENODEV;
> > +     }
> > +
> > +     base = of_iomap(np, 0);
> > +     if (!base) {
> > +             pr_err("%pOFP: could not map registers\n", np);
> > +             return -ENODEV;
> > +     }
> > +
> > +     clint_ipi_base = base + CLINT_IPI_OFF;
> > +     clint_time_cmp = base + CLINT_TIME_CMP_OFF;
> > +     clint_time_val = base + CLINT_TIME_VAL_OFF;
> > +     clint_freq = riscv_timebase;
> > +
> > +     pr_info("%pOFP: timer running at %ld Hz\n", np, clint_freq);
> > +
> > +     rc = clocksource_register_hz(&clint_clocksource, clint_freq);
> > +     if (rc) {
> > +             iounmap(base);
> > +             pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
> > +             return rc;
> > +     }
> > +
> > +     sched_clock_register(clint_sched_clock, 64, clint_freq);
> > +
> > +     rc = request_percpu_irq(clint_irq, clint_timer_interrupt,
> > +                              "clint-timer", &clint_clock_event);
> > +     if (rc) {
> > +             iounmap(base);
> > +             pr_err("registering percpu irq failed [%d]\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
> > +                             "clockevents/clint/timer:starting",
> > +                             clint_timer_starting_cpu,
> > +                             clint_timer_dying_cpu);
> > +     if (rc) {
> > +             free_irq(clint_irq, &clint_clock_event);
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
> > +TIMER_OF_DECLARE(clint_timer1, "sifive,clint-1.0.0", clint_timer_init_dt);
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 57b1f8f777d9..52552492c2f2 100644
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
