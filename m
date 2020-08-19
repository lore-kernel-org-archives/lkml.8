Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F224FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51F12067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597824872;
	bh=iy+98yEcdg/0uWleUjvQdBaqa49qL9P2nF4i2FkdT2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Pye6Bm396xXZa65ywmlOfjpdQGGER4oqPjG0skr+CWD1+Ipfn1lnjla77csWQxYz3
	 +ylQIWFqXp/rntp7zCZp30dNt8OdUL3kBvTS7j+S8hawhkiBh1d5eF14fmpIqCEJH3
	 5/gBLEYyZZX9E05QwFVItlWlYcS4Qwwz4CLqe+a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHSIOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSIO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:14:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2A32067C;
        Wed, 19 Aug 2020 08:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597824867;
        bh=iy+98yEcdg/0uWleUjvQdBaqa49qL9P2nF4i2FkdT2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wXcQEVBgl6gRt6zks0dWmKVMFlAzkCtEZDMYnPA6DuqthOP094xV1VaxIUawwgw+P
         QCKJaN1lzEMP1zW4sfFXVoabfiV2M7n3g2bUntkIbRym+mus27wuntlh2TpKF7V4+X
         L2cLsx7ijMk875QJrkeze4eKLwS/ok1aYxoD+GVo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8JEm-0048ZR-Qj; Wed, 19 Aug 2020 09:14:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 09:14:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        alix.wu@mediatek.com, daniel@0x0f.com
Subject: Re: [PATCH 1/2] irqchip: irq-mst: Add MStar interrupt controller
 support
In-Reply-To: <20200819034231.20726-2-mark-pk.tsai@mediatek.com>
References: <20200819034231.20726-1-mark-pk.tsai@mediatek.com>
 <20200819034231.20726-2-mark-pk.tsai@mediatek.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com, alix.wu@mediatek.com, daniel@0x0f.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 04:42, Mark-PK Tsai wrote:
> Add MStar interrupt controller support using hierarchy irq
> domain.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/irqchip/Kconfig        |   7 ++
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/irq-mst-intc.c | 195 +++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mst-intc.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bb70b7177f94..c3a9d880a4ea 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -571,4 +571,11 @@ config LOONGSON_PCH_MSI
>  	help
>  	  Support for the Loongson PCH MSI Controller.
> 
> +config MST_IRQ
> +	bool "MStar Interrupt Controller"
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  Support MStar Interrupt Controller.

What selects it? Can it have a default for the relevant platforms?

> +
>  endmenu
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 133f9c45744a..e2688a62403e 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= 
> irq-loongson-htpic.o
>  obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>  obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
>  obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
> +obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
> diff --git a/drivers/irqchip/irq-mst-intc.c 
> b/drivers/irqchip/irq-mst-intc.c
> new file mode 100644
> index 000000000000..38d567741860
> --- /dev/null
> +++ b/drivers/irqchip/irq-mst-intc.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> + */
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define INTC_MASK	0x0
> +#define INTC_EOI	0x20
> +
> +struct mst_intc_chip_data {
> +	raw_spinlock_t lock;
> +	unsigned int irq_start, nr_irqs;
> +	void __iomem *base;
> +	bool no_eoi;

nit: please align the fields of the data structure on a vertical line.

> +};
> +
> +static void mst_poke_irq(struct irq_data *d, u32 offset)

Given that this is supposed to be the opposite of "clear", this
should be mst_set_irq().

> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +	u16 val, mask;
> +
> +	mask = 1 << (hwirq % 16);
> +	offset += (hwirq / 16) * 4;
> +
> +	raw_spin_lock(&cd->lock);
> +	val = readw_relaxed(cd->base + offset) | mask;
> +	writew_relaxed(val, cd->base + offset);
> +	raw_spin_unlock(&cd->lock);

Small improvement, but you still miss the fact that a masking
operation can also occur from an interrupt handler, and this
will cause a deadlock. You need to disable interrupts as well.

