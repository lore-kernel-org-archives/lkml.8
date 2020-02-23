Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F8C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E22E20880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBWSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:24:48 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46917 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:24:48 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DAA4930000E5D;
        Sun, 23 Feb 2020 19:24:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AFAAA27E893; Sun, 23 Feb 2020 19:24:45 +0100 (CET)
Date:   Sun, 23 Feb 2020 19:24:45 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH v2] irqchip/bcm2835: Quiesce IRQs left enabled by
 bootloader
Message-ID: <20200223182445.n44wgrourk4cpfoq@wunner.de>
References: <20200212123651.apio6kno2cqhcskb@wunner.de>
 <61cc6b74-3dd2-38d0-6da0-eb3fbd87c598@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61cc6b74-3dd2-38d0-6da0-eb3fbd87c598@i2se.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 06:59:56PM +0100, Stefan Wahren wrote:
> thanks for all the investigation. Unfortunately the patch below doesn't
> compile, since it lacks the definiton of REG_FIQ_ENABLE.

Ugh, I recall fixing that when compile-testing.  I must have forgotten
to invoke "git commit --amend" before "git format-patch".

> Btw the name is a little bit unlucky because it defines a single flag
> within REG_FIQ_CONTROL instead of a separate register.

The Foundation's repo uses that name so I stuck by it to reduce the
number of merge conflicts Phil will have to resolve.  Happy to change
though, suggestions welcome.

Thanks!

Lukas

> >
> > -- >8 --
> > From: Lukas Wunner <lukas@wunner.de>
> > Subject: [PATCH] irqchip/bcm2835: Quiesce IRQs left enabled by bootloader
> >
> > Per the spec, the BCM2835's IRQs are all disabled when coming out of
> > power-on reset.  Its IRQ driver assumes that's still the case when the
> > kernel boots and does not perform any initialization of the registers.
> > However the Raspberry Pi Foundation's bootloader leaves the USB
> > interrupt enabled when handing over control to the kernel.
> >
> > Quiesce IRQs and the FIQ if they were left enabled and log a message to
> > let users know that they should update the bootloader once a fixed
> > version is released.
> >
> > If the USB interrupt is not quiesced and the USB driver later on claims
> > the FIQ (as it does on the Raspberry Pi Foundation's downstream kernel),
> > interrupt latency for all other peripherals increases and occasional
> > lockups occur.  That's because both the FIQ and the normal USB interrupt
> > fire simultaneously.
> >
> > On a multicore Raspberry Pi, if normal interrupts are routed to CPU 0
> > and the FIQ to CPU 1 (hardcoded in the Foundation's kernel), then a USB
> > interrupt causes CPU 0 to spin in bcm2836_chained_handle_irq() until the
> > FIQ on CPU 1 has cleared it.  Other peripherals' interrupts are starved
> > as long.  I've seen CPU 0 blocked for up to 2.9 msec.  eMMC throughput
> > on a Compute Module 3 irregularly dips to 23.0 MB/s without this commit
> > but remains relatively constant at 23.5 MB/s with this commit.
> >
> > The lockups occur when CPU 0 receives a USB interrupt while holding a
> > lock which CPU 1 is trying to acquire while the FIQ is temporarily
> > disabled on CPU 1.  At best users get RCU CPU stall warnings, but most
> > of the time the system just freezes.
> >
> > Fixes: 89214f009c1d ("ARM: bcm2835: add interrupt controller driver")
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: stable@vger.kernel.org # v3.7+
> > Cc: Serge Schneider <serge@raspberrypi.org>
> > Cc: Kristina Brooks <notstina@gmail.com>
> > ---
> >  drivers/irqchip/irq-bcm2835.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> > index 418245d..eca9ac7 100644
> > --- a/drivers/irqchip/irq-bcm2835.c
> > +++ b/drivers/irqchip/irq-bcm2835.c
> > @@ -135,6 +135,7 @@ static int __init armctrl_of_init(struct device_node *node,
> >  {
> >  	void __iomem *base;
> >  	int irq, b, i;
> > +	u32 reg;
> >  
> >  	base = of_iomap(node, 0);
> >  	if (!base)
> > @@ -157,6 +158,19 @@ static int __init armctrl_of_init(struct device_node *node,
> >  				handle_level_irq);
> >  			irq_set_probe(irq);
> >  		}
> > +
> > +		reg = readl_relaxed(intc.enable[b]);
> > +		if (reg) {
> > +			writel_relaxed(reg, intc.disable[b]);
> > +			pr_err(FW_BUG "Bootloader left irq enabled: "
> > +			       "bank %d irq %*pbl\n", b, IRQS_PER_BANK, &reg);
> > +		}
> > +	}
> > +
> > +	reg = readl_relaxed(base + REG_FIQ_CONTROL);
> > +	if (reg & REG_FIQ_ENABLE) {
> > +		writel_relaxed(0, base + REG_FIQ_CONTROL);
> > +		pr_err(FW_BUG "Bootloader left fiq enabled\n");
> >  	}
> >  
> >  	if (is_2836) {
