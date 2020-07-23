Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770DFC433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E3C20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YqPlk3KX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KL2Bg4tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGWTKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:10:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgGWTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:46 -0400
Date:   Thu, 23 Jul 2020 19:09:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty/3qycxAkk21iKIw1gGS2adNh0M4jh9Aw06Dx04iOE=;
        b=YqPlk3KXfyt4e1shwpebWqL7NyGrUP1Zr7VkC1vdYfTeGeZtrwUmYnU8+Comhwcjr0+zxp
        SaoXIuqTdEq+uGRjT0iTjmjj7l8ghhMvHlAV+a431wULSFm2OGSGxBJsnwbWEMuMZMLwrx
        S0EWCpSQLUPc6Ox0A+QJWfocOXzrm8J15sRfgrFuADGPMqRu3jLF2VE7ra5WrUNgn0wYLy
        3qtkupbm+RvLc3ooRZk2Myu80OPtvfBwXGQzb4QbWU7vVCRD32zR++GEMBoU3oxQ15sUOd
        EvczN3KqwE2/PinLOACAgtf2pWizy9dafe6xSfS6WcEEBF5bSV3yn11JCYNM1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty/3qycxAkk21iKIw1gGS2adNh0M4jh9Aw06Dx04iOE=;
        b=KL2Bg4tgm00Y6jYznythnxkxKFdFV866yOG37YWg0ZroaU7qTkRYT++QJiGYOfj2O9CKDS
        yQgi+vArS/zp9MCw==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-atmel-tcb: Fill tcb_config
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-7-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-7-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138386.4006.12033281869452578323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d2c60dcf86fabb542b96b4444ca81be0b1b30099
Gitweb:        https://git.kernel.org/tip/d2c60dcf86fabb542b96b4444ca81be0b1b30099
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:10 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:58:04 +02:00

clocksource/drivers/timer-atmel-tcb: Fill tcb_config

Use the tcb_config and struct atmel_tcb_config to get the timer counter
width. This is necessary because atmel_tcb_config will be extended later
on.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-7-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index b255a4a..423af2f 100644
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
