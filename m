Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,
	SUBJ_OBFU_PUNCT_FEW autolearn=no autolearn_force=no version=3.4.0
Received: from lists.gateworks.com ([108.161.130.12]:39778 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbgCKPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:43:58 -0400
From: Tim Harvey <tharvey@gateworks.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Robert Richter <rrichter@marvell.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] gpio: thunderx: fix irq_request_resources
Date: Wed, 11 Mar 2020 08:43:53 -0700
Message-Id: <1583941433-15876-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If there are no parent resources do not call irq_chip_request_resources_parent
at all as this will return an error.

This resolves a regression where devices using a thunderx gpio as an interrupt
would fail probing.

Fixes: 0d04d0c ("gpio: thunderx: Use the default parent apis for {request,release}_resources")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/gpio/gpio-thunderx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 4627704..f84b9b1 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -366,15 +366,18 @@ static int thunderx_gpio_irq_request_resources(struct irq_data *data)
 {
 	struct thunderx_line *txline = irq_data_get_irq_chip_data(data);
 	struct thunderx_gpio *txgpio = txline->txgpio;
+	struct irq_data *parent_data = data->parent_data;
 	int r;
 
 	r = gpiochip_lock_as_irq(&txgpio->chip, txline->line);
 	if (r)
 		return r;
 
-	r = irq_chip_request_resources_parent(data);
-	if (r)
-		gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
+	if (parent_data && parent_data->chip->irq_request_resources) {
+		r = irq_chip_request_resources_parent(data);
+		if (r)
+			gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
+	}
 
 	return r;
 }
-- 
2.7.4

