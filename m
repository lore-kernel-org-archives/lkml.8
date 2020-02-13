Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBACC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA12082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgBMMB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:01:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:01:28 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2DBK-0000AB-2E; Thu, 13 Feb 2020 13:01:22 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B69E71013A6; Thu, 13 Feb 2020 13:01:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>,
        jason@lakedaemon.net, maz@kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, siva.durga.paladugu@xilinx.com,
        anirudha.sarangi@xilinx.com,
        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
Subject: Re: [PATCH v3] irqchip: xilinx: Add support for multiple instances
In-Reply-To: <20200211190303.7991-1-mubin.usman.sayyed@xilinx.com>
References: <20200211190303.7991-1-mubin.usman.sayyed@xilinx.com>
Date:   Thu, 13 Feb 2020 13:01:21 +0100
Message-ID: <871rqy3dda.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mubin,

Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com> writes:

> From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
>
> This patch adds support for multiple instances of

git grep 'This patch' Documentation/process/submitting-patches.rst

> xilinx interrupt controller. Below configurations are
> supported by driver,
>
> - peripheral->xilinx-intc->xilinx-intc->gic
> - peripheral->xilinx-intc->xilinx-intc

This is really not much of an explanation.

> Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>

This Signed-off-by chain is incorrect. See chapter 11 and 12 in the same
document.

> @@ -38,29 +38,32 @@ struct xintc_irq_chip {
>  	void		__iomem *base;
>  	struct		irq_domain *root_domain;
>  	u32		intr_mask;
> +	struct		irq_chip *intc_dev;
> +	u32		nr_irq;
>  };
>  
> -static struct xintc_irq_chip *xintc_irqc;
> +static struct xintc_irq_chip *primary_intc;
>  
> -static void xintc_write(int reg, u32 data)
> +static void xintc_write(struct xintc_irq_chip *irqc, int reg, u32 data)
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
> +	unsigned long mask = BIT(d->hwirq);
> +	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);

Please order your local variables in reverse fir tree order:

	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
        unsigned long mask = BIT(d->hwirq);

which is the preferred coding style in this subsystem and way simpler to
read.

>  static void intc_mask_ack(struct irq_data *d)
>  {
> -	unsigned long mask = 1 << d->hwirq;
> +	unsigned long mask = BIT(d->hwirq);
> +	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);

Ditto.
  
>  	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
> -	xintc_write(CIE, mask);
> -	xintc_write(IAR, mask);
> +	xintc_write(irqc, CIE, mask);
> +	xintc_write(irqc, IAR, mask);
>  }
> +static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
> +{
> +	u32 hwirq;
> +	unsigned int irq = 0;

Same.

> +	hwirq = xintc_read(irqc, IVR);
> +	if (hwirq != -1U)
> +		irq = irq_find_mapping(irqc->root_domain, hwirq);
> +
> +	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);

Are these pr_debugs all over the please really required? I can
understand that you use them for development, but are they useful once
the stuff works?

> +	return irq;
> +}
> +
>  unsigned int xintc_get_irq(void)
>  {
> -	unsigned int hwirq, irq = -1;
> +	u32 hwirq;
> +	unsigned int irq = -1;

See above.
 
> -	hwirq = xintc_read(IVR);
> +	hwirq = xintc_read(primary_intc, IVR);
>  	if (hwirq != -1U)
> -		irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
> +		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>  
>  	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>  
> @@ -138,12 +164,14 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
>  static void xil_intc_irq_handler(struct irq_desc *desc)
>  {
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct xintc_irq_chip *irqc =
> +		irq_data_get_irq_handler_data(&desc->irq_data);

Please avoid these ugly line breaks and put the initialization of the
variable in to the code below the declaration.

>  	/* Turn on the Master Enable. */
> -	xintc_write(MER, MER_HIE | MER_ME);
> -	if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
> +	xintc_write(irqc, MER, MER_HIE | MER_ME);
> +	if (!(xintc_read(irqc, MER) & (MER_HIE | MER_ME))) {
>  		static_branch_enable(&xintc_is_be);

I see it's existing logic, but this lacks a comment how it's determined
that xintc is big endian. Looks like some weird "write works?"
probing. Why?

> +	xintc_write(irqc, MER, MER_HIE | MER_ME);

So this writes MER_HIE | MER_ME into MER

> +	if (!(xintc_read(irqc, MER) & (MER_HIE | MER_ME))) {

but this checks just whether ONE of the bits is set. Shouldn't it check
for MER == (MER_HIE | MER_ME), i.e. read back what was written?

Thanks,

        tglx