> +}
> +
> +static void mst_clear_irq(struct irq_data *d, u32 offset)
> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +	u16 val, mask;
> +
> +	mask = 1 << (hwirq % 16);
> +	offset += (hwirq / 16) * 4;
> +
> +	raw_spin_lock(&cd->lock);
> +	val = readw_relaxed(cd->base + offset) & ~mask;
> +	writew_relaxed(val, cd->base + offset);
> +	raw_spin_unlock(&cd->lock);
> +}
> +
> +static void mst_intc_mask_irq(struct irq_data *d)
> +{
> +	mst_poke_irq(d, INTC_MASK);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void mst_intc_unmask_irq(struct irq_data *d)
> +{
> +	mst_clear_irq(d, INTC_MASK);
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static void mst_intc_eoi_irq(struct irq_data *d)
> +{
> +	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +
> +	if (!cd->no_eoi)
> +		mst_poke_irq(d, INTC_EOI);
> +
> +	irq_chip_eoi_parent(d);
> +}
> +
> +static struct irq_chip mst_intc_chip = {
> +	.name			= "mst-intc",
> +	.irq_mask		= mst_intc_mask_irq,
> +	.irq_unmask		= mst_intc_unmask_irq,
> +	.irq_eoi		= mst_intc_eoi_irq,
> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.flags			= IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int mst_intc_domain_translate(struct irq_domain *d,
> +				     struct irq_fwspec *fwspec,
> +				     unsigned long *hwirq,
> +				     unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 3)
> +			return -EINVAL;
> +
> +		/* No PPI should point to this domain */
> +		if (fwspec->param[0] != 0)
> +			return -EINVAL;
> +
> +		*hwirq = fwspec->param[1];
> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned 
> int virq,
> +				 unsigned int nr_irqs, void *data)
> +{
> +	int i;
> +	irq_hw_number_t hwirq;
> +	struct irq_fwspec parent_fwspec, *fwspec = data;
> +	struct mst_intc_chip_data *cd = (struct mst_intc_chip_data
> *)domain->host_data;

No cast necessary here.

> +
> +	/* Not GIC compliant */
> +	if (fwspec->param_count != 3)
> +		return -EINVAL;
> +
> +	/* No PPI should point to this domain */
> +	if (fwspec->param[0])
> +		return -EINVAL;
> +
> +	if (fwspec->param[1] >= cd->nr_irqs)

This condition is bogus, as it doesn't take into account the nr_irqs
parameter.

> +		return -EINVAL;
> +
> +	hwirq = fwspec->param[1];
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &mst_intc_chip,
> +					      domain->host_data);
> +
> +	parent_fwspec = *fwspec;
> +	parent_fwspec.fwnode = domain->parent->fwnode;
> +	parent_fwspec.param[1] = cd->irq_start + hwirq;
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, 
> &parent_fwspec);
> +}
> +
> +static const struct irq_domain_ops mst_intc_domain_ops = {
> +	.translate	= mst_intc_domain_translate,
> +	.alloc		= mst_intc_domain_alloc,
> +	.free		= irq_domain_free_irqs_common,
> +};
> +
> +int __init
> +mst_intc_of_init(struct device_node *dn, struct device_node *parent)
> +{
> +	struct irq_domain *domain, *domain_parent;
> +	struct mst_intc_chip_data *cd;
> +	unsigned int irq_start, irq_end;

unsigned int != u32.

> +
> +	domain_parent = irq_find_host(parent);
> +	if (!domain_parent) {
> +		pr_err("mst-intc: interrupt-parent not found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_index(dn, "mstar,irqs-map-range", 0, 
> &irq_start) ||
> +	    of_property_read_u32_index(dn, "mstar,irqs-map-range", 1, 
> &irq_end))
> +		return -EINVAL;
> +
> +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +	if (!cd)
> +		return -ENOMEM;
> +
> +	cd->base = of_iomap(dn, 0);
> +	if (!cd->base) {
> +		kfree(cd);
> +		return -ENOMEM;
> +	}
> +
> +	cd->no_eoi = of_property_read_bool(dn, "mstar,intc-no-eoi");
> +	raw_spin_lock_init(&cd->lock);
> +	cd->irq_start = irq_start;
> +	cd->nr_irqs = irq_end - irq_start + 1;
> +	domain = irq_domain_add_hierarchy(domain_parent, 0, cd->nr_irqs, dn,
> +					  &mst_intc_domain_ops, cd);
> +	if (!domain) {
> +		iounmap(cd->base);
> +		kfree(cd);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
