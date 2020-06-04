Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252ACC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E191A207ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="H70iaDLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgFDUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgFDUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:40:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1ECC08C5C3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:40:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so4020631pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=L/U8c/PXFMTsxrpivoUvDjmS/iUJqKU1K1bbJF/atPo=;
        b=H70iaDLrtQ5Ua3qIrKMV6cKkCUIy2rlAV9Cj7hsuwrteP/aPko7J/cOi/4uSFXFWtK
         G5Dfyw1hR9uKnqiQr7G6hT0kMklntnOaKmKKpkMUkRzsZNefksGULPdNVIuhXHj2l3I6
         E2b96OThXjKeb6zqRtGGFqFCO4qo3PBZkq5LYddeBPshajHXzlxr5k+e9BRNql3FN0OJ
         TEN6dz+fgaqc7XOdz7v1IgBX9PM+ufbqrr1zmR16o2xZLspxAP4BqRSJkeJPy1O+V0pg
         yudRiOU/JGW5WnznExsO084DXEa+366ANQDwvRZUvRqLeKj0EcfmYatONrlSv6IFS9pX
         +eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=L/U8c/PXFMTsxrpivoUvDjmS/iUJqKU1K1bbJF/atPo=;
        b=GS0ACvvyqjRutJjbIojHLj/Mo0uv+F0FHwLOlx2Ty/ZHB+YydiECEh2VX67MR6TL3X
         c9OcmAnub+pPwFw9XtFOjY1FBC+2tgihhjViNVopZNX81Z4c4qe5LbECdpb6pwQWlR/5
         4gUWFJBYrgXzAbMRJoUasJL4UAz+NyU4IyZfretUSdynT1yzYjz4xvOqfoWyJVoi0HYR
         EmJ+zIzf8/9W3t6gxeeB6TdqgxmtQ+Gt1xliD3HQkmir80zjKAhflqBxt9aTnKFzUOW0
         H38eWifxfujsJJaotMWREAEkUULa3mJgn+JOlmmuARwbIGXFZ5QWgh2uL4UOSo9XmjiS
         vdgA==
X-Gm-Message-State: AOAM532NK7dxfp1GOyLxVpjzvvLUEGxo0Ft8DKF+Ne2roTSYTYhZDOKT
        Pe0YYC3cfHRVhuvZ34w0z6M8fg==
X-Google-Smtp-Source: ABdhPJyjDp8Wov2+zjLUCvWPv8t855rDDpwh4uo8Oh00TNkCWoaJ6DtEBL9V+UhE702w6gjZ/GQHmg==
X-Received: by 2002:a63:7b51:: with SMTP id k17mr6179958pgn.422.1591303222623;
        Thu, 04 Jun 2020 13:40:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y186sm5051677pfy.66.2020.06.04.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:40:22 -0700 (PDT)
Date:   Thu, 04 Jun 2020 13:40:22 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 13:36:30 PDT (-0700)
Subject:     Re: [PATCH 4/5] clocksource/drivers: Add CLINT timer driver
In-Reply-To: <20200521134544.816918-5-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-a3c3bd81-fd8f-4975-8a33-41e40cf2b341@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:45:43 PDT (-0700), Anup Patel wrote:
> The TIME CSR and SBI calls are not available in RISC-V M-mode so we
> add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU kernel).
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/clocksource/Kconfig       |  10 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/timer-clint.c | 226 ++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h        |   1 +
>  4 files changed, 238 insertions(+)
>  create mode 100644 drivers/clocksource/timer-clint.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 21950d9e3e9d..ea97bf0eb09f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -659,6 +659,16 @@ config RISCV_TIMER
>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>  	  required for all RISC-V systems.
>
> +config CLINT_TIMER
> +	bool "Timer for the RISC-V platform"
> +	depends on GENERIC_SCHED_CLOCK && RISCV

Presumably this also depends on RISCV_M_MODE?

