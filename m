Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D716C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B223206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589632169;
	bh=JvrhDUMp86FNszye3SbB+cqhFFgDxWeCZ7/NXmVsSJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wEUKCJd2AUFL5CBHhLaUPfz5Y2NQ7fjeAtG7PFGcDWBosChXN03gpM8Os/E8d03d+
	 iTi2vWjX1xZYViZkraStPDP2Bd7i3nYIFk6jmkmIWMsUcKsViIsOM3APsMh0TN9VTV
	 74inh75xdDrCRhrLaG2VQp6DrChdG5yNssgCf0zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEPM32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgEPM32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:29:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F54420671;
        Sat, 16 May 2020 12:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589632167;
        bh=JvrhDUMp86FNszye3SbB+cqhFFgDxWeCZ7/NXmVsSJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i95nq4ml7mfjjkKFdvHi0R0Ze1VbrontEaC9F55UT77rZR25XDkvcgOUxxfTasngu
         lvDtjsaA+eTXvIX58Ah4hqWqD0KH4sOZwlgN+2WygzX2VvmsZIxA8z19Ou7iCxRRL8
         jiNtyKp8agnE1HXOHIJObIjsyWb5HzMAoxPeWQd8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZvwT-00CoGL-1T; Sat, 16 May 2020 13:29:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 13:29:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] irqchip/sifive-plic: Separate irq_chip for muiltiple
 PLIC instances
In-Reply-To: <20200516063901.18365-4-anup.patel@wdc.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-4-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <577f9a16b3dddfadb7c5487ffaef31d8@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-16 07:39, Anup Patel wrote:
> To distinguish interrupts from multiple PLIC instances, we use a
> per-PLIC irq_chip instance with a different name.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index 2d3db927a551..e42fc082ad18 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -60,6 +60,7 @@
>  #define	PLIC_ENABLE_THRESHOLD		0
> 
>  struct plic_priv {
> +	struct irq_chip chip;
>  	struct cpumask lmask;
>  	struct irq_domain *irqdomain;
>  	void __iomem *regs;
> @@ -76,6 +77,7 @@ struct plic_handler {
>  	void __iomem		*enable_base;
>  	struct plic_priv	*priv;
>  };
> +static unsigned int plic_count;
>  static bool plic_cpuhp_setup_done;
>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> 
> @@ -164,20 +166,12 @@ static void plic_irq_eoi(struct irq_data *d)
>  	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>  }
> 
> -static struct irq_chip plic_chip = {
> -	.name		= "SiFive PLIC",
> -	.irq_mask	= plic_irq_mask,
> -	.irq_unmask	= plic_irq_unmask,
> -	.irq_eoi	= plic_irq_eoi,
> -#ifdef CONFIG_SMP
> -	.irq_set_affinity = plic_set_affinity,
> -#endif
> -};
> -
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  			      irq_hw_number_t hwirq)
>  {
> -	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> +	struct plic_priv *priv = d->host_data;
> +
> +	irq_domain_set_info(d, irq, hwirq, &priv->chip, d->host_data,
>  			    handle_fasteoi_irq, NULL, NULL);
>  	irq_set_noprobe(irq);
>  	return 0;
> @@ -294,6 +288,14 @@ static int __init plic_init(struct device_node 
> *node,
>  	if (!priv)
>  		return -ENOMEM;
> 
> +	priv->chip.name = kasprintf(GFP_KERNEL, "PLIC%d", plic_count++);
> +	priv->chip.irq_mask = plic_irq_mask,
> +	priv->chip.irq_unmask = plic_irq_unmask,
> +	priv->chip.irq_eoi = plic_irq_eoi,
> +#ifdef CONFIG_SMP
> +	priv->chip.irq_set_affinity = plic_set_affinity,
> +#endif
> +
>  	priv->regs = of_iomap(node, 0);
>  	if (WARN_ON(!priv->regs)) {
>  		error = -EIO;
> @@ -383,9 +385,9 @@ static int __init plic_init(struct device_node 
> *node,
>  	}
> 
>  	pr_info("interrupt-controller at 0x%llx "
> -		"(interrupts=%d, contexts=%d, handlers=%d)\n",
> +		"(interrupts=%d, contexts=%d, handlers=%d) (%s)\n",
>  		(unsigned long long)iores.start, nr_irqs,
> -		nr_contexts, nr_handlers);
> +		nr_contexts, nr_handlers, priv->chip.name);
>  	set_handle_irq(plic_handle_irq);
>  	return 0;

I really dislike this patch for multiple reasons:

- Allocating a new struc irq_chip just for a string seems over the top,
   specially as all the *useful* stuff stays the same.

- Even if I hate it, /proc is API. I'm sure something, somewhere is
   parsing this. Changing the string is likely to confuse it.

- If you do this for debug purposes, then CONFIG_GENERIC_IRQ_DEBUGFS
   is the right way to look up the information.

- If, for reasons that are beyond me, you actually *need* this, then
   implementing irq_print_chip in your irq_chip structure is the way
   to go.

But frankly, I'd rather you drop this altogether.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
