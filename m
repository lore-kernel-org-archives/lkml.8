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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F3C3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C5524699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D24i0/Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgB2NZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:25:55 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55405 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgB2NZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:25:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id a18so2456343pjs.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 05:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACluAC+gEXxqzqMeKD0mwXDgd2QsjpKmTJJvUvk09Jc=;
        b=D24i0/Ts7mZXnYKFwuEE9Pn2riSsdb01CfPQzAxmx/6ww/53E3zZ57LSsyV1EKebg/
         IN+db1yK5ffTBXI7OsVGzS0fcrkIXW5QMGueP+Aj+kqBiIQ3T5yX/EilWM6BF+LacByP
         U9rl7g8koVmVoMearOYqcbHWlWyWFQ/d8afkAQbmnY0s36TNnCYO4w1NUfhp32i6PwLl
         cK5pTY0yaMNlNtD6WO4B0iUZHA7vSt8NFFINhUX6IYlp3GfJKHZDXaf4Mh5sZid3Alvi
         2KkPIkGu/cQPKB15gDtC5KGV2ltqGqYcEmEK10jOHzQxz4GfHYkbQ1bfFoHixcWFZbhE
         LPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACluAC+gEXxqzqMeKD0mwXDgd2QsjpKmTJJvUvk09Jc=;
        b=Q4BAShrY3G0kmRYocqXdZdoR+MRzsgjtgTM73DhKEkGTpFWS/WtFUiGzqU9vruZHc4
         zANVMFD4gXTVMMy5VpeED3iUvtHD9vi8wJuHvK29er1Qotl/8taHziADM2qvO72lQkhz
         ah6KIPSkrvpevUUx3j7HdxDhJPv0qCV/ViZXLmP+s721HZY2amipNr8/9eAPN8giJq8O
         81wTqxfRpzbIj74lBBIXrct2VBOyb63EP/OQXy4fLsbDxqFdSTrHPYGSYYhA65zFnBTk
         NnPqRZLIBZTj2SnBZp6bfO7EhMRWID8XwcJg2X2FBjLdprk7YoxAIGuFqmi3geWq6m2C
         qGYQ==
X-Gm-Message-State: APjAAAUbzfyWAm0SSPSLVSNavIH5+5QfR6upnHrs1oxHEDHByt7uVhkQ
        MpPzhmJ2RA0MnJo1sZas3jk=
X-Google-Smtp-Source: APXvYqwhUOm7oLjt+usRNWX0dmxNo8bWcH48RYX+wUpNGiiPQvb9h/cjjs4GYLdmRaVyATCyJkxCeA==
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr10303449pjx.113.1582982753724;
        Sat, 29 Feb 2020 05:25:53 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id d3sm14501534pfn.113.2020.02.29.05.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 05:25:53 -0800 (PST)
Date:   Sat, 29 Feb 2020 18:55:51 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200229132551.GA5111@afzalpc>
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

Huh, i messed it up in a hurry, i forgot to make modifications in 2
places, i will send v4 after  handling those 2 cases as well.

Regards
afzal

