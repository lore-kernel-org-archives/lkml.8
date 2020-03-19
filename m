Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19753C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02E4208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCSIso convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59807 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqL-00034J-Ri; Thu, 19 Mar 2020 09:47:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CB231C229E;
        Thu, 19 Mar 2020 09:47:54 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:54 -0000
From:   "tip-bot2 for Joel Stanley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/fttmr010: Parametrise shutdown
Cc:     clg@kaod.org, Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191107094218.13210-2-joel@jms.id.au>
References: <20191107094218.13210-2-joel@jms.id.au>
MIME-Version: 1.0
Message-ID: <158460767417.28353.8600794669933114812.tip-bot2@tip-bot2>
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

Commit-ID:     84fb64c28acd85ae4d29b9c81926bdfa5f1bf25e
Gitweb:        https://git.kernel.org/tip/84fb64c28acd85ae4d29b9c81926bdfa5f1bf25e
Author:        Joel Stanley <joel@jms.id.au>
AuthorDate:    Thu, 07 Nov 2019 20:12:15 +10:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 21 Feb 2020 09:28:38 +01:00

clocksource/drivers/fttmr010: Parametrise shutdown

In preparation for supporting the ast2600 which uses a different method
to clear bits in the control register, use a callback for performing the
shutdown sequence.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191107094218.13210-2-joel@jms.id.au
---
 drivers/clocksource/timer-fttmr010.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index fadff79..c2d30eb 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -97,6 +97,7 @@ struct fttmr010 {
 	bool is_aspeed;
 	u32 t1_enable_val;
 	struct clock_event_device clkevt;
+	int (*timer_shutdown)(struct clock_event_device *evt);
 #ifdef CONFIG_ARM
 	struct delay_timer delay_timer;
 #endif
@@ -140,9 +141,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	if (fttmr010->is_aspeed) {
 		/*
@@ -183,9 +182,7 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
@@ -211,9 +208,7 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	/* Setup timer to fire at 1/HZ intervals. */
 	if (fttmr010->is_aspeed) {
@@ -350,6 +345,8 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
+	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
@@ -370,10 +367,10 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	fttmr010->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
 		CLOCK_EVT_FEAT_ONESHOT;
 	fttmr010->clkevt.set_next_event = fttmr010_timer_set_next_event;
-	fttmr010->clkevt.set_state_shutdown = fttmr010_timer_shutdown;
+	fttmr010->clkevt.set_state_shutdown = fttmr010->timer_shutdown;
 	fttmr010->clkevt.set_state_periodic = fttmr010_timer_set_periodic;
 	fttmr010->clkevt.set_state_oneshot = fttmr010_timer_set_oneshot;
-	fttmr010->clkevt.tick_resume = fttmr010_timer_shutdown;
+	fttmr010->clkevt.tick_resume = fttmr010->timer_shutdown;
 	fttmr010->clkevt.cpumask = cpumask_of(0);
 	fttmr010->clkevt.irq = irq;
 	clockevents_config_and_register(&fttmr010->clkevt,
