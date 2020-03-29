Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B853C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4820F20784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgC2U0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgC2U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVv-0001Xo-9V; Sun, 29 Mar 2020 22:26:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 83AF11C04DD;
        Sun, 29 Mar 2020 22:26:25 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:25 -0000
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: vic: Support cascaded VIC in device tree
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219153543.137153-1-linus.walleij@linaro.org>
References: <20200219153543.137153-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <158551358513.28353.16110733638970294999.tip-bot2@tip-bot2>
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

Commit-ID:     a15111075a847432b90e1534095b195aac8d9ec2
Gitweb:        https://git.kernel.org/tip/a15111075a847432b90e1534095b195aac8d9ec2
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Wed, 19 Feb 2020 16:35:43 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 08 Mar 2020 14:25:45 

irqchip: vic: Support cascaded VIC in device tree

When transitioning some elder platforms to device tree it
becomes necessary to cascade VIC IRQ chips off another
interrupt controller.

Tested with the cascaded VIC on the Integrator/AP attached
logic module IM-PD1.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200219153543.137153-1-linus.walleij@linaro.org
---
 drivers/irqchip/irq-vic.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index f3f20a3..3c87d92 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -509,9 +509,7 @@ static int __init vic_of_init(struct device_node *node,
 	void __iomem *regs;
 	u32 interrupt_mask = ~0;
 	u32 wakeup_mask = ~0;
-
-	if (WARN(parent, "non-root VICs are not supported"))
-		return -EINVAL;
+	int parent_irq;
 
 	regs = of_iomap(node, 0);
 	if (WARN_ON(!regs))
@@ -519,11 +517,14 @@ static int __init vic_of_init(struct device_node *node,
 
 	of_property_read_u32(node, "valid-mask", &interrupt_mask);
 	of_property_read_u32(node, "valid-wakeup-mask", &wakeup_mask);
+	parent_irq = of_irq_get(node, 0);
+	if (parent_irq < 0)
+		parent_irq = 0;
 
 	/*
 	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, 0, 0, interrupt_mask, wakeup_mask, node);
+	__vic_init(regs, parent_irq, 0, interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
