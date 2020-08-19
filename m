Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC5C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93790207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mELPK41e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHSQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:52:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7DC061757;
        Wed, 19 Aug 2020 09:52:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so27077206ejb.11;
        Wed, 19 Aug 2020 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lu1L8Np4Sb1znwysVOMYeFd9PeezWxo0K5RLTh1iwF8=;
        b=mELPK41eNWYV7XCpw+RnLESHqhS/nSXA6SruNKm9XqHomDbZgcdomg5q5FIYFGSOgF
         57r/JqBVViqLKlIIsg4KLyBe+8DjxUn/C3Pxdj8RqwGLc09S8EnZ1QG4OsN8REr6N3cA
         M9xwDj9I+1WK7OWfJLVMDuugstPh+OdMFKN5xF+M1U3BL7npqHGqOFaoEGxTJIZextjX
         h51o68qT+7dEgZdmXXYLzP5h3cBRwnRkk2j8Moh/pdNLYDtvuLyYHGt0dZNXEibMbOHh
         bf/bOUyNZb6D6Ws0NgvGv5DJ63UXWsa8GHq2DiTJysjxkCsWRM8wgyxzQehSY1O1zaar
         i2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Lu1L8Np4Sb1znwysVOMYeFd9PeezWxo0K5RLTh1iwF8=;
        b=A2C3Q7SxF3ICTNUq71Iac5guKEhha+0uNvvuaH6BYGhoaAehluLisIpGCHKUoUpNMF
         6VFhUiLIuYKPIfSstzWOfGKShc3FLgP6UtIFlgwLwgHSnGfomdRLnoaj3VO9zjumwb8i
         8OnRW9hOj0P7igfK0Fktaspt04W47xb7TDlw1TSF1lVlnvw6PC5mG1Zm+mpJh2aIYKjx
         CMVSGZtOU40Van43oiDqSCiar99yauynPioVIzCc74touCYArrqIQViEdHIx+za7ltnl
         TBpB3X9yxuqxt3LOvEDK9DN7mx07jUC0X8X8Hd52vVLesQpgCZdMyv76MDGFfsR/wRlQ
         Ykdw==
X-Gm-Message-State: AOAM530YzW0HLHyuihCyZeCxS2biwNA0vjVD0BKU80PS+jazTJxgYU+P
        5ry7/K07xIDPtYTPnyvSOSw=
X-Google-Smtp-Source: ABdhPJzExkOe6H5raBLgYHpzAZF5ZdHMeGO0Fle/sZJSryqt3vGK8hjC1O2pz4tO/1tevNlhoZxw8w==
X-Received: by 2002:a17:906:f8c3:: with SMTP id lh3mr26531749ejb.263.1597855932552;
        Wed, 19 Aug 2020 09:52:12 -0700 (PDT)
Received: from BV030612LT ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id u6sm19416937ejf.98.2020.08.19.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:52:12 -0700 (PDT)
Date:   Wed, 19 Aug 2020 19:52:09 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v4 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Message-ID: <20200819165209.GA2137769@BV030612LT>
References: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
 <addb413d192d88c076c6ed7f453aa693095bdd15.1597571397.git.cristian.ciocaltea@gmail.com>
 <8e43fe6c6246bfd5347dc21b6f5c3f50@kernel.org>
 <20200818174241.GA2020288@BV030612LT>
 <87lfibn0ie.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfibn0ie.wl-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:48:41PM +0100, Marc Zyngier wrote:
