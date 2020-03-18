Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B3FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C554C2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUKJexe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCRRm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40655 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCRRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id z12so4358166wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlGq9h23WNlUJL/JkBvC83xSMOUHn/TwnzYmgAc5b60=;
        b=tUKJexe/TuTjORUSvNmV+O2RtuIDDFId4/CNYuRBs+XD5p/9AK7JaVIdDWy8/OKdSb
         MXitobStdli+k1msJX/H8T0GdWBJWedk0ms7chON9WJ0QY6TwHQVV4szdOa/Ekn3PXbN
         wm12R9AiNRk/dQDwZ+Itu4IGonRg+CfC8GWSSRoPjdOdGT6FfoxWjGd7QobBnF+UOY+q
         HJPyYWxGkXeUN+u7sJPyiospJCHa0V8lJk93RShYwYgfKc3oReo96EMN1hyk1ZFxiHqb
         k6U9cQAM8FVLJUQrHtRF78002FT8gRe8+nvRCdZWQ8LlqmNcLR4juHtWlXrzyOEdDYbu
         /uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlGq9h23WNlUJL/JkBvC83xSMOUHn/TwnzYmgAc5b60=;
        b=VTtCzBAf7wJZ9Adu5r+p+mKTWhsDUyujQNUkhZkIUoadzTtlMEZkk/QLiveRCC3pNs
         DTmNcRuYnhMUUGebkZqPZoV17WI9NA3YsRT+zrRn74P+MbINAotGZsC3SkF2awqjnwIG
         wWRQV/Cesg8y6sjD+CyCIJ6QV4V4qrPB1AFxGpPyb9o2xd/mpONagvKXmBN5K0GI9dVA
         GN+kwzm0eOrK5v6Rhj/XOH2wb5I6C11M6IqYJyNAbxUadxbcKAoDDyqVT5wqe+akRFA0
         v/qpvCYtR2d3gVBFkoehpt/BQxioeJl/PYLyysLQr1Gm6uYX5/R4VFJel3WIU4qW4IWW
         UB5g==
X-Gm-Message-State: ANhLgQ1+rzyNhqHhM+g9FJIbEJIyE81TnZFfbNTnyKQ5tejltL91Gp9r
        1GGtImNAABmDi3lEqHztqif3UXPZZ5Q=
X-Google-Smtp-Source: ADFU+vs6frHEkbdh3s5ozfdB6VvazYhybHDT/o0Wu49gMdSDTLhmGyLIQx/Wv7yDAswUhKp4Jz4FzQ==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr6286997wmb.8.1584553371867;
        Wed, 18 Mar 2020 10:42:51 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 14/21] clocksource/drivers/timer-ti-dm: Prepare for using cpuidle
Date:   Wed, 18 Mar 2020 18:41:24 +0100
Message-Id: <20200318174131.20582-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

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
 drivers/clocksource/timer-ti-dm.c | 36 ++++++++++++++++++++++++++-----
 include/clocksource/timer-ti-dm.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index c0e9e9978cdd..fe939d1c0b38 100644
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
index 7d9598dc578d..eef5de300731 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -105,6 +105,7 @@ struct omap_dm_timer {
 	void __iomem	*pend;		/* write pending */
 	void __iomem	*func_base;	/* function register base */
 
+	atomic_t enabled;
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
-- 
2.17.1

