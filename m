Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB21CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A83206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oldN3uSz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mMVGCP0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgGWTJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgGWTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:46 -0400
Date:   Thu, 23 Jul 2020 19:09:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Mwt9NZqiGCWc/y/PwDNXa+V9bdnR9Bcgv963eoI4WQ=;
        b=oldN3uSz3oj86BmkOiqqgH+4+fPiI1S9w3U6lpfNrAPEmMRdNkbQa6t3ANY5a6Nd51yRoc
        KIcPKN5MEtDZNh5vBVd6SWdlomCCL6SEE06hezcob3pIfON134Hw7iU4067Q4WngtdjzV2
        AXX05vpPhQ3XzUN4QJMUDdW2nvJbqIlUTsxerr0Owb7GuJP/wsHYikzALobdAYNdZ2FyUh
        B2TjuN3HI4iCSlVq6wNYx2hRlVXbgZ/lTHlGQiksV2mKLTnQWbcQZ1TYKVJ/WF30UaVwkm
        iLg0ZfLtvz1/tiBqga6Od833CR2cec0LzIl2/cz2giWZO0m0Sxm2U22fijzpWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Mwt9NZqiGCWc/y/PwDNXa+V9bdnR9Bcgv963eoI4WQ=;
        b=mMVGCP0qIpIlSZ66jkfUoHKJ+wQ+eKQ3S0cZgeg7/xiYfR+H9fDxOszIwIVPYrWwkWSBX7
        GrDXyuLuka+wZ/Dg==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-atmel-tcb: Rework 32khz
 clock selection
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-6-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138460.4006.12847358392559063922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     228e21848623e0ce54a1a3d7857b444813e49b2e
Gitweb:        https://git.kernel.org/tip/228e21848623e0ce54a1a3d7857b444813e49b2e
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:09 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:57:58 +02:00

clocksource/drivers/timer-atmel-tcb: Rework 32khz clock selection

On all the supported SoCs, the slow clock is always ATMEL_TC_TIMER_CLOCK5,
avoid looking it up and pass it directly to setup_clkevents.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-6-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7427b07..b255a4a 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -346,7 +346,7 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
 
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
@@ -362,7 +362,6 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
-	int clk32k_divisor_idx = -1;
 	int bits;
 	int i;
 	int ret;
@@ -416,12 +415,6 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
-		/* remember 32 KiHz clock for later */
-		if (!divisor) {
-			clk32k_divisor_idx = i;
-			continue;
-		}
-
 		tmp = rate / divisor;
 		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
 		if (best_divisor_idx > 0) {
@@ -467,7 +460,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
-	ret = setup_clkevents(&tc, clk32k_divisor_idx);
+	ret = setup_clkevents(&tc, ATMEL_TC_TIMER_CLOCK5);
 	if (ret)
 		goto err_unregister_clksrc;
 
