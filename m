Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA575C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EB3206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596441884;
	bh=86jByJPP79HZFb7NJt9RymPkDBrD8xB0L58L0m5gXMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xJIcK2glXxSCNxHDhtZNy5PcrvO1Ju/JrkWcOlz9xOGZn5Tc9kpH0boAiR2V9iN1C
	 B/kWpd9ABAGO0Ez9vY2Ti1fDWRMudc3V8RnLj9S7/hEa2ycAzLUKGPLOcrDAdyWOhZ
	 3fJzM1A/bZyZKrQ85MFzq6hJKBOajCKPX6UgsAA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHCIEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCIEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:04:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30F22177B;
        Mon,  3 Aug 2020 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596441881;
        bh=86jByJPP79HZFb7NJt9RymPkDBrD8xB0L58L0m5gXMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0TPAb+4m1u6BTKJKJTZkSF57dcsZYmS5f9UJn/olzqz4DSfA0wQ9v4S32SKSTf5OK
         iobLmB3a4vU9pS66FU3Z5aMln2Z6Rh4CYPTtyBgIm1yjWhgiOzc+rpI7CDxrDepn2K
         bZt+U9LelufiWlbNJJg+kLveIB1Nr2T4oJ7amJRA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k2VSZ-00H2M2-Ph; Mon, 03 Aug 2020 09:04:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 09:04:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     yj.chiang@mediatek.com, alix.wu@mediatek.com, tglx@linutronix.de,
        jason@lakedaemon.net, robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] irqchip: irq-mt58xx: Add mt58xx interrupt controller
 support
In-Reply-To: <20200803062214.24076-2-mark-pk.tsai@mediatek.com>
References: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
 <20200803062214.24076-2-mark-pk.tsai@mediatek.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <43f5cba1199f89cde68c8a577103f28b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, yj.chiang@mediatek.com, alix.wu@mediatek.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-03 07:22, Mark-PK Tsai wrote:
