Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C111C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65879206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895934AbgDOJun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:50:43 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37533 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895841AbgDOJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:48:59 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1B46C20008;
        Wed, 15 Apr 2020 09:48:57 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 9/9] clocksource/drivers/timer-atmel-tcb: add sama5d2 support
Date:   Wed, 15 Apr 2020 11:48:26 +0200
Message-Id: <20200415094826.132562-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200415094826.132562-1-alexandre.belloni@bootlin.com>
References: <20200415094826.132562-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first divisor for the sama5d2 is actually the gclk selector. Because
the currently remaining divisors are fitting the use case, currently ensure
it is skipped.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-tcb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index ccb77b9cb489..e373b02d509a 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -359,9 +359,15 @@ static struct atmel_tcb_config tcb_sam9x5_config = {
 	.counter_width = 32,
 };
 
+static struct atmel_tcb_config tcb_sama5d2_config = {
+	.counter_width = 32,
+	.has_gclk = 1,
+};
+
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
 	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
+	{ .compatible = "atmel,sama5d2-tcb", .data = &tcb_sama5d2_config, },
 	{ /* sentinel */ }
 };
 
@@ -426,7 +432,10 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+	i = 0;
+	if (tc.tcb_config->has_gclk)
+		i = 1;
+	for (; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
 		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
-- 
2.25.2

