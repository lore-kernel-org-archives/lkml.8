Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD4CC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977912071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587810595;
	bh=OnIlYiQte8vLjVIxAMAdY+TpiPpcVzuY5O1fmTyq7+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xtCGuVyvXissqcsT4hSqrIIssbkpxQRfWHsPB6AUjCV0nk2AGW0XmYmYsurvIretJ
	 0FL5WEWrKmUfbXrRmTeao4maKLcJjSdzq8kmKYyS+nX6wu6NLXmuXUyzqlfRo17azU
	 vxV3dWkSbrCg7MteYZxYas1PVGZEk9H3tUY+MTPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDYK3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYK3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:29:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0D4206ED;
        Sat, 25 Apr 2020 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587810593;
        bh=OnIlYiQte8vLjVIxAMAdY+TpiPpcVzuY5O1fmTyq7+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bv0ALoEnQatFldA7tqW0d52kgR5KLG0rtNDWuoE/MoLoUmFYrh7hOVz0gO+WAxuvI
         256JDSv6GV/cKQUauCGL5kLz252R3HMn063bNpPBw0CE0vDVASgTpDGJXbnpULI9jS
         MyTz8uzhhm6IeMdtJcKZ25Y0nhhCasKapE3X8KP8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jSI4F-006HcM-RZ; Sat, 25 Apr 2020 11:29:51 +0100
Date:   Sat, 25 Apr 2020 11:29:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
Message-ID: <20200425112950.3a4815b6@why>
In-Reply-To: <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
        <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 16:39:12 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

Hi Sumit,

> With pseudo NMIs enabled, interrupt controller can be configured to
> deliver SGI as a pseudo NMI. So add corresponding handling for SGIs.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index d7006ef..be361bf 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -609,17 +609,29 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
>  	if (irqs_enabled)
>  		nmi_enter();
>  
> -	if (static_branch_likely(&supports_deactivate_key))
> -		gic_write_eoir(irqnr);
>  	/*
>  	 * Leave the PSR.I bit set to prevent other NMIs to be
>  	 * received while handling this one.
>  	 * PSR.I will be restored when we ERET to the
>  	 * interrupted context.
>  	 */
> -	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
> -	if (err)
> -		gic_deactivate_unhandled(irqnr);
> +	if (likely(irqnr > 15)) {
> +		if (static_branch_likely(&supports_deactivate_key))
> +			gic_write_eoir(irqnr);
> +
> +		err = handle_domain_nmi(gic_data.domain, irqnr, regs);
> +		if (err)
> +			gic_deactivate_unhandled(irqnr);
> +	} else {
> +		gic_write_eoir(irqnr);
> +		if (static_branch_likely(&supports_deactivate_key))
> +			gic_write_dir(irqnr);
> +#ifdef CONFIG_SMP
> +		handle_IPI(irqnr, regs);
> +#else
> +		WARN_ONCE(true, "Unexpected SGI received!\n");
> +#endif
> +	}
>  
>  	if (irqs_enabled)
>  		nmi_exit();

If there is one thing I would like to avoid, it is to add more ugly
hacks to the way we handle SGIs. There is very little reason why SGIs
should be handled differently from all other interrupts. They have the
same properties, and it is only because of the 32bit legacy that we deal
with them in such a cumbersome way. Nothing that we cannot fix though.

What I would really like to see is first a conversion of the SGIs to
normal, full fat interrupts. These interrupts can then be configured as
NMI using the normal API.

I think Julien had something along these lines (or was that limited to
the PMU?). Otherwise, I'll happily help you with that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
