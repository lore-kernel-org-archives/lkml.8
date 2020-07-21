Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DCFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D142073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9sw06fM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TD/e8gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgGUQPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:15:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41498 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:15:23 -0400
Date:   Tue, 21 Jul 2020 16:15:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595348119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoG8zHzSIQUncV2ofzomm2r8fkZN3EZB87jI6FsGl9A=;
        b=U9sw06fM8cHWE7ajpcC38JpNxu0/IOtSaebnRAWXcZcOaGzPxjoTGaQepP+g47IJtHo2zC
        4pAHM+dMm3Wrv0woDoBtvzs0k89juEIZy6jxKucHh40PBe262GPTQjnvJuH22WsUC6Mbk4
        bX0VdfRf6iLRoaQ9jQMRxEBanRWfIscN7uXUf7SKftYCtEP3izzp4B/BZs17NoqXajIDGJ
        0tcbeNkolqBXyd76HVgXIXdgMLzjmwXgS76ZokAgft7aHwmNkrHdk364PQPPxXZF0dYWF5
        S72y4f8ocbN8n4aG9uEZOx/HkB8XQG9wuY5ykigZ2wI6448E8Fs8MV8h0lUmpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595348119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoG8zHzSIQUncV2ofzomm2r8fkZN3EZB87jI6FsGl9A=;
        b=4TD/e8gJspPienxbSx/rlgmhI+RfvNLsKqoSNgAFtFfyfjCoPYgnvq+EXquOdqiFXTFPcX
        eXsuCdW3XS8rIGAA==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/timer-ti-dm: Fix suspend and
 resume for am3 and am4
Cc:     Carlos Hernandez <ceh@ti.com>, Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713162601.6829-1-tony@atomide.com>
References: <20200713162601.6829-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <159534811841.4006.16924195387641534460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     6cfcd5563b4fadbf49ba8fa481978e5e86d30322
Gitweb:        https://git.kernel.org/tip/6cfcd5563b4fadbf49ba8fa481978e5e86d30322
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 13 Jul 2020 09:26:01 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 21 Jul 2020 15:48:33 +02:00

clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and am4

Carlos Hernandez <ceh@ti.com> reported that we now have a suspend and
resume regresssion on am3 and am4 compared to the earlier kernels. While
suspend and resume works with v5.8-rc3, we now get errors with rtcwake:

pm33xx pm33xx: PM: Could not transition all powerdomains to target state
...
rtcwake: write error

This is because we now fail to idle the system timer clocks that the
idle code checks and the error gets propagated to the rtcwake.

Turns out there are several issues that need to be fixed:

1. Ignore no-idle and no-reset configured timers for the ti-sysc
   interconnect target driver as otherwise it will keep the system timer
   clocks enabled

2. Toggle the system timer functional clock for suspend for am3 and am4
   (but not for clocksource on am3)

3. Only reconfigure type1 timers in dmtimer_systimer_disable()

4. Use of_machine_is_compatible() instead of of_device_is_compatible()
   for checking the SoC type

Fixes: 52762fbd1c47 ("clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support")
Reported-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200713162601.6829-1-tony@atomide.com
---
 drivers/bus/ti-sysc.c                      | 22 ++++++++++-
 drivers/clocksource/timer-ti-dm-systimer.c | 46 ++++++++++++++++-----
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index bb54fb5..c6427d0 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2864,6 +2864,24 @@ static int sysc_check_disabled_devices(struct sysc *ddata)
 	return error;
 }
 
+/*
+ * Ignore timers tagged with no-reset and no-idle. These are likely in use,
+ * for example by drivers/clocksource/timer-ti-dm-systimer.c. If more checks
+ * are needed, we could also look at the timer register configuration.
+ */
+static int sysc_check_active_timer(struct sysc *ddata)
+{
+	if (ddata->cap->type != TI_SYSC_OMAP2_TIMER &&
+	    ddata->cap->type != TI_SYSC_OMAP4_TIMER)
+		return 0;
+
+	if ((ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&
+	    (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE))
+		return -EBUSY;
+
+	return 0;
+}
+
 static const struct of_device_id sysc_match_table[] = {
 	{ .compatible = "simple-bus", },
 	{ /* sentinel */ },
@@ -2920,6 +2938,10 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	error = sysc_check_active_timer(ddata);
+	if (error)
+		return error;
+
 	error = sysc_get_clocks(ddata);
 	if (error)
 		return error;
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 6fd1f21..f6fd1c1 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -19,7 +19,7 @@
 /* For type1, set SYSC_OMAP2_CLOCKACTIVITY for fck off on idle, l4 clock on */
 #define DMTIMER_TYPE1_ENABLE	((1 << 9) | (SYSC_IDLE_SMART << 3) | \
 				 SYSC_OMAP2_ENAWAKEUP | SYSC_OMAP2_AUTOIDLE)
-
+#define DMTIMER_TYPE1_DISABLE	(SYSC_OMAP2_SOFTRESET | SYSC_OMAP2_AUTOIDLE)
 #define DMTIMER_TYPE2_ENABLE	(SYSC_IDLE_SMART_WKUP << 2)
 #define DMTIMER_RESET_WAIT	100000
 
@@ -44,6 +44,8 @@ struct dmtimer_systimer {
 	u8 ctrl;
 	u8 wakeup;
 	u8 ifctrl;
+	struct clk *fck;
+	struct clk *ick;
 	unsigned long rate;
 };
 
@@ -298,16 +300,20 @@ static void __init dmtimer_systimer_select_best(void)
 }
 
 /* Interface clocks are only available on some SoCs variants */
