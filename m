Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF571C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A1B2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0iOol61m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGULoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgGULoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:44:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35116C0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:44:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so10603705wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8KZzDda9edvjFBOlGjuGRmYMPyPlcqvYLeB8aIs6P4=;
        b=0iOol61mueyGeN/+5vIGdNF7qNFaGQ10xYB28DqGeD2HA6twlcLhJKFXpIllxMAxj7
         ECXVoAauufksXRH63XkAhgaeoW0iMKsq+UIDbWjE3arVfcdvNgnC6a0Ez3BfRYtksa6q
         RW1hDC7LJQauFF2MRobig4TO57CxeXoZX7u02KdOXTrcI27Fb06Huu6k6070/n+iRMhX
         ISySfSCsRpb2t9sccd/g3O/8KanYG7A1lmFCcIKkh7DxpGkImiA1U6a8epc1ZN5IHrM3
         rRlMebI5OcJdHhq9eJb2Fw3UFxFDm7+L1JeErpuEXSfeLTByJFxeJ8SVqKcFwK6lUMk0
         YrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8KZzDda9edvjFBOlGjuGRmYMPyPlcqvYLeB8aIs6P4=;
        b=ae3cPvEWkX72AjVl9fgzNgAg191b4tPsodcJgLDCJux0VN49cYSr81QHhw/uRgrNpe
         /f5+8gYhnx2EaKg1TfXP9gTkjG62tt8s4/Ql2uHjAGdBUvHknEnwFlpjjrpFVisGeVub
         OOH929rD388Nm6AfljJviWCKCCHSZ6udD6fbyKWcEdLJqvE797DTEzVcx+U1tTuNPLIl
         fLBlY8zBheM5uB0uObGNAZJjryF2Ymb4W2bk9lTd9H3jqQitD6zxrxtI6uk6p3iol9Ji
         +EShRVAkPaJ9pwwf94umevcHLS1vtwZxCA+uwSzr6CWm1t1nJDhWVN6sI3QFcRNnKtnu
         MU2A==
X-Gm-Message-State: AOAM532Tz6dREv0OWoS5LFiECbilsdBj26SwE8Gsz4+QTm/Ykd+nUces
        3EuvQLCcSoDnMEIrhEugflRehYuE/QR2lgIc9zq5nw==
X-Google-Smtp-Source: ABdhPJxGJx2s1J28uAxaxwyjHtpdxOmqIjh1a7g5BBb7OCBYYK6qgmzRo0DnQ9UdUP8GKGtvCU1rM/RZQq8lh4VvNeE=
X-Received: by 2002:adf:9203:: with SMTP id 3mr9695194wrj.144.1595331840654;
 Tue, 21 Jul 2020 04:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200717075101.263332-1-anup.patel@wdc.com> <20200717075101.263332-3-anup.patel@wdc.com>
 <CAOnJCUL=LSEfK67GbZ6c0NjEpHmpWq3HM1odgU=bo5JAjAGO2A@mail.gmail.com>
