Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C27C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322C21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgBLWZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:25:27 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:44534 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgBLWZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:25:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CE6B929AAE;
        Wed, 12 Feb 2020 17:25:19 -0500 (EST)
Date:   Thu, 13 Feb 2020 09:25:19 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <1941c51a3237c4e9df6d9a5b87615cd1bba572dc.1581478324.git.afzal.mohd.ma@gmail.com>
Message-ID: <alpine.LNX.2.22.394.2002130912140.8@nippy.intranet>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com> <1941c51a3237c4e9df6d9a5b87615cd1bba572dc.1581478324.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020, afzal mohammed wrote:

> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> 
> Since cc'ing cover letter to all maintainers/reviewers would be too
> many, refer for cover letter,
>  https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com
> 
>  arch/m68k/68000/timers.c      |  9 ++-------
>  arch/m68k/coldfire/pit.c      |  9 ++-------
>  arch/m68k/coldfire/sltimers.c | 19 +++++--------------
>  arch/m68k/coldfire/timers.c   | 19 +++++--------------
>  4 files changed, 14 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> index 71ddb4c98726..7a55d664592e 100644
> --- a/arch/m68k/68000/timers.c
> +++ b/arch/m68k/68000/timers.c
> @@ -68,12 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction m68328_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = hw_tick,
> -};
> -
>  /***************************************************************************/
>  
>  static u64 m68328_read_clk(struct clocksource *cs)
> @@ -106,7 +100,8 @@ void hw_timer_init(irq_handler_t handler)
>  	TCTL = 0;
>  
>  	/* set ISR */
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "timer");

"request_irq() on timer failed" is bad grammar and doesn't convey what 
went wrong. It could be taken to mean that request_irq() was called 
because a timer went off.

Have you considered,

		pr_err("%s: request_irq() failed\n", "timer");

I think that would be more typical of error messages on UNIX. E.g.

$ grep x -- /tmp/foo
grep: /tmp/foo: No such file or directory

>  
>  	/* Restart mode, Enable int, Set clock source */
>  	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
> diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
> index eb6f16b0e2e6..d09e253abe5a 100644
> --- a/arch/m68k/coldfire/pit.c
> +++ b/arch/m68k/coldfire/pit.c
> @@ -111,12 +111,6 @@ static irqreturn_t pit_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction pit_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = pit_tick,
> -};
> -
>  /***************************************************************************/
>  
>  static u64 pit_read_clk(struct clocksource *cs)
> @@ -156,7 +150,8 @@ void hw_timer_init(irq_handler_t handler)
>  	cf_pit_clockevent.min_delta_ticks = 0x3f;
>  	clockevents_register_device(&cf_pit_clockevent);
>  
> -	setup_irq(MCF_IRQ_PIT1, &pit_irq);
> +	if (request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "timer");
>  

Same here.

>  	clocksource_register_hz(&pit_clk, FREQ);
>  }
> diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
> index 1b11e7bacab3..2188a21e5413 100644
> --- a/arch/m68k/coldfire/sltimers.c
> +++ b/arch/m68k/coldfire/sltimers.c
> @@ -50,18 +50,14 @@ irqreturn_t mcfslt_profile_tick(int irq, void *dummy)
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
>  	printk(KERN_INFO "PROFILE: lodging TIMER 1 @ %dHz as profile timer\n",
>  	       PROFILEHZ);
>  
> -	setup_irq(MCF_IRQ_PROFILER, &mcfslt_profile_irq);
> +	if (request_irq(MCF_IRQ_PROFILER, mcfslt_profile_tick, IRQF_TIMER,
> +			"profile timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "profile timer");
>  

And here.

>  	/* Set up TIMER 2 as high speed profile clock */
>  	__raw_writel(MCF_BUSCLK / PROFILEHZ - 1, PA(MCFSLT_STCNT));
> @@ -92,12 +88,6 @@ static irqreturn_t mcfslt_tick(int irq, void *dummy)
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
> @@ -140,7 +130,8 @@ void hw_timer_init(irq_handler_t handler)
>  	mcfslt_cnt = mcfslt_cycles_per_jiffy;
>  
>  	timer_interrupt = handler;
> -	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
> +	if (request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "timer");
>  

And so on.

>  	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
>  
> diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
> index 227aa5d13709..f384e92d8b1c 100644
> --- a/arch/m68k/coldfire/timers.c
> +++ b/arch/m68k/coldfire/timers.c
> @@ -82,12 +82,6 @@ static irqreturn_t mcftmr_tick(int irq, void *dummy)
>  
>  /***************************************************************************/
>  
> -static struct irqaction mcftmr_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcftmr_tick,
> -};
> -
>  /***************************************************************************/
>  
>  static u64 mcftmr_read_clk(struct clocksource *cs)
> @@ -134,7 +128,8 @@ void hw_timer_init(irq_handler_t handler)
>  
>  	timer_interrupt = handler;
>  	init_timer_irq();
> -	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
> +	if (request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "timer");
>  
>  #ifdef CONFIG_HIGHPROFILE
>  	coldfire_profile_init();
> @@ -170,12 +165,6 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
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
> @@ -188,7 +177,9 @@ void coldfire_profile_init(void)
>  	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
>  		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
>  
> -	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
> +	if (request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
> +			"profile timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "profile timer");
>  }
>  
>  /***************************************************************************/
> 

