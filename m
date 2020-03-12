Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1348FC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6585206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bxRBBSCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCLMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:34:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42192 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uArEIWDizojf1gfTMVx1qCJUduEJPhHKxNwomQ/vzcc=; b=bxRBBSCrPliEVChheadid/egV
        5hQidV2aAqDPPk8Q+WIyDRA8K7d/p4tvDMUrVvU9rrRjUMyN7FM6G6XoDXIFxOCjRCCIA7ROvGYKh
        S+ul/OBJQCx4kykw0TyI5hOC05w8GkxVhss6KrkUmZeCmJzbCAKYdfBjv3qeWaizqTqsVqti4rLhl
        iRMdWyecuMT/JH24hvKEqM0xEZs+/bKLomgMFjlfxKAgGlrqvK4xXgol8kEnz8sofW3xNfolo3gDj
        9xOHOKpMnVz0ThDJ6FZJ8YRUs1ohapG7qRe5jjNwMsyV0V5wmSBEt+jZ1+mjIJy6UPbUQ4qxuc9fn
        z0tvbDfxw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59536)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jCN2o-0001Bp-3W; Thu, 12 Mar 2020 12:34:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jCN2m-0006KF-PN; Thu, 12 Mar 2020 12:34:32 +0000
Date:   Thu, 12 Mar 2020 12:34:32 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: footbridge: replace setup_irq() by request_irq()
Message-ID: <20200312123432.GZ25745@shell.armlinux.org.uk>
References: <20200301122131.3902-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301122131.3902-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 05:51:31PM +0530, afzal mohammed wrote:
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
> Hi sub-arch maintainers,
> 
> If the patch is okay, please take it thr' your tree.

This patch causes a build warning:

arch/arm/mach-footbridge/isa-irq.c:113:15: warning: unused variable 'irq' [-Wunused-variable]

because you introduce a new 'int irq' variable in a sub-block where the
parent already declares 'irq', causing the parent 'irq' to be unused.

Hence, I'm dropping this patch.

I think you need to look more carefully at the code you are modifying,
and maybe even build test it.  Cross compilers are available from
kernel.org.

Russell.

> 
> Regards
> afzal
> 
> v3:
>  * Split out from series, also create subarch level patch as Thomas
> 	suggested to take it thr' respective maintainers
>  * Modify string displayed in case of error as suggested by Thomas
>  * Re-arrange code as required to improve readability
>  * Remove irrelevant parts from commit message & improve
>  
> v2:
>  * Replace pr_err("request_irq() on %s failed" by
>            pr_err("%s: request_irq() failed"
>  * Commit message massage
> 
>  arch/arm/mach-footbridge/dc21285-timer.c | 11 +++--------
>  arch/arm/mach-footbridge/isa-irq.c       | 10 ++++------
>  arch/arm/mach-footbridge/isa-timer.c     | 11 +++--------
>  3 files changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
> index f76212d2dbf1..2908c9ef3c9b 100644
> --- a/arch/arm/mach-footbridge/dc21285-timer.c
> +++ b/arch/arm/mach-footbridge/dc21285-timer.c
> @@ -101,13 +101,6 @@ static irqreturn_t timer1_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction footbridge_timer_irq = {
> -	.name		= "dc21285_timer1",
> -	.handler	= timer1_interrupt,
> -	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> -	.dev_id		= &ckevt_dc21285,
> -};
> -
>  /*
>   * Set up timer interrupt.
>   */
> @@ -118,7 +111,9 @@ void __init footbridge_timer_init(void)
>  
>  	clocksource_register_hz(&cksrc_dc21285, rate);
>  
> -	setup_irq(ce->irq, &footbridge_timer_irq);
> +	if (request_irq(ce->irq, timer1_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
> +			"dc21285_timer1", &ckevt_dc21285))
> +		pr_err("Failed to request irq %d (dc21285_timer1)", ce->irq);
>  
>  	ce->cpumask = cpumask_of(smp_processor_id());
>  	clockevents_config_and_register(ce, rate, 0x4, 0xffffff);
> diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
> index 88a553932c33..16c5455199e8 100644
> --- a/arch/arm/mach-footbridge/isa-irq.c
> +++ b/arch/arm/mach-footbridge/isa-irq.c
> @@ -96,11 +96,6 @@ static void isa_irq_handler(struct irq_desc *desc)
>  	generic_handle_irq(isa_irq);
>  }
>  
> -static struct irqaction irq_cascade = {
> -	.handler = no_action,
> -	.name = "cascade",
> -};
> -
>  static struct resource pic1_resource = {
>  	.name	= "pic1",
>  	.start	= 0x20,
> @@ -146,6 +141,8 @@ void __init isa_init_irq(unsigned int host_irq)
>  	}
>  
>  	if (host_irq != (unsigned int)-1) {
> +		int irq = IRQ_ISA_CASCADE;
> +
>  		for (irq = _ISA_IRQ(0); irq < _ISA_IRQ(8); irq++) {
>  			irq_set_chip_and_handler(irq, &isa_lo_chip,
>  						 handle_level_irq);
> @@ -160,7 +157,8 @@ void __init isa_init_irq(unsigned int host_irq)
>  
>  		request_resource(&ioport_resource, &pic1_resource);
>  		request_resource(&ioport_resource, &pic2_resource);
> -		setup_irq(IRQ_ISA_CASCADE, &irq_cascade);
> +		if (request_irq(irq, no_action, 0, "cascade", NULL))
> +			pr_err("Failed to request irq %d (cascade)\n", irq);
>  
>  		irq_set_chained_handler(host_irq, isa_irq_handler);
>  
> diff --git a/arch/arm/mach-footbridge/isa-timer.c b/arch/arm/mach-footbridge/isa-timer.c
> index 82f45591fb2c..723e3eae995d 100644
> --- a/arch/arm/mach-footbridge/isa-timer.c
> +++ b/arch/arm/mach-footbridge/isa-timer.c
> @@ -25,17 +25,12 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction pit_timer_irq = {
> -	.name		= "pit",
> -	.handler	= pit_timer_interrupt,
> -	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> -	.dev_id		= &i8253_clockevent,
> -};
> -
>  void __init isa_timer_init(void)
>  {
>  	clocksource_i8253_init();
>  
> -	setup_irq(i8253_clockevent.irq, &pit_timer_irq);
> +	if (request_irq(i8253_clockevent.irq, pit_timer_interrupt,
> +			IRQF_TIMER | IRQF_IRQPOLL, "pit", &i8253_clockevent))
> +		pr_err("Failed to request irq %d(pit)\n", i8253_clockevent.irq);
>  	clockevent_i8253_init(false);
>  }
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
