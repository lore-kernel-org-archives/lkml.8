Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2703FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A8920829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596132651;
	bh=oy4zBu3xLBCuWxdfRxweVj3pqrgDJqo/r08Kl3Db94g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QwUQd5YVR7EAGCC87x6RNcFCrCyLn/qhmaA+QoOEtXczv4l9ZHRZKGHH8YIW898k8
	 OAJ5IUrDK2bsuLu/c+Gh8mGB/0kr4chQAMNuVIjHLqOAoqaE4mmAXqVSbi1Guw2JCr
	 E2Lrbi4F72l8VPi+cGqsVulbn9IGh9WS6wNev4HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgG3SKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgG3SKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:10:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1843D20829;
        Thu, 30 Jul 2020 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596132646;
        bh=oy4zBu3xLBCuWxdfRxweVj3pqrgDJqo/r08Kl3Db94g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fl299ZqPsQzWw9UVgzFctl4++/RwzhtHSmL+sPpgHZLcjvSdE26MKYvDtoNPvtCKP
         mo/1w6qj8PpE0ErMIE2Aw2XcRgsnE0h/LePYRHTcoQ/MjvjdII7TpzUHWU8busK7zV
         /ze1wpqbNMVAZ7q9TAzIrB4CXKwS9+P9AlpDj9hY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k1D0u-00GKY3-DU; Thu, 30 Jul 2020 19:10:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jul 2020 19:10:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] irqchip/gic-v2, v3: Prevent SW resends entirely
In-Reply-To: <20200730170321.31228-3-valentin.schneider@arm.com>
References: <20200730170321.31228-1-valentin.schneider@arm.com>
 <20200730170321.31228-3-valentin.schneider@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <ba26464de5e82eace97924121d7bcd1d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, Lorenzo.Pieralisi@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 2020-07-30 18:03, Valentin Schneider wrote:
> The GIC irqchips can now use a HW resend when a retrigger is invoked by
> check_irq_resend(). However, should the HW resend fail, 
> check_irq_resend()
> will still attempt to trigger a SW resend, which is still a bad idea 
> for
> the GICs.
> 
> Prevent this from happening by setting IRQD_HANDLE_ENFORCE_IRQCTX on 
> all
> GIC IRQs. Technically per-cpu IRQs do not need this, as their flow 
> handlers
> never set IRQS_PENDING, but this aligns all IRQs wrt context 
> enforcement:
> this also forces all GIC IRQ handling to happen in IRQ context (as 
> defined
> by in_irq()).
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 5 ++++-
>  drivers/irqchip/irq-gic.c    | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 0fbcbf55ec48..1a8acf7cd8ac 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1279,6 +1279,7 @@ static int gic_irq_domain_map(struct irq_domain
> *d, unsigned int irq,
>  			      irq_hw_number_t hw)
>  {
>  	struct irq_chip *chip = &gic_chip;
> +	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
> 
>  	if (static_branch_likely(&supports_deactivate_key))
>  		chip = &gic_eoimode1_chip;
> @@ -1296,7 +1297,7 @@ static int gic_irq_domain_map(struct irq_domain
> *d, unsigned int irq,
>  		irq_domain_set_info(d, irq, hw, chip, d->host_data,
>  				    handle_fasteoi_irq, NULL, NULL);
>  		irq_set_probe(irq);
> -		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
> +		irqd_set_single_target(irqd);
>  		break;
> 
>  	case LPI_RANGE:
> @@ -1310,6 +1311,8 @@ static int gic_irq_domain_map(struct irq_domain
> *d, unsigned int irq,
>  		return -EPERM;
>  	}
> 
> +	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
> +	irqd_set_handle_enforce_irqctx(irqd);
>  	return 0;
>  }
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index e2b4cae88bce..a91ce1e73bd2 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -983,6 +983,7 @@ static int gic_irq_domain_map(struct irq_domain
> *d, unsigned int irq,
>  				irq_hw_number_t hw)
>  {
>  	struct gic_chip_data *gic = d->host_data;
> +	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
> 
>  	if (hw < 32) {
>  		irq_set_percpu_devid(irq);
> @@ -992,8 +993,11 @@ static int gic_irq_domain_map(struct irq_domain
> *d, unsigned int irq,
>  		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
>  				    handle_fasteoi_irq, NULL, NULL);
>  		irq_set_probe(irq);
> -		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
> +		irqd_set_single_target(irqd);
>  	}
> +
> +	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
> +	irqd_set_handle_enforce_irqctx(irqd);
>  	return 0;
>  }

I'm OK with this in principle, but this requires additional changes
in the rest of the GIC universe. The ITS driver needs to provide its own
retrigger function for LPIs (queuing an INT command), and any of the
SPI generating widgets that can be stacked on top of a GIC (GICv3-MBI,
GICv2m, and all the other Annapurna/Marvell/NVDIA wonders need to gain
directly or indirectly a call to irq_chip_retrigger_hierarchy().

We can probably avoid changing the MSI widgets by teaching the MSI
code about the HW retrigger, but a number of other non-MSI drivers
will need some help...

I'll have a look tomorrow.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
