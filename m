Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B1C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2139A21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgBZAmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZAmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:42:06 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07E82082F;
        Wed, 26 Feb 2020 00:42:03 +0000 (UTC)
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
Date:   Wed, 26 Feb 2020 10:42:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal,

On 24/2/20 10:50 am, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). The early boot setup_irq()
> invocations happen either via 'init_IRQ()' or 'time_init()', while
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
> Tested-by: Greg Ungerer <gerg@linux-m68k.org> # ColdFire
> ---
> 
> v2:
>   * Replace pr_err("request_irq() on %s failed" by
>             pr_err("%s: request_irq() failed"
>   * Commit message massage
>   * remove now irrelevant comment lines at 3 places
> 
>   arch/m68k/68000/timers.c      | 11 ++---------
>   arch/m68k/coldfire/pit.c      | 11 ++---------
>   arch/m68k/coldfire/sltimers.c | 19 +++++--------------
>   arch/m68k/coldfire/timers.c   | 21 +++++----------------
>   4 files changed, 14 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> index 71ddb4c98726..55a76a2d3d58 100644
> --- a/arch/m68k/68000/timers.c
> +++ b/arch/m68k/68000/timers.c
> @@ -68,14 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
>   
>   /***************************************************************************/
>   
> -static struct irqaction m68328_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = hw_tick,
> -};
> -
> -/***************************************************************************/
> -
>   static u64 m68328_read_clk(struct clocksource *cs)
>   {
>   	unsigned long flags;
> @@ -106,7 +98,8 @@ void hw_timer_init(irq_handler_t handler)
>   	TCTL = 0;
>   
>   	/* set ISR */
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "timer");

Why not just:

                 pr_err("timer: request_irq() failed\n");

And maybe would it be useful to print out the error return code from a
failed request_irq()?  What about displaying the requested IRQ number as well?
Just a thought.

Regards
Greg


>   	/* Restart mode, Enable int, Set clock source */
>   	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
> diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
> index eb6f16b0e2e6..604acd658dec 100644
> --- a/arch/m68k/coldfire/pit.c
> +++ b/arch/m68k/coldfire/pit.c
> @@ -111,14 +111,6 @@ static irqreturn_t pit_tick(int irq, void *dummy)
>   
>   /***************************************************************************/
>   
> -static struct irqaction pit_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = pit_tick,
> -};
> -
> -/***************************************************************************/
> -
>   static u64 pit_read_clk(struct clocksource *cs)
>   {
>   	unsigned long flags;
> @@ -156,7 +148,8 @@ void hw_timer_init(irq_handler_t handler)
>   	cf_pit_clockevent.min_delta_ticks = 0x3f;
>   	clockevents_register_device(&cf_pit_clockevent);
>   
> -	setup_irq(MCF_IRQ_PIT1, &pit_irq);
> +	if (request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "timer");
>   
>   	clocksource_register_hz(&pit_clk, FREQ);
>   }
> diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
> index 1b11e7bacab3..c5d5862e1d2b 100644
> --- a/arch/m68k/coldfire/sltimers.c
> +++ b/arch/m68k/coldfire/sltimers.c
> @@ -50,18 +50,14 @@ irqreturn_t mcfslt_profile_tick(int irq, void *dummy)
>   	return IRQ_HANDLED;
>   }
>   
> -static struct irqaction mcfslt_profile_irq = {
> -	.name	 = "profile timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcfslt_profile_tick,
> -};
> -
>   void mcfslt_profile_init(void)
>   {
>   	printk(KERN_INFO "PROFILE: lodging TIMER 1 @ %dHz as profile timer\n",
>   	       PROFILEHZ);
>   
> -	setup_irq(MCF_IRQ_PROFILER, &mcfslt_profile_irq);
> +	if (request_irq(MCF_IRQ_PROFILER, mcfslt_profile_tick, IRQF_TIMER,
> +			"profile timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "profile timer");
>   
>   	/* Set up TIMER 2 as high speed profile clock */
>   	__raw_writel(MCF_BUSCLK / PROFILEHZ - 1, PA(MCFSLT_STCNT));
> @@ -92,12 +88,6 @@ static irqreturn_t mcfslt_tick(int irq, void *dummy)
>   	return timer_interrupt(irq, dummy);
>   }
>   
> -static struct irqaction mcfslt_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcfslt_tick,
> -};
> -
>   static u64 mcfslt_read_clk(struct clocksource *cs)
>   {
>   	unsigned long flags;
> @@ -140,7 +130,8 @@ void hw_timer_init(irq_handler_t handler)
>   	mcfslt_cnt = mcfslt_cycles_per_jiffy;
>   
>   	timer_interrupt = handler;
> -	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
> +	if (request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "timer");
>   
>   	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
>   
> diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
> index 227aa5d13709..52294c1f01f8 100644
> --- a/arch/m68k/coldfire/timers.c
> +++ b/arch/m68k/coldfire/timers.c
> @@ -82,14 +82,6 @@ static irqreturn_t mcftmr_tick(int irq, void *dummy)
>   
>   /***************************************************************************/
>   
> -static struct irqaction mcftmr_timer_irq = {
> -	.name	 = "timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = mcftmr_tick,
> -};
> -
> -/***************************************************************************/
> -
>   static u64 mcftmr_read_clk(struct clocksource *cs)
>   {
>   	unsigned long flags;
> @@ -134,7 +126,8 @@ void hw_timer_init(irq_handler_t handler)
>   
>   	timer_interrupt = handler;
>   	init_timer_irq();
> -	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
> +	if (request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "timer");
>   
>   #ifdef CONFIG_HIGHPROFILE
>   	coldfire_profile_init();
> @@ -170,12 +163,6 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
>   
>   /***************************************************************************/
>   
> -static struct irqaction coldfire_profile_irq = {
> -	.name	 = "profile timer",
> -	.flags	 = IRQF_TIMER,
> -	.handler = coldfire_profile_tick,
> -};
> -
>   void coldfire_profile_init(void)
>   {
>   	printk(KERN_INFO "PROFILE: lodging TIMER2 @ %dHz as profile timer\n",
> @@ -188,7 +175,9 @@ void coldfire_profile_init(void)
>   	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
>   		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
>   
> -	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
> +	if (request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
> +			"profile timer", NULL))
> +		pr_err("%s: request_irq() failed\n", "profile timer");
>   }
>   
>   /***************************************************************************/
> 
