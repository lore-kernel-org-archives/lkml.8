Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4815C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4FC246AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkwmopvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgB2M44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:56:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38378 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgB2M44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:56:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so2985109pgn.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NX9ENWB57ncJ2ZQkc2q1+k0FDL3Rjf+Dpqv+RftvUyA=;
        b=tkwmopvCQJRyHkLmC7aKrjeAUO/sgJGTtza0BbhBzlE9A4cZ7URqVocX3QeFC243wn
         BEzTTz7G2CEs6KFu/P8NQJmhfDD1iBfdbrFrXq7B12XOtWYYbUboI9OAt5Q7D7RwA5k6
         k+mXJjobPT4ngeV3gzqjujyufMyYjsHo2vow8+lIk1L9t8Fl5vpDkDHeOUeICnREeoyw
         D8iq4OFqfHbAhyl8g0VCTyTNEJP75wCBa7MiIHYqHlMn62lIGGDm5URZcqqLBK1njCkf
         3Htlqfna4x/y82O5Wr6BvFCyhvcYhMmtOzIhj41N2UYZMsVa8BH+4vkb6n1hUnsUk9YS
         UafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NX9ENWB57ncJ2ZQkc2q1+k0FDL3Rjf+Dpqv+RftvUyA=;
        b=iGZHIvsrKGXHCUSLBDmdLy2Gh5i7PKHO76+t4wxNxahmCFh/hgLYrFbOXVp6SwzMTw
         xUWmDZxYBW1cx+huOEQRKPyVP4lWdgC3gdS/ZUVAV2xy16D8jIkMaGbO4j2y1d+bumtl
         Xu/cXXOVIAWGmEk33ZraOL6l35mkzmc5+67XWMnUQW7PgIZh6klTFhLZLNuYQq6TzacX
         PZyqvJS2xSu4WrpuHVVOkR00Eo+yjJOpXOuSnlQDEjthTCTWD6yuWze6KZrJBs6rQPtr
         kIU4kXfYdInQ0xJ3oEay4XWK85xFvPBR2ubZtRjhTyegxVLgIc0hhCPqHNCzeM1MYJHX
         MFdw==
X-Gm-Message-State: APjAAAV/6Y++cOloPwalPISvFCXllRVWECwcOxbiiefomnvRIYEEC7dG
        1OjySl5bFe4/AykJ6SwcjBo=
X-Google-Smtp-Source: APXvYqzTFAa4j0rGV9i/qX7J+L4IMStoWZUD34qzjZcJQ4mO14BcoUgLzdKYtSpYWDXLOJmZmeyFBw==
X-Received: by 2002:a63:ad46:: with SMTP id y6mr6932324pgo.11.1582981015108;
        Sat, 29 Feb 2020 04:56:55 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id u24sm13914237pgo.83.2020.02.29.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 04:56:54 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] m68k: Replace setup_irq() by request_irq()
Date:   Sat, 29 Feb 2020 18:26:50 +0530
Message-Id: <20200229125650.3239-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Hi Greg,

i have removed your Tested-by due to the modifications, if possible,
please test & let me know.

Regards
afzal

v3:
 * Instead of tree wide series, arch specific patch (per tglx)
 * Strip irrelevant portions & more tweaking in commit message
 * Remove name indirection in pr_err string, print irq # and
   symbolic error name in case of error
 * s/pr_err/pr_debug
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage
 * remove now irrelevant comment lines at 3 places

 arch/m68k/68000/timers.c      | 16 +++++++---------
 arch/m68k/coldfire/pit.c      | 16 +++++++---------
 arch/m68k/coldfire/sltimers.c | 24 ++++++++++--------------
 arch/m68k/coldfire/timers.c   | 26 ++++++++++----------------
 4 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
index 71ddb4c98726..07a389a287e4 100644
--- a/arch/m68k/68000/timers.c
+++ b/arch/m68k/68000/timers.c
@@ -68,14 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction m68328_timer_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = hw_tick,
-};
-
-/***************************************************************************/
-
 static u64 m68328_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
