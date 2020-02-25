Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E97C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAD920714
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgBYJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:50:44 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:37295 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgBYJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:50:44 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 1E07D1008D00B;
        Tue, 25 Feb 2020 10:50:42 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id CC23461146E6;
        Tue, 25 Feb 2020 10:50:41 +0100 (CET)
X-Mailbox-Line: From f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea Mon Sep 17 00:00:00 2001
Message-Id: <f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de>
In-Reply-To: <1a5735e8-b876-92e4-9f1e-687f5abf8708@i2se.com>
References: <1a5735e8-b876-92e4-9f1e-687f5abf8708@i2se.com>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 25 Feb 2020 10:50:41 +0100
Subject: [PATCH v4] irqchip/bcm2835: Quiesce IRQs left enabled by bootloader
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
fire simultaneously:

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
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: stable@vger.kernel.org # v3.7+
Cc: Serge Schneider <serge@raspberrypi.org>
Cc: Kristina Brooks <notstina@gmail.com>
Cc: Stefan Wahren <wahrenst@gmx.net>
---
v4:
* Add missing REG_FIQ_ENABLE macro, rename to FIQ_CONTROL_ENABLE (Stefan)

v3: (submitted as inline patch)
* Shorten commit message (Florian, Marc)

v2:
* Use "relaxed" MMIO accessors to avoid memory barriers (Marc)
* Use u32 instead of int for register access (Marc)
* Quiesce FIQ as well (Marc)
* Quiesce IRQs after mapping them for better readability
* Drop alternative approach from commit message (Marc)

 drivers/irqchip/irq-bcm2835.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 418245d31921..a1e004af23e7 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -61,6 +61,7 @@
 					| SHORTCUT1_MASK | SHORTCUT2_MASK)
 
 #define REG_FIQ_CONTROL		0x0c
+#define FIQ_CONTROL_ENABLE	BIT(7)
 
 #define NR_BANKS		3
 #define IRQS_PER_BANK		32
@@ -135,6 +136,7 @@ static int __init armctrl_of_init(struct device_node *node,
 {
 	void __iomem *base;
 	int irq, b, i;
+	u32 reg;
 
 	base = of_iomap(node, 0);
 	if (!base)
@@ -157,6 +159,19 @@ static int __init armctrl_of_init(struct device_node *node,
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
+	if (reg & FIQ_CONTROL_ENABLE) {
+		writel_relaxed(0, base + REG_FIQ_CONTROL);
+		pr_err(FW_BUG "Bootloader left fiq enabled\n");
 	}
 
 	if (is_2836) {
-- 
2.24.0

