Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D627C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDDD20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403972AbgFYSZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:25:37 -0400
Received: from foss.arm.com ([217.140.110.172]:43110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbgFYSZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:25:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFE9FD6E;
        Thu, 25 Jun 2020 11:25:35 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D54A3F71E;
        Thu, 25 Jun 2020 11:25:34 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-5-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 04/17] ARM: Allow IPIs to be handled as normal interrupts
In-reply-to: <20200624195811.435857-5-maz@kernel.org>
Date:   Thu, 25 Jun 2020 19:25:32 +0100
Message-ID: <jhjk0zvgfz7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 20:57, Marc Zyngier wrote:
> @@ -696,9 +696,76 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>
>       if ((unsigned)ipinr < NR_IPI)
>               trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +}
> +
> +/* Legacy version, should go away once all irqchips have been converted */
> +void handle_IPI(int ipinr, struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irq_enter();
> +	do_handle_IPI(ipinr);
> +	irq_exit();
> +
>       set_irq_regs(old_regs);
>  }
>
> +static irqreturn_t ipi_handler(int irq, void *data)
> +{
> +	do_handle_IPI(irq - ipi_irq_base);
> +	return IRQ_HANDLED;
> +}
> +
> +static void ipi_send(const struct cpumask *target, unsigned int ipi)
> +{
> +	__ipi_send_mask(ipi_desc[ipi], target);
> +}
> +
> +static void ipi_setup(int cpu)
> +{
> +	if (ipi_irq_base) {
> +		int i;
> +
> +		for (i = 0; i < nr_ipi; i++)
> +			enable_percpu_irq(ipi_irq_base + i, 0);
> +	}
> +}
> +
> +static void ipi_teardown(int cpu)
> +{
> +	if (ipi_irq_base) {
> +		int i;
> +
> +		for (i = 0; i < nr_ipi; i++)
> +			disable_percpu_irq(ipi_irq_base + i);
> +	}
> +}
> +
> +void __init set_smp_ipi_range(int ipi_base, int n)
> +{
> +	int i;
> +
> +	WARN_ON(n < MAX_IPI);
> +	nr_ipi = min(n, MAX_IPI);


I got confused by that backtrace thing and NR_IPI vs MAX_IPI.
I think I got it now : we don't want to call trace_ipi_raise() for
IPI_CPU_BACKTRACE *but* we still need to alloc the desc and route it
through the generic IPI layers.

The only difference I can tell is that now we will get some trace events
for it via the handler entry/exit tracepoints - that shouldn't cause any
issue.

> +
> +	for (i = 0; i < nr_ipi; i++) {
> +		int err;
> +
> +		err = request_percpu_irq(ipi_base + i, ipi_handler,
> +					 "IPI", &irq_stat);
> +		WARN_ON(err);
> +
> +		ipi_desc[i] = irq_to_desc(ipi_base + i);
> +		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> +	}
> +
> +	ipi_irq_base = ipi_base;
> +	set_smp_cross_call(ipi_send);
> +
> +	/* Setup the boot CPU immediately */
> +	ipi_setup(smp_processor_id());
> +}
> +
>  void smp_send_reschedule(int cpu)
>  {
>       smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
