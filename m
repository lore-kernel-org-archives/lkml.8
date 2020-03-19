Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18814C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D848220732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgCSIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgCSIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:47:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqD-0002yf-D7; Thu, 19 Mar 2020 09:47:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F9D71C2298;
        Thu, 19 Mar 2020 09:47:49 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:48 -0000
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Implement cpu_pm
 notifier for context save and restore
Cc:     Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200316111453.15441-1-lokeshvutla@ti.com>
References: <20200316111453.15441-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <158460766876.28353.2554006990397817405.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b34677b0999a7c0de45e57b780508c14cb438ed8
Gitweb:        https://git.kernel.org/tip/b34677b0999a7c0de45e57b780508c14cb438ed8
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Mon, 16 Mar 2020 16:44:53 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 16 Mar 2020 12:40:29 +01:00

clocksource/drivers/timer-ti-dm: Implement cpu_pm notifier for context save and restore

omap_dm_timer_enable() restores the entire context(including counter)
based on 2 conditions:
- If get_context_loss_count is populated and context is lost.
- If get_context_loss_count is not populated update unconditionally.

Case2 has a side effect of updating the counter register even though
context is not lost. When timer is configured in pwm mode, this is
causing undesired behaviour in the pwm period.

Instead of using get_context_loss_count call back, implement cpu_pm
notifier with context save and restore support. And delete the
get_context_loss_count callback all together.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[tony@atomide.com: removed pm_runtime calls from cpuidle calls]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200316111453.15441-1-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 97 +++++++++++++++++-------------
 include/clocksource/timer-ti-dm.h |  3 +-
 2 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index fe939d1..1d1bea7 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/device.h>
@@ -92,6 +93,47 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 				timer->context.tclr);
 }
 
+static void omap_timer_save_context(struct omap_dm_timer *timer)
+{
+	timer->context.tclr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.twer =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
+	timer->context.tldr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
+	timer->context.tmar =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
+	timer->context.tier = readl_relaxed(timer->irq_ena);
+	timer->context.tsicr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
+}
+
+static int omap_timer_context_notifier(struct notifier_block *nb,
+				       unsigned long cmd, void *v)
+{
+	struct omap_dm_timer *timer;
+
+	timer = container_of(nb, struct omap_dm_timer, nb);
+
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if ((timer->capability & OMAP_TIMER_ALWON) ||
+		    !atomic_read(&timer->enabled))
+			break;
+		omap_timer_save_context(timer);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if ((timer->capability & OMAP_TIMER_ALWON) ||
+		    !atomic_read(&timer->enabled))
+			break;
+		omap_timer_restore_context(timer);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
 	u32 l, timeout = 100000;
@@ -208,21 +250,7 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
 static void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	int c;
-
 	pm_runtime_get_sync(&timer->pdev->dev);
-
-	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		if (timer->get_context_loss_count) {
-			c = timer->get_context_loss_count(&timer->pdev->dev);
-			if (c != timer->ctx_loss_count) {
-				omap_timer_restore_context(timer);
-				timer->ctx_loss_count = c;
-			}
-		} else {
-			omap_timer_restore_context(timer);
-		}
-	}
 }
 
 static void omap_dm_timer_disable(struct omap_dm_timer *timer)
@@ -515,8 +543,6 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 
-	/* Save the context */
-	timer->context.tclr = l;
 	return 0;
 }
 
@@ -532,13 +558,6 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	/*
-	 * Since the register values are computed and written within
-	 * __omap_dm_timer_stop, we need to use read to retrieve the
-	 * context.
-	 */
-	timer->context.tclr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -561,9 +580,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -585,9 +601,6 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tmar = match;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -611,8 +624,6 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -634,8 +645,6 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -649,9 +658,6 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	omap_dm_timer_enable(timer);
 	__omap_dm_timer_int_enable(timer, value);
 
-	/* Save the context */
-	timer->context.tier = value;
-	timer->context.twer = value;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -679,9 +685,6 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
-	/* Save the context */
-	timer->context.tier &= ~mask;
-	timer->context.twer &= ~mask;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -756,6 +759,11 @@ static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 
 	atomic_set(&timer->enabled, 0);
 
+	if (timer->capability & OMAP_TIMER_ALWON || !timer->func_base)
+		return 0;
+
+	omap_timer_save_context(timer);
+
 	return 0;
 }
 
@@ -763,6 +771,9 @@ static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
 {
 	struct omap_dm_timer *timer = dev_get_drvdata(dev);
 
+	if (!(timer->capability & OMAP_TIMER_ALWON) && timer->func_base)
+		omap_timer_restore_context(timer);
+
 	atomic_set(&timer->enabled, 1);
 
 	return 0;
@@ -829,7 +840,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		timer->id = pdev->id;
 		timer->capability = pdata->timer_capability;
 		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
-		timer->get_context_loss_count = pdata->get_context_loss_count;
+	}
+
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
+		timer->nb.notifier_call = omap_timer_context_notifier;
+		cpu_pm_register_notifier(&timer->nb);
 	}
 
 	if (pdata)
@@ -883,6 +898,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (!strcmp(dev_name(&timer->pdev->dev),
 			    dev_name(&pdev->dev))) {
+			if (!(timer->capability & OMAP_TIMER_ALWON))
+				cpu_pm_unregister_notifier(&timer->nb);
 			list_del(&timer->node);
 			ret = 0;
 			break;
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index eef5de3..25f0523 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -110,13 +110,12 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned posted:1;
 	struct timer_regs context;
-	int (*get_context_loss_count)(struct device *);
-	int ctx_loss_count;
 	int revision;
 	u32 capability;
 	u32 errata;
 	struct platform_device *pdev;
 	struct list_head node;
+	struct notifier_block nb;
 };
 
 int omap_dm_timer_reserve_systimer(int id);
