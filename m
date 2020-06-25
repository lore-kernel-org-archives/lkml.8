Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F3DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB81120781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404482AbgFYSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:25:51 -0400
Received: from foss.arm.com ([217.140.110.172]:43148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404019AbgFYSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:25:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B13FD6E;
        Thu, 25 Jun 2020 11:25:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7C93F71E;
        Thu, 25 Jun 2020 11:25:48 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-7-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 06/17] irqchip/gic-v3: Configure SGIs as standard interrupts
In-reply-to: <20200624195811.435857-7-maz@kernel.org>
Date:   Thu, 25 Jun 2020 19:25:46 +0100
Message-ID: <jhjimffgfyt.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 20:58, Marc Zyngier wrote:
> Change the way we deal with GICv3 SGIs by turning them into proper
> IRQs, and calling into the arch code to register the interrupt range
> instead of a callback.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 81 +++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 19b294ed48ba..d275e9b9533d 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -36,6 +36,8 @@
>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
>
> +#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
> +

Nit: this piqued my interest but ended up being just a define shuffle; As a
member of the git speleologists' guild, I'd be overjoyed with having a
small notion of that in the changelog.

>  struct redist_region {
>       void __iomem		*redist_base;
>       phys_addr_t		phys_base;
> @@ -657,38 +659,14 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>       if ((irqnr >= 1020 && irqnr <= 1023))
>               return;
>
> -	/* Treat anything but SGIs in a uniform way */
> -	if (likely(irqnr > 15)) {
> -		int err;
> -
> -		if (static_branch_likely(&supports_deactivate_key))
> -			gic_write_eoir(irqnr);
> -		else
> -			isb();
> -
> -		err = handle_domain_irq(gic_data.domain, irqnr, regs);
> -		if (err) {
> -			WARN_ONCE(true, "Unexpected interrupt received!\n");
> -			gic_deactivate_unhandled(irqnr);
> -		}
> -		return;
> -	}
> -	if (irqnr < 16) {
> +	if (static_branch_likely(&supports_deactivate_key))
>               gic_write_eoir(irqnr);
> -		if (static_branch_likely(&supports_deactivate_key))
> -			gic_write_dir(irqnr);
> -#ifdef CONFIG_SMP
> -		/*
> -		 * Unlike GICv2, we don't need an smp_rmb() here.
> -		 * The control dependency from gic_read_iar to
> -		 * the ISB in gic_write_eoir is enough to ensure
> -		 * that any shared data read by handle_IPI will
> -		 * be read after the ACK.
> -		 */

Isn't that still relevant?

Also, while staring at this it dawned on me that IPI's don't need the
eoimode=0 isb(): due to how the IPI flow-handler is structured, we'll get a
gic_eoi_irq() just before calling into the irqaction. Dunno how much we
care about it.

> -		handle_IPI(irqnr, regs);
> -#else
> -		WARN_ONCE(true, "Unexpected SGI received!\n");
> -#endif
> +	else
> +		isb();
> +
> +	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
> +		WARN_ONCE(true, "Unexpected interrupt received!\n");
> +		gic_deactivate_unhandled(irqnr);
>       }
>  }
>
