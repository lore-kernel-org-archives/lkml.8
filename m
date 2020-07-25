Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F45C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C944E206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595674443;
	bh=kkyDIY4cLytO4fWKrF7cGh9SaGh2/fxL7ImxZBPYFTo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pW0qgOV/1KWa6fRJE/XOjMe79LNOaX1sM60MCZ+4dSvM6PWFu0XF2qBL4A0r6+97/
	 ekI0VxMCXgxvddNq7Jqp1ZmqZLQbqRiDNIaBlORrbITqGtknip/8djk82f4e0OJ1yO
	 UyVH79RdSMKJ/zeCLVPXxQ9bCDuvMLS4pEavS7Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGYKyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:54:02 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E9BC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:54:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gg18so9049571ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xxwPO762QGuVYnkDFWAUTcjVrmFhEofF0vwMqrx3SEc=;
        b=XrWZqclEiC1GGcJVM9481P4qRkBgsiSVAS+zo0+FTHSi9qpbEQZcAuocFRUh49PCUD
         dpFVSerNNTkj7yL2As2Q/9assu1ekk8QOWZde8qI9PjpzM3f8reWozuzbxoZgow1KL6q
         p5c68JlBNh4KKxOYPM5xsTovbPNTn8EfaDs8fU+mrKFpy5eVMxpvz3EjzvW+wncj8BSj
         6kdkqAKm9x5sAJ4BIxjex/69FPjgXaKh5lqGrNoZClbEwbYZtEMhlSQsDQgKYi/m/S1j
         g00NerDxCl+my2fbJ/oqAOYK/bgZAL7wJmM48kRRHcJ3AvpJTnS87ILljbrowqEemcx8
         n2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=xxwPO762QGuVYnkDFWAUTcjVrmFhEofF0vwMqrx3SEc=;
        b=cBU6uO6nwiqQpR24cbi7zHx68ita3iAnJrWzF2BrjI9pEJE3+6j3z7k7NQEpM+TCPg
         oozI8fgYapsUzh38rW0dKhG+foBY9K8v0XuaXyLQdn6FdAA9pwPYyrjRPdlHApX+UeZJ
         W0ozzgW6UOc4BDFGiGQh9QV4ALGSMqnQJP6ByOH20I5+ZBhMZX4hf6hk9mv2pjYCfPG8
         e+syKNenbZlmkUB0BfR7D2RCg1Ov5UHerfzgejTPc5UMOCL53I9FsnVHimcH04nEbBHr
         Mns7XDmO8E+q3UHicAN517RbI8TkV1NX7zHfenBhD3svjifO4ZEYfh4+hUkLDCasY9NG
         nRXg==
X-Gm-Message-State: AOAM531wCdeHdtgL9VcmTdKG+ogX4yx2KdljQ1EQjAdmQvfBcN4+EOhm
        Npe/YVg4lCtQCwI2K2GcTS0=
X-Google-Smtp-Source: ABdhPJzEc2nrx23rIIGehIyPrYtvEgCE1Q5Hk7nDuOW2GWHjcOhuazFjAbRJk+acg2SR25raEwz8/A==
X-Received: by 2002:a17:906:8392:: with SMTP id p18mr13885947ejx.24.1595674440435;
        Sat, 25 Jul 2020 03:54:00 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id qc23sm620133ejb.97.2020.07.25.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:53:59 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:53:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] clocksource driver fix
Message-ID: <20200725105357.GA883878@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-07-25

   # HEAD: b4a25fb0e62990df467451744b22e0e24960a5e6 Merge tag 'timers-v5.8-rc7' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

Fix a suspend/resume regression (crash) on TI AM3/AM4 SoC's.

 Thanks,

	Ingo

------------------>
Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and am4


 drivers/bus/ti-sysc.c                      | 22 ++++++++++++++
 drivers/clocksource/timer-ti-dm-systimer.c | 46 +++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index bb54fb514e40..c6427d0bc94c 100644
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
index 6fd1f219a512..f6fd1c1cc527 100644
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
