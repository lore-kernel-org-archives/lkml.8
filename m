Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E6C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC3E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NK+qvfDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395482AbgAPSYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50201 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395552AbgAPSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so4826347wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XCi3giR9VTe0RVdSxNrJbzA2jQPkRo5HAD6T0ea6ezU=;
        b=NK+qvfDtbcETsJbAUVtyYTvabKJ7laoZoo3Pi72AybzAYgicukjcCrWLCLPsmdQPQj
         C0UI1PjWGa06gE5PQhLy87feylKf6CPXf2dkpMFywDgcIsqCO4MDp4VSmSdRlW2LEmCy
         xI9fnWtM1bQBiAbH/XuAamzKVB7uJLB6NaQoVfy/p/KF6ia3cjsEr856YXyoF/ZKkohp
         p/UrPuAqIKV6lDpaSd9WB6EXh8To64A5Qm2MDTJsX3vVT1od0n0ghNHpDw1sSY3G/L/x
         SDy55Mxs4F2j+3td7ZJJZ9sle90kNaTdZ8yFYvEIbn5OpmNYMYSDRnLLOSyqpYC5aw+l
         Qccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XCi3giR9VTe0RVdSxNrJbzA2jQPkRo5HAD6T0ea6ezU=;
        b=umQG8cfdMMrVY2mEbrkBV3y+Ltpwv4eoNiPWrkyUXaqRIb3d9WIRHUxql04eo0CKao
         yXGGDgl2pqNQ0s4ttSwAt+CnFKEhgipjVvmDwM7Y4mdwqoxKPk1OiRK2KAV+DRaR1dSC
         3onz3B5Bidj8eFqookEV+rdNl/fF8qR5HP8d1nzp2TNLxUQUUH7BiLIbwrqJphat9010
         HdY+toxTMJ7OUdGO3xPIUJeQR54iyfAcpC3fBA1XGXgC+0BVJkC3iTeIOCsQHSivqVXv
         MEaJsvlXcn/GCFbg7o/iDZR0RGpshgH96Tk9JiSm4rzTA5pVJCJ3Ny+7+DX7z5i+wiUT
         ef8g==
X-Gm-Message-State: APjAAAWJOLb1KU8nxAbs9W3MgLMtpbpUw7Ltr8XhIpCdZdIbnJkqruMC
        lpgsEimjoJpB+hj4cV0r1PO71g==
X-Google-Smtp-Source: APXvYqzzk/u9wMQmxsWFQjXXqLpW96/Wotc9bX/2MlWh/iCgtJD6BoISx1/3AIymdgPTxC0p+Kg8UQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr365782wmc.54.1579199011774;
        Thu, 16 Jan 2020 10:23:31 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
        ARCHITECTURE)
Subject: [PATCH 07/17] clocksource/drivers/cadence-ttc: Use ttc driver as platform driver
Date:   Thu, 16 Jan 2020 19:22:54 +0100
Message-Id: <20200116182304.4926-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
that, TTC driver may be initialized before other clock drivers. If
TTC driver is dependent on that clock driver then initialization of
TTC driver will failed.

So use TTC driver as platform driver instead of using
TIMER_OF_DECLARE.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com
---
 drivers/clocksource/timer-cadence-ttc.c | 26 +++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9ba9a3..38858e141731 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -15,6 +15,8 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
 
 /*
  * This driver configures the 2 16/32-bit count-up timers as follows:
@@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	return 0;
 }
 
-/**
- * ttc_timer_init - Initialize the timer
- *
- * Initializes the timer hardware and register the clock source and clock event
- * timers with Linux kernal timer framework
- */
-static int __init ttc_timer_init(struct device_node *timer)
+static int __init ttc_timer_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
@@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	static int initialized;
 	int clksel, ret;
 	u32 timer_width = 16;
+	struct device_node *timer = pdev->dev.of_node;
 
 	if (initialized)
 		return 0;
@@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node *timer)
 	return 0;
 }
 
-TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
+static const struct of_device_id ttc_timer_of_match[] = {
+	{.compatible = "cdns,ttc"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
+
+static struct platform_driver ttc_timer_driver = {
+	.driver = {
+		.name	= "cdns_ttc_timer",
+		.of_match_table = ttc_timer_of_match,
+	},
+};
+builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
-- 
2.17.1

