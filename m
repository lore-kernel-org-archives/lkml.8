Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8169C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7847D20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imSpYHKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGPV16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgGPV15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:27:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28641C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:27:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so13167639wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5JK92VW764q8+USTjp6WsKDCkLnb7pSW+aOBiWRJygQ=;
        b=imSpYHKGyCOjJ5Czt9h9k8iCF4SQ6VgenxISWpdI4s/RoZ8vjykJyzRAP3GibqqzCN
         1zR0OXHHC8eOk/tLf1wSf6Pll7CFEC3R406a0r849aChSB4SsqU36qDOVZwW1wEH2jUQ
         4Op5zJiIjkFdtTwQFUBsnT18Gq8TI/+1N2VN9+HRguUp0o+4GeiXI90TCA/QI0mqLMU/
         HzJZ1/jPGxS0yMNm6pUFj3L6bsgVujg/IaJL5AOcKIB+nn1kSpteEKKsheYK46z38xZA
         WeUlmhG1LM2+gSwo5Xu38m6B+uRNl7B0Z8hdrNvtscJpG+5BGjaaL3Eb4MjdsfqP7zpo
         CBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JK92VW764q8+USTjp6WsKDCkLnb7pSW+aOBiWRJygQ=;
        b=YTjLY1Y2EezlkHm4/MOfm9denpYC+H9Re/2Cr4x4FnQ8naZtlI86slJt6/X3UeZ31q
         z79blqv5TRnCCBFXjKmJRKISD9Hv2QqisUfLY6DhYtW7hopL/x5Hz2BVZAXt9vPk9iXw
         dl6CFSfvqz8y2klXN4R+NUztsI4c17e8ZHIY+yMyMaP6/dOL8JuEShPxl5lYuB5cIKJT
         YHgmPLwxvjpZ2yZW0Lbu+kAAc5VAPz/C6U7IFr6cpmRqwbeQjueZhEmXbMzbFFmknzRA
         hi3m2y5TgDyxBEJhdaj55Ao6xZDiI5zy9kRADhBBXCj+4zXv96UeYYh7QzS74q4jSC31
         A0iA==
X-Gm-Message-State: AOAM530cNcx/LALG/uotcc/sABI6b/ok0bhADiQ+1BripOhCLEAhypwE
        ZcLCt67GfZkeB9DUXYvY0O5nHw==
X-Google-Smtp-Source: ABdhPJx/j03mgDlvlWgpmQ2ia1yJEQnASVHO1jQdzhgeWj89VUwrgjaN8TNbJuT0Xde214d2LVKjag==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr6135208wmh.68.1594934875604;
        Thu, 16 Jul 2020 14:27:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id x185sm10493058wmg.41.2020.07.16.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 14:27:54 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] clocksource/drivers: Add CLINT timer driver
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200715071506.10994-1-anup.patel@wdc.com>
 <20200715071506.10994-3-anup.patel@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9a36824c-ef23-de47-b52c-bf680067be6c@linaro.org>
Date:   Thu, 16 Jul 2020 23:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715071506.10994-3-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anup,


On 15/07/2020 09:15, Anup Patel wrote:
> The TIME CSR and SBI calls are not available in RISC-V M-mode so we
> separate add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU
> kernel).

The description is confusing, please reword it and give a bit more
information about the timer itself, especially, the IPI thing.

> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/clocksource/Kconfig       |  10 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/timer-clint.c | 229 ++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h        |   1 +
>  4 files changed, 241 insertions(+)
>  create mode 100644 drivers/clocksource/timer-clint.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 91418381fcd4..eabcf1cfb0c0 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -658,6 +658,16 @@ config RISCV_TIMER
>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>  	  required for all RISC-V systems.
>  
> +config CLINT_TIMER
> +	bool "Timer for the RISC-V platform"
> +	depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> +	default y
> +	select TIMER_PROBE
> +	select TIMER_OF
> +	help
> +	  This option enables the CLINT timer for RISC-V systems. The CLINT
> +	  driver is usually used for NoMMU RISC-V systems.

