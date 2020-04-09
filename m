Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206F9C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B49208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586424716;
	bh=yu1DxhA5goDLvRx/GPY7agiWxznEHMQNlRX0ba5w0Mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s4LW2XmX9cMGSMbbirfK+8Y3BsPJumhXUMdRPYLSVRY6iaC2aIT24GaYn8A9fLTJ/
	 Pil/13lN6CqX5tO9QXBx2kdAHMK6B1i/JlNn/4BBaBz1HG16ZQIzRwAvAjWV1+ioFD
	 lyekm5TTccEaZwM5GnUX7/NzqbbwSNGOS/TWKMo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIJby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIJbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:31:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5518220730;
        Thu,  9 Apr 2020 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586424713;
        bh=yu1DxhA5goDLvRx/GPY7agiWxznEHMQNlRX0ba5w0Mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gSUHo4+B6MWf9VBolg2AvbN+t9D926yHPJkK5bSTa93ofzCplHB/Tgjl/uBT29NPL
         FShJubWHD3/RVb6Eersg/7hprxFTloZioz9EWSAD75N2SEGcmCaF5QKHyCi0+mJsJ6
         IeNija7yfMYeS2fVSiSWK2GSiQuRTHgDh6yUCyPE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jMTXG-001rlN-39; Thu, 09 Apr 2020 10:31:46 +0100
Date:   Thu, 9 Apr 2020 10:31:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] irqchip/ti-sci-inta: fix processing of masked irqs
Message-ID: <20200409103144.3b2169bf@why>
In-Reply-To: <20200408191532.31252-1-grygorii.strashko@ti.com>
References: <20200408191532.31252-1-grygorii.strashko@ti.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: grygorii.strashko@ti.com, nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lokeshvutla@ti.com, peter.ujfalusi@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 22:15:32 +0300
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> The ti_sci_inta_irq_handler() does not take into account INTA IRQs state
> (masked/unmasked) as it uses INTA_STATUS_CLEAR_j register to get INTA IRQs
> status, which provides raw status value.
> This causes hard IRQ handlers to be called or threaded handlers to be
> scheduled many times even if corresponding INTA IRQ is masked.
> Above, first of all, affects the LEVEL interrupts processing and causes
> unexpected behavior up the system stack or crash.
> 
> Fix it by using the Interrupt Masked Status INTA_STATUSM_j register which
> provides masked INTA IRQs status.
> 
> Fixes: 9f1463b86c13 ("irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Given the failure mode, doesn't this deserve a Cc stable?

> ---
>  drivers/irqchip/irq-ti-sci-inta.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> index 8f6e6b08eadf..7e3ebf6ed2cd 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -37,6 +37,7 @@
>  #define VINT_ENABLE_SET_OFFSET	0x0
>  #define VINT_ENABLE_CLR_OFFSET	0x8
>  #define VINT_STATUS_OFFSET	0x18
> +#define VINT_STATUS_MASKED_OFFSET	0x20
>  
>  /**
>   * struct ti_sci_inta_event_desc - Description of an event coming to
> @@ -116,7 +117,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
>  	chained_irq_enter(irq_desc_get_chip(desc), desc);
>  
>  	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
> -			    VINT_STATUS_OFFSET);
> +			    VINT_STATUS_MASKED_OFFSET);
>  
>  	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
>  		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);


Otherwise queued for post -rc1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
