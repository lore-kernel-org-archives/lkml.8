Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F28C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991EC24680
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr+2GaJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgB2PeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:34:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34836 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB2PeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:34:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so2452612plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 07:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rcsfQ4b9lT5hVSYtCF0fUzYPpToVmNPhI/nePHcpJ3A=;
        b=dr+2GaJyJLQS1L+Pr3nwcZn8oRCNzOTtWXFBRyID62AvZIZE5bYoVqqEpAPL51goJO
         3QfED8UDOSJGfgjnaOdXn6xf6DI4qIGtx0Z04ULFVCtWkeW/Ch54/P205OSwkAYKqTJR
         BtT3ZTmecPm2pXZ+wZgY5TP7JTx9bD7b4U0yXidkHqOWcxLwFoVfqdo+0ngW6cxzC8bB
         i7K+Db6HtFYWjwuGZiHwx8EnA5/hiG1xL/IurlrqfEoTRUXHFy5QdofAmW5noKsx2f/L
         m28VMgdLdApap5L8m+jz5jq505UvsQcitwNEfR+5naI/d6GRXNzyzDk1+eeBMha9UC10
         2kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcsfQ4b9lT5hVSYtCF0fUzYPpToVmNPhI/nePHcpJ3A=;
        b=Nyc28jIG6CHiyIXG9eK17dXPPe943WIbamKz0/FFuliqdVJdrkdiWFfbUXTFdwAU3q
         z2w0OwMDMJAaOJk0967CPZWEbGVgT7DpqQmCMDhx/9pXZiGqOTU4gCshszqOELF6A6gj
         ib7hu/NiI8UD7knSOFXoVt68mHHW6u7JYZB4liCSZfKMnSo5keHXDJ74iugIW35ktwdr
         p0MuOetTBGf7mgJ3CMt4Yzb02QJRS5f8H2mpx65yv+C7RE18mReH6TCO9FFTVjQAockR
         jsKGU3aF18wdHpdmKM4QM3ieBesrnesF0sWwlbn3AOLdYPMtP4bJks2tWdCUN9nSZ+v2
         FWMA==
X-Gm-Message-State: APjAAAU16giEibwxdPpTN9e9KzuRKUI9BCOxHDAIkDPtkw+E7JGJp20U
        fSve1/+deDPlOpR5Qe24ai1YBxmk
X-Google-Smtp-Source: APXvYqx5EraYzaZTFtlw1qwdhLFpyT334Eyy/rCEYZN+XnblmA+jYC15/QwY3O90chZnRvwCt30d4g==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr9228507plt.306.1582990448461;
        Sat, 29 Feb 2020 07:34:08 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id k24sm11630815pgm.61.2020.02.29.07.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 07:34:07 -0800 (PST)
Date:   Sat, 29 Feb 2020 21:04:06 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200229153406.GA32479@afzalpc>
References: <20200229125650.3239-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229125650.3239-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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

v4:
 * Add modifications done per v3, but missed at couple of places
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
 arch/m68k/coldfire/sltimers.c | 29 +++++++++++++++--------------
 arch/m68k/coldfire/timers.c   | 31 +++++++++++++++----------------
 4 files changed, 44 insertions(+), 48 deletions(-)

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
index 1b11e7bacab3..95b9d1557ee9 100644
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
@@ -126,6 +121,8 @@ static struct clocksource mcfslt_clk = {
 
 void hw_timer_init(irq_handler_t handler)
 {
+	int r;
+
 	mcfslt_cycles_per_jiffy = MCF_BUSCLK / HZ;
 	/*
 	 *	The coldfire slice timer (SLT) runs from STCNT to 0 included,
@@ -140,7 +137,11 @@ void hw_timer_init(irq_handler_t handler)
 	mcfslt_cnt = mcfslt_cycles_per_jiffy;
 
 	timer_interrupt = handler;
-	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
+	r = request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL);
+	if (r) {
+		pr_debug("Failed to request irq %d (timer): %pe\n",
+			 MCF_IRQ_TIMER, ERR_PTR(r));
+	}
 
 	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
 
diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
index 227aa5d13709..0c12d6b64a76 100644
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
@@ -170,14 +168,10 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction coldfire_profile_irq = {
-	.name	 = "profile timer",
-	.flags	 = IRQF_TIMER,
-	.handler = coldfire_profile_tick,
-};
-
 void coldfire_profile_init(void)
 {
+	int ret;
+
 	printk(KERN_INFO "PROFILE: lodging TIMER2 @ %dHz as profile timer\n",
 	       PROFILEHZ);
 
@@ -188,7 +182,12 @@ void coldfire_profile_init(void)
 	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
 		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
 
-	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
+	ret = request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
+			  "profile timer", NULL);
+	if (ret) {
+		pr_debug("Failed to request irq %d (profile timer): %pe\n",
+			 MCF_IRQ_PROFILER, ERR_PTR(ret));
+	}
 }
 
 /***************************************************************************/
-- 
2.25.1