On Sat, Feb 29, 2020 at 06:26:50PM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> 
> Hi Greg,
> 
> i have removed your Tested-by due to the modifications, if possible,
> please test & let me know.
> 
> Regards
> afzal
> 
> v3:
>  * Instead of tree wide series, arch specific patch (per tglx)
>  * Strip irrelevant portions & more tweaking in commit message
>  * Remove name indirection in pr_err string, print irq # and
>    symbolic error name in case of error
>  * s/pr_err/pr_debug
> v2:
>  * Replace pr_err("request_irq() on %s failed" by
>            pr_err("%s: request_irq() failed"
>  * Commit message massage
>  * remove now irrelevant comment lines at 3 places
> 
>  arch/m68k/68000/timers.c      | 16 +++++++---------
>  arch/m68k/coldfire/pit.c      | 16 +++++++---------
>  arch/m68k/coldfire/sltimers.c | 24 ++++++++++--------------
>  arch/m68k/coldfire/timers.c   | 26 ++++++++++----------------
>  4 files changed, 34 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> index 71ddb4c98726..07a389a287e4 100644
> --- a/arch/m68k/68000/timers.c
> +++ b/arch/m68k/68000/timers.c
> @@ -68,14 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction m68328_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = hw_tick,
> -};
> -
> -/***************************************************************************/
> -
>  static u64 m68328_read_clk(struct clocksource *cs)
>  {
>  	unsigned long flags;
> @@ -102,11 +94,17 @@ static struct clocksource m68328_clk = {
>  
>  void hw_timer_init(irq_handler_t handler)
>  {
> +	int ret;
> +
>  	/* disable timer 1 */
>  	TCTL = 0;
>  
>  	/* set ISR */
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	ret = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> +	if (ret) {
> +		pr_debug("Failed to request irq %d (timer): %pe\n", TMR_IRQ_NUM,
> +			 ERR_PTR(ret));
> +	}
>  
>  	/* Restart mode, Enable int, Set clock source */
>  	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
> diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
> index eb6f16b0e2e6..482678cf4819 100644
> --- a/arch/m68k/coldfire/pit.c
> +++ b/arch/m68k/coldfire/pit.c
> @@ -111,14 +111,6 @@ static irqreturn_t pit_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction pit_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = pit_tick,
> -};
> -
> -/***************************************************************************/
> -
>  static u64 pit_read_clk(struct clocksource *cs)
>  {
>  	unsigned long flags;
> @@ -146,6 +138,8 @@ static struct clocksource pit_clk = {
>  
>  void hw_timer_init(irq_handler_t handler)
>  {
> +	int ret;
> +
>  	cf_pit_clockevent.cpumask = cpumask_of(smp_processor_id());
>  	cf_pit_clockevent.mult = div_sc(FREQ, NSEC_PER_SEC, 32);
>  	cf_pit_clockevent.max_delta_ns =
> @@ -156,7 +150,11 @@ void hw_timer_init(irq_handler_t handler)
>  	cf_pit_clockevent.min_delta_ticks = 0x3f;
>  	clockevents_register_device(&cf_pit_clockevent);
>  
> -	setup_irq(MCF_IRQ_PIT1, &pit_irq);
> +	ret = request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL);
> +	if (ret) {
> +		pr_debug("Failed to request irq %d (timer): %pe\n",
> +			 MCF_IRQ_PIT1, ERR_PTR(ret));
> +	}
>  
>  	clocksource_register_hz(&pit_clk, FREQ);
>  }
> diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
> index 1b11e7bacab3..087c68d2d909 100644
> --- a/arch/m68k/coldfire/sltimers.c
> +++ b/arch/m68k/coldfire/sltimers.c
> @@ -50,18 +50,19 @@ irqreturn_t mcfslt_profile_tick(int irq, void *dummy)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction mcfslt_profile_irq = {
> -	.name	 = "profile timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcfslt_profile_tick,
> -};
> -
>  void mcfslt_profile_init(void)
>  {
> +	int ret;
> +
>  	printk(KERN_INFO "PROFILE: lodging TIMER 1 @ %dHz as profile timer\n",
>  	       PROFILEHZ);
>  
> -	setup_irq(MCF_IRQ_PROFILER, &mcfslt_profile_irq);
> +	ret = request_irq(MCF_IRQ_PROFILER, mcfslt_profile_tick, IRQF_TIMER,
> +			  "profile timer", NULL);
> +	if (ret) {
> +		pr_debug("Failed to request irq %d (profile timer): %pe\n",
> +			 MCF_IRQ_PROFILER, ERR_PTR(ret));
> +	}
>  
>  	/* Set up TIMER 2 as high speed profile clock */
>  	__raw_writel(MCF_BUSCLK / PROFILEHZ - 1, PA(MCFSLT_STCNT));
> @@ -92,12 +93,6 @@ static irqreturn_t mcfslt_tick(int irq, void *dummy)
>  	return timer_interrupt(irq, dummy);
>  }
>  
> -static struct irqaction mcfslt_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcfslt_tick,
> -};
> -
>  static u64 mcfslt_read_clk(struct clocksource *cs)
>  {
>  	unsigned long flags;
> @@ -140,7 +135,8 @@ void hw_timer_init(irq_handler_t handler)
>  	mcfslt_cnt = mcfslt_cycles_per_jiffy;
>  
>  	timer_interrupt = handler;
> -	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
> +	if (request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "timer");
>  
>  	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
>  
> diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
> index 227aa5d13709..eb442a0e3b50 100644
> --- a/arch/m68k/coldfire/timers.c
> +++ b/arch/m68k/coldfire/timers.c
> @@ -82,14 +82,6 @@ static irqreturn_t mcftmr_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction mcftmr_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcftmr_tick,
> -};
> -
> -/***************************************************************************/
> -
>  static u64 mcftmr_read_clk(struct clocksource *cs)
>  {
>  	unsigned long flags;
> @@ -118,6 +110,8 @@ static struct clocksource mcftmr_clk = {
>  
>  void hw_timer_init(irq_handler_t handler)
>  {
> +	int r;
> +
>  	__raw_writew(MCFTIMER_TMR_DISABLE, TA(MCFTIMER_TMR));
>  	mcftmr_cycles_per_jiffy = FREQ / HZ;
>  	/*
> @@ -134,7 +128,11 @@ void hw_timer_init(irq_handler_t handler)
>  
>  	timer_interrupt = handler;
>  	init_timer_irq();
> -	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
> +	r = request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL);
> +	if (r) {
> +		pr_debug("Failed to request irq %d (timer): %pe\n",
> +			 MCF_IRQ_TIMER, ERR_PTR(r));
> +	}
>  
>  #ifdef CONFIG_HIGHPROFILE
>  	coldfire_profile_init();
> @@ -170,12 +168,6 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction coldfire_profile_irq = {
> -	.name	 = "profile timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = coldfire_profile_tick,
> -};
> -
>  void coldfire_profile_init(void)
>  {
>  	printk(KERN_INFO "PROFILE: lodging TIMER2 @ %dHz as profile timer\n",
> @@ -188,7 +180,9 @@ void coldfire_profile_init(void)
>  	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
>  		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
>  
> -	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
> +	if (request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
> +			"profile timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "profile timer");
>  }
>  
>  /***************************************************************************/
> -- 
> 2.25.1
