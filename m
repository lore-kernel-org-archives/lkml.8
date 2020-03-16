Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C71C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4A20575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584369247;
	bh=uMF3QsbME7AEQLIGa4it4F+7gI7S9iWWCO7lcyAp5HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d4Cl8XS4KrwchnfnQoVzeburI9F/69CPMfOgfWYMfz+H0DIDfZ0inatIJ9ThLGaJs
	 tWYkRxwJ8CCzJvsLQDgDprKQPeIBzXiIe0VYzxdq0Fcgc5XDEBLL5OvrcQSDeQCC8h
	 VhtVdO6Z1lITJCpEgD1BHCrhLxZjK6GYYjb9w9w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgCPOeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731572AbgCPOeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:34:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 413582051A;
        Mon, 16 Mar 2020 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584369244;
        bh=uMF3QsbME7AEQLIGa4it4F+7gI7S9iWWCO7lcyAp5HI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSv8Cm2r8XV3m93SmiqNJ1nWMcnKG4gI9XG3V1wG7Uu2Y+srI21d/OIJjkZVLWEpV
         1Xl0M+gKXvEHXXk0QqmN1mqGibRmMDE9cC8YtW+9hmABBCA+MDItqQdyAfZOevIbeH
         SIloO7iYnJQBr/xMLhYAaCoVGd06DQFEx4VLvzA8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDqoc-00D655-Fc; Mon, 16 Mar 2020 14:34:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 14:34:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, michals@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sivadur@xilinx.com, anirudh@xilinx.com,
        Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Subject: Re: [PATCH v4 1/3] irqchip: xilinx: Add support for multiple
 instances
In-Reply-To: <20200316135447.30162-2-mubin.usman.sayyed@xilinx.com>
References: <20200316135447.30162-1-mubin.usman.sayyed@xilinx.com>
 <20200316135447.30162-2-mubin.usman.sayyed@xilinx.com>
