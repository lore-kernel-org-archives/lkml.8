Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF3C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50B92071C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzQsanbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXAuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:50:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43173 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:50:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so4442787pfh.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZS6fQMh3ZMPAk3llNcuEIbSQHZt9MdrkgVHpIvIjCFg=;
        b=uzQsanbd/YDvNOgSm5ga4nhJTE+NWe8mypiEmXRX7VkIdQhZwfIbWYhxL7I6njAxrd
         4U77ni86HljVXgZghK6iVBFqjMbd1rH2Q9mwsem8fSecveprSw0FwPidP9WfMsDlazTY
         fzHVNlM5enZ+6vaCjh7fFg2TEqZDQCVRg/M/kvSwSXOPDgBCgXyuGBTA7PB0XSylu0OT
         23AdkDeqyIYD6PRSsD0aDbtO7CpJU4n3u6ZeSz9NYxMvkesdegCZslR7Vyttvkmqg8Op
         jNxl4vTnpM30hNP/xsnmAkiJOrujsIS7wCYZ5qg2ndD45AfitpLWMAETKeFxSd89YM7H
         hLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZS6fQMh3ZMPAk3llNcuEIbSQHZt9MdrkgVHpIvIjCFg=;
        b=VY5tOf6xT9cMGxcQkd4tDB8fFuqBiP+d0Vg9ZbTi6U9hXPu600Zt9hvlnifuUlHMh1
         wCx0fCrvK3x6v/VKGvwHx5UpMT35NFzihk50KuZ8jAuAncN/JlEmc4aUXlkCv1r7Ox1N
         g+i0SI8PJWaafxTny5OYkrO+jmL9KNwrqtyaMHhAlkH9+ZB6uXkhZiAJS8gdXMVc6GEZ
         Tj3q3gtzSrn5/dFrKlPQyJ0kjXeDllf72gU87ecg6epgvcGl7tcy3BzEJY3IG+vhdSSG
         X2eCf2M5MU8oqbgtkg3LUQZhSjhlYOcQBq/lgxLWQ4TyfrNy0Kz7FHw6D5QXTxqsaB9P
         HK6w==
X-Gm-Message-State: APjAAAUb2lAf9UqJnr4nOz1TMemYR8wLBh8o2LZgFnkjaB8SWalJl20k
        CxEIjRWpBPO2+rcveUtA38pV+z1zRy8=
X-Google-Smtp-Source: APXvYqxShtyB0IiNDxLVXIkPIBnFnYy6WJ2eIMlfZ5okPv3Mfw4a0C9b5xo/rO9B6w2xyf+2p+bsdQ==
X-Received: by 2002:a62:1dca:: with SMTP id d193mr50200036pfd.140.1582505412965;
        Sun, 23 Feb 2020 16:50:12 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id o6sm9959665pgg.37.2020.02.23.16.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:50:12 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:20:11 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Tested-by: Greg Ungerer <gerg@linux-m68k.org> # ColdFire
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage
 * remove now irrelevant comment lines at 3 places

 arch/m68k/68000/timers.c      | 11 ++---------
 arch/m68k/coldfire/pit.c      | 11 ++---------
 arch/m68k/coldfire/sltimers.c | 19 +++++--------------
 arch/m68k/coldfire/timers.c   | 21 +++++----------------
 4 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
index 71ddb4c98726..55a76a2d3d58 100644
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
@@ -106,7 +98,8 @@ void hw_timer_init(irq_handler_t handler)
 	TCTL = 0;
 
 	/* set ISR */
-	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
+	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("%s: request_irq() failed\n", "timer");
 
 	/* Restart mode, Enable int, Set clock source */
 	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
index eb6f16b0e2e6..604acd658dec 100644
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
@@ -156,7 +148,8 @@ void hw_timer_init(irq_handler_t handler)
 	cf_pit_clockevent.min_delta_ticks = 0x3f;
 	clockevents_register_device(&cf_pit_clockevent);
 
-	setup_irq(MCF_IRQ_PIT1, &pit_irq);
+	if (request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("%s: request_irq() failed\n", "timer");
 
 	clocksource_register_hz(&pit_clk, FREQ);
 }
diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
index 1b11e7bacab3..c5d5862e1d2b 100644
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
+		pr_err("%s: request_irq() failed\n", "profile timer");
 
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
+		pr_err("%s: request_irq() failed\n", "timer");
 
 	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
 
diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
index 227aa5d13709..52294c1f01f8 100644
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
@@ -134,7 +126,8 @@ void hw_timer_init(irq_handler_t handler)
 
 	timer_interrupt = handler;
 	init_timer_irq();
-	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
+	if (request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL))
+		pr_err("%s: request_irq() failed\n", "timer");
 
 #ifdef CONFIG_HIGHPROFILE
 	coldfire_profile_init();
@@ -170,12 +163,6 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
 
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
@@ -188,7 +175,9 @@ void coldfire_profile_init(void)
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

