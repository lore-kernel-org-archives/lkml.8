Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29455C43459
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056692086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEUGtAZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgGWP1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgGWP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20485C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so5345587wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NpN6vwpNGFrmKHXZA+xE9YNl04TWY4QjIajSNvVcqI=;
        b=aEUGtAZIDshRVd/hX89wGAPq91RQ9Vmz+YYHCiHcETrwy/C9kpFks+YYrXAir08n4t
         X3eEg9kZlVw092N2gK4pezjLzdchra1jmWsGjaAMrywEmF0Ar2WbfjoUm5MN0bI0c0pD
         GeW8aYmxtYppycdoE4VB0rtAa04zFi35bpxTWbh7nVYc62x/MAr6MUmcuzMM7A6ZSswl
         LgGN29YP6NDBf4P6G+y81UzA8r7GgJKWWj7jimo0aA+0eHeVG6cpVWFz8rhBblZTVZ7n
         D3Jjev8QWmSyeoudsXisjVcQ4sN4KyX/yCf+BglJgeUO5KR1lx3rGCx/SdcagPalkEol
         ucFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NpN6vwpNGFrmKHXZA+xE9YNl04TWY4QjIajSNvVcqI=;
        b=SJ2IkA5ZWiRI7AyNy4ZN1zkbFcnet7IY9Xo0OeqYOlXPO0W1Pg2GzuswRxzaPneQ4q
         yC5sbrogGxp54HhqjObkLdtqAnNbVc9bFb+HHm0k1rmZDzC++c9I3k/e+H1N2thgK8lA
         VJLpELm8KRVxwLIqLV4si32twYFd3wMKwjEnv4csCtWHWlTYorNnRI6JeWYxTOjA5vv3
         n/r+T8mKHzRMt/zlwZAYgTlRX31dtqPyfTyX0hWGEjCS1AHBX+xCGtSSgoVcu58m/Hzp
         O1xSGaoA1aLw1yPKSu4hUCM13wVoPA0Ld23kZPZKXhQFQau5b5IC7ur746HLz8SS5f+i
         KNfA==
X-Gm-Message-State: AOAM532TOqdJetOFkuz3IoHqns+OsInrF58wA2I0sMvAFPMS3lTFWUFR
        LVgqepTWofz5yTWloszOVtlqeg==
X-Google-Smtp-Source: ABdhPJykbgZiz9e8tZr4TtwFzSuPsYlppku/LsYQx6m//wEDLxa446XX63F4bocUiIVM9Xwgj0P2Yg==
X-Received: by 2002:a1c:ab84:: with SMTP id u126mr4467525wme.43.1595518020709;
        Thu, 23 Jul 2020 08:27:00 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 06/16] clocksource/drivers/timer-atmel-tcb: Fill tcb_config
Date:   Thu, 23 Jul 2020 17:26:26 +0200
Message-Id: <20200723152639.639771-6-daniel.lezcano@linaro.org>
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

Use the tcb_config and struct atmel_tcb_config to get the timer counter
width. This is necessary because atmel_tcb_config will be extended later
on.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-7-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index b255a4a1a36b..423af2f9835f 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -348,9 +348,17 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 
 static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
 
+static struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
+
+static struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
+
 static const struct of_device_id atmel_tcb_of_match[] = {
-	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
-	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
+	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
 	{ /* sentinel */ }
 };
 
@@ -398,7 +406,11 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	}
 
 	match = of_match_node(atmel_tcb_of_match, node->parent);
-	bits = (uintptr_t)match->data;
+	if (!match)
+		return -ENODEV;
+
+	tc.tcb_config = match->data;
+	bits = tc.tcb_config->counter_width;
 
 	for (i = 0; i < ARRAY_SIZE(tc.irq); i++)
 		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
-- 
2.25.1

