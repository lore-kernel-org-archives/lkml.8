Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95DE2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596657755;
	bh=NuRrHjb75cFrk+n0vybfkD6hzBt2HG5YdzBYnMqCit0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RDNwer+w5KE4FzWh6kuIZNggBEEaNq70Y/CSvHBDPthVVXHuBen4sqUitDdmafi3X
	 wc7X3RihBuwvlU0ZofanhAUQal1DlCXUIJXyQ+ywAUhetw8Vo+1l/0H2nRGVp16YXW
	 7Fz9RcUXkTXkK5OjOetTntcnjakOvUm1hBsHqC+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgHEUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgHEQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:38:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77CD52067C;
        Wed,  5 Aug 2020 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596644802;
        bh=NuRrHjb75cFrk+n0vybfkD6hzBt2HG5YdzBYnMqCit0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2BymGdaHusJTYFIG1xA3p908Cd/DF3LTrd7CO4lIWW06cbmdScox9iztI5jlm//wF
         iJmXcdFRD7g73XSW/VqccNdZOhWBzPT+Z6vSsQfXYa52Vk5pqJDbY0A4HcRYFkyIjO
         kqnDo0H5qnidMxWe2tEOBCpv6nYrUYhyipcTnJbM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k3MFU-0003cw-Tu; Wed, 05 Aug 2020 17:26:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 05 Aug 2020 17:26:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, robh+dt@kernel.org, arnd@arndb.de,
        Willy Tarreau <w@1wt.eu>, mark-pk.tsai@mediatek.com
Subject: Re: [PATCH 2/3] irqchip: mstar: msc313-intc interrupt controller
 driver
In-Reply-To: <20200805110052.2655487-3-daniel@0x0f.com>
References: <20200805110052.2655487-1-daniel@0x0f.com>
 <20200805110052.2655487-3-daniel@0x0f.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <a2ac8875d67ce7afe1b28f01683e0c9d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel@0x0f.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, arnd@arndb.de, w@1wt.eu, mark-pk.tsai@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Mark-PK Tsai]

Hi Daniel,

