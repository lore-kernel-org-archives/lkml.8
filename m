Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D50C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F109C206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgEUOE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:04:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgEUOE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:04:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218FAD6E;
        Thu, 21 May 2020 07:04:58 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67353F305;
        Thu, 21 May 2020 07:04:56 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-7-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 06/11] irqchip/gic-v3: Configure SGIs as standard interrupts
In-reply-to: <20200519161755.209565-7-maz@kernel.org>
Date:   Thu, 21 May 2020 15:04:54 +0100
Message-ID: <jhjimgpxu2h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/20 17:17, Marc Zyngier wrote:
> Change the way we deal with GICv3 SGIs by turning them into proper
> IRQs, and calling into the arch code to register the interrupt range
> instead of a callback.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 91 +++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 23d7c87da407..d57289057b75 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1163,10 +1142,36 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>
>  static void gic_smp_init(void)
>  {
> -	set_smp_cross_call(gic_raise_softirq);
> +	struct irq_fwspec sgi_fwspec = {
> +		.fwnode		= gic_data.fwnode,
> +	};
> +	int base_sgi;
> +
>       cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
>                                 "irqchip/arm/gicv3:starting",
>                                 gic_starting_cpu, NULL);
> +
> +	if (is_of_node(gic_data.fwnode)) {
> +		/* DT */
> +		sgi_fwspec.param_count = 3;
> +		sgi_fwspec.param[0] = GIC_IRQ_TYPE_SGI;
> +		sgi_fwspec.param[1] = 0;
> +		sgi_fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> +	} else {
> +		/* ACPI */
> +		sgi_fwspec.param_count = 2;
> +		sgi_fwspec.param[0] = 0;
> +		sgi_fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
> +	}
> +
> +	/* Register all 8 non-secure SGIs */
> +	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
> +					   NUMA_NO_NODE, &sgi_fwspec,
> +					   false, NULL);

So IIUC using irq_reserve_ipi() would require us to have a separate IPI
domain, so instead here we can use a fwspec + the 'regular' GIC domain.

One thing I see is that by not going through irq_reserve_ipi(), we don't set
data->common->ipi_offset. I think this is all kzalloc'd, and we want an
offset of 0 so it all works out, but this feels somewhat fragile.

> +	if (WARN_ON(base_sgi <= 0))
> +		return;
> +
> +	set_smp_ipi_range(base_sgi, 8);
>  }
>
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> @@ -1289,6 +1296,13 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>
>       switch (__get_intid_range(hw)) {
>       case SGI_RANGE:
> +		irq_set_percpu_devid(irq);
> +		irq_domain_set_info(d, irq, hw, chip, d->host_data,
> +				    handle_percpu_devid_fasteoi_ipi,
> +				    NULL, NULL);
> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);

FWIW IRQ_NOAUTOEN is already set by irq_set_percpu_devid_flags(), so that's
not required. I know we do that for (E)PPIs, I think I already have a small
patch stashed somewhere regarding that.

> +		break;
> +
>       case PPI_RANGE:
>       case EPPI_RANGE:
>               irq_set_percpu_devid(irq);
