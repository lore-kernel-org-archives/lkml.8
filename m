Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E5EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14E820732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgCSIsX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgCSIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqL-00033e-0d; Thu, 19 Mar 2020 09:47:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1AE871C22A1;
        Thu, 19 Mar 2020 09:47:54 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:53 -0000
From:   "tip-bot2 for Joel Stanley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/fttmr010: Set interrupt and shutdown
Cc:     clg@kaod.org, Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191107094218.13210-3-joel@jms.id.au>
References: <20191107094218.13210-3-joel@jms.id.au>
MIME-Version: 1.0
Message-ID: <158460767369.28353.13687641500549950134.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5422413ce56877f35415f6e4b53171e6e13ec4c1
Gitweb:        https://git.kernel.org/tip/5422413ce56877f35415f6e4b53171e6e13ec4c1
Author:        Joel Stanley <joel@jms.id.au>
AuthorDate:    Thu, 07 Nov 2019 20:12:16 +10:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 21 Feb 2020 09:28:38 +01:00

clocksource/drivers/fttmr010: Set interrupt and shutdown

In preparation for supporting the ast2600, pass the shutdown and
interrupt functions to the common init callback.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191107094218.13210-3-joel@jms.id.au
---
 drivers/clocksource/timer-fttmr010.c | 51 ++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c2d30eb..edb1d5f 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -38,6 +38,11 @@
 #define TIMER_CR		(0x30)
 
 /*
+ * Control register set to clear for ast2600 only.
+ */
+#define AST2600_TIMER_CR_CLR	(0x3c)
+
+/*
  * Control register (TMC30) bit fields for fttmr010/gemini/moxart timers.
  */
 #define TIMER_1_CR_ENABLE	BIT(0)
@@ -163,6 +168,16 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
+static int ast2600_timer_shutdown(struct clock_event_device *evt)
+{
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+
+	/* Stop */
+	writel(fttmr010->t1_enable_val, fttmr010->base + AST2600_TIMER_CR_CLR);
+
+	return 0;
+}
+
 static int fttmr010_timer_shutdown(struct clock_event_device *evt)
 {
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
@@ -244,7 +259,21 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
+static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+
+	writel(0x1, fttmr010->base + TIMER_INTR_STATE);
+
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static int __init fttmr010_common_init(struct device_node *np,
+		bool is_aspeed,
+		int (*timer_shutdown)(struct clock_event_device *),
+		irq_handler_t irq_handler)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -345,7 +374,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
-	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+	fttmr010->timer_shutdown = timer_shutdown;
 
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
@@ -354,7 +383,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret = request_irq(irq, fttmr010_timer_interrupt, IRQF_TIMER,
+	ret = request_irq(irq, irq_handler, IRQF_TIMER,
 			  "FTTMR010-TIMER1", &fttmr010->clkevt);
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
@@ -401,14 +430,25 @@ out_disable_clock:
 	return ret;
 }
 
+static __init int ast2600_timer_init(struct device_node *np)
+{
+	return fttmr010_common_init(np, true,
+			ast2600_timer_shutdown,
+			ast2600_timer_interrupt);
+}
+
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true);
+	return fttmr010_common_init(np, true,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false);
+	return fttmr010_common_init(np, false,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
@@ -416,3 +456,4 @@ TIMER_OF_DECLARE(gemini, "cortina,gemini-timer", fttmr010_timer_init);
 TIMER_OF_DECLARE(moxart, "moxa,moxart-timer", fttmr010_timer_init);
 TIMER_OF_DECLARE(ast2400, "aspeed,ast2400-timer", aspeed_timer_init);
 TIMER_OF_DECLARE(ast2500, "aspeed,ast2500-timer", aspeed_timer_init);
+TIMER_OF_DECLARE(ast2600, "aspeed,ast2600-timer", ast2600_timer_init);
