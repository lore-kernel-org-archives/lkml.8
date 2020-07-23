Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7B5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0081E2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xemi9yha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgGWP1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgGWP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B3C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r4so2608515wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7i5aCeoYGYSqIOTMXORInZCKzVcS5GG+dOuM60dxhZQ=;
        b=xemi9yha2Bu2YaifaLGhS8NaMOJSI8JL+5c7Tcnb09hBqkStXsci5/GPJLpG0iu/rq
         vhiineqjdk6tfQmkwgtPHA0WArw10U7D8AGp58CIUb+m2MXoUY+gUEVnn3bafuhEQP3l
         IpanFQgH+FMkgiffo24b68yeQQKTUzxB8ccdv1HNWicUZcoodOPBioYI2f8V3Qx1ZKuY
         bWDiGf/TB9deRhjwtEJHRezYi0cwy+x12EMYIrWCampfcUdrbInVC60mC7gktETGWOU9
         chHLQOOeHWybHBzB1PLQ4weCJBK05dcopHYtGeqK8yw42dlBvbxPR1N2DAyescEylFdZ
         +U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7i5aCeoYGYSqIOTMXORInZCKzVcS5GG+dOuM60dxhZQ=;
        b=IlNkUnYjCp3pr/TXBW5VcnPpXzQRtfbWvswYagaiv2CmJt2mH19vgP/j+XuB2QXGv6
         DBRSC8Ak0GyPJJZNh6v0CvO9PwjQ9gSi+euqr0+ajPsvLGX2HromXDJLe6FiNulwnhl4
         GTd4yrNemrkOjg12IrdIDJIZgczbv4Qh6iVUvrH5WOGtil0x7I6JgoAC7/rDd5GlqM2t
         cgHasNZYRnImKB1JuTtRy2Jh5uGR0jp4megFQ0bHQrrjowPewJIYmoINS4TuQpMglX0j
         9ZOe70AZB6SVbxzt+I84L6j5pm1yS7vu9W1EhzXyvzbbjNLTok/P9/y8TmP0iJNUa9y2
         WZKw==
X-Gm-Message-State: AOAM532OwBEjC6lEI5Kj1cQ6bTWEejBl5lXs1zdYhkrPuWLPJM4D8BER
        aK7u2OcPtJKWfFu0uvruKSyNiQ==
X-Google-Smtp-Source: ABdhPJw7BQRyrbXR6RkFmX7taaPIvp1bgn/wVN3bL3Kqz8/9jzo2eGS5IZfe6ngpBkTCqn86tu6c7w==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr4446980wrc.257.1595518021896;
        Thu, 23 Jul 2020 08:27:01 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 07/16] clocksource/drivers/timer-atmel-tcb: Stop using the 32kHz for clockevents
Date:   Thu, 23 Jul 2020 17:26:27 +0200
Message-Id: <20200723152639.639771-7-daniel.lezcano@linaro.org>
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

Stop using the slow clock as the clock source for 32 bit counters because
even at 10MHz, they are able to handle delays up to two minutes. This
provides a way better resolution.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-8-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 63 ++++++++++++++-------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 423af2f9835f..7a6474acc774 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -27,9 +27,10 @@
  *   - Some chips support 32 bit counter. A single channel is used for
  *     this 32 bit free-running counter. the second channel is not used.
  *
- *   - The third channel may be used to provide a 16-bit clockevent
- *     source, used in either periodic or oneshot mode.  This runs
- *     at 32 KiHZ, and can handle delays of up to two seconds.
+ *   - The third channel may be used to provide a clockevent source, used in
+ *   either periodic or oneshot mode. For 16-bit counter its runs at 32 KiHZ,
+ *   and can handle delays of up to two seconds. For 32-bit counters, it runs at
+ *   the same rate as the clocksource
  *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
@@ -47,6 +48,8 @@ static struct
 } tcb_cache[3];
 static u32 bmr_cache;
 
+static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
+
 static u64 tc_get_cycles(struct clocksource *cs)
 {
 	unsigned long	flags;
@@ -143,6 +146,7 @@ static unsigned long notrace tc_delay_timer_read32(void)
 struct tc_clkevt_device {
 	struct clock_event_device	clkevt;
 	struct clk			*clk;
+	u32				rate;
 	void __iomem			*regs;
 };
 
@@ -151,13 +155,6 @@ static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
 	return container_of(clkevt, struct tc_clkevt_device, clkevt);
 }
 
-/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
- * because using one of the divided clocks would usually mean the
- * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
- *
- * A divided clock could be good for high resolution timers, since
- * 30.5 usec resolution can seem "low".
- */
 static u32 timer_clock;
 
 static int tc_shutdown(struct clock_event_device *d)
@@ -183,7 +180,7 @@ static int tc_set_oneshot(struct clock_event_device *d)
 
 	clk_enable(tcd->clk);
 
-	/* slow clock, count up to RC, then irq and stop */
+	/* count up to RC, then irq and stop */
 	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
 		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -205,10 +202,10 @@ static int tc_set_periodic(struct clock_event_device *d)
 	 */
 	clk_enable(tcd->clk);
 
-	/* slow clock, count up to RC, then irq and restart */
+	/* count up to RC, then irq and restart */
 	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 		     regs + ATMEL_TC_REG(2, CMR));
-	writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+	writel((tcd->rate + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
 
 	/* Enable clock and interrupts on RC compare */
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -256,47 +253,55 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
 
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
 	int ret;
 	struct clk *t2_clk = tc->clk[2];
 	int irq = tc->irq[2];
-
-	ret = clk_prepare_enable(tc->slow_clk);
-	if (ret)
-		return ret;
+	int bits = tc->tcb_config->counter_width;
 
 	/* try to enable t2 clk to avoid future errors in mode change */
 	ret = clk_prepare_enable(t2_clk);
-	if (ret) {
-		clk_disable_unprepare(tc->slow_clk);
+	if (ret)
 		return ret;
-	}
-
-	clk_disable(t2_clk);
 
 	clkevt.regs = tc->regs;
 	clkevt.clk = t2_clk;
 
-	timer_clock = clk32k_divisor_idx;
+	if (bits == 32) {
+		timer_clock = divisor_idx;
+		clkevt.rate = clk_get_rate(t2_clk) / atmel_tcb_divisors[divisor_idx];
+	} else {
+		ret = clk_prepare_enable(tc->slow_clk);
+		if (ret) {
+			clk_disable_unprepare(t2_clk);
+			return ret;
+		}
+
+		clkevt.rate = clk_get_rate(tc->slow_clk);
+		timer_clock = ATMEL_TC_TIMER_CLOCK5;
+	}
+
+	clk_disable(t2_clk);
 
 	clkevt.clkevt.cpumask = cpumask_of(0);
 
 	ret = request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
 	if (ret) {
 		clk_unprepare(t2_clk);
-		clk_disable_unprepare(tc->slow_clk);
+		if (bits != 32)
+			clk_disable_unprepare(tc->slow_clk);
 		return ret;
 	}
 
-	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, clkevt.rate, 1, BIT(bits) - 1);
 
 	return ret;
 }
 
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
 
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
 	/* NOTHING */
 	return 0;
@@ -346,8 +351,6 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
-
 static struct atmel_tcb_config tcb_rm9200_config = {
 	.counter_width = 16,
 };
@@ -472,7 +475,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
-	ret = setup_clkevents(&tc, ATMEL_TC_TIMER_CLOCK5);
+	ret = setup_clkevents(&tc, best_divisor_idx);
 	if (ret)
 		goto err_unregister_clksrc;
 
-- 
2.25.1

