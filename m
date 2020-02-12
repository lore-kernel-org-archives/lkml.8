Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA89BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A2520661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axKFYFpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBLIDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:03:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:03:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so850089pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wEZlgFm4FNfzz/lXt6jpAfiPKuyVHar0QeF+K8/f4Pg=;
        b=axKFYFpugWMCeCSbnL9lxqZCEt6U5PV2TyJ5/Gb2FFMk2gQw8aZoGAC53qBXNxPc+9
         f0p5I8y10USvjuH/P3aUXX0TjgvM4vfN+fL22IGpLhPZi1dzavndMM5KwNqBHADcrq9u
         OSN24xNN806OmOwdY0r1q65IW96+GqiJ1ntJTxWIegT6tk1h/1IJwviDB0MC+178xKt0
         aVUZEe+hYHACM+Qgjx/udYYdfgP9gEHS9jx3V3c2YMbo2oeBP0qWb/3yf98mwLOgBaM9
         dfUQn8E0rJMhNyf/iW8L6xS+Jp1KTjiVz1+8WyStA48waiF0eSAK7dTpvGckxGLwflOG
         LUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wEZlgFm4FNfzz/lXt6jpAfiPKuyVHar0QeF+K8/f4Pg=;
        b=hyCpgwH724pUuUhGafKnpCucQVgCEJEbBsoIm8IjikY4jA5utltqOrPe6OKlzS89dP
         c1jpuxKBmordCYjLN5V8Qv0u3GubQvk5Qjq6VyvWNDcB5TnAJEQHQIewShlDTdoxs/tz
         z6wybQE+lAS2Mn+oc2fIOQhJUOkFeCsU3H1QJbLSL5tV8zhjqGsqBq7noNmcSwlmixM1
         Hko/CY6t+mq0bFvkjJSTmF5CGjs6adILZgZAhpvw2UOhdg+tJFbqKL542lXeBQADdZDe
         VJuk5bqi0V1/3wnmDEZaEgh1PcRxEWUtxstvcv0CT9yy9LV+tq5hcF0qCmFeuwKNVdVi
         lA5w==
X-Gm-Message-State: APjAAAXMnpB9iBWx8yKq6BiFm3Kam15PZm3wpDl0bG3+F5jpGrsmyn8F
        OJEn7YfxQUfHKhw0eSai/v0=
X-Google-Smtp-Source: APXvYqxbgQBfm2Wxs4LZzJSvAgO6gppgc4vxA4JaRT+DbMdiQwqWI8Y9z4Gssuy2bWR7wmKRt0zLaA==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr10874713pgp.65.1581494612586;
        Wed, 12 Feb 2020 00:03:32 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id v25sm6870937pfe.147.2020.02.12.00.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:03:32 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:33:30 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <1941c51a3237c4e9df6d9a5b87615cd1bba572dc.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/m68k/68000/timers.c      |  9 ++-------
 arch/m68k/coldfire/pit.c      |  9 ++-------
 arch/m68k/coldfire/sltimers.c | 19 +++++--------------
 arch/m68k/coldfire/timers.c   | 19 +++++--------------
 4 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
index 71ddb4c98726..7a55d664592e 100644
--- a/arch/m68k/68000/timers.c
+++ b/arch/m68k/68000/timers.c
@@ -68,12 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction m68328_timer_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = hw_tick,
-};
-
 /***************************************************************************/
 
 static u64 m68328_read_clk(struct clocksource *cs)
@@ -106,7 +100,8 @@ void hw_timer_init(irq_handler_t handler)
 	TCTL = 0;
 
 	/* set ISR */
-	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
+	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("request_irq() on %s failed\n", "timer");
 
 	/* Restart mode, Enable int, Set clock source */
 	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
index eb6f16b0e2e6..d09e253abe5a 100644
--- a/arch/m68k/coldfire/pit.c
+++ b/arch/m68k/coldfire/pit.c
@@ -111,12 +111,6 @@ static irqreturn_t pit_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction pit_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = pit_tick,
-};
-
 /***************************************************************************/
 
 static u64 pit_read_clk(struct clocksource *cs)
@@ -156,7 +150,8 @@ void hw_timer_init(irq_handler_t handler)
 	cf_pit_clockevent.min_delta_ticks = 0x3f;
 	clockevents_register_device(&cf_pit_clockevent);
 
-	setup_irq(MCF_IRQ_PIT1, &pit_irq);
+	if (request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("request_irq() on %s failed\n", "timer");
 
 	clocksource_register_hz(&pit_clk, FREQ);
 }
diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
index 1b11e7bacab3..2188a21e5413 100644
--- a/arch/m68k/coldfire/sltimers.c
+++ b/arch/m68k/coldfire/sltimers.c
@@ -50,18 +50,14 @@ irqreturn_t mcfslt_profile_tick(int irq, void *dummy)
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
 	printk(KERN_INFO "PROFILE: lodging TIMER 1 @ %dHz as profile timer\n",
 	       PROFILEHZ);
 
-	setup_irq(MCF_IRQ_PROFILER, &mcfslt_profile_irq);
+	if (request_irq(MCF_IRQ_PROFILER, mcfslt_profile_tick, IRQF_TIMER,
+			"profile timer", NULL))
+		pr_err("request_irq() on %s failed\n", "profile timer");
 
 	/* Set up TIMER 2 as high speed profile clock */
 	__raw_writel(MCF_BUSCLK / PROFILEHZ - 1, PA(MCFSLT_STCNT));
@@ -92,12 +88,6 @@ static irqreturn_t mcfslt_tick(int irq, void *dummy)
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
@@ -140,7 +130,8 @@ void hw_timer_init(irq_handler_t handler)
 	mcfslt_cnt = mcfslt_cycles_per_jiffy;
 
 	timer_interrupt = handler;
-	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
+	if (request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("request_irq() on %s failed\n", "timer");
 
 	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
 
diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
index 227aa5d13709..f384e92d8b1c 100644
--- a/arch/m68k/coldfire/timers.c
+++ b/arch/m68k/coldfire/timers.c
@@ -82,12 +82,6 @@ static irqreturn_t mcftmr_tick(int irq, void *dummy)
 
 /***************************************************************************/
 
-static struct irqaction mcftmr_timer_irq = {
-	.name	 = "timer",
-	.flags	 = IRQF_TIMER,
-	.handler = mcftmr_tick,
-};
-
 /***************************************************************************/
 
 static u64 mcftmr_read_clk(struct clocksource *cs)
@@ -134,7 +128,8 @@ void hw_timer_init(irq_handler_t handler)
 
 	timer_interrupt = handler;
 	init_timer_irq();
-	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
+	if (request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("request_irq() on %s failed\n", "timer");
 
 #ifdef CONFIG_HIGHPROFILE
 	coldfire_profile_init();
@@ -170,12 +165,6 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
 
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
@@ -188,7 +177,9 @@ void coldfire_profile_init(void)
 	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
 		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
 
-	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
+	if (request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
+			"profile timer", NULL))
+		pr_err("request_irq() on %s failed\n", "profile timer");
 }
 
 /***************************************************************************/
-- 
2.24.1

