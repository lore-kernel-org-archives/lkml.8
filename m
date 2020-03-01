Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E60C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF75B24672
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 01:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm9Q1pq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCAB1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 20:27:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCAB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 20:26:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id q4so2756439pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 17:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZ98MAtmzJD3PkkfGRavMVXdDCFnsPgSryPFXXjh1aM=;
        b=fm9Q1pq8xRhFNXUyFMgfojMeobWVOKu2sLKo8bd8PeoJwJ0Jqd03QGcLUx3fYJwaUX
         mwfoUp0xbTksbxtCGiZn8ilxpaO7W5zUL4bigE9sbolFeebx5mgGxOS7kLiOjVsIDw7g
         unPchVp/1jFZ3VfLQKl8SZ3NbJpwaqJDKsH++PpJUJP4zQZMLqwWgdTPBOOAkVUDeME+
         eQItbEuaBAXIYzD43F/Uli5IEkLtH+v9FFeYKelBRx9FgCX4mDsOO7eKM0nk9XeUz5+p
         y1wGeqhMOxRQZe2KoyWTHt117D3HG0qnHraOA/yd5XcLAqKG85wf/Q84doZsWwA4ycs8
         8Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZ98MAtmzJD3PkkfGRavMVXdDCFnsPgSryPFXXjh1aM=;
        b=CqBoZXqDaVmQHOWPOXp0qOYNq5Y5QVYw15t1kuVOXr2Otf7osodFa3US2GNSreclUe
         Vlt3x4lpMQ6zunXOu/rGD4NBmbxV82qYR9EElsD7FUpdTzgoTCAV+qUQUQvMbUknThid
         kPexSMio/foq/5rLSNT+1yDZzAoI3YT0lZ7a3UFUZFHc7WcM8ivTAVTqi0vUwFTdAZz/
         +etg780eSLjzEY+lCYMkQy/GBCZ27DPgf7ALpQqGc/WGuFWMeovhLDrjSvDBgihnlcxb
         agt9+v0boQ4ZBHrdcVBkdOTSHLDhim75T2rPHMsnY2OwKqXBzZNu6Q3BiEcFAZsQ0Bw2
         G2tQ==
X-Gm-Message-State: APjAAAVX0LfqHLOopsbz2Fun++U8jl5a1VwYx8lnF2SSFHMFcQsqF0Lh
        jj0SJeCLdpeoJxkdl2ZsYEk=
X-Google-Smtp-Source: APXvYqyHe+nX8DM+EyFzGgX7ZTqN4LB1jGI04o9Tr2g1DG2kJSJIDbUw5y+DykDkZvZr3+9A//+vRQ==
X-Received: by 2002:a17:902:b783:: with SMTP id e3mr10295656pls.31.1583026017145;
        Sat, 29 Feb 2020 17:26:57 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id w2sm15728973pfw.43.2020.02.29.17.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 17:26:56 -0800 (PST)
Date:   Sun, 1 Mar 2020 06:56:55 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v5] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200301012655.GA6035@afzalpc>
References: <20200229153406.GA32479@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229153406.GA32479@afzalpc>
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

v5:
 * Revert to pr_err
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
index 71ddb4c98726..1c8e8a83c325 100644
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
+		pr_err("Failed to request irq %d (timer): %pe\n", TMR_IRQ_NUM,
+		       ERR_PTR(ret));
+	}
 
 	/* Restart mode, Enable int, Set clock source */
 	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
index eb6f16b0e2e6..fd1d9c915daa 100644
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
+		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_PIT1,
+		       ERR_PTR(ret));
+	}
 
 	clocksource_register_hz(&pit_clk, FREQ);
 }
diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
index 1b11e7bacab3..5ab81c9c552d 100644
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
+		pr_err("Failed to request irq %d (profile timer): %pe\n",
+		       MCF_IRQ_PROFILER, ERR_PTR(ret));
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
+		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_TIMER,
+		       ERR_PTR(r));
+	}
 
 	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
 
diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
index 227aa5d13709..b8301fddf901 100644
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
+		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_TIMER,
+		       ERR_PTR(r));
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
+		pr_err("Failed to request irq %d (profile timer): %pe\n",
+		       MCF_IRQ_PROFILER, ERR_PTR(ret));
+	}
 }
 
 /***************************************************************************/
-- 
2.25.1

