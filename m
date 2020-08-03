Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40DCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F31D2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596469924;
	bh=T7K90irjubNIFSVeq85wbcwpNGOjt5yZjmQ4qDPlPPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JC8bj3q01tndQbsAT90sO8etIs1FDdUwFPyYGSfpX7vRwvPkyW6Lk3nhIitGaV/U8
	 P934dFOmFPzdfreS0CbzCbIDr/2pk/65YdqF+E24noJR7pDvFYc2JGjjHSPwkRxFXM
	 GZXipOesKui47z+xUg91gyESeVpyX7RtPDUbe0XU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHCPwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgHCPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:52:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FC82072A;
        Mon,  3 Aug 2020 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596469922;
        bh=T7K90irjubNIFSVeq85wbcwpNGOjt5yZjmQ4qDPlPPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GLBfpVc5Ixviz5v0DVPOVmz1tmitRI10Gp8/FidMeHlrayRDhtgVC7M/4ZRnlau1q
         SSrM+ks+Cx1yJl1dJyu7bbxVJbTB/pZE4AQweAh3x0yVYKWqGsg6kKsB3d+P8K/iJb
         NnFRHgjqe+VJC0LcpHWWsJHEQ0+oJgK4jAERly5c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k2ckr-00H9C1-Cr; Mon, 03 Aug 2020 16:52:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 16:52:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     alix.wu@mediatek.com, devicetree@vger.kernel.org,
        jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de,
        yj.chiang@mediatek.com
Subject: Re: [PATCH 1/2] irqchip: irq-mt58xx: Add mt58xx interrupt controller
 support
In-Reply-To: <43f5cba1199f89cde68c8a577103f28b@kernel.org> (raw)
References: <43f5cba1199f89cde68c8a577103f28b@kernel.org>
 <43f5cba1199f89cde68c8a577103f28b@kernel.org> (raw)
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <18809de59c26b1817320992c7f7bb0f4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, alix.wu@mediatek.com, devicetree@vger.kernel.org, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-03 16:03, Mark-PK Tsai wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
>> On 2020-08-03 07:22, Mark-PK Tsai wrote:
>> > Add mt58xx interrupt controller support using hierarchy irq
>> > domain.
>> >
>> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
>> > ---
>> >  drivers/irqchip/Kconfig      |   7 ++
>> >  drivers/irqchip/Makefile     |   1 +
>> >  drivers/irqchip/irq-mt58xx.c | 196 +++++++++++++++++++++++++++++++++++
>> >  3 files changed, 204 insertions(+)
>> >  create mode 100644 drivers/irqchip/irq-mt58xx.c
>> >
>> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> > index 216b3b8392b5..00453af78be0 100644
>> > --- a/drivers/irqchip/Kconfig
>> > +++ b/drivers/irqchip/Kconfig
>> > @@ -572,4 +572,11 @@ config LOONGSON_PCH_MSI
>> >  	help
>> >  	  Support for the Loongson PCH MSI Controller.
>> >
>> > +config MT58XX_IRQ
>> > +	bool "MT58XX IRQ"
>> > +	select IRQ_DOMAIN
>> > +	select IRQ_DOMAIN_HIERARCHY
>> > +	help
>> > +	  Support Mediatek MT58XX Interrupt Controller.
>> > +
>> >  endmenu
>> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> > index 133f9c45744a..5062e9bfa92d 100644
>> > --- a/drivers/irqchip/Makefile
>> > +++ b/drivers/irqchip/Makefile
>> > @@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+=
>> > irq-loongson-htpic.o
>> >  obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>> >  obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
>> >  obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
>> > +obj-$(CONFIG_MT58XX_IRQ)		+= irq-mt58xx.o
>> > diff --git a/drivers/irqchip/irq-mt58xx.c
>> > b/drivers/irqchip/irq-mt58xx.c
>> > new file mode 100644
>> > index 000000000000..e45ad023afa6
>> > --- /dev/null
>> > +++ b/drivers/irqchip/irq-mt58xx.c
>> > @@ -0,0 +1,196 @@
>> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>> > +/*
>> > + * Copyright (c) 2020 MediaTek Inc.
>> > + * Author Mark-PK Tsai <mark-pk.tsai@mediatek.com>
>> > + */
>> > +
>> > +#include <linux/interrupt.h>
>> > +#include <linux/io.h>
>> > +#include <linux/irq.h>
>> > +#include <linux/irqchip.h>
>> > +#include <linux/irqdomain.h>
>> > +#include <linux/of.h>
>> > +#include <linux/of_address.h>
>> > +#include <linux/of_irq.h>
>> > +#include <linux/slab.h>
>> > +
>> > +#define INTC_MASK	0x0
>> > +#define INTC_EOI	0x20
>> > +
>> > +struct mtk_intc_chip_data {
>> > +	char *name;
>> > +	struct irq_chip chip;
>> 
>> There is no need to embed a full struct irqchip per controller, see
>> below.
> 
> We want to distinguish which controller the device interrupts are 
> belong to
> by "cat /proc/interrupts".
> And if all the controller share the same struct, the name field will be 
> the
> same.
> Do you have suggestion for this?

Yes. /proc/interrupts is not a debug tool, and doesn't need to
show the interrupt routing. We have a debugfs option for this
purpose, and that is what you should use. If it is missing
any information, just say so and I will see what we can do.

[...]

>> > +static struct irq_chip mtk_intc_chip = {
>> > +	.irq_mask		= mtk_intc_mask_irq,
>> > +	.irq_unmask		= mtk_intc_unmask_irq,
>> > +	.irq_eoi		= mtk_intc_eoi_irq,
>> > +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
>> > +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
>> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> > +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
>> 
>> How about retrigger?
>> 
> 
> What is retrigger means?

It allows the HW to regenerate an interrupt. Set irq_retrigger
to irq_chip_retrigger_hierarchy, and you'll be fine. It is
going to be implemented shortly in the GIC driver.

> To be honest, I just try to direct all the irqchip ops implemented in
> /drivers/irqchip/irq-gic.c to gic driver.
> But "irq_set_vcpu_affinity" is not used in our projects now.

I assume you are not contributing this code just for your
own project...

> Should I remove ".irq_set_vcpu_affinity" here?

No, just leave it. Who knows, just in case virtualization becomes
a thing...

         M.
-- 
Jazz is not dead. It just smells funny...
