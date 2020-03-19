Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E3C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F6720732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgCSIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgCSIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:47:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqD-0002zL-Rx; Thu, 19 Mar 2020 09:47:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 86B581C1DC3;
        Thu, 19 Mar 2020 09:47:49 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:49 -0000
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Prepare for using cpuidle
Cc:     Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305082715.15861-3-lokeshvutla@ti.com>
References: <20200305082715.15861-3-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <158460766913.28353.18101835082004521218.tip-bot2@tip-bot2>
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

Commit-ID:     5e20931c6a750b4b1ea9a2f7b863cc2dd9222ead
Gitweb:        https://git.kernel.org/tip/5e20931c6a750b4b1ea9a2f7b863cc2dd9222ead
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Thu, 05 Mar 2020 13:57:11 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 16 Mar 2020 12:40:21 +01:00

clocksource/drivers/timer-ti-dm: Prepare for using cpuidle

Let's add runtime_suspend and resume functions and atomic enabled
flag. This way we can use these when converting to use cpuidle
for saving and restoring device context.

And we need to maintain the driver state in the driver as documented
in "9. Autosuspend, or automatically-delayed suspends" in the
Documentation/power/runtime_pm.rst document related to using driver
private lock and races with runtime_suspend().

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-3-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 36 +++++++++++++++++++++++++-----
 include/clocksource/timer-ti-dm.h |  1 +-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index c0e9e99..fe939d1 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -491,7 +491,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 int omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
@@ -690,7 +690,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
 	}
@@ -702,7 +702,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
+	if (unlikely(!timer || !atomic_read(&timer->enabled)))
 		return -EINVAL;
 
 	__omap_dm_timer_write_status(timer, value);
@@ -712,7 +712,7 @@ static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int 
 
 static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not iavailable or enabled.\n", __func__);
 		return 0;
 	}
@@ -722,7 +722,7 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
@@ -750,6 +750,29 @@ int omap_dm_timers_active(void)
 	return 0;
 }
 
+static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
+{
+	struct omap_dm_timer *timer = dev_get_drvdata(dev);
+
+	atomic_set(&timer->enabled, 0);
+
+	return 0;
+}
+
+static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
+{
+	struct omap_dm_timer *timer = dev_get_drvdata(dev);
+
+	atomic_set(&timer->enabled, 1);
+
+	return 0;
+}
+
+static const struct dev_pm_ops omap_dm_timer_pm_ops = {
+	SET_RUNTIME_PM_OPS(omap_dm_timer_runtime_suspend,
+			   omap_dm_timer_runtime_resume, NULL)
+};
+
 static const struct of_device_id omap_timer_match[];
 
 /**
@@ -791,6 +814,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
+	platform_set_drvdata(pdev, timer);
+
 	if (dev->of_node) {
 		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
 			timer->capability |= OMAP_TIMER_ALWON;
@@ -936,6 +961,7 @@ static struct platform_driver omap_dm_timer_driver = {
 	.driver = {
 		.name   = "omap_timer",
 		.of_match_table = of_match_ptr(omap_timer_match),
+		.pm = &omap_dm_timer_pm_ops,
 	},
 };
 
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 7d9598d..eef5de3 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -105,6 +105,7 @@ struct omap_dm_timer {
 	void __iomem	*pend;		/* write pending */
 	void __iomem	*func_base;	/* function register base */
 
+	atomic_t enabled;
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
