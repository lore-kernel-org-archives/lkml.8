Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842E620786
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGJXI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:08:29 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37781 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgGJXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:08:24 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A17E51BF204;
        Fri, 10 Jul 2020 23:08:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 7/9] clocksource/drivers/timer-atmel-tcb: stop using the 32kHz for clockevents
Date:   Sat, 11 Jul 2020 01:08:11 +0200
Message-Id: <20200710230813.1005150-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710230813.1005150-1-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using the slow clock as the clock source for 32 bit counters because
even at 10MHz, they are able to handle delays up to two minutes. This
provides a way better resolution.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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
2.26.2

