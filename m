Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB0AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9187E20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JA0vfdWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCRRmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42640 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so31569896wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11KtN2tfBF8mWAfeSnPKTL3ojrjHIEnffXWT3p6cKhU=;
        b=JA0vfdWKEFt/83FtC+ZAiIE9aPaWBH2nDMLKDWn7xMnKO63UYQ6aQATkod7ozmTqCh
         OUXyixv7zWI8sIAqlGdgO6eh+DhyQCe6znUDBkwC9ySBaFAmUrr6MPETV1okFiTozvxz
         34u3LZ5GuIZGw9zN8J9NusbQKITmMEac5rX9zy6NJL33rxNDKcFawT2RjDRH2yg6AxX1
         S0ecE1/cI/wazgo0rXkeqhnRadTvTM84AIDNjv31+wE7EI5uZFo9uTeTKjzuZlKZW4jK
         zR7UCKFGeeo0cNInAZ2afDaCnSqu9q5LRyuI5NeJtPtxroGTTz5zKvpxAAG/w7m/CqJ2
         VlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11KtN2tfBF8mWAfeSnPKTL3ojrjHIEnffXWT3p6cKhU=;
        b=PjnZr9t8AsM0w/RdVz9Ecp/COePp/HijZeHxfVE9/0mGQz3gALUaiIUJBUgJc3whtV
         eHFdqwmXJhPeYhc0MqSiKShMzIq6NCklm6ytdEM44JvyWOla9Pkt/70x9Ktxo/g8LMCb
         vEieFOo1rQ9vU6WJZN8Bqsl8uxgUJJZBKGbqeY0KX57k1w5h8Ssb99mWJM35iTnwFmu8
         jiH+9BPZMt+Tj13/6KTPYLpQeaRN4MUNePPyc3tuNPd3TZWd1GhNVM7eHXOzu4eoAZlM
         zSkgyAmKU2zFfur0AQRjjFPwFkTr/CmFzbVYuwvrSJIcb6kouChZH0xqlCwO6S9fgiQw
         qghw==
X-Gm-Message-State: ANhLgQ3RJq6sckF69lvoBWm5nyfS9M/ULvdWg/sIoBWbtgbB/6zWrXYH
        G90qrCHpgmvmTZB8i1EuRb7j9Q==
X-Google-Smtp-Source: ADFU+vucoWXNHYYZ+ob/BVDAKR0hBJs8bxcjaTBc7G2PpJLc1jCsLCV7hRZu3wWyWVJwlunX4eL6DQ==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr6667102wro.224.1584553338309;
        Wed, 18 Mar 2020 10:42:18 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 02/21] clocksource/drivers/fttmr010: Set interrupt and shutdown
Date:   Wed, 18 Mar 2020 18:41:12 +0100
Message-Id: <20200318174131.20582-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

In preparation for supporting the ast2600, pass the shutdown and
interrupt functions to the common init callback.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191107094218.13210-3-joel@jms.id.au
---
 drivers/clocksource/timer-fttmr010.c | 51 +++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c2d30eb9dc72..edb1d5f193f5 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -37,6 +37,11 @@
 #define TIMER3_MATCH2		(0x2c)
 #define TIMER_CR		(0x30)
 
+/*
+ * Control register set to clear for ast2600 only.
+ */
+#define AST2600_TIMER_CR_CLR	(0x3c)
+
 /*
  * Control register (TMC30) bit fields for fttmr010/gemini/moxart timers.
  */
@@ -163,6 +168,16 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
+static int ast2600_timer_shutdown(struct clock_event_device *evt)
+{
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+
+	/* Stop */
+	writel(fttmr010->t1_enable_val, fttmr010->base + AST2600_TIMER_CR_CLR);
+
+	return 0;
+}
+
 static int fttmr010_timer_shutdown(struct clock_event_device *evt)
 {
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
@@ -244,7 +259,21 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
+static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+
+	writel(0x1, fttmr010->base + TIMER_INTR_STATE);
+
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static int __init fttmr010_common_init(struct device_node *np,
+		bool is_aspeed,
+		int (*timer_shutdown)(struct clock_event_device *),
+		irq_handler_t irq_handler)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -345,7 +374,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
-	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+	fttmr010->timer_shutdown = timer_shutdown;
 
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
@@ -354,7 +383,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret = request_irq(irq, fttmr010_timer_interrupt, IRQF_TIMER,
+	ret = request_irq(irq, irq_handler, IRQF_TIMER,
 			  "FTTMR010-TIMER1", &fttmr010->clkevt);
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
@@ -401,14 +430,25 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	return ret;
 }
 
+static __init int ast2600_timer_init(struct device_node *np)
+{
+	return fttmr010_common_init(np, true,
+			ast2600_timer_shutdown,
+			ast2600_timer_interrupt);
+}
+
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true);
+	return fttmr010_common_init(np, true,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false);
+	return fttmr010_common_init(np, false,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
@@ -416,3 +456,4 @@ TIMER_OF_DECLARE(gemini, "cortina,gemini-timer", fttmr010_timer_init);
 TIMER_OF_DECLARE(moxart, "moxa,moxart-timer", fttmr010_timer_init);
 TIMER_OF_DECLARE(ast2400, "aspeed,ast2400-timer", aspeed_timer_init);
 TIMER_OF_DECLARE(ast2500, "aspeed,ast2500-timer", aspeed_timer_init);
+TIMER_OF_DECLARE(ast2600, "aspeed,ast2600-timer", ast2600_timer_init);
-- 
2.17.1

