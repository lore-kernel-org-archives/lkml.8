Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55C0C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26B2206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLNp4nQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgGWP1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgGWP1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C2C0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so4965427wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEfaBqT/0CoLB9mlKqYWw9OwFPm9et7GWv9HdjL+20Q=;
        b=qLNp4nQHmBcL9wwPcTVh1KdyojCC+Ng1h0PSBagRtQe/13DibONXpQ/OK1hYytNNyB
         oIN9Ptyndv/Mdo9ftVGZGb8jmZv9mBo2JX2mhV/GoJR0eJPnlepcmPCQrMS03klCj/Ls
         idzzWjFAhcItNP0G7hHezWVLTTLW7KvYCyQtdYFHjfPjitCHAQmeGMcVSldgCYpOTDJT
         C24PkFeoRuHRkm65GPydAWLnOnCU0v5MJKZssXF58zH/bkoRrGpMAEaYVjYBt2TmmOu9
         QSfDL52VJVbM/N6YhjSl24VOEWL2ETfHOyHe0/Gn3himhdQox/4Q0OkYhWHIYcnUZlmx
         vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEfaBqT/0CoLB9mlKqYWw9OwFPm9et7GWv9HdjL+20Q=;
        b=VOBw1RkVDgEtd8pK6vsSX2ehzYbMYa4N2U6PgfRkMzr3AWIbay2q6PUcll9+IIaXDS
         ehYKH+zoU3rKZ/1rpEXcpdgT4MKuedQWjJ/gSxMuUGVTO+bZ4F9b42P4CxWUBKY7GG8r
         0H9kKflaUNJQ4i4pYyJqvPr764gHn+0yJqVWmb3uRRH6/x0CguDDE/TlGVnzfYj4updz
         HR86NsJtF36PT5kGwCamB7D19WMdbbrEy0dcZOKwJAzGPtxXcDFnv46wbAZxNGMXD+LY
         YIqZEMIdTkXBWXO6c+KjHSZYcJP91Cx4EHPjiq98qvKOoohf/tUtVS1nDCu2ky2UaAQx
         ThFA==
X-Gm-Message-State: AOAM531R8sJ2G/NwHPyaOwSj7MmgL/FRnvxk+frcn9dAtD9kaoRcRnHQ
        e990HxNnDncSndrTfmCUj2DlwA==
X-Google-Smtp-Source: ABdhPJzKZTThxX/bozgKe2UbCkR0civZnFkJIRvbd/AnyAaR20RyQH92o7sYad6XySCakbUDgu3WMg==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr2125925wmj.13.1595518019623;
        Thu, 23 Jul 2020 08:26:59 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:26:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 05/16] clocksource/drivers/timer-atmel-tcb: Rework 32khz clock selection
Date:   Thu, 23 Jul 2020 17:26:25 +0200
Message-Id: <20200723152639.639771-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On all the supported SoCs, the slow clock is always ATMEL_TC_TIMER_CLOCK5,
avoid looking it up and pass it directly to setup_clkevents.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-6-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7427b07495a8..b255a4a1a36b 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -346,7 +346,7 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
 
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
@@ -362,7 +362,6 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
-	int clk32k_divisor_idx = -1;
 	int bits;
 	int i;
 	int ret;
@@ -416,12 +415,6 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
-		/* remember 32 KiHz clock for later */
-		if (!divisor) {
-			clk32k_divisor_idx = i;
-			continue;
-		}
-
 		tmp = rate / divisor;
 		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
 		if (best_divisor_idx > 0) {
@@ -467,7 +460,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
-	ret = setup_clkevents(&tc, clk32k_divisor_idx);
+	ret = setup_clkevents(&tc, ATMEL_TC_TIMER_CLOCK5);
 	if (ret)
 		goto err_unregister_clksrc;
 
-- 
2.25.1