In-Reply-To: <CAOnJCUL=LSEfK67GbZ6c0NjEpHmpWq3HM1odgU=bo5JAjAGO2A@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Jul 2020 17:13:48 +0530
Message-ID: <CAAhSdy1AJAp7WOMPhJRk9ahs2Puhpct2nb+ZDz02iYG2NVP1rA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] clocksource/drivers: Add CLINT timer driver
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:41 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Fri, Jul 17, 2020 at 12:52 AM Anup Patel <anup.patel@wdc.com> wrote:
> >
> > We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
> > RISC-V NoMMU kernel).
> >
> > The CLINT MMIO device provides three things:
> > 1. 64bit free running counter register
> > 2. 64bit per-CPU time compare registers
> > 3. 32bit per-CPU inter-processor interrupt registers
> >
> > Unlike other timer devices, CLINT provides IPI registers along with
> > timer registers. To use CLINT IPI registers, the CLINT timer driver
> > provides IPI related callbacks to arch/riscv.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> > ---
> >  drivers/clocksource/Kconfig       |   9 ++
> >  drivers/clocksource/Makefile      |   1 +
> >  drivers/clocksource/timer-clint.c | 231 ++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h        |   1 +
> >  4 files changed, 242 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-clint.c
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 91418381fcd4..e1ce0d510a03 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -658,6 +658,15 @@ config RISCV_TIMER
> >           is accessed via both the SBI and the rdcycle instruction.  This is
> >           required for all RISC-V systems.
> >
> > +config CLINT_TIMER
> > +       bool "Timer for the RISC-V platform"
> > +       depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> > +       select TIMER_PROBE
> > +       select TIMER_OF
> > +       help
> > +         This option enables the CLINT timer for RISC-V systems. The CLINT
> > +         driver is usually used for NoMMU RISC-V systems.
> > +
> >  config CSKY_MP_TIMER
> >         bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
> >         depends on CSKY
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index bdda1a2e4097..18e700e703a0 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -87,6 +87,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)           += clksrc_st_lpc.o
> >  obj-$(CONFIG_X86_NUMACHIP)             += numachip.o
> >  obj-$(CONFIG_ATCPIT100_TIMER)          += timer-atcpit100.o
> >  obj-$(CONFIG_RISCV_TIMER)              += timer-riscv.o
> > +obj-$(CONFIG_CLINT_TIMER)              += timer-clint.o
> >  obj-$(CONFIG_CSKY_MP_TIMER)            += timer-mp-csky.o
> >  obj-$(CONFIG_GX6605S_TIMER)            += timer-gx6605s.o
> >  obj-$(CONFIG_HYPERV_TIMER)             += hyperv_timer.o
> > diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> > new file mode 100644
> > index 000000000000..e1698efa73a1
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-clint.c
> > @@ -0,0 +1,231 @@
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
> > +#define CLINT_IPI_OFF          0
> > +#define CLINT_TIMER_CMP_OFF    0x4000
> > +#define CLINT_TIMER_VAL_OFF    0xbff8
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
> > +       unsigned int cpu;
> > +
> > +       for_each_cpu(cpu, target)
> > +               writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
> > +}
> > +
> > +static void clint_clear_ipi(void)
> > +{
> > +       writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
> > +}
> > +
> > +static struct riscv_ipi_ops clint_ipi_ops = {
> > +       .ipi_inject = clint_send_ipi,
> > +       .ipi_clear = clint_clear_ipi,
> > +};
> > +
> > +#ifdef CONFIG_64BIT
> > +#define clint_get_cycles()     readq_relaxed(clint_timer_val)
> > +#else
> > +#define clint_get_cycles()     readl_relaxed(clint_timer_val)
> > +#define clint_get_cycles_hi()  readl_relaxed(((u32 *)clint_timer_val) + 1)
> > +#endif
> > +
> > +#ifdef CONFIG_64BIT
> > +static u64 notrace clint_get_cycles64(void)
> > +{
> > +       return clint_get_cycles();
> > +}
> > +#else /* CONFIG_64BIT */
> > +static u64 notrace clint_get_cycles64(void)
> > +{
> > +       u32 hi, lo;
> > +
> > +       do {
> > +               hi = clint_get_cycles_hi();
> > +               lo = clint_get_cycles();
> > +       } while (hi != clint_get_cycles_hi());
> > +
> > +       return ((u64)hi << 32) | lo;
> > +}
> > +#endif /* CONFIG_64BIT */
> > +
> > +static u64 clint_rdtime(struct clocksource *cs)
> > +{
> > +       return clint_get_cycles64();
> > +}
> > +
> > +static struct clocksource clint_clocksource = {
> > +       .name           = "clint_clocksource",
> > +       .rating = 300,
>
> nit: Not aligned with other structure members.
>
> > +       .mask           = CLOCKSOURCE_MASK(64),
> > +       .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> > +       .read           = clint_rdtime,
> > +};
> > +
> > +static int clint_clock_next_event(unsigned long delta,
> > +                                  struct clock_event_device *ce)
> > +{
> > +       void __iomem *r = clint_timer_cmp +
> > +                         cpuid_to_hartid_map(smp_processor_id());
> > +
> > +       csr_set(CSR_IE, IE_TIE);
> > +       writeq_relaxed(clint_get_cycles64() + delta, r);
> > +       return 0;
> > +}
> > +
> > +static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
> > +       .name                   = "clint_clockevent",
> > +       .features               = CLOCK_EVT_FEAT_ONESHOT,
> > +       .rating         = 100,
> > +       .set_next_event = clint_clock_next_event,
>
> nit: Not aligned with other structure members.

Okay, will update.