> +	default y
> +	select TIMER_PROBE
> +	select TIMER_OF
> +	help
> +	  This option enables the CLINT timer for RISC-V systems. The CLINT
> +	  driver is usually used for NoMMU RISC-V systems.
> +
>  config CSKY_MP_TIMER
>  	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
>  	depends on CSKY
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 641ba5383ab5..dca308b5ff98 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
> +obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>  obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> new file mode 100644
> index 000000000000..7fc4f145da65
> --- /dev/null
> +++ b/drivers/clocksource/timer-clint.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + *
> + * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
> + * CLINT MMIO timer device.
> + */
> +
> +#define pr_fmt(fmt) "clint: " fmt
> +#include <linux/bitops.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/sched_clock.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/irqchip/irq-riscv-intc.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
> +#include <linux/smp.h>
> +
> +#define CLINT_IPI_OFF		0
> +#define CLINT_TIME_CMP_OFF	0x4000
> +#define CLINT_TIME_VAL_OFF	0xbff8
> +
> +/* CLINT manages IPI and Timer for RISC-V M-mode  */
> +static u32 __iomem *clint_ipi_base;

It seems odd to have IPIs in the timer driver.  I know the CLINT handles both
of them, but these really feel like two separate drivers.

> +static u64 __iomem *clint_time_cmp;
> +static u64 __iomem *clint_time_val;
> +static unsigned long clint_freq;
> +static unsigned int clint_irq;
> +
> +static void clint_send_ipi(const unsigned long *hart_mask)
> +{
> +	u32 hartid;
> +
> +	for_each_set_bit(hartid, hart_mask, NR_CPUS)
> +		writel(1, clint_ipi_base + hartid);
> +}
> +
> +static void clint_clear_ipi(void)
> +{
> +	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
> +}
> +
> +static struct riscv_ipi_ops clint_ipi_ops = {
> +	.ipi_inject = clint_send_ipi,
> +	.ipi_clear = clint_clear_ipi,
> +};
> +
> +#ifdef CONFIG_64BIT
> +#define clint_get_cycles()	readq_relaxed(clint_time_val)
> +#else
> +#define clint_get_cycles()	readl_relaxed(clint_time_val)
> +#define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_time_val) + 1)
> +#endif
> +
> +#ifdef CONFIG_64BIT
> +static u64 clint_get_cycles64(void)
> +{
> +	return clint_get_cycles();
> +}
> +#else /* CONFIG_64BIT */
> +static u64 clint_get_cycles64(void)
> +{
> +	u32 hi, lo;
> +
> +	do {
> +		hi = clint_get_cycles_hi();
> +		lo = clint_get_cycles();
> +	} while (hi != clint_get_cycles_hi());
> +
> +	return ((u64)hi << 32) | lo;
> +}
> +#endif /* CONFIG_64BIT */
> +
> +static int clint_clock_next_event(unsigned long delta,
> +				   struct clock_event_device *ce)
> +{
> +	void __iomem *r = clint_time_cmp +
> +			  cpuid_to_hartid_map(smp_processor_id());
> +
> +	csr_set(CSR_IE, IE_TIE);
> +	writeq_relaxed(clint_get_cycles64() + delta, r);
> +	return 0;
> +}
> +
> +static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
> +	.name			= "clint_clockevent",
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> +	.rating		= 100,
> +	.set_next_event	= clint_clock_next_event,
> +};
> +
> +static u64 clint_rdtime(struct clocksource *cs)
> +{
> +	return readq_relaxed(clint_time_val);
> +}
> +
> +static u64 notrace clint_sched_clock(void)
> +{
> +	return readq_relaxed(clint_time_val);
> +}
> +
> +static struct clocksource clint_clocksource = {
> +	.name		= "clint_clocksource",
> +	.rating	= 300,
> +	.mask		= CLOCKSOURCE_MASK(64),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read		= clint_rdtime,
> +};
> +
> +static int clint_timer_starting_cpu(unsigned int cpu)
> +{
> +	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> +
> +	ce->cpumask = cpumask_of(cpu);
> +	clockevents_config_and_register(ce, clint_freq, 200, ULONG_MAX);
> +
> +	enable_percpu_irq(clint_irq, irq_get_trigger_type(clint_irq));
> +	return 0;
> +}
> +
> +static int clint_timer_dying_cpu(unsigned int cpu)
> +{
> +	disable_percpu_irq(clint_irq);
> +	return 0;
> +}
> +
> +static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evdev = this_cpu_ptr(&clint_clock_event);
> +
> +	csr_clear(CSR_IE, IE_TIE);
> +	evdev->event_handler(evdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init clint_timer_init_dt(struct device_node *np)
> +{
> +	int rc;
> +	u32 i, nr_irqs;
> +	void __iomem *base;
> +	struct of_phandle_args oirq;
> +
> +	/*
> +	 * Ensure that CLINT device interrupts are either RV_IRQ_TIMER or
> +	 * RV_IRQ_SOFT. If it's anything else then we ignore the device.
> +	 */
> +	nr_irqs = of_irq_count(np);
> +	for (i = 0; i < nr_irqs; i++) {
> +		if (of_irq_parse_one(np, i, &oirq)) {
> +			pr_err("%pOFP: failed to parse irq %d.\n", np, i);
> +			continue;
> +		}
> +
> +		if ((oirq.args_count != 1) ||
> +		    (oirq.args[0] != RV_IRQ_TIMER &&
> +		     oirq.args[0] != RV_IRQ_SOFT)) {
> +			pr_info("%pOFP: invalid irq %d (hwirq %d)\n",
> +				np, i, oirq.args[0]);
> +			return 0;
> +		}
> +	}
> +
> +	oirq.np = riscv_of_intc_domain_node();
> +	oirq.args_count = 1;
> +	oirq.args[0] = RV_IRQ_TIMER;
> +	clint_irq = irq_create_of_mapping(&oirq);
> +	if (!clint_irq) {
> +		pr_err("%pOFP: could not map hwirq %d\n", np, RV_IRQ_TIMER);
> +		return -ENODEV;
> +	}
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_err("%pOFP: could not map registers\n", np);
> +		return -ENODEV;
> +	}
> +
> +	clint_ipi_base = base + CLINT_IPI_OFF;
> +	clint_time_cmp = base + CLINT_TIME_CMP_OFF;
> +	clint_time_val = base + CLINT_TIME_VAL_OFF;
> +	clint_freq = riscv_timebase;
> +
> +	pr_info("%pOFP: timer running at %ld Hz\n", np, clint_freq);
> +
> +	rc = clocksource_register_hz(&clint_clocksource, clint_freq);
> +	if (rc) {
> +		iounmap(base);
> +		pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
> +		return rc;
> +	}
> +
> +	sched_clock_register(clint_sched_clock, 64, clint_freq);
> +
> +	rc = request_percpu_irq(clint_irq, clint_timer_interrupt,
> +				 "clint-timer", &clint_clock_event);
> +	if (rc) {
> +		iounmap(base);
> +		pr_err("registering percpu irq failed [%d]\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
> +				"clockevents/clint/timer:starting",
> +				clint_timer_starting_cpu,
> +				clint_timer_dying_cpu);
> +	if (rc) {
> +		free_irq(clint_irq, &clint_clock_event);
> +		iounmap(base);
> +		pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
> +		return rc;
> +	}
> +
> +	riscv_set_ipi_ops(&clint_ipi_ops);
> +	clint_clear_ipi();
> +
> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
> +TIMER_OF_DECLARE(clint_timer1, "sifive,clint-1.0.0", clint_timer_init_dt);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 57b1f8f777d9..52552492c2f2 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -132,6 +132,7 @@ enum cpuhp_state {
>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>  	CPUHP_AP_ARC_TIMER_STARTING,
>  	CPUHP_AP_RISCV_TIMER_STARTING,
> +	CPUHP_AP_CLINT_TIMER_STARTING,
>  	CPUHP_AP_CSKY_TIMER_STARTING,
>  	CPUHP_AP_HYPERV_TIMER_STARTING,
>  	CPUHP_AP_KVM_STARTING,
