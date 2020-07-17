Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BAC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327BF20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="bN5UieoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGQF5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGQF5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:57:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327EC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:57:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so9696448wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JZvHizUVqRN667HIjufhBos1B0Ox7ddF/o24MKYIlJc=;
        b=bN5UieoGp648UmUuNWTHkpNFPQh/0obFUDF1iszS9wHV7vs6OphAaaxkioqzZvS7BC
         LscGMWuLhGmYOLHHkfJcjVX7iaHtVNTXOyhd7ZpRy6mw3Gkhb+GKN0w9eOcZYxVBmFlZ
         j+ATGV0Bt0OUNGiaI8eZlUorZrDO+ymcIha2gMuF2bPXoRhm124LUHFtU1H2OBlfxwRM
         iWRv6FfH0p1HuAF8VQPFX2jCq+liLlqIFDO3kRIrhzf8bgNEbwGtTYdaoj1tjUSOku1E
         8n7GyVymcGIH04hJo92u5i/cADZ4OxiB33HybHZB+5IaqaV2Np0vSeE5xAD8oT5nv2vj
         34bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JZvHizUVqRN667HIjufhBos1B0Ox7ddF/o24MKYIlJc=;
        b=L6JFGWIoNu2a2mMRkoAjo1iIXEsuCopr2ZnCyAQCPEB534TPCPa85XvqExNiS2Xivs
         P0QubEJoG2i4tIE0bu9j3OZxwHsyqrAuUHdgUbteJFV1QrX+4ynvkkI8j+paRzXAj9fd
         2XexB3vL5BmlnVEWknUHEPFtu1IJZhjpdgSIFlSYbZ2WEnhn229Fkc76YvAR3r3DBxTY
         cicm2iayjzFjZNxYP0kyZnVBs9OydA4uNP5Umpk5KNRUuQi4efMfJXkfPuYBrieqo8An
         jQZse3FiWFszciQOLgDqfyE3nN0pnYXgX1MShdw/m6X7C7wgbjL5AslmxX9P0AnZoh+Q
         PV9A==
X-Gm-Message-State: AOAM533IbpZzv+ebhklTjxVDsovtIFzYdkDrGRJ1aPB8QTjVPaWJvW5S
        lJSff5uFT+marr5WRrZ7y3PgrUQL2fEgCSowldFzDw==
X-Google-Smtp-Source: ABdhPJzMn/gLFelIa9GUbc6ws3AVutFf7cz4pHclu7dRCQHEMxukp/enYyphRMjX9tXnf3VDAi5srJ+nhmeX645OSwE=
X-Received: by 2002:adf:ff87:: with SMTP id j7mr9121458wrr.128.1594965432021;
 Thu, 16 Jul 2020 22:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200715071506.10994-1-anup.patel@wdc.com> <20200715071506.10994-3-anup.patel@wdc.com>
 <9a36824c-ef23-de47-b52c-bf680067be6c@linaro.org> <CAAhSdy3iurBWELjrjKr4mWdueZqw3xmf2e6AD_Km0PE+5TZHWQ@mail.gmail.com>
 <212eb026-e063-2b64-757b-9ca0e3f430bf@linaro.org>
In-Reply-To: <212eb026-e063-2b64-757b-9ca0e3f430bf@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Jul 2020 11:26:59 +0530
Message-ID: <CAAhSdy1fR-GZfTAD4KOJF7j0LzCjYrscxKDD2cTi-8OYnQL5Fg@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 10:58 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 17/07/2020 07:21, Anup Patel wrote:
> > On Fri, Jul 17, 2020 at 2:57 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Anup,
> >>
> >>
> >> On 15/07/2020 09:15, Anup Patel wrote:
> >>> The TIME CSR and SBI calls are not available in RISC-V M-mode so we
> >>> separate add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU
> >>> kernel).
> >>
> >> The description is confusing, please reword it and give a bit more
> >> information about the timer itself, especially, the IPI thing.
> >
> > Okay, will update.
> >
> >>
> >>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >>> ---
> >>>  drivers/clocksource/Kconfig       |  10 ++
> >>>  drivers/clocksource/Makefile      |   1 +
> >>>  drivers/clocksource/timer-clint.c | 229 ++++++++++++++++++++++++++++=
++
> >>>  include/linux/cpuhotplug.h        |   1 +
> >>>  4 files changed, 241 insertions(+)
> >>>  create mode 100644 drivers/clocksource/timer-clint.c
> >>>
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> >>> index 91418381fcd4..eabcf1cfb0c0 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -658,6 +658,16 @@ config RISCV_TIMER
> >>>         is accessed via both the SBI and the rdcycle instruction.  Th=
is is
> >>>         required for all RISC-V systems.
> >>>
> >>> +config CLINT_TIMER
> >>> +     bool "Timer for the RISC-V platform"
> >>> +     depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> >>> +     default y
> >>> +     select TIMER_PROBE
> >>> +     select TIMER_OF
> >>> +     help
> >>> +       This option enables the CLINT timer for RISC-V systems. The C=
LINT
> >>> +       driver is usually used for NoMMU RISC-V systems.
> >>
> >> For the timer, we do silent option and let the platform config select
> >> it. Please refer to other timer option below as reference.
> >
> > Okay, I will use "default RISCV" instead of "default y" (just like othe=
r
> > timer Kconfig options).
>
> Preferably, select it from the platform's Kconfig.