@@ -102,11 +94,17 @@ static struct clocksource m68328_clk = {
 
 void hw_timer_init(irq_handler_t handler)
 {
+	int ret;
+
 	/* disable timer 1 */
 	TCTL = 0;
 
 	/* set ISR */
-	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
+	ret = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
+	if (ret) {
+		pr_debug("Failed to request irq %d (timer): %pe\n", TMR_IRQ_NUM,
+			 ERR_PTR(ret));
+	}
 
 	/* Restart mode, Enable int, Set clock source */
 	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
index eb6f16b0e2e6..482678cf4819 100644
--- a/arch/m68k/coldfire/pit.c
+++ b/arch/m68k/coldfire/pit.c
@@ -111,14 +111,6 @@ static irqreturn_t pit_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction pit_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = pit_tick,
-};
-
-/***************************************************************************/
-
 static u64 pit_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
@@ -146,6 +138,8 @@ static struct clocksource pit_clk = {
 
 void hw_timer_init(irq_handler_t handler)
 {
+	int ret;
+
 	cf_pit_clockevent.cpumask = cpumask_of(smp_processor_id());
 	cf_pit_clockevent.mult = div_sc(FREQ, NSEC_PER_SEC, 32);
 	cf_pit_clockevent.max_delta_ns =
@@ -156,7 +150,11 @@ void hw_timer_init(irq_handler_t handler)
 	cf_pit_clockevent.min_delta_ticks = 0x3f;
 	clockevents_register_device(&cf_pit_clockevent);
 
-	setup_irq(MCF_IRQ_PIT1, &pit_irq);
+	ret = request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL);
+	if (ret) {
+		pr_debug("Failed to request irq %d (timer): %pe\n",
+			 MCF_IRQ_PIT1, ERR_PTR(ret));
+	}
 
 	clocksource_register_hz(&pit_clk, FREQ);
 }
diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
index 1b11e7bacab3..087c68d2d909 100644
--- a/arch/m68k/coldfire/sltimers.c
+++ b/arch/m68k/coldfire/sltimers.c
@@ -50,18 +50,19 @@ irqreturn_t mcfslt_profile_tick(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mcfslt_profile_irq = {
-	.name	 = "profile timer",
-	.flags	 = IRQF_TIMER,
-	.handler = mcfslt_profile_tick,
-};
-
 void mcfslt_profile_init(void)
 {
+	int ret;
+
 	printk(KERN_INFO "PROFILE: lodging TIMER 1 @ %dHz as profile timer\n",
 	       PROFILEHZ);
 
-	setup_irq(MCF_IRQ_PROFILER, &mcfslt_profile_irq);
+	ret = request_irq(MCF_IRQ_PROFILER, mcfslt_profile_tick, IRQF_TIMER,
+			  "profile timer", NULL);
+	if (ret) {
+		pr_debug("Failed to request irq %d (profile timer): %pe\n",
+			 MCF_IRQ_PROFILER, ERR_PTR(ret));
+	}
 
 	/* Set up TIMER 2 as high speed profile clock */
 	__raw_writel(MCF_BUSCLK / PROFILEHZ - 1, PA(MCFSLT_STCNT));
@@ -92,12 +93,6 @@ static irqreturn_t mcfslt_tick(int irq, void *dummy)
 	return timer_interrupt(irq, dummy);
 }
 
-static struct irqaction mcfslt_timer_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = mcfslt_tick,
-};
-
 static u64 mcfslt_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
@@ -140,7 +135,8 @@ void hw_timer_init(irq_handler_t handler)
 	mcfslt_cnt = mcfslt_cycles_per_jiffy;
 
 	timer_interrupt = handler;
-	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
+	if (request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("%s: request_irq() failed\n", "timer");
 
 	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
 
diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
index 227aa5d13709..eb442a0e3b50 100644
--- a/arch/m68k/coldfire/timers.c
+++ b/arch/m68k/coldfire/timers.c
@@ -82,14 +82,6 @@ static irqreturn_t mcftmr_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction mcftmr_timer_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = mcftmr_tick,
-};
-
-/***************************************************************************/
-
 static u64 mcftmr_read_clk(struct clocksource *cs)
 {
 	unsigned long flags;
@@ -118,6 +110,8 @@ static struct clocksource mcftmr_clk = {
 
 void hw_timer_init(irq_handler_t handler)
 {
+	int r;
+
 	__raw_writew(MCFTIMER_TMR_DISABLE, TA(MCFTIMER_TMR));
 	mcftmr_cycles_per_jiffy = FREQ / HZ;
 	/*
@@ -134,7 +128,11 @@ void hw_timer_init(irq_handler_t handler)
 
 	timer_interrupt = handler;
 	init_timer_irq();
-	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
+	r = request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL);
+	if (r) {
+		pr_debug("Failed to request irq %d (timer): %pe\n",
+			 MCF_IRQ_TIMER, ERR_PTR(r));
+	}
 
 #ifdef CONFIG_HIGHPROFILE
 	coldfire_profile_init();
@@ -170,12 +168,6 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction coldfire_profile_irq = {
-	.name	 = "profile timer",
-	.flags	 = IRQF_TIMER,
-	.handler = coldfire_profile_tick,
-};
-
 void coldfire_profile_init(void)
 {
 	printk(KERN_INFO "PROFILE: lodging TIMER2 @ %dHz as profile timer\n",
@@ -188,7 +180,9 @@ void coldfire_profile_init(void)
 	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
 		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
 
-	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
+	if (request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
+			"profile timer", NULL))
+		pr_err("%s: request_irq() failed\n", "profile timer");
 }
 
 /***************************************************************************/
-- 
2.25.1

