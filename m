Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3773C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39952074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCMUjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:39:22 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34575 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCMUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:39:22 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 744E420007;
        Fri, 13 Mar 2020 20:39:15 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH v3] ARM: orion: replace setup_irq() by request_irq()
In-Reply-To: <20200301122330.4296-1-afzal.mohd.ma@gmail.com>
References: <20200301122330.4296-1-afzal.mohd.ma@gmail.com>
Date:   Fri, 13 Mar 2020 21:39:15 +0100
Message-ID: <87sgicxa4s.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi afzal,

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

Applied on mvebu/arm

Thanks,

Gregory

> ---
> Hi sub-arch maintainers,
>
> If the patch is okay, please take it thr' your tree.
>
> Regards
> afzal
>
> v3:
>  * Split out from series, also split out from ARM patch to subarch level
> 	as Thomas suggested to take it thr' respective maintainers
>  * Modify string displayed in case of error as suggested by Thomas
>  * Re-arrange code as required to improve readability
>  * Remove irrelevant parts from commit message & improve
>  
> v2:
>  * Replace pr_err("request_irq() on %s failed" by
>            pr_err("%s: request_irq() failed"
>  * Commit message massage
>
>  arch/arm/plat-orion/time.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
> index ffb93db68e9c..509d4824dc1c 100644
> --- a/arch/arm/plat-orion/time.c
> +++ b/arch/arm/plat-orion/time.c
> @@ -177,12 +177,6 @@ static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction orion_timer_irq = {
> -	.name		= "orion_tick",
> -	.flags		= IRQF_TIMER,
> -	.handler	= orion_timer_interrupt
> -};
> -
>  void __init
>  orion_time_set_base(void __iomem *_timer_base)
>  {
> @@ -236,7 +230,9 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
>  	/*
>  	 * Setup clockevent timer (interrupt-driven).
>  	 */
> -	setup_irq(irq, &orion_timer_irq);
> +	if (request_irq(irq, orion_timer_interrupt, IRQF_TIMER, "orion_tick",
> +			NULL))
> +		pr_err("Failed to request irq %u (orion_tick)\n", irq);
>  	orion_clkevt.cpumask = cpumask_of(0);
>  	clockevents_config_and_register(&orion_clkevt, tclk, 1, 0xfffffffe);
>  }
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