Okay, I will update.

>
> >>
> >>>  config CSKY_MP_TIMER
> >>>       bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
> >>>       depends on CSKY
> >>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> >>> index bdda1a2e4097..18e700e703a0 100644
> >>> --- a/drivers/clocksource/Makefile
> >>> +++ b/drivers/clocksource/Makefile
> >>> @@ -87,6 +87,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)         +=3D clksrc_st_=
lpc.o
> >>>  obj-$(CONFIG_X86_NUMACHIP)           +=3D numachip.o
> >>>  obj-$(CONFIG_ATCPIT100_TIMER)                +=3D timer-atcpit100.o
> >>>  obj-$(CONFIG_RISCV_TIMER)            +=3D timer-riscv.o
> >>> +obj-$(CONFIG_CLINT_TIMER)            +=3D timer-clint.o
> >>>  obj-$(CONFIG_CSKY_MP_TIMER)          +=3D timer-mp-csky.o
> >>>  obj-$(CONFIG_GX6605S_TIMER)          +=3D timer-gx6605s.o
> >>>  obj-$(CONFIG_HYPERV_TIMER)           +=3D hyperv_timer.o
> >>> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/=
timer-clint.c
> >>> new file mode 100644
> >>> index 000000000000..bfc38bb5a589
> >>> --- /dev/null
> >>> +++ b/drivers/clocksource/timer-clint.c
> >>> @@ -0,0 +1,229 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> >>> + *
> >>> + * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
> >>> + * CLINT MMIO timer device.
> >>> + */
> >>> +
> >>> +#define pr_fmt(fmt) "clint: " fmt
> >>> +#include <linux/bitops.h>
> >>> +#include <linux/clocksource.h>
> >>> +#include <linux/clockchips.h>
> >>> +#include <linux/cpu.h>
> >>> +#include <linux/delay.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of_address.h>
> >>> +#include <linux/sched_clock.h>
> >>> +#include <linux/io-64-nonatomic-lo-hi.h>
> >>> +#include <linux/interrupt.h>
> >>> +#include <linux/of_irq.h>
> >>> +#include <linux/smp.h>
> >>> +
> >>> +#define CLINT_IPI_OFF                0
> >>> +#define CLINT_TIMER_CMP_OFF  0x4000
> >>> +#define CLINT_TIMER_VAL_OFF  0xbff8
> >>> +
> >>> +/* CLINT manages IPI and Timer for RISC-V M-mode  */
> >>> +static u32 __iomem *clint_ipi_base;
> >>> +static u64 __iomem *clint_timer_cmp;
> >>> +static u64 __iomem *clint_timer_val;
> >>> +static unsigned long clint_timer_freq;
> >>> +static unsigned int clint_timer_irq;
> >>> +
> >>> +static void clint_send_ipi(const struct cpumask *target)
> >>> +{
> >>> +     unsigned int cpu;
> >>> +
> >>> +     for_each_cpu(cpu, target)
> >>> +             writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
> >>> +}
> >>> +
> >>> +static void clint_clear_ipi(void)
> >>> +{
> >>> +     writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id=
()));
> >>> +}
> >>> +
> >>> +static struct riscv_ipi_ops clint_ipi_ops =3D {
> >>> +     .ipi_inject =3D clint_send_ipi,
> >>> +     .ipi_clear =3D clint_clear_ipi,
> >>> +};
> >>> +
> >>> +#ifdef CONFIG_64BIT
> >>> +#define clint_get_cycles()   readq_relaxed(clint_timer_val)
> >>> +#else
> >>> +#define clint_get_cycles()   readl_relaxed(clint_timer_val)
> >>> +#define clint_get_cycles_hi()        readl_relaxed(((u32 *)clint_tim=
er_val) + 1)
> >>> +#endif
> >>> +
> >>> +#ifdef CONFIG_64BIT
> >>> +static u64 clint_get_cycles64(void)
> >>> +{
> >>> +     return clint_get_cycles();
> >>> +}
> >>> +#else /* CONFIG_64BIT */
> >>> +static u64 clint_get_cycles64(void)
> >>> +{
> >>> +     u32 hi, lo;
> >>> +
> >>> +     do {
> >>> +             hi =3D clint_get_cycles_hi();
> >>> +             lo =3D clint_get_cycles();
> >>> +     } while (hi !=3D clint_get_cycles_hi());
> >>> +
> >>> +     return ((u64)hi << 32) | lo;
> >>> +}
> >>> +#endif /* CONFIG_64BIT */
> >>> +static int clint_clock_next_event(unsigned long delta,
> >>> +                                struct clock_event_device *ce)
> >>> +{
> >>> +     void __iomem *r =3D clint_timer_cmp +
> >>> +                       cpuid_to_hartid_map(smp_processor_id());
> >>> +
> >>> +     csr_set(CSR_IE, IE_TIE);
> >>> +     writeq_relaxed(clint_get_cycles64() + delta, r);
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) =
=3D {
> >>> +     .name                   =3D "clint_clockevent",
> >>> +     .features               =3D CLOCK_EVT_FEAT_ONESHOT,
> >>> +     .rating         =3D 100,
> >>> +     .set_next_event =3D clint_clock_next_event,
> >>> +};
> >>> +
> >>> +static u64 clint_rdtime(struct clocksource *cs)
> >>> +{
> >>> +     return readq_relaxed(clint_timer_val);
> >>> +}
> >>> +
> >>> +static u64 notrace clint_sched_clock(void)
> >>> +{
> >>> +     return readq_relaxed(clint_timer_val);
> >>> +}
> >>> +
> >>> +static struct clocksource clint_clocksource =3D {
> >>> +     .name           =3D "clint_clocksource",
> >>> +     .rating =3D 300,
> >>> +     .mask           =3D CLOCKSOURCE_MASK(64),
> >>> +     .flags          =3D CLOCK_SOURCE_IS_CONTINUOUS,
> >>> +     .read           =3D clint_rdtime,
> >>
> >> What if !CONFIG_64BIT
> >
> > The CLINT counter is 64bit for both 32bit and 64bit systems
> > but I should have used clint_get_cycles64() in clint_rdtime().
> > I will update it.
> >
> >>
> >>> +};
> >>> +
> >>> +static int clint_timer_starting_cpu(unsigned int cpu)
> >>> +{
> >>> +     struct clock_event_device *ce =3D per_cpu_ptr(&clint_clock_even=
t, cpu);
> >>> +
> >>> +     ce->cpumask =3D cpumask_of(cpu);
> >>> +     clockevents_config_and_register(ce, clint_timer_freq, 200, ULON=
G_MAX);
> >>
> >> The function is not immune against registering the same clockevents. I=
f
> >> the CPU is hotplugged several times, this function will be called agai=
n
> >> and again. Why not rely on a for_each_possible_cpu loop in the init
> >> function ?
> >>
> >>> +     enable_percpu_irq(clint_timer_irq,
> >>> +                       irq_get_trigger_type(clint_timer_irq));
> >>
> >> Why do you want to enable / disable the interrrupts ? The should be
> >> already handle by the hotplug framework no ?
> >
> > The perCPU interrupts are not enabled by default. We have to
> > explicitly enable/disable perCPU interrupts in CPU hotplug callbacks.
> >
>
> Isn't is possible to do that in the probe/init function ?

The enable_percpu_irq() and disable_percpu_irq() work for current
CPU only. This means we have to call these functions separately on
each CPU.

>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
