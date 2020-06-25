Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32758C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E7620709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407377AbgFYVnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:43:39 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39255 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407340AbgFYVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:43:28 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0C70A20005;
        Thu, 25 Jun 2020 21:43:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 6/9] clocksource/drivers/timer-atmel-tcb: fill tcb_config
Date:   Thu, 25 Jun 2020 23:43:09 +0200
Message-Id: <20200625214312.1382063-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625214312.1382063-1-alexandre.belloni@bootlin.com>
References: <20200625214312.1382063-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tcb_config and struct atmel_tcb_config to get the timer counter
width. This is necessary because atmel_tcb_config will be extended later
on.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-tcb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index b255a4a1a36b..423af2f9835f 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -348,9 +348,17 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 
 static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
 
+static struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
+
+static struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
+
 static const struct of_device_id atmel_tcb_of_match[] = {
-	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
-	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
+	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
 	{ /* sentinel */ }
 };
 
@@ -398,7 +406,11 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	}
 
 	match = of_match_node(atmel_tcb_of_match, node->parent);
-	bits = (uintptr_t)match->data;
+	if (!match)
+		return -ENODEV;
+
+	tc.tcb_config = match->data;
+	bits = tc.tcb_config->counter_width;
 
 	for (i = 0; i < ARRAY_SIZE(tc.irq); i++)
 		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
-- 
2.26.2

