Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46B8C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIJZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:25:48 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:50454 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:25:48 -0400
Received: from localhost.localdomain ([93.22.150.119])
        by mwinf5d85 with ME
        id QZRk2200H2aoYT903ZRllb; Thu, 09 Apr 2020 11:25:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 09 Apr 2020 11:25:46 +0200
X-ME-IP: 93.22.150.119
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clocksource: davinci: avoid trailing '\n' hidden in pr_fmt()
Date:   Thu,  9 Apr 2020 11:25:43 +0200
Message-Id: <20200409092543.14727-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_xxx() functions usually have '\n' at the end of the logging message.
Here, this '\n' is added via the 'pr_fmt' macro.

In order to be more consistent with other files, use a more standard
convention and put these '\n' back in the messages themselves and remove it
from the pr_fmt macro.

While at it, remove a useless message in case of 'kzalloc' failure,
especially with a __GFP_NOFAIL flag.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure that the __GFP_NOFAIL is relevant here.
---
 drivers/clocksource/timer-davinci.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index e421946a91c5..aae938368230 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -18,7 +18,7 @@
 #include <clocksource/timer-davinci.h>
 
 #undef pr_fmt
-#define pr_fmt(fmt) "%s: " fmt "\n", __func__
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #define DAVINCI_TIMER_REG_TIM12			0x10
 #define DAVINCI_TIMER_REG_TIM34			0x14
@@ -250,20 +250,20 @@ int __init davinci_timer_register(struct clk *clk,
 
 	rv = clk_prepare_enable(clk);
 	if (rv) {
-		pr_err("Unable to prepare and enable the timer clock");
+		pr_err("Unable to prepare and enable the timer clock\n");
 		return rv;
 	}
 
 	if (!request_mem_region(timer_cfg->reg.start,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
-		pr_err("Unable to request memory region");
+		pr_err("Unable to request memory region\n");
 		return -EBUSY;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
-		pr_err("Unable to map the register range");
+		pr_err("Unable to map the register range\n");
 		return -ENOMEM;
 	}
 
@@ -271,10 +271,8 @@ int __init davinci_timer_register(struct clk *clk,
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL | __GFP_NOFAIL);
-	if (!clockevent) {
-		pr_err("Error allocating memory for clockevent data");
+	if (!clockevent)
 		return -ENOMEM;
-	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -298,7 +296,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 davinci_timer_irq_timer, IRQF_TIMER,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
-		pr_err("Unable to request the clockevent interrupt");
+		pr_err("Unable to request the clockevent interrupt\n");
 		return rv;
 	}
 
@@ -325,7 +323,7 @@ int __init davinci_timer_register(struct clk *clk,
 
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
-		pr_err("Unable to register clocksource");
+		pr_err("Unable to register clocksource\n");
 		return rv;
 	}
 
@@ -343,20 +341,20 @@ static int __init of_davinci_timer_register(struct device_node *np)
 
 	rv = of_address_to_resource(np, 0, &timer_cfg.reg);
 	if (rv) {
-		pr_err("Unable to get the register range for timer");
+		pr_err("Unable to get the register range for timer\n");
 		return rv;
 	}
 
 	rv = of_irq_to_resource_table(np, timer_cfg.irq,
 				      DAVINCI_TIMER_NUM_IRQS);
 	if (rv != DAVINCI_TIMER_NUM_IRQS) {
-		pr_err("Unable to get the interrupts for timer");
+		pr_err("Unable to get the interrupts for timer\n");
 		return rv;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Unable to get the timer clock");
+		pr_err("Unable to get the timer clock\n");
 		return PTR_ERR(clk);
 	}
 
-- 
2.20.1