For the timer, we do silent option and let the platform config select
it. Please refer to other timer option below as reference.

>  config CSKY_MP_TIMER
>  	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
>  	depends on CSKY
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index bdda1a2e4097..18e700e703a0 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
> +obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>  obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> new file mode 100644
> index 000000000000..bfc38bb5a589
> --- /dev/null
> +++ b/drivers/clocksource/timer-clint.c
> @@ -0,0 +1,229 @@
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
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
> +#include <linux/smp.h>
> +
> +#define CLINT_IPI_OFF		0
> +#define CLINT_TIMER_CMP_OFF	0x4000
> +#define CLINT_TIMER_VAL_OFF	0xbff8
> +
> +/* CLINT manages IPI and Timer for RISC-V M-mode  */
> +static u32 __iomem *clint_ipi_base;
> +static u64 __iomem *clint_timer_cmp;
> +static u64 __iomem *clint_timer_val;
> +static unsigned long clint_timer_freq;
> +static unsigned int clint_timer_irq;
> +
> +static void clint_send_ipi(const struct cpumask *target)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, target)
> +		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
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
> +#define clint_get_cycles()	readq_relaxed(clint_timer_val)
> +#else
> +#define clint_get_cycles()	readl_relaxed(clint_timer_val)
> +#define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_timer_val) + 1)
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
> +static int clint_clock_next_event(unsigned long delta,
> +				   struct clock_event_device *ce)
> +{
> +	void __iomem *r = clint_timer_cmp +
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
> +	return readq_relaxed(clint_timer_val);
> +}
> +
> +static u64 notrace clint_sched_clock(void)
> +{
> +	return readq_relaxed(clint_timer_val);
> +}
> +
> +static struct clocksource clint_clocksource = {
> +	.name		= "clint_clocksource",
> +	.rating	= 300,
> +	.mask		= CLOCKSOURCE_MASK(64),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read		= clint_rdtime,

What if !CONFIG_64BIT

> +};
> +
> +static int clint_timer_starting_cpu(unsigned int cpu)
> +{
> +	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> +
> +	ce->cpumask = cpumask_of(cpu);
> +	clockevents_config_and_register(ce, clint_timer_freq, 200, ULONG_MAX);

The function is not immune against registering the same clockevents. If
the CPU is hotplugged several times, this function will be called again
and again. Why not rely on a for_each_possible_cpu loop in the init
function ?

> +	enable_percpu_irq(clint_timer_irq,
> +			  irq_get_trigger_type(clint_timer_irq));

Why do you want to enable / disable the interrrupts ? The should be
already handle by the hotplug framework no ?

> +	return 0;
> +}
> +
> +static int clint_timer_dying_cpu(unsigned int cpu)
> +{
> +	disable_percpu_irq(clint_timer_irq);
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
> +			pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
> +			       np, i, oirq.args[0]);
> +			return -ENODEV;
> +		}
> +
> +		/* Find parent irq domain and map timer irq */
> +		if (!clint_timer_irq &&
> +		    oirq.args[0] == RV_IRQ_TIMER &&
> +		    irq_find_host(oirq.np))
> +			clint_timer_irq = irq_of_parse_and_map(np, i);
> +	}
> +
> +	/* If CLINT timer irq not found then fail */
> +	if (!clint_timer_irq) {
> +		pr_err("%pOFP: timer irq not found\n", np);
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
> +	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
> +	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
> +	clint_timer_freq = riscv_timebase;
> +
> +	pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
> +
> +	rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
> +	if (rc) {
> +		iounmap(base);
> +		pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
> +		return rc;
> +	}
> +
> +	sched_clock_register(clint_sched_clock, 64, clint_timer_freq);
> +
> +	rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
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
> +		free_irq(clint_timer_irq, &clint_clock_event);
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
> +TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 191772d4a4d7..1451f4625833 100644
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
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
