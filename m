Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC63C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B53520781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgC2U1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57040 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgC2U0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVm-0001UQ-PE; Sun, 29 Mar 2020 22:26:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0C6191C07F3;
        Sun, 29 Mar 2020 22:26:21 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:20 -0000
From:   "tip-bot2 for Lukas Wunner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/bcm2835: Quiesce IRQs left enabled by bootloader
Cc:     Lukas Wunner <lukas@wunner.de>, Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de>
References: <f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de>
MIME-Version: 1.0
Message-ID: <158551358063.28353.14980225519315478462.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bd59b343a9c902c522f006e6d71080f4893bbf42
Gitweb:        https://git.kernel.org/tip/bd59b343a9c902c522f006e6d71080f4893bbf42
Author:        Lukas Wunner <lukas@wunner.de>
AuthorDate:    Tue, 25 Feb 2020 10:50:41 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:54 

irqchip/bcm2835: Quiesce IRQs left enabled by bootloader

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de
---
 drivers/irqchip/irq-bcm2835.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 418245d..a1e004a 100644
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
