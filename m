Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653A4C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A39A206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOg1f43G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgGWP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgGWP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF472C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so4965662wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gT16S+wE9QP+Lpme4e1jgxInlD0M0uUa46Dg/gZiw4M=;
        b=OOg1f43G0/Boq4zjOO1Z381OJt14MPElkJJ6ldbqBbuoTC9fhJZGA3yDnmM95/n/7O
         pDdAajclwTkT1pQIg42a9a1qY5XBCIdofu2d0gGgNEfWv1Wdivb/YuXCY21uinty3DiC
         P1+yAP36cUUz+fQFtnR/jhbxIHAKWbNAHKXK/YsxVQgCHPNtIzD/gidu6IIKbmvi6j+i
         YCRGBtrS9vVSkrxhOpvzpN5THXNqYDZpMjeydx9SVHGlyuk/KNMMjhZ9GWu8F4LwfuMH
         yZrM6chFuRBiJJg3ceGRVvI8fVaOWDx2UsZw7Bq8yomd+bJHtgz3vKwAZcQ65d9ZAGgO
         dbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT16S+wE9QP+Lpme4e1jgxInlD0M0uUa46Dg/gZiw4M=;
        b=niZo5EEv4ZJPbcAXFiW2d0R/rBRmpgrsIdvedXawE+XHOUFQW69vVOl5QkILhdYFlq
         xicGYsKQibO5ATLz7XLF+RZy3jGtkpCVCYLGDSSDYG6L9y+V8A53K+8mX9qVULdM1wxj
         n+7bVUhU1EIYVj2eU+BUKDs/VutbBv4hkPwEGUUteapsxgv1oDsX98adwjc5/HQFTed6
         beBxEZUlZmJPh3OVHYzFh9nfEvkOtIrHXZNZB2vAxTs5gaUSeVJvj29TGRAC2QmzijjQ
         siNtXKdfXJEUuEPI0lRTCC3a0C/8AMoOtgOXifX9otB8yEcFbvSbMl/9V6zyDXhsxJof
         NQ9g==
X-Gm-Message-State: AOAM531XKiGwnkGFX9K5jjudjD/mINQwE/QFp9Pacs8S0pFaC/ee7G4w
        BxNm7oI4Ipe2nYshq8rqgulUHw==
X-Google-Smtp-Source: ABdhPJwY+1bzVpcKIe9+Fd1bx4mT//TJdWy4E/CueiOaDYHUQBR9iRc4PNZhj2N3QFJvjfFN+ZJvTA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr4521810wmc.109.1595518024251;
        Thu, 23 Jul 2020 08:27:04 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 09/16] clocksource/drivers/timer-atmel-tcb: Add sama5d2 support
Date:   Thu, 23 Jul 2020 17:26:29 +0200
Message-Id: <20200723152639.639771-9-daniel.lezcano@linaro.org>
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

The first divisor for the sama5d2 is actually the gclk selector. Because
the currently remaining divisors are fitting the use case, currently ensure
it is skipped.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-10-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7fea134650fc..787dbebbb432 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -359,9 +359,15 @@ static struct atmel_tcb_config tcb_sam9x5_config = {
 	.counter_width = 32,
 };
 
+static struct atmel_tcb_config tcb_sama5d2_config = {
+	.counter_width = 32,
+	.has_gclk = 1,
+};
+
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
 	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
+	{ .compatible = "atmel,sama5d2-tcb", .data = &tcb_sama5d2_config, },
 	{ /* sentinel */ }
 };
 
@@ -426,7 +432,10 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+	i = 0;
+	if (tc.tcb_config->has_gclk)
+		i = 1;
+	for (; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
 		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
-- 
2.25.1