-static int __init dmtimer_systimer_init_clock(struct device_node *np,
+static int __init dmtimer_systimer_init_clock(struct dmtimer_systimer *t,
+					      struct device_node *np,
 					      const char *name,
 					      unsigned long *rate)
 {
 	struct clk *clock;
 	unsigned long r;
+	bool is_ick = false;
 	int error;
 
+	is_ick = !strncmp(name, "ick", 3);
+
 	clock = of_clk_get_by_name(np, name);
-	if ((PTR_ERR(clock) == -EINVAL) && !strncmp(name, "ick", 3))
+	if ((PTR_ERR(clock) == -EINVAL) && is_ick)
 		return 0;
 	else if (IS_ERR(clock))
 		return PTR_ERR(clock);
@@ -320,6 +326,11 @@ static int __init dmtimer_systimer_init_clock(struct device_node *np,
 	if (!r)
 		return -ENODEV;
 
+	if (is_ick)
+		t->ick = clock;
+	else
+		t->fck = clock;
+
 	*rate = r;
 
 	return 0;
@@ -339,7 +350,10 @@ static void dmtimer_systimer_enable(struct dmtimer_systimer *t)
 
 static void dmtimer_systimer_disable(struct dmtimer_systimer *t)
 {
-	writel_relaxed(0, t->base + t->sysc);
+	if (!dmtimer_systimer_revision1(t))
+		return;
+
+	writel_relaxed(DMTIMER_TYPE1_DISABLE, t->base + t->sysc);
 }
 
 static int __init dmtimer_systimer_setup(struct device_node *np,
@@ -366,13 +380,13 @@ static int __init dmtimer_systimer_setup(struct device_node *np,
 		pr_err("%s: clock source init failed: %i\n", __func__, error);
 
 	/* For ti-sysc, we have timer clocks at the parent module level */
-	error = dmtimer_systimer_init_clock(np->parent, "fck", &rate);
+	error = dmtimer_systimer_init_clock(t, np->parent, "fck", &rate);
 	if (error)
 		goto err_unmap;
 
 	t->rate = rate;
 
-	error = dmtimer_systimer_init_clock(np->parent, "ick", &rate);
+	error = dmtimer_systimer_init_clock(t, np->parent, "ick", &rate);
 	if (error)
 		goto err_unmap;
 
@@ -496,12 +510,18 @@ static void omap_clockevent_idle(struct clock_event_device *evt)
 	struct dmtimer_systimer *t = &clkevt->t;
 
 	dmtimer_systimer_disable(t);
+	clk_disable(t->fck);
 }
 
 static void omap_clockevent_unidle(struct clock_event_device *evt)
 {
 	struct dmtimer_clockevent *clkevt = to_dmtimer_clockevent(evt);
 	struct dmtimer_systimer *t = &clkevt->t;
+	int error;
+
+	error = clk_enable(t->fck);
+	if (error)
+		pr_err("could not enable timer fck on resume: %i\n", error);
 
 	dmtimer_systimer_enable(t);
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_ena);
@@ -570,8 +590,8 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 					3, /* Timer internal resynch latency */
 					0xffffffff);
 
-	if (of_device_is_compatible(np, "ti,am33xx") ||
-	    of_device_is_compatible(np, "ti,am43")) {
+	if (of_machine_is_compatible("ti,am33xx") ||
+	    of_machine_is_compatible("ti,am43")) {
 		dev->suspend = omap_clockevent_idle;
 		dev->resume = omap_clockevent_unidle;
 	}
@@ -616,12 +636,18 @@ static void dmtimer_clocksource_suspend(struct clocksource *cs)
 
 	clksrc->loadval = readl_relaxed(t->base + t->counter);
 	dmtimer_systimer_disable(t);
+	clk_disable(t->fck);
 }
 
 static void dmtimer_clocksource_resume(struct clocksource *cs)
 {
 	struct dmtimer_clocksource *clksrc = to_dmtimer_clocksource(cs);
 	struct dmtimer_systimer *t = &clksrc->t;
+	int error;
+
+	error = clk_enable(t->fck);
+	if (error)
+		pr_err("could not enable timer fck on resume: %i\n", error);
 
 	dmtimer_systimer_enable(t);
 	writel_relaxed(clksrc->loadval, t->base + t->counter);
@@ -653,8 +679,8 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
 	dev->mask = CLOCKSOURCE_MASK(32);
 	dev->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
-	if (of_device_is_compatible(np, "ti,am33xx") ||
-	    of_device_is_compatible(np, "ti,am43")) {
+	/* Unlike for clockevent, legacy code sets suspend only for am4 */
+	if (of_machine_is_compatible("ti,am43")) {
 		dev->suspend = dmtimer_clocksource_suspend;
 		dev->resume = dmtimer_clocksource_resume;
 	}