> Add mt58xx interrupt controller support using hierarchy irq
> domain.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/irqchip/Kconfig      |   7 ++
>  drivers/irqchip/Makefile     |   1 +
>  drivers/irqchip/irq-mt58xx.c | 196 +++++++++++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mt58xx.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 216b3b8392b5..00453af78be0 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -572,4 +572,11 @@ config LOONGSON_PCH_MSI
>  	help
>  	  Support for the Loongson PCH MSI Controller.
> 
> +config MT58XX_IRQ
> +	bool "MT58XX IRQ"
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  Support Mediatek MT58XX Interrupt Controller.
> +
>  endmenu
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 133f9c45744a..5062e9bfa92d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= 
> irq-loongson-htpic.o
>  obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>  obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
>  obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
> +obj-$(CONFIG_MT58XX_IRQ)		+= irq-mt58xx.o
> diff --git a/drivers/irqchip/irq-mt58xx.c 
> b/drivers/irqchip/irq-mt58xx.c
> new file mode 100644
> index 000000000000..e45ad023afa6
> --- /dev/null
> +++ b/drivers/irqchip/irq-mt58xx.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +
> +#define INTC_MASK	0x0
> +#define INTC_EOI	0x20
> +
> +struct mtk_intc_chip_data {
> +	char *name;
> +	struct irq_chip chip;

There is no need to embed a full struct irqchip per controller, see 
below.

> +	unsigned int irq_start, nr_irqs;
> +	void __iomem *base;
> +};
> +
> +static void mtk_poke_irq(struct irq_data *d, u32 offset)
> +{
> +	struct mtk_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +	void __iomem *base = cd->base;
> +	u8 index = (u8)irqd_to_hwirq(d);

Why the restrictive type? Why isn't unsigned int good enough?

> +	u16 val, mask;
> +
> +	mask = 1 << (index % 16);
> +	val = readw_relaxed(base + offset + (index / 16) * 4) | mask;
> +	writew_relaxed(val, base + offset + (index / 16) * 4);

RMW without locking, you will end-up with corruption.
Please store the address calculation in a temporaty variable to make it
more readable

> +}
> +
> +static void mtk_clear_irq(struct irq_data *d, u32 offset)
> +{
> +	struct mtk_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +	void __iomem *base = cd->base;
> +	u8 index = (u8)irqd_to_hwirq(d);
> +	u16 val, mask;
> +
> +	mask = 1 << (index % 16);
> +	val = readw_relaxed(base + offset + (index / 16) * 4) & ~mask;
> +	writew_relaxed(val, base + offset + (index / 16) * 4);

Same comments.

> +}
> +
> +static void mtk_intc_mask_irq(struct irq_data *d)
> +{
> +	mtk_poke_irq(d, INTC_MASK);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void mtk_intc_unmask_irq(struct irq_data *d)
> +{
> +	mtk_clear_irq(d, INTC_MASK);
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static void mtk_intc_eoi_irq(struct irq_data *d)
> +{
> +	mtk_poke_irq(d, INTC_EOI);
> +	irq_chip_eoi_parent(d);
> +}
> +
> +static struct irq_chip mtk_intc_chip = {
> +	.irq_mask		= mtk_intc_mask_irq,
> +	.irq_unmask		= mtk_intc_unmask_irq,
> +	.irq_eoi		= mtk_intc_eoi_irq,
> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,

How about retrigger?

> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.flags			= IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int mt58xx_intc_domain_translate(struct irq_domain *d,
> +					struct irq_fwspec *fwspec,
> +					unsigned long *hwirq,
> +					unsigned int *type)
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
> +static int mt58xx_intc_domain_alloc(struct irq_domain *domain,
> unsigned int virq,
> +				    unsigned int nr_irqs, void *data)
> +{
> +	int i;
> +	irq_hw_number_t hwirq;
> +	struct irq_fwspec parent_fwspec, *fwspec = data;
> +	struct mtk_intc_chip_data *cd = (struct mtk_intc_chip_data
> *)domain->host_data;
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
> +		return -EINVAL;
> +
> +	hwirq = fwspec->param[1];
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &cd->chip,
> +					      domain->host_data);
> +
> +	parent_fwspec = *fwspec;
> +	parent_fwspec.fwnode = domain->parent->fwnode;
> +	parent_fwspec.param[1] = cd->irq_start + hwirq;
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, 
> &parent_fwspec);
> +}
> +
> +static const struct irq_domain_ops mt58xx_intc_domain_ops = {
> +	.translate	= mt58xx_intc_domain_translate,
> +	.alloc		= mt58xx_intc_domain_alloc,
> +	.free		= irq_domain_free_irqs_common,
> +};
> +
> +int __init
> +mt58xx_intc_of_init(struct device_node *dn, struct device_node 
> *parent)
> +{
> +	static int nr_intc;
> +	struct irq_domain *domain, *domain_parent;
> +	struct mtk_intc_chip_data *cd;
> +	unsigned int irq_start, irq_end;
> +
> +	domain_parent = irq_find_host(parent);
> +	if (!domain_parent) {
> +		pr_err("mt58xx-intc: interrupt-parent not found\n");
> +		return -EINVAL;
> +	}
> +
> +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +	if (!cd)
> +		return -ENOMEM;
> +
> +	cd->chip = mtk_intc_chip;
> +	if (of_property_read_u32_index(dn, "mediatek,irqs-map-range", 0,
> &irq_start) ||
> +	    of_property_read_u32_index(dn, "mediatek,irqs-map-range", 1, 
> &irq_end)) {
> +		kfree(cd);
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_bool(dn, "mediatek,intc-no-eoi"))
> +		cd->chip.irq_eoi = irq_chip_eoi_parent;

No. Just add a flag to your chip data structure, and check for this
flag in your irq_eoi callback. Or provide two distinct irq_chip
structures that will only differ by the irq_eoi method.

> +
> +	cd->irq_start = irq_start;
> +	cd->nr_irqs = irq_end - irq_start + 1;
> +	cd->chip.name = kasprintf(GFP_KERNEL, "mt58xx-intc-%d", nr_intc++);

Neither. That's not useful, and is a waste of memory. Stick to constant
names in the irq_chip structure.

> +	if (!cd->chip.name) {
> +		kfree(cd);
> +		return -ENOMEM;
> +	}
> +
> +	cd->base = of_iomap(dn, 0);
> +	if (!cd->base) {
> +		kfree(cd->chip.name);
> +		kfree(cd);
> +		return -ENOMEM;
> +	}
> +
> +	domain = irq_domain_add_hierarchy(domain_parent, 0, cd->nr_irqs,
> +					  dn, &mt58xx_intc_domain_ops, cd);
> +	if (!domain) {
> +		kfree(cd->chip.name);
> +		iounmap(cd->base);
> +		kfree(cd);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(mt58xx_intc, "mediatek,mt58xx-intc", 
> mt58xx_intc_of_init);

On a side note, the merge window has just opened. Please refrain from
reposting this until -rc1.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