> On Tue, 18 Aug 2020 18:42:41 +0100,
> Cristian Ciocaltea <cristian.ciocaltea@gmail.com> wrote:
> > 
> > Hi Marc,
> > 
> > Thanks for your quick and detailed review!
> > 
> > On Mon, Aug 17, 2020 at 02:52:06PM +0100, Marc Zyngier wrote:
> > > On 2020-08-16 12:33, Cristian Ciocaltea wrote:
> > > > This controller appears on Actions Semi Owl family SoC's S500, S700 and
> > > > S900 and provides support for 3 external interrupt controllers through
> > > 
> > > Is that really 3 interrupt controllers? Or merely 3 interrupt lines?
> > 
> > This is mostly a leftover statement from the previous patch revision.
> > I will change it to something like:
> > 
> > "This interrupt controller is found in the Actions Semi Owl SoCs (S500,
> > S700 and S900) and provides support for handling up to 3 external
> > interrupt lines."
> 
> Looks good.
> 
> > 
> > > > dedicated SIRQ pins.
> > > > 
> > > > Each line can be independently configured as interrupt and triggers
> > > > on either of the edges (raising or falling) or either of the levels
> > > > (high or low). Each line can also be masked independently.
> > > > 
> > > > This is based on the patch series submitted by Parthiban Nallathambi:
> > > > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> > > > 
> > > > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > [cristi: optimized DT, various fixes/cleanups/improvements]
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > ---
> > > >  drivers/irqchip/Makefile       |   1 +
> > > >  drivers/irqchip/irq-owl-sirq.c | 318 +++++++++++++++++++++++++++++++++
> > > >  2 files changed, 319 insertions(+)
> > > >  create mode 100644 drivers/irqchip/irq-owl-sirq.c
> > > > 
> > > > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > > > index 133f9c45744a..b8eb5b8b766d 100644
> > > > --- a/drivers/irqchip/Makefile
> > > > +++ b/drivers/irqchip/Makefile
> > > > @@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
> > > >  obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
> > > >  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
> > > >  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
> > > > +obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
> > > >  obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
> > > >  obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
> > > >  obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
> > > > diff --git a/drivers/irqchip/irq-owl-sirq.c
> > > > b/drivers/irqchip/irq-owl-sirq.c
> > > > new file mode 100644
> > > > index 000000000000..29b7ffc40ac7
> > > > --- /dev/null
> > > > +++ b/drivers/irqchip/irq-owl-sirq.c
> > > > @@ -0,0 +1,318 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Actions Semi Owl SoCs SIRQ interrupt controller driver
> > > > + *
> > > > + * Copyright (C) 2014 Actions Semi Inc.
> > > > + * David Liu <liuwei@actions-semi.com>
> > > > + *
> > > > + * Author: Parthiban Nallathambi <pn@denx.de>
> > > > + * Author: Saravanan Sekar <sravanhome@gmail.com>
> > > > + * Author: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/irqchip.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/of_irq.h>
> > > > +
> > > > +#define NUM_SIRQ			3
> > > > +
> > > > +#define INTC_EXTCTL_PENDING		BIT(0)
> > > > +#define INTC_EXTCTL_CLK_SEL		BIT(4)
> > > > +#define INTC_EXTCTL_EN			BIT(5)
> > > > +#define INTC_EXTCTL_TYPE_MASK		GENMASK(7, 6)
> > > > +#define INTC_EXTCTL_TYPE_HIGH		0
> > > > +#define INTC_EXTCTL_TYPE_LOW		BIT(6)
> > > > +#define INTC_EXTCTL_TYPE_RISING		BIT(7)
> > > > +#define INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
> > > > +
> > > > +/* S900 SIRQ1 & SIRQ2 control register offsets, relative to SIRQ0 */
> > > > +#define INTC_EXTCTL1			0x0328
> > > > +#define INTC_EXTCTL2			0x032c
> > > > +
> > > > +struct owl_sirq_params {
> > > > +	/* INTC_EXTCTL reg shared for all three SIRQ lines */
> > > > +	bool reg_shared;
> > > > +	/* INTC_EXTCTL reg offsets relative to controller base address */
> > > > +	u16 reg_offset[NUM_SIRQ];
> > > > +};
> > > > +
> > > > +struct owl_sirq_chip_data {
> > > > +	const struct owl_sirq_params *params;
> > > > +	void __iomem *base;
> > > > +	raw_spinlock_t lock;
> > > > +	u32 ext_irqs[NUM_SIRQ];
> > > > +	u8 trigger;
> > > 
> > > Nit: Please align data structure members vertically:
> > > 
> > > struct owl_sirq_chip_data {
> > > 	const struct owl_sirq_params *params;
> > > 	void __iomem                 *base;
> > > 	raw_spinlock_t               lock;
> > > 	u32                          ext_irqs[NUM_SIRQ];
> > > 	u8                           trigger;
> > > };
> > 
> > Done.
> > 
> > > > +};
> > > > +
> > > > +/* S500 and S700 SoCs */
> > > > +static const struct owl_sirq_params owl_sirq_s500_params = {
> > > > +	.reg_shared = true,
> > > > +	.reg_offset = { 0, 0, 0 },
> > > > +};
> > > > +
> > > > +/* S900 SoC */
> > > > +static const struct owl_sirq_params owl_sirq_s900_params = {
> > > > +	.reg_shared = false,
> > > > +	.reg_offset = { 0, INTC_EXTCTL1, INTC_EXTCTL2 },
> > > 
> > > 0 *is* an offset, right? Why doesn't it have a name too?
> > 
> > Right, I updated the defines section:
> > 
> > /* S900 SIRQ control register offsets, relative to controller base address */
> > #define INTC_EXTCTL0			0x0000
> > #define INTC_EXTCTL1			0x0328
> > [...]
> > 
> > The controller base address points to SIRQ0 control register, so this
> > offset is always 0, but I totally agree we should have a name for it.
> > 
> > > > +};
> > > > +
> > > > +static u32 owl_sirq_read_extctl(struct owl_sirq_chip_data *data, u32
> > > > index)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	val = readl_relaxed(data->base + data->params->reg_offset[index]);
> > > > +	if (data->params->reg_shared)
> > > > +		val = (val >> (2 - index) * 8) & 0xff;
> > > 
> > >         base = (2 - index) * 8;
> > >         val = FIELD_GET(GENMASK(base + 7, base), val);
> > 
> > Unfortunately the context doesn't allow using FIELD_GET:
> > 
> > ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_159’ 
> >  declared with attribute error: FIELD_GET: mask is not constant
> 
> Bah. Turning the whole thing into compile-time values would actually
> be more readable, so how about this:
> 
> diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
> index 29b7ffc40ac7..b771acbda7d5 100644
> --- a/drivers/irqchip/irq-owl-sirq.c
> +++ b/drivers/irqchip/irq-owl-sirq.c
> @@ -57,13 +57,39 @@ static const struct owl_sirq_params owl_sirq_s900_params = {
>  	.reg_offset = { 0, INTC_EXTCTL1, INTC_EXTCTL2 },
>  };
>  
> +static u32 owl_field_get(u32 val, int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return FIELD_GET(GENMASK(23, 16), val);
> +	case 1:
> +		return FIELD_GET(GENMASK(15, 8), val);
> +	case 2:
> +	default:
> +		return FIELD_GET(GENMASK(7, 0), val);
> +	}
> +}
> +
> +static u32 owl_field_prep(u32 val, int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return FIELD_PREP(GENMASK(23, 16), val);
> +	case 1:
> +		return FIELD_PREP(GENMASK(15, 8), val);
> +	case 2:
> +	default:
> +		return FIELD_PREP(GENMASK(7, 0), val);
> +	}
> +}
> +
>  static u32 owl_sirq_read_extctl(struct owl_sirq_chip_data *data, u32 index)
>  {
>  	u32 val;
>  
>  	val = readl_relaxed(data->base + data->params->reg_offset[index]);
>  	if (data->params->reg_shared)
> -		val = (val >> (2 - index) * 8) & 0xff;
> +		val = owl_field_get(val, index);
>  
>  	return val;
>  }
> @@ -75,9 +101,8 @@ static void owl_sirq_write_extctl(struct owl_sirq_chip_data *data,
>  
>  	if (data->params->reg_shared) {
>  		val = readl_relaxed(data->base + data->params->reg_offset[index]);
> -		val &= ~(0xff << (2 - index) * 8);
> -		extctl &= 0xff;
> -		extctl = (extctl << (2 - index) * 8) | val;
> +		val &= ~owl_field_prep(0xff, index);
> +		extctl = owl_field_prep(extctl, index) | val;
>  	}
>  
>  	writel_relaxed(extctl, data->base + data->params->reg_offset[index]);
> 
> Yes, this is a bit more code, but it *is* readable. Bonus points if
> you add proper defines for the masks.
 
That's great, thanks a lot!

I have submitted a new revision:
https://lore.kernel.org/lkml/cover.1597852360.git.cristian.ciocaltea@gmail.com/

Regards,
Cristi

> > 
> > > > +
> > > > +	return val;
> > > > +}
> > > > +
> > > > +static void owl_sirq_write_extctl(struct owl_sirq_chip_data *data,
> > > > +				  u32 extctl, u32 index)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	if (data->params->reg_shared) {
> > > > +		val = readl_relaxed(data->base + data->params->reg_offset[index]);
> > > > +		val &= ~(0xff << (2 - index) * 8);
> > > > +		extctl &= 0xff;
> > > > +		extctl = (extctl << (2 - index) * 8) | val;
> > > 
> > > Please make use of FIELD_PREP, FIELD_GET and GENMASK.
> > 
> > I'm not sure how to deal with the mask constness restriction, except
> > using static defines and if/else statements, which is not quite
> > elegant.
> 
> See above.
> 
> > 
> > > > +	}
> > > > +
> > > > +	writel_relaxed(extctl, data->base + data->params->reg_offset[index]);
> > > > +}
> > > > +
> > > > +static void owl_sirq_clear_set_extctl(struct owl_sirq_chip_data *d,
> > > > +				      u32 clear, u32 set, u32 index)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	u32 val;
> > > > +
> > > > +	raw_spin_lock_irqsave(&d->lock, flags);
> > > > +	val = owl_sirq_read_extctl(d, index);
> > > > +	val &= ~clear;
> > > > +	val |= set;
> > > > +	owl_sirq_write_extctl(d, val, index);
> > > > +	raw_spin_unlock_irqrestore(&d->lock, flags);
> > > > +}
> > > > +
> > > > +static void owl_sirq_eoi(struct irq_data *data)
> > > > +{
> > > > +	struct owl_sirq_chip_data *chip_data =
> > > > irq_data_get_irq_chip_data(data);
> > > > +
> > > > +	/*
> > > > +	 * Software must clear external interrupt pending, when interrupt type
> > > > +	 * is edge triggered, so we need per SIRQ based clearing.
> > > > +	 */
> > > > +	if (chip_data->trigger & (1 << data->hwirq))
> > > 
> > > BIT(d->hwirq)
> > > 
> > > But it also begs the question: we already have all the trigger information
> > > in the irqdesc. Why do you need some additional bookkeeping?
> > 
> > That's another leftover from the original work. Thanks for pointing
> > this out, I missed it. I dropped the redundant handling of the IRQ
> > trigger information and just replaced this with:
> > 
> >   if (!irqd_is_level_type(data))
> 
> Yup.
> 
> > 
> > > > +		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_PENDING,
> > > > +					  data->hwirq);
> > > > +
> > > > +	irq_chip_eoi_parent(data);
> > > > +}
> > > > +
> > > > +static void owl_sirq_mask(struct irq_data *data)
> > > > +{
> > > > +	struct owl_sirq_chip_data *chip_data =
> > > > irq_data_get_irq_chip_data(data);
> > > > +
> > > > +	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_EN, 0, data->hwirq);
> > > > +	irq_chip_mask_parent(data);
> > > > +}
> > > > +
> > > > +static void owl_sirq_unmask(struct irq_data *data)
> > > > +{
> > > > +	struct owl_sirq_chip_data *chip_data =
> > > > irq_data_get_irq_chip_data(data);
> > > > +
> > > > +	owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_EN, data->hwirq);
> > > > +	irq_chip_unmask_parent(data);
> > > > +}
> > > > +
> > > > +/*
> > > > + * GIC does not handle falling edge or active low, hence SIRQ shall be
> > > > + * programmed to convert falling edge to rising edge signal and active
> > > > + * low to active high signal.
> > > > + */
> > > > +static int owl_sirq_set_type(struct irq_data *data, unsigned int type)
> > > > +{
> > > > +	struct owl_sirq_chip_data *chip_data =
> > > > irq_data_get_irq_chip_data(data);
> > > > +	u32 sirq_type;
> > > > +
> > > > +	switch (type) {
> > > > +	case IRQ_TYPE_LEVEL_LOW:
> > > > +		sirq_type = INTC_EXTCTL_TYPE_LOW;
> > > > +		chip_data->trigger &= ~(1 << data->hwirq);
> > > > +		type = IRQ_TYPE_LEVEL_HIGH;
> > > > +		break;
> > > > +	case IRQ_TYPE_LEVEL_HIGH:
> > > > +		sirq_type = INTC_EXTCTL_TYPE_HIGH;
> > > > +		chip_data->trigger &= ~(1 << data->hwirq);
> > > > +		break;
> > > > +	case IRQ_TYPE_EDGE_FALLING:
> > > > +		sirq_type = INTC_EXTCTL_TYPE_FALLING;
> > > > +		chip_data->trigger |= 1 << data->hwirq;
> > > > +		type = IRQ_TYPE_EDGE_RISING;
> > > > +		break;
> > > > +	case IRQ_TYPE_EDGE_RISING:
> > > > +		sirq_type = INTC_EXTCTL_TYPE_RISING;
> > > > +		chip_data->trigger |= 1 << data->hwirq;
> > > > +		break;
> > > > +	default:
> > > > +		WARN_ON(1);
> > > 
> > > No need for this WARN_ON(), the core kernel is loud enough.
> > 
> > Done.
> > 
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_TYPE_MASK, sirq_type,
> > > > +				  data->hwirq);
> > > > +
> > > > +	return irq_chip_set_type_parent(data, type);
> > > > +}
> > > > +
> > > > +static struct irq_chip owl_sirq_chip = {
> > > > +	.name		= "owl-sirq",
> > > > +	.irq_mask	= owl_sirq_mask,
> > > > +	.irq_unmask	= owl_sirq_unmask,
> > > > +	.irq_eoi	= owl_sirq_eoi,
> > > > +	.irq_set_type	= owl_sirq_set_type,
> > > > +	.irq_retrigger	= irq_chip_retrigger_hierarchy,
> > > 
> > > How about irq_set_affinity? Or does it only exist on UP systems?
> > 
> > I have just added:
> > 
> > #ifdef CONFIG_SMP
> > 	.irq_set_affinity = irq_chip_set_affinity_parent,
> > #endif
> 
> Looks OK.
> 
> Cheers,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
