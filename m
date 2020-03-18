Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865EC20719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Txm8Zbsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRRmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so2734574wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwtKT3TLRrtzvoSqBBz0zTgfqFifuE6VoyUdNbDunc4=;
        b=Txm8Zbsj4srRl12Bc9u2Ahdo09SsF2DWB7GaCUCsfdnVQOtQwVrNea9z7RQlziZUHz
         0oi03V0F4zjzJ5lkfnoCPXoHH7y1bEjeb5jimKQGtfC7jWvgxSE7O61+LRJt4MBHg3qs
         mLyiC+ffeduRIqUMFrRote/N92sreIhOmtN3v3JstcmhJRWo+rTejRHrbZ5leRmJAcfl
         jKQ2NUlmn4oRi6vPyl+hj2s26IeN/kGJELphRgYfE6ALBixIG+oQvHSAwdNPE17CeClM
         rzOLDHy5o/1hS951eLvrhdS8qZlcllsf9EymMo9SUKC4Uvx0DtyGQevkULHJAhO209Uz
         PRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwtKT3TLRrtzvoSqBBz0zTgfqFifuE6VoyUdNbDunc4=;
        b=Qc6cAovy2ZzIrPaV9gejQxyX/Fo8MNlrg6rPci9LCDvg8jnayqJtCtQfuCCJCoN/ze
         oA703QEn7akDK7SVqRj3ixUKiRVH4cwl/mia8kWWhlWqSbP8qq4VWDeF6rokly43wqHT
         KCkUUAQKV6G35fHXOsumsF2fBnuXEvUMQVOfQQ1mCjvAzvWG2OA1TwNOf0KtIcC5z4mI
         9YIhIODPkRbm1oE5MbROe/BNPxXPXs1QdqrxenuvrubC7XDGay+Eb4rCefUn9e03NSF0
         QvM6jm7Jo+j52+/C+B6SdKgkanHESEjutUM7Ui9cxkHIzvs8kUj7CabRjomaJEXj4P6U
         X4ug==
X-Gm-Message-State: ANhLgQ20m+FCKMBmapXntRlMNFRo3NibIX4K16VeVRgBkk3G7WH5eTQ/
        2cdXq6Y/rq4avGGm4NJv+fQDsA==
X-Google-Smtp-Source: ADFU+vsfCkZNAANMgmxHq7StxwCjju8knfcDnD5lzRbZBit1YecnrfC01TJe9+onxOHb/ndwRj4pAg==
X-Received: by 2002:adf:a348:: with SMTP id d8mr6758805wrb.83.1584553336425;
        Wed, 18 Mar 2020 10:42:16 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 01/21] clocksource/drivers/fttmr010: Parametrise shutdown
Date:   Wed, 18 Mar 2020 18:41:11 +0100
Message-Id: <20200318174131.20582-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

In preparation for supporting the ast2600 which uses a different method
to clear bits in the control register, use a callback for performing the
shutdown sequence.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191107094218.13210-2-joel@jms.id.au
---
 drivers/clocksource/timer-fttmr010.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index fadff7915dd9..c2d30eb9dc72 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -97,6 +97,7 @@ struct fttmr010 {
 	bool is_aspeed;
 	u32 t1_enable_val;
 	struct clock_event_device clkevt;
+	int (*timer_shutdown)(struct clock_event_device *evt);
 #ifdef CONFIG_ARM
 	struct delay_timer delay_timer;
 #endif
@@ -140,9 +141,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	if (fttmr010->is_aspeed) {
 		/*
@@ -183,9 +182,7 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
@@ -211,9 +208,7 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	/* Setup timer to fire at 1/HZ intervals. */
 	if (fttmr010->is_aspeed) {
@@ -350,6 +345,8 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
+	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
@@ -370,10 +367,10 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	fttmr010->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
 		CLOCK_EVT_FEAT_ONESHOT;
 	fttmr010->clkevt.set_next_event = fttmr010_timer_set_next_event;
-	fttmr010->clkevt.set_state_shutdown = fttmr010_timer_shutdown;
+	fttmr010->clkevt.set_state_shutdown = fttmr010->timer_shutdown;
 	fttmr010->clkevt.set_state_periodic = fttmr010_timer_set_periodic;
 	fttmr010->clkevt.set_state_oneshot = fttmr010_timer_set_oneshot;
-	fttmr010->clkevt.tick_resume = fttmr010_timer_shutdown;
+	fttmr010->clkevt.tick_resume = fttmr010->timer_shutdown;
 	fttmr010->clkevt.cpumask = cpumask_of(0);
 	fttmr010->clkevt.irq = irq;
 	clockevents_config_and_register(&fttmr010->clkevt,
-- 
2.17.1

