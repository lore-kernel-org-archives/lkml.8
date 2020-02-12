Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3146CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC0820714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:36:54 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:32887 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:36:54 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8C351100B0156;
        Wed, 12 Feb 2020 13:36:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2E768228065; Wed, 12 Feb 2020 13:36:51 +0100 (CET)
Date:   Wed, 12 Feb 2020 13:36:51 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH v2] irqchip/bcm2835: Quiesce IRQs left enabled by
 bootloader
Message-ID: <20200212123651.apio6kno2cqhcskb@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9ce391-e217-1207-d3b7-0a69b7ab3837@gmail.com>
 <d49218987c0d1d573aaa3bcccf44ffe3@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:47:05PM -0800, Florian Fainelli wrote:
> The commit message is a bit long and starts
> going into details that I am not sure add anything

I adhere to the school of thought which holds that commit messages
shall provide complete context, including numbers to back up claims,
user-visible impact, affected versions, genesis of the fix and so on.
By that logic there's no such a thing as a too long commit message.

Nevertheless please find a shortened version below, complete with
the Fixes tag you requested as well as your R-b.


On Wed, Feb 12, 2020 at 08:13:29AM +0000, Marc Zyngier wrote:
> It otherwise looks good. You can either resend it with a fixed commit
> message,
> or provide me with a commit message that I can stick there while applying
> it.

The below also contains the patch itself, so can be applied directly
with git am --scissors.  Feel free to tweak as you see fit.
Shout if I've missed anything.  Thanks.

-- >8 --
From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] irqchip/bcm2835: Quiesce IRQs left enabled by bootloader

Per the spec, the BCM2835's IRQs are all disabled when coming out of
power-on reset.  Its IRQ driver assumes that's still the case when the
kernel boots and does not perform any initialization of the registers.
However the Raspberry Pi Foundation's bootloader leaves the USB
interrupt enabled when handing over control to the kernel.

Quiesce IRQs and the FIQ if they were left enabled and log a message to
let users know that they should update the bootloader once a fixed
version is released.

If the USB interrupt is not quiesced and the USB driver later on claims
the FIQ (as it does on the Raspberry Pi Foundation's downstream kernel),
interrupt latency for all other peripherals increases and occasional
lockups occur.  That's because both the FIQ and the normal USB interrupt
fire simultaneously.

On a multicore Raspberry Pi, if normal interrupts are routed to CPU 0
and the FIQ to CPU 1 (hardcoded in the Foundation's kernel), then a USB
interrupt causes CPU 0 to spin in bcm2836_chained_handle_irq() until the
FIQ on CPU 1 has cleared it.  Other peripherals' interrupts are starved
as long.  I've seen CPU 0 blocked for up to 2.9 msec.  eMMC throughput
on a Compute Module 3 irregularly dips to 23.0 MB/s without this commit
but remains relatively constant at 23.5 MB/s with this commit.

The lockups occur when CPU 0 receives a USB interrupt while holding a
lock which CPU 1 is trying to acquire while the FIQ is temporarily
disabled on CPU 1.  At best users get RCU CPU stall warnings, but most
of the time the system just freezes.

Fixes: 89214f009c1d ("ARM: bcm2835: add interrupt controller driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org # v3.7+
Cc: Serge Schneider <serge@raspberrypi.org>
Cc: Kristina Brooks <notstina@gmail.com>
---
 drivers/irqchip/irq-bcm2835.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 418245d..eca9ac7 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -135,6 +135,7 @@ static int __init armctrl_of_init(struct device_node *node,
 {
 	void __iomem *base;
 	int irq, b, i;
+	u32 reg;
 
 	base = of_iomap(node, 0);
 	if (!base)
@@ -157,6 +158,19 @@ static int __init armctrl_of_init(struct device_node *node,
 				handle_level_irq);
 			irq_set_probe(irq);
 		}
+
+		reg = readl_relaxed(intc.enable[b]);
+		if (reg) {
+			writel_relaxed(reg, intc.disable[b]);
+			pr_err(FW_BUG "Bootloader left irq enabled: "
+			       "bank %d irq %*pbl\n", b, IRQS_PER_BANK, &reg);
+		}
+	}
+
+	reg = readl_relaxed(base + REG_FIQ_CONTROL);
+	if (reg & REG_FIQ_ENABLE) {
+		writel_relaxed(0, base + REG_FIQ_CONTROL);
+		pr_err(FW_BUG "Bootloader left fiq enabled\n");
 	}
 
 	if (is_2836) {
-- 
2.24.0

