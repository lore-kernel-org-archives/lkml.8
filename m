Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF8C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098820719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owVdIOkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgCRRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36990 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgCRRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so2805262wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZgHSIt1QCaNSrew0phAsOoqe5n7G9L1tILJmRg4I3I=;
        b=owVdIOkxQFzC6zceFlziNxoXfOXqzLHoa5PQrcaXZn9Mse7ZIzbqRYPBJSeKGxuTsA
         6YQzvDCVPHit3zfb3QknU3IeCvsM/zDDx6QOCZ0bYaj+Lmwn445TPmXj8vVySH9yllIb
         8xwTEV0t9LOEo66cJfd55K7CScWzfG0BLooJkrq0JohS+KlAyYmRlIwLTCAwHmantzx+
         3vBQg3J0zg3huAMWeHL5JOBU9gc9scJ1QcgKYt9LSavzwDUyOYELF03FizzMO9pwG8Fw
         m02ZaVeMw0u76croNmrdBoSPPFV6HfUNdwZ2EgO/dBdiRYIWsxmvYLxTtTRqlfIt02p1
         1O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZgHSIt1QCaNSrew0phAsOoqe5n7G9L1tILJmRg4I3I=;
        b=VujsZ3xdaeGK6BVaV4Zop6IQJ3u91o96LWF7D4utxra2HQ/g9dTZrThxfIM2g8FO8p
         WQahazAsXMuI0XYBKbC6HMijhq4k5J7lqfTvgqsOgXhlPPKkbF4a8pa0bmJ8JAtyPyEJ
         n81NaEyyKwy3cGiJdLSxX3OFnE+9mGYfej+piQWlaMiD2hKhllHdW1jYSLT+gWlz0Q4G
         fLM/RSxxnQlqOWlhpszRjHrnkxAJYAMCxcfmB/U8iX6RZ4EZQkajQBcefNBPNUhmKePA
         zkTFebsf6F7v4qWqiJ2nklkqkaTTRjWQ20/3UNF7tNtV4dqLWhrnsYuRUDbVrrEGaO+F
         /OJQ==
X-Gm-Message-State: ANhLgQ24HAnWpJXcREwmYiK7s0NJAY5SkWNhQLwtDJWsqK0usNOi+4sl
        hyjqdw0MbLlMITaOrzsCRLVcnQ==
X-Google-Smtp-Source: ADFU+vuTn5+Nf6ove9FH20yINeRNOPu1YtXvvKvXpgawIWPZ6tLlVEDRnSZWyq18UzzV3bL2ElGdkQ==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr6272702wmg.60.1584553375015;
        Wed, 18 Mar 2020 10:42:55 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/21] clocksource/drivers/timer-ti-dm: Implement cpu_pm notifier for context save and restore
Date:   Wed, 18 Mar 2020 18:41:25 +0100
Message-Id: <20200318174131.20582-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

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
 drivers/clocksource/timer-ti-dm.c | 97 ++++++++++++++++++-------------
 include/clocksource/timer-ti-dm.h |  3 +-
 2 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index fe939d1c0b38..1d1bea79cbf1 100644
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
index eef5de300731..25f05235866e 100644
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
-- 
2.17.1