On 2020-08-05 12:00, Daniel Palmer wrote:
> Add a driver for the two peripheral interrupt controllers
> in MStar MSC313 and other MStar/Sigmastar Armv7 SoCs.
> 
> Supports both the "IRQ" and "FIQ" controllers that
> forward interrupts from the various IP blocks inside the
> SoC to the ARM GIC.
> 
> They are basically the same thing except for one difference:
> The FIQ controller needs to clear the interrupt and the IRQ
> controller doesn't.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Tested-by: Willy Tarreau <w@1wt.eu>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-msc313-intc.c | 210 ++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/irqchip/irq-msc313-intc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e64d17aad7b..4d07403a7726 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2157,6 +2157,7 @@ F:	arch/arm/boot/dts/infinity*.dtsi
>  F:	arch/arm/boot/dts/mercury*.dtsi
>  F:	arch/arm/boot/dts/mstar-v7.dtsi
>  F:	arch/arm/mach-mstar/
> +F:	drivers/irqchip/irq-msc313-intc.c
> 
>  ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
>  M:	Michael Petchkovsky <mkpetch@internode.on.net>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 133f9c45744a..67f3ae3507b8 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= 
> irq-loongson-htpic.o
>  obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>  obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
>  obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
> +obj-$(CONFIG_ARCH_MSTARV7)		+= irq-msc313-intc.o
> diff --git a/drivers/irqchip/irq-msc313-intc.c
> b/drivers/irqchip/irq-msc313-intc.c
> new file mode 100644
> index 000000000000..b50f5c858d38
> --- /dev/null
> +++ b/drivers/irqchip/irq-msc313-intc.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Daniel Palmer
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#define REGOFF_MASK		0x0
> +#define REGOFF_POLARITY		0x10
> +#define REGOFF_STATUSCLEAR	0x20
> +#define IRQSPERREG		16
> +#define IRQBIT(hwirq)		BIT((hwirq % IRQSPERREG))
> +#define REGOFF(hwirq)		((hwirq >> 4) * 4)
> +
> +struct msc313_intc {
> +	struct irq_domain *domain;
> +	void __iomem *base;
> +	struct irq_chip irqchip;

Why do you need to embed the irq_chip on a per-controller basis?

> +	u8 gicoff;

Given that basic SPIs can be in the 32-1019 range, this is at
best risky. u32s are free, please use them.

> +};
> +
> +static void msc313_intc_maskunmask(struct msc313_intc *intc, int
> hwirq, bool mask)
> +{
> +	int regoff = REGOFF(hwirq);
> +	void __iomem *addr = intc->base + REGOFF_MASK + regoff;
> +	u16 bit = IRQBIT(hwirq);
> +	u16 reg = readw_relaxed(addr);
> +
> +	if (mask)
> +		reg |= bit;
> +	else
> +		reg &= ~bit;
> +
> +	writew_relaxed(reg, addr);

RMW on a shared MMIO register. Not going to end well. This is valid
for all the callbacks, I believe.

Also, please inline the maskunmask code in their respective callers.
It will be much more readable.

> +}
> +
> +static void msc313_intc_mask_irq(struct irq_data *data)
> +{
> +	struct msc313_intc *intc = data->chip_data;
> +
> +	msc313_intc_maskunmask(intc, data->hwirq, true);
> +	irq_chip_mask_parent(data);
> +}
> +
> +static void msc313_intc_unmask_irq(struct irq_data *data)
> +{
> +	struct msc313_intc *intc = data->chip_data;
> +
> +	msc313_intc_maskunmask(intc, data->hwirq, false);
> +	irq_chip_unmask_parent(data);
> +}
> +
> +static int msc313_intc_set_type_irq(struct irq_data *data, unsigned
> int flow_type)
> +{
> +	struct msc313_intc *intc = data->chip_data;
> +	int irq = data->hwirq;
> +	int regoff = REGOFF(irq);
> +	void __iomem *addr = intc->base + REGOFF_POLARITY + regoff;
> +	u16 bit = IRQBIT(irq);
> +	u16 reg = readw_relaxed(addr);

Please try to write this in a more readable way. For example:


         struct msc313_intc *intc = data->chip_data;
         void __iomem *addr;
         u16 reg, bit;

         addr = intc->base + REGOFF_POLARITY + REGOFF(d->hwirq);
         reg = readw_relaxed(addr);
         bit = IRQBIT(d->hwirq);

White space is free, and some of the variables are really useless.

> +
> +	if (flow_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_HIGH))
> +		reg &= ~bit;
> +	else
> +		reg |= bit;

I don't follow grasp the logic here. What happens on EDGE_BOTH, for
example?

> +
> +	writew_relaxed(reg, addr);

Surely you need to communicate the change of signalling mode
to the parent irqchip, don't you?