Message-ID: <be19cec70f79e10483bd8da592b5a924@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mubin.usman.sayyed@xilinx.com, tglx@linutronix.de, jason@lakedaemon.net, michals@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sivadur@xilinx.com, anirudh@xilinx.com, anirudha.sarangi@xilinx.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-16 13:54, Mubin Usman Sayyed wrote:
> From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> 
> Added support for cascaded interrupt controllers.
> 
> Following cascaded configurations have been tested,
> 
> - peripheral->xilinx-intc->xilinx-intc->gic->Cortexa53 processor
>   on zcu102 board
> - peripheral->xilinx-intc->xilinx-intc->microblaze processor
>   on kcu105 board
> 
> Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> ---
> Changes for v4:
> 	- Fixed review comments from Thomas - updated commit
> 	  message, variable declarations changed to reverse
> 	  fir tree and cleaned up some code.
> 
> Changes for v3:
> 	- Modified prototype of xintc_write/xintc_read
> 	- Fixed review comments regarding indentation/variable
> 	  names, used BIT
> 	- Modified xintc_get_irq_local to return 0
> 	  in case of failure/no pending interrupts
> 	- Fixed return type of xintc_read
> 	- Reverted changes related to device name and
> 	  kept intc_dev as static
> 
> Changes for v2:
>         - Removed write_fn/read_fn hooks, used xintc_write/
> 	  xintc_read directly
>         - Moved primary_intc declaration after xintc_irq_chip
> ---
>  drivers/irqchip/irq-xilinx-intc.c | 121 ++++++++++++++++++------------
>  1 file changed, 71 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-xilinx-intc.c
> b/drivers/irqchip/irq-xilinx-intc.c
> index e3043ded8973..65b77720ef2e 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -38,29 +38,32 @@ struct xintc_irq_chip {
>  	void		__iomem *base;
>  	struct		irq_domain *root_domain;
>  	u32		intr_mask;
> +	struct		irq_chip *intc_dev;

What is the need for this pointer? As far as I can see, all the 
interrupts
have the same callbacks, and even then, there should be no need to keep
a pointer to that.

> +	u32		nr_irq;
>  };
> 
> -static struct xintc_irq_chip *xintc_irqc;
> +static struct xintc_irq_chip *primary_intc;
> 
> -static void xintc_write(int reg, u32 data)
> +static void xintc_write(struct xintc_irq_chip *irqc, int reg, u32 
> data)
>  {
>  	if (static_branch_unlikely(&xintc_is_be))
> -		iowrite32be(data, xintc_irqc->base + reg);
> +		iowrite32be(data, irqc->base + reg);
>  	else
> -		iowrite32(data, xintc_irqc->base + reg);
> +		iowrite32(data, irqc->base + reg);
>  }
> 
> -static unsigned int xintc_read(int reg)
> +static u32 xintc_read(struct xintc_irq_chip *irqc, int reg)
>  {
>  	if (static_branch_unlikely(&xintc_is_be))
> -		return ioread32be(xintc_irqc->base + reg);
> +		return ioread32be(irqc->base + reg);
>  	else
> -		return ioread32(xintc_irqc->base + reg);
> +		return ioread32(irqc->base + reg);
>  }
> 
>  static void intc_enable_or_unmask(struct irq_data *d)
>  {
> -	unsigned long mask = 1 << d->hwirq;
> +	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +	unsigned long mask = BIT(d->hwirq);
> 
>  	pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);
> 
> @@ -69,30 +72,35 @@ static void intc_enable_or_unmask(struct irq_data 
> *d)
>  	 * acks the irq before calling the interrupt handler
>  	 */
>  	if (irqd_is_level_type(d))
> -		xintc_write(IAR, mask);
> +		xintc_write(irqc, IAR, mask);
> 
> -	xintc_write(SIE, mask);
> +	xintc_write(irqc, SIE, mask);
>  }
> 
>  static void intc_disable_or_mask(struct irq_data *d)
>  {
> +	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +
>  	pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
> -	xintc_write(CIE, 1 << d->hwirq);
> +	xintc_write(irqc, CIE, BIT(d->hwirq));
>  }
> 
>  static void intc_ack(struct irq_data *d)
>  {
> +	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +
>  	pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
> -	xintc_write(IAR, 1 << d->hwirq);
> +	xintc_write(irqc, IAR, BIT(d->hwirq));
>  }
> 
>  static void intc_mask_ack(struct irq_data *d)
>  {
> -	unsigned long mask = 1 << d->hwirq;
> +	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +	unsigned long mask = BIT(d->hwirq);
> 
>  	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
> -	xintc_write(CIE, mask);
> -	xintc_write(IAR, mask);
> +	xintc_write(irqc, CIE, mask);
> +	xintc_write(irqc, IAR, mask);
>  }
> 
>  static struct irq_chip intc_dev = {
> @@ -103,13 +111,28 @@ static struct irq_chip intc_dev = {
>  	.irq_mask_ack = intc_mask_ack,
>  };
> 
> +static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
> +{
> +	unsigned int irq = 0;
> +	u32 hwirq;
> +
> +	hwirq = xintc_read(irqc, IVR);
> +	if (hwirq != -1U)
> +		irq = irq_find_mapping(irqc->root_domain, hwirq);
> +
> +	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
> +
> +	return irq;
> +}
> +
>  unsigned int xintc_get_irq(void)
>  {
> -	unsigned int hwirq, irq = -1;
> +	unsigned int irq = -1;
> +	u32 hwirq;
> 
> -	hwirq = xintc_read(IVR);
> +	hwirq = xintc_read(primary_intc, IVR);
>  	if (hwirq != -1U)
> -		irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
> +		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
> 
>  	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
> 
> @@ -118,15 +141,18 @@ unsigned int xintc_get_irq(void)
> 
>  static int xintc_map(struct irq_domain *d, unsigned int irq,
> irq_hw_number_t hw)
>  {
> -	if (xintc_irqc->intr_mask & (1 << hw)) {
> -		irq_set_chip_and_handler_name(irq, &intc_dev,
> -						handle_edge_irq, "edge");
> +	struct xintc_irq_chip *irqc = d->host_data;
> +
> +	if (irqc->intr_mask & BIT(hw)) {
> +		irq_set_chip_and_handler_name(irq, irqc->intc_dev,
> +					      handle_edge_irq, "edge");
>  		irq_clear_status_flags(irq, IRQ_LEVEL);
>  	} else {
> -		irq_set_chip_and_handler_name(irq, &intc_dev,
> -						handle_level_irq, "level");
> +		irq_set_chip_and_handler_name(irq, irqc->intc_dev,
> +					      handle_level_irq, "level");
>  		irq_set_status_flags(irq, IRQ_LEVEL);
>  	}
> +	irq_set_chip_data(irq, irqc);
>  	return 0;
>  }
> 
> @@ -138,12 +164,14 @@ static const struct irq_domain_ops
> xintc_irq_domain_ops = {
>  static void xil_intc_irq_handler(struct irq_desc *desc)
>  {
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct xintc_irq_chip *irqc;
>  	u32 pending;
> 
> +	irqc = irq_data_get_irq_handler_data(&desc->irq_data);
>  	chained_irq_enter(chip, desc);
>  	do {
> -		pending = xintc_get_irq();
> -		if (pending == -1U)
> +		pending = xintc_get_irq_local(irqc);
> +		if (pending == 0U)

nit: I don't think we need to consider the sign of zero.

>  			break;
>  		generic_handle_irq(pending);
>  	} while (true);
> @@ -153,28 +181,19 @@ static void xil_intc_irq_handler(struct irq_desc 
> *desc)
>  static int __init xilinx_intc_of_init(struct device_node *intc,
>  					     struct device_node *parent)
>  {
> -	u32 nr_irq;
> -	int ret, irq;
>  	struct xintc_irq_chip *irqc;
> -
> -	if (xintc_irqc) {
> -		pr_err("irq-xilinx: Multiple instances aren't supported\n");
> -		return -EINVAL;
> -	}
> +	int ret, irq;
> 
>  	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
>  	if (!irqc)
>  		return -ENOMEM;
> -
> -	xintc_irqc = irqc;
> -
>  	irqc->base = of_iomap(intc, 0);
>  	BUG_ON(!irqc->base);
> 
> -	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
> +	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", 
> &irqc->nr_irq);
>  	if (ret < 0) {
>  		pr_err("irq-xilinx: unable to read xlnx,num-intr-inputs\n");
> -		goto err_alloc;
> +		goto error;
>  	}
> 
>  	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", 
> &irqc->intr_mask);
> @@ -183,34 +202,35 @@ static int __init xilinx_intc_of_init(struct
> device_node *intc,
>  		irqc->intr_mask = 0;
>  	}
> 
> -	if (irqc->intr_mask >> nr_irq)
> +	if (irqc->intr_mask >> irqc->nr_irq)
>  		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
> 
>  	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",
> -		intc, nr_irq, irqc->intr_mask);
> +		intc, irqc->nr_irq, irqc->intr_mask);
> 
> +	irqc->intc_dev = &intc_dev;

Based on the above, this should go.

> 
>  	/*
>  	 * Disable all external interrupts until they are
>  	 * explicity requested.
>  	 */
> -	xintc_write(IER, 0);
> +	xintc_write(irqc, IER, 0);
> 
>  	/* Acknowledge any pending interrupts just in case. */
> -	xintc_write(IAR, 0xffffffff);
> +	xintc_write(irqc, IAR, 0xffffffff);
> 
>  	/* Turn on the Master Enable. */
> -	xintc_write(MER, MER_HIE | MER_ME);
> -	if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
> +	xintc_write(irqc, MER, MER_HIE | MER_ME);
> +	if (xintc_read(irqc, MER) != (MER_HIE | MER_ME)) {
>  		static_branch_enable(&xintc_is_be);
> -		xintc_write(MER, MER_HIE | MER_ME);
> +		xintc_write(irqc, MER, MER_HIE | MER_ME);
>  	}
> 
> -	irqc->root_domain = irq_domain_add_linear(intc, nr_irq,
> +	irqc->root_domain = irq_domain_add_linear(intc, irqc->nr_irq,
>  						  &xintc_irq_domain_ops, irqc);
>  	if (!irqc->root_domain) {
>  		pr_err("irq-xilinx: Unable to create IRQ domain\n");
> -		goto err_alloc;
> +		goto error;
>  	}
> 
>  	if (parent) {
> @@ -222,16 +242,17 @@ static int __init xilinx_intc_of_init(struct
> device_node *intc,
>  		} else {
>  			pr_err("irq-xilinx: interrupts property not in DT\n");
>  			ret = -EINVAL;
> -			goto err_alloc;
> +			goto error;
>  		}
>  	} else {
> -		irq_set_default_host(irqc->root_domain);
> +		primary_intc = irqc;
> +		irq_set_default_host(primary_intc->root_domain);

Do you still need this irq_set_default_host() horror? I thought 
microblaze
was fully DT-ified and didn't need this. The use of a non-legacy domain 
tends
to confirm this.

>  	}
> 
>  	return 0;
> 
> -err_alloc:
> -	xintc_irqc = NULL;
> +error:
> +	iounmap(irqc->base);
>  	kfree(irqc);
>  	return ret;

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
