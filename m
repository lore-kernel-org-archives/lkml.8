Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F57C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCE0246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCBBc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 20:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgCBBc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:32:59 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912CD24697;
        Mon,  2 Mar 2020 01:32:56 +0000 (UTC)
Subject: Re: [PATCH v5] m68k: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
References: <20200229153406.GA32479@afzalpc> <20200301012655.GA6035@afzalpc>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c2c04a29-4fc8-7cb5-6cc6-5bc3b125d047@linux-m68k.org>
Date:   Mon, 2 Mar 2020 11:32:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301012655.GA6035@afzalpc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal,

On 1/3/20 11:26 am, afzal mohammed wrote:
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
> v5:
>   * Revert to pr_err

You have been busy :-)

I have retested and everything works as expected, so:

   Tested-by: Greg Ungerer <gerg@linux-m68k.org>

I have applied this to the m68knommu git tree, for next branch.

One comment below, but it is not important.


> v4:
>   * Add modifications done per v3, but missed at couple of places
> v3:
>   * Instead of tree wide series, arch specific patch (per tglx)
>   * Strip irrelevant portions & more tweaking in commit message
>   * Remove name indirection in pr_err string, print irq # and
>     symbolic error name in case of error
>   * s/pr_err/pr_debug
> v2:
>   * Replace pr_err("request_irq() on %s failed" by
>             pr_err("%s: request_irq() failed"
>   * Commit message massage
>   * remove now irrelevant comment lines at 3 places
> 
>   arch/m68k/68000/timers.c      | 16 +++++++---------
>   arch/m68k/coldfire/pit.c      | 16 +++++++---------
>   arch/m68k/coldfire/sltimers.c | 29 +++++++++++++++--------------
>   arch/m68k/coldfire/timers.c   | 31 +++++++++++++++----------------
>   4 files changed, 44 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> index 71ddb4c98726..1c8e8a83c325 100644
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
> @@ -102,11 +94,17 @@ static struct clocksource m68328_clk = {
>   
>   void hw_timer_init(irq_handler_t handler)
>   {
> +	int ret;
> +
>   	/* disable timer 1 */
>   	TCTL = 0;
>   
>   	/* set ISR */
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	ret = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> +	if (ret) {
> +		pr_err("Failed to request irq %d (timer): %pe\n", TMR_IRQ_NUM,
> +		       ERR_PTR(ret));
> +	}
>   
>   	/* Restart mode, Enable int, Set clock source */
>   	TCTL = TCTL_OM | TCTL_IRQEN | CLOCK_SOURCE;
> diff --git a/arch/m68k/coldfire/pit.c b/arch/m68k/coldfire/pit.c
> index eb6f16b0e2e6..fd1d9c915daa 100644
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
> @@ -146,6 +138,8 @@ static struct clocksource pit_clk = {
>   
>   void hw_timer_init(irq_handler_t handler)
>   {
> +	int ret;
> +
>   	cf_pit_clockevent.cpumask = cpumask_of(smp_processor_id());
>   	cf_pit_clockevent.mult = div_sc(FREQ, NSEC_PER_SEC, 32);
>   	cf_pit_clockevent.max_delta_ns =
> @@ -156,7 +150,11 @@ void hw_timer_init(irq_handler_t handler)
>   	cf_pit_clockevent.min_delta_ticks = 0x3f;
>   	clockevents_register_device(&cf_pit_clockevent);
>   
> -	setup_irq(MCF_IRQ_PIT1, &pit_irq);
> +	ret = request_irq(MCF_IRQ_PIT1, pit_tick, IRQF_TIMER, "timer", NULL);
> +	if (ret) {
> +		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_PIT1,
> +		       ERR_PTR(ret));
> +	}
>   
>   	clocksource_register_hz(&pit_clk, FREQ);
>   }
> diff --git a/arch/m68k/coldfire/sltimers.c b/arch/m68k/coldfire/sltimers.c
> index 1b11e7bacab3..5ab81c9c552d 100644
> --- a/arch/m68k/coldfire/sltimers.c
> +++ b/arch/m68k/coldfire/sltimers.c
> @@ -50,18 +50,19 @@ irqreturn_t mcfslt_profile_tick(int irq, void *dummy)
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
> +	int ret;
> +
>   	printk(KERN_INFO "PROFILE: lodging TIMER 1 @ %dHz as profile timer\n",
>   	       PROFILEHZ);
>   
> -	setup_irq(MCF_IRQ_PROFILER, &mcfslt_profile_irq);
> +	ret = request_irq(MCF_IRQ_PROFILER, mcfslt_profile_tick, IRQF_TIMER,
> +			  "profile timer", NULL);
> +	if (ret) {
> +		pr_err("Failed to request irq %d (profile timer): %pe\n",
> +		       MCF_IRQ_PROFILER, ERR_PTR(ret));
> +	}
>   
>   	/* Set up TIMER 2 as high speed profile clock */
>   	__raw_writel(MCF_BUSCLK / PROFILEHZ - 1, PA(MCFSLT_STCNT));
> @@ -92,12 +93,6 @@ static irqreturn_t mcfslt_tick(int irq, void *dummy)
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
> @@ -126,6 +121,8 @@ static struct clocksource mcfslt_clk = {
>   
>   void hw_timer_init(irq_handler_t handler)
>   {
> +	int r;

You used 'r' here as the error return value holder.
But in the previous cases you used 'ret'.
I would have used the same name everywhere ('ret' probably being the
most commonly used in the kernel).

Regards
Greg


> +
>   	mcfslt_cycles_per_jiffy = MCF_BUSCLK / HZ;
>   	/*
>   	 *	The coldfire slice timer (SLT) runs from STCNT to 0 included,
> @@ -140,7 +137,11 @@ void hw_timer_init(irq_handler_t handler)
>   	mcfslt_cnt = mcfslt_cycles_per_jiffy;
>   
>   	timer_interrupt = handler;
> -	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
> +	r = request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL);
> +	if (r) {
> +		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_TIMER,
> +		       ERR_PTR(r));
> +	}
>   
>   	clocksource_register_hz(&mcfslt_clk, MCF_BUSCLK);
>   
> diff --git a/arch/m68k/coldfire/timers.c b/arch/m68k/coldfire/timers.c
> index 227aa5d13709..b8301fddf901 100644
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
> @@ -118,6 +110,8 @@ static struct clocksource mcftmr_clk = {
>   
>   void hw_timer_init(irq_handler_t handler)
>   {
> +	int r;
> +
>   	__raw_writew(MCFTIMER_TMR_DISABLE, TA(MCFTIMER_TMR));
>   	mcftmr_cycles_per_jiffy = FREQ / HZ;
>   	/*
> @@ -134,7 +128,11 @@ void hw_timer_init(irq_handler_t handler)
>   
>   	timer_interrupt = handler;
>   	init_timer_irq();
> -	setup_irq(MCF_IRQ_TIMER, &mcftmr_timer_irq);
> +	r = request_irq(MCF_IRQ_TIMER, mcftmr_tick, IRQF_TIMER, "timer", NULL);
> +	if (r) {
> +		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_TIMER,
> +		       ERR_PTR(r));
> +	}
>   
>   #ifdef CONFIG_HIGHPROFILE
>   	coldfire_profile_init();
> @@ -170,14 +168,10 @@ irqreturn_t coldfire_profile_tick(int irq, void *dummy)
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
> +	int ret;
> +
>   	printk(KERN_INFO "PROFILE: lodging TIMER2 @ %dHz as profile timer\n",
>   	       PROFILEHZ);
>   
> @@ -188,7 +182,12 @@ void coldfire_profile_init(void)
>   	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
>   		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
>   
> -	setup_irq(MCF_IRQ_PROFILER, &coldfire_profile_irq);
> +	ret = request_irq(MCF_IRQ_PROFILER, coldfire_profile_tick, IRQF_TIMER,
> +			  "profile timer", NULL);
> +	if (ret) {
> +		pr_err("Failed to request irq %d (profile timer): %pe\n",
> +		       MCF_IRQ_PROFILER, ERR_PTR(ret));
> +	}
>   }
>   
>   /***************************************************************************/
> 
