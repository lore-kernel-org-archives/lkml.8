Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98872C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BAC20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbgFYSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:25:23 -0400
Received: from foss.arm.com ([217.140.110.172]:43054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbgFYSZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:25:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 186B1D6E;
        Thu, 25 Jun 2020 11:25:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BF923F71E;
        Thu, 25 Jun 2020 11:25:20 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-4-maz@kernel.org>
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
Subject: Re: [PATCH v2 03/17] arm64: Allow IPIs to be handled as normal interrupts
In-reply-to: <20200624195811.435857-4-maz@kernel.org>
Date:   Thu, 25 Jun 2020 19:25:18 +0100
Message-ID: <jhjlfkbgfzl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 20:57, Marc Zyngier wrote:
> @@ -958,9 +958,76 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
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

Nit: Once we have the irqchip changes in, should we warn & bail out when
!ipi_irq_base? Ditto for the teardown

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
