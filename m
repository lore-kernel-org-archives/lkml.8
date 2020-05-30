Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20230C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA322073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590838887;
	bh=rVDhV2vAFhEf0xk3y1F3ElGbH9lOTyved4Q4Ncoc9sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bEoGsB7CG50zybSAEehH9N50BRXIOByzCnM9WBt/JaOomsPSe/v7AhUavobicjlft
	 nwoK3UozASCmzd/kzGHkz+LzMvgrSP/P4zstNy1Ek9mIh/udGIEsFfgXQIBfkwEYUy
	 RNawfeFOWJ0NEADggNmOtqQ4qDRGR1z0Jc51uPuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3Ll0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 07:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3LlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 07:41:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854CF206C3;
        Sat, 30 May 2020 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590838884;
        bh=rVDhV2vAFhEf0xk3y1F3ElGbH9lOTyved4Q4Ncoc9sY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AdD51k266D3EFq7x6xbTQZDCUr0bLCc1yUqez9xWVWX456N+2E6Wbq1Um6/oYFj3Q
         /UEwj/rbA9oRmoodiJmN8LkDQpJTUHuIxY3QLJpnpoW33DueTnAnbA0HruDwYAwhXW
         UwYoyoRIhU98vahB5v9FNmY+Fr2rUMgwyajR4iPQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jezrf-00GX4B-0j; Sat, 30 May 2020 12:41:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 30 May 2020 12:41:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] clocksource/drivers/timer-riscv: Use per-CPU timer
 interrupt
In-Reply-To: <20200530100725.265481-5-anup.patel@wdc.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
 <20200530100725.265481-5-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <e9a832ec748671b4daef398ecf784db2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-30 11:07, Anup Patel wrote:
> Instead of directly calling RISC-V timer interrupt handler from
> RISC-V local interrupt conntroller driver, this patch implements
> RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
> of Linux IRQ subsystem.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/irq.h      |  2 --
>  drivers/clocksource/timer-riscv.c | 41 ++++++++++++++++++++++++++++---
>  drivers/irqchip/irq-riscv-intc.c  |  8 ------
>  3 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/irq.h 
> b/arch/riscv/include/asm/irq.h
> index a9e5f07a7e9c..9807ad164015 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -10,8 +10,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/linkage.h>
> 
> -void riscv_timer_interrupt(void);
> -
>  #include <asm-generic/irq.h>
> 
>  #endif /* _ASM_RISCV_IRQ_H */
> diff --git a/drivers/clocksource/timer-riscv.c
> b/drivers/clocksource/timer-riscv.c
> index c4f15c4068c0..1fe847983f50 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -12,8 +12,11 @@
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/sched_clock.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
>  #include <asm/smp.h>
>  #include <asm/sbi.h>
> 
> @@ -39,6 +42,7 @@ static int riscv_clock_next_event(unsigned long 
> delta,
>  	return 0;
>  }
> 
> +static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = 
> {
>  	.name			= "riscv_timer_clockevent",
>  	.features		= CLOCK_EVT_FEAT_ONESHOT,
> @@ -74,30 +78,36 @@ static int riscv_timer_starting_cpu(unsigned int 
> cpu)
>  	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
> 
>  	ce->cpumask = cpumask_of(cpu);
> +	ce->irq = riscv_clock_event_irq;
>  	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> 
> -	csr_set(CSR_IE, IE_TIE);
> +	enable_percpu_irq(riscv_clock_event_irq,
> +			  irq_get_trigger_type(riscv_clock_event_irq));
>  	return 0;
>  }
> 
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
> -	csr_clear(CSR_IE, IE_TIE);
> +	disable_percpu_irq(riscv_clock_event_irq);
>  	return 0;
>  }
> 
>  /* called directly from the low-level interrupt handler */
> -void riscv_timer_interrupt(void)
> +static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
>  {
>  	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
> 
>  	csr_clear(CSR_IE, IE_TIE);
>  	evdev->event_handler(evdev);
> +
> +	return IRQ_HANDLED;
>  }
> 
>  static int __init riscv_timer_init_dt(struct device_node *n)
>  {
>  	int cpuid, hartid, error;
> +	struct device_node *child;
> +	struct irq_domain *domain;
> 
>  	hartid = riscv_of_processor_hartid(n);
>  	if (hartid < 0) {
> @@ -115,6 +125,23 @@ static int __init riscv_timer_init_dt(struct
> device_node *n)
>  	if (cpuid != smp_processor_id())
>  		return 0;
> 
> +	domain = NULL;
> +	for_each_child_of_node(n, child) {
> +		domain = irq_find_host(child);
> +		if (domain)
> +			break;
> +	}

This is a bit clumsy, and probably better written as:

         child = of_get_compatible(n, "riscv,cpu-intc");
         if (!child) { error out }
         domain = irq_find_host(child);

It would be even better if each CPU would have its per-CPU interrupt
controller designated as such (with an interrupt-parent property),
meaning that you wouldn't have to do anything at all.

Too late for that anyway.

         M.
-- 
Jazz is not dead. It just smells funny...