> +	return 0;
> +}
> +
> +static void msc313_intc_irq_eoi(struct irq_data *data)
> +{
> +	struct msc313_intc *intc = data->chip_data;
> +	int irq = data->hwirq;
> +	int regoff = REGOFF(irq);
> +	void __iomem *addr = intc->base + REGOFF_STATUSCLEAR + regoff;
> +	u16 bit = IRQBIT(irq);
> +	u16 reg = readw_relaxed(addr);
> +
> +	reg |= bit;
> +	writew_relaxed(reg, addr);
> +	irq_chip_eoi_parent(data);
> +}
> +
> +static int msc313_intc_domain_translate(struct irq_domain *d,
> +				     struct irq_fwspec *fwspec,
> +				     unsigned long *hwirq,
> +				     unsigned int *type)
> +{
> +	if (!is_of_node(fwspec->fwnode) || fwspec->param_count != 2)
> +		return -EINVAL;
> +
> +	*hwirq = fwspec->param[0];

Don't you want to check that the input you get is actually in range?
Not a big deal, given that you then use it as an input parameter
to the GIC driver, it'd better be correct.

> +	*type = fwspec->param[1];
> +
> +	return 0;
> +}
> +
> +static int msc313_intc_domain_alloc(struct irq_domain *domain,
> unsigned int virq,
> +				 unsigned int nr_irqs, void *data)
> +{
> +	struct irq_fwspec *fwspec = data;
> +	struct irq_fwspec parent_fwspec;
> +	struct msc313_intc *intc = domain->host_data;
> +
> +	if (fwspec->param_count != 2)
> +		return -EINVAL;
> +
> +	irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
> &intc->irqchip, intc);
> +
> +	parent_fwspec.fwnode = domain->parent->fwnode;
> +	parent_fwspec.param[0] = GIC_SPI;
> +	parent_fwspec.param[1] = fwspec->param[0] + intc->gicoff;
> +	parent_fwspec.param[2] = fwspec->param[1];
> +	parent_fwspec.param_count = 3;
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> +					    &parent_fwspec);
> +}
> +
> +static const struct irq_domain_ops msc313_intc_domain_ops = {
> +		.translate = msc313_intc_domain_translate,
> +		.alloc = msc313_intc_domain_alloc,
> +		.free = irq_domain_free_irqs_common,
> +};
> +
> +static int  msc313_intc_of_init(struct device_node *node,
> +				   struct device_node *parent,
> +				   void (*eoi)(struct irq_data *data))
> +{
> +	struct irq_domain *domain_parent;
> +	struct msc313_intc *intc;
> +	int ret = 0;
> +	u32 gicoffset, numirqs;
> +
> +	if (of_property_read_u32(node, "mstar,gic-offset", &gicoffset)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (of_property_read_u32(node, "mstar,nr-interrupts", &numirqs)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	domain_parent = irq_find_host(parent);
> +	if (!domain_parent) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
> +	if (!intc) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	intc->base = of_iomap(node, 0);
> +	if (IS_ERR(intc->base)) {
> +		ret = PTR_ERR(intc->base);
> +		goto free_intc;
> +	}
> +
> +	intc->irqchip.name = node->name;

No, please. /proc/interrupt isn't a dumping ground for DT related
information. We have debugfs for that.

> +	intc->irqchip.irq_mask = msc313_intc_mask_irq;
> +	intc->irqchip.irq_unmask = msc313_intc_unmask_irq;
> +	intc->irqchip.irq_eoi = eoi;
> +	intc->irqchip.irq_set_type = msc313_intc_set_type_irq;
> +	intc->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND;

This needs to be a static irq_chip structure. Use two for the EOI
weirdness, or test a flag in your eoi callback.

> +
> +	intc->gicoff = gicoffset;
> +
> +	intc->domain = irq_domain_add_hierarchy(domain_parent, 0, numirqs, 
> node,
> +			&msc313_intc_domain_ops, intc);
> +	if (!intc->domain) {
> +		ret = -ENOMEM;
> +		goto unmap;
> +	}
> +
> +	return 0;
> +
> +unmap:
> +	iounmap(intc->base);
> +free_intc:
> +	kfree(intc);
> +out:
> +	return ret;
> +}
> +
> +static int __init msc313_intc_irq_of_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	return msc313_intc_of_init(node, parent, irq_chip_eoi_parent);
> +};
> +
> +static int __init msc313_intc_fiq_of_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	return msc313_intc_of_init(node, parent, msc313_intc_irq_eoi);
> +};
> +
> +IRQCHIP_DECLARE(msc313_intc_irq, "mstar,msc313-intc-irq",
> +		msc313_intc_irq_of_init);
> +IRQCHIP_DECLARE(mstar_intc_fiq, "mstar,msc313-intc-fiq",
> +		msc313_intc_fiq_of_init);

This driver has a massive feeling of déja-vu. It is almost
a copy of the one posted at [1], which I reviewed early
this week. The issues are the exact same, and I'm 98%
sure this is the same IP block used by two SoC vendors.

Please talk to each other and come up with a single driver.

Thanks,

         M.

[1] 
https://lore.kernel.org/r/20200803062214.24076-1-mark-pk.tsai@mediatek.com
-- 
Jazz is not dead. It just smells funny...