> > +};
> > +
> > +static DEFINE_PER_CPU(bool, clint_clock_event_registered);
> > +
> > +static int clint_timer_starting_cpu(unsigned int cpu)
> > +{
> > +       bool *registered = per_cpu_ptr(&clint_clock_event_registered, cpu);
> > +       struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> > +
> > +       if (!(*registered)) {
> > +               ce->cpumask = cpumask_of(cpu);
> > +               clockevents_config_and_register(ce, clint_timer_freq, 200,
> > +                                                ULONG_MAX);
>
> Is there a specific reason to choose different values from the timer-riscv ?
> The min_delta is set to 100 and max_delta is set to 0x7fffffff in
> timer-riscv driver.

Not really, I will update. I think it's better to use 100 and ULONG_MAX to
have fewer magic values.

>
> > +               *registered = true;
> > +       }
> > +
> > +       enable_percpu_irq(clint_timer_irq,
> > +                         irq_get_trigger_type(clint_timer_irq));
> > +       return 0;
> > +}
> > +
> > +static int clint_timer_dying_cpu(unsigned int cpu)
> > +{
> > +       disable_percpu_irq(clint_timer_irq);
> > +       return 0;
> > +}
> > +
> > +static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
> > +{
> > +       struct clock_event_device *evdev = this_cpu_ptr(&clint_clock_event);
> > +
> > +       csr_clear(CSR_IE, IE_TIE);
> > +       evdev->event_handler(evdev);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int __init clint_timer_init_dt(struct device_node *np)
> > +{
> > +       int rc;
> > +       u32 i, nr_irqs;
> > +       void __iomem *base;
> > +       struct of_phandle_args oirq;
> > +
> > +       /*
> > +        * Ensure that CLINT device interrupts are either RV_IRQ_TIMER or
> > +        * RV_IRQ_SOFT. If it's anything else then we ignore the device.
> > +        */
> > +       nr_irqs = of_irq_count(np);
> > +       for (i = 0; i < nr_irqs; i++) {
> > +               if (of_irq_parse_one(np, i, &oirq)) {
> > +                       pr_err("%pOFP: failed to parse irq %d.\n", np, i);
> > +                       continue;
> > +               }
> > +
> > +               if ((oirq.args_count != 1) ||
> > +                   (oirq.args[0] != RV_IRQ_TIMER &&
> > +                    oirq.args[0] != RV_IRQ_SOFT)) {
> > +                       pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
> > +                              np, i, oirq.args[0]);
> > +                       return -ENODEV;
> > +               }
> > +
> > +               /* Find parent irq domain and map timer irq */
> > +               if (!clint_timer_irq &&
> > +                   oirq.args[0] == RV_IRQ_TIMER &&
> > +                   irq_find_host(oirq.np))
> > +                       clint_timer_irq = irq_of_parse_and_map(np, i);
> > +       }
> > +
> > +       /* If CLINT timer irq not found then fail */
> > +       if (!clint_timer_irq) {
> > +               pr_err("%pOFP: timer irq not found\n", np);
> > +               return -ENODEV;
> > +       }
> > +
> > +       base = of_iomap(np, 0);
> > +       if (!base) {
> > +               pr_err("%pOFP: could not map registers\n", np);
> > +               return -ENODEV;
> > +       }
> > +
> > +       clint_ipi_base = base + CLINT_IPI_OFF;
> > +       clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
> > +       clint_timer_val = base + CLINT_TIMER_VAL_OFF;
> > +       clint_timer_freq = riscv_timebase;
> > +
> > +       pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
> > +
> > +       rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
> > +       if (rc) {
> > +               iounmap(base);
> > +               pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
> > +               return rc;
> > +       }
> > +
> > +       sched_clock_register(clint_get_cycles64, 64, clint_timer_freq);
> > +
> > +       rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
> > +                                "clint-timer", &clint_clock_event);
> > +       if (rc) {
> > +               iounmap(base);
> > +               pr_err("registering percpu irq failed [%d]\n", rc);
> > +               return rc;
> > +       }
> > +
> > +       rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
> > +                               "clockevents/clint/timer:starting",
> > +                               clint_timer_starting_cpu,
> > +                               clint_timer_dying_cpu);
> > +       if (rc) {
> > +               free_irq(clint_timer_irq, &clint_clock_event);
> > +               iounmap(base);
> > +               pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
> > +               return rc;
>
> All the iounmap & return statements can be moved to a goto at the end
> of the function.

Okay, will update.

>
> > +       }
> > +
> > +       riscv_set_ipi_ops(&clint_ipi_ops);
> > +       clint_clear_ipi();
> > +
> > +       return 0;
> > +}
> > +
> > +TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
> > +TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 191772d4a4d7..1451f4625833 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -132,6 +132,7 @@ enum cpuhp_state {
> >         CPUHP_AP_MIPS_GIC_TIMER_STARTING,
> >         CPUHP_AP_ARC_TIMER_STARTING,
> >         CPUHP_AP_RISCV_TIMER_STARTING,
> > +       CPUHP_AP_CLINT_TIMER_STARTING,
> >         CPUHP_AP_CSKY_TIMER_STARTING,
> >         CPUHP_AP_HYPERV_TIMER_STARTING,
> >         CPUHP_AP_KVM_STARTING,
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish

Regards,
Anup
