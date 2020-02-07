Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFAC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33493222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGPrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:47:20 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:41793 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBGPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:47:20 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 6682E100B01B2;
        Fri,  7 Feb 2020 16:47:17 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 097A8615E104;
        Fri,  7 Feb 2020 16:47:17 +0100 (CET)
X-Mailbox-Line: From 988737dbbc4e499c2faaaa4e567ba3ed8deb9a89 Mon Sep 17 00:00:00 2001
Message-Id: <988737dbbc4e499c2faaaa4e567ba3ed8deb9a89.1581089797.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 7 Feb 2020 16:46:41 +0100
Subject: [PATCH] irqchip/bcm2835: Quiesce IRQs left enabled by bootloader
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Customers of our "Revolution Pi" open source PLCs (which are based on
the Raspberry Pi) have reported random lockups as well as jittery eMMC,
UART and SPI latency.  We were able to reproduce the lockups in our lab
and hooked up a JTAG debugger:

It turns out that the USB controller's interrupt is already enabled when
the kernel boots.  All interrupts are disabled when the chip comes out
of power-on reset, according to the spec.  So apparently the bootloader
enables the interrupt but neglects to disable it before handing over
control to the kernel.

The bootloader is a closed source blob provided by the Raspberry Pi
Foundation.  Development of an alternative open source bootloader was
begun by Kristina Brooks but it's not fully functional yet.  Usage of
the blob is thus without alternative for the time being.

The Raspberry Pi Foundation's downstream kernel has a performance-
optimized USB driver (which we use on our Revolution Pi products).
The driver takes advantage of the FIQ fast interrupt.  Because the
regular USB interrupt was left enabled by the bootloader, both the
FIQ and the normal interrupt is enabled once the USB driver probes.

The spec has the following to say on simultaneously enabling the FIQ
and the normal interrupt of a peripheral:

"One interrupt source can be selected to be connected to the ARM FIQ
 input.  An interrupt which is selected as FIQ should have its normal
 interrupt enable bit cleared.  Otherwise a normal and an FIQ interrupt
 will be fired at the same time.  Not a good idea!"
                                  ^^^^^^^^^^^^^^^
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
page 110

On a multicore Raspberry Pi, the Foundation's kernel routes all normal
interrupts to CPU 0 and the FIQ to CPU 1.  Because both the FIQ and the
normal interrupt is enabled, a USB interrupt causes CPU 0 to spin in
bcm2836_chained_handle_irq() until the FIQ on CPU 1 has cleared it.
Interrupts with a lower priority than USB are starved as long.

That explains the jittery eMMC, UART and SPI latency:  On one occasion
I've seen CPU 0 blocked for no less than 2.9 msec.  Basically,
everything not USB takes a performance hit:  Whereas eMMC throughput
on a Compute Module 3 remains relatively constant at 23.5 MB/s with
this commit, it irregularly dips to 23.0 MB/s without this commit.

The lockups occur when CPU 0 receives a USB interrupt while holding a
lock which CPU 1 is trying to acquire while the FIQ is temporarily
disabled on CPU 1.

I've tested old releases of the Foundation's bootloader as far back as
1.20160202-1 and they all leave the USB interrupt enabled.  Still older
releases fail to boot a contemporary kernel on a Compute Module 1 or 3,
which are the only Raspberry Pi variants I have at my disposal for
testing.

Fix by disabling IRQs left enabled by the bootloader.  Although the
impact is most pronounced on the Foundation's downstream kernel,
it seems prudent to apply the fix to the upstream kernel to guard
against such mistakes in any present and future bootloader.

An alternative, though more convoluted approach would be to clear the
IRQD_IRQ_MASKED flag on all interrupts left enabled on boot.  Then the
first invocation of handle_level_irq() would mask and thereby quiesce
those interrupts.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Serge Schneider <serge@raspberrypi.org>
Cc: Kristina Brooks <notstina@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-bcm2835.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 418245d31921..0d9a5a7ebe2c 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -150,6 +150,13 @@ static int __init armctrl_of_init(struct device_node *node,
 		intc.enable[b] = base + reg_enable[b];
 		intc.disable[b] = base + reg_disable[b];
 
+		irq = readl(intc.enable[b]);
+		if (irq) {
+			writel(irq, intc.disable[b]);
+			pr_err(FW_BUG "Bootloader left irq enabled: "
+			       "bank %d irq %*pbl\n", b, IRQS_PER_BANK, &irq);
+		}
+
 		for (i = 0; i < bank_irqs[b]; i++) {
 			irq = irq_create_mapping(intc.domain, MAKE_HWIRQ(b, i));
 			BUG_ON(irq <= 0);
-- 
2.24.0

