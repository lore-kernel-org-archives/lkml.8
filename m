Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EEBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A2520728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589631106;
	bh=wrMFzf+QBFblU189yRzbGWglv3qwzLmaHvcvHlV0GUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Orp3LZRMyIRjtf/tmZARIFEqssDlKicQ1ELVDDmwubkGLnOa6CpBXpPHoZCfiBlnS
	 wDa/d9IdzNu+evhZ/NDrem1eqkCUPz3gECydIlpqVzkSaKBrUgeBCh8ttEzKr9E23H
	 sK09V8yr18UxVpm0kyk4mnSm7z6kT3fQdzIATw9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPMLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPMLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:11:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C11D20657;
        Sat, 16 May 2020 12:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589631104;
        bh=wrMFzf+QBFblU189yRzbGWglv3qwzLmaHvcvHlV0GUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cZUTWWofrxjhsMrtbblojBWSTAuVWrw2XfAsy+QYwUuumLbri+luonsWq2TXbojcm
         mfDYXurSW0VN2DlmyjAuIgiP0aLq+iJ5DWW4JtcTSZ0MssmCZTKdOnNS1RK+bXSxTA
         PvbQ6LY1xv4i5CPuT+x3nynooAgmFy78LUzhZPuw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZvfK-00Co1D-He; Sat, 16 May 2020 13:11:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 13:11:42 +0100
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
Subject: Re: [PATCH 1/4] irqchip/sifive-plic: Setup cpuhp once after current
 handler is present
In-Reply-To: <20200516063901.18365-2-anup.patel@wdc.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-2-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d4e0dcceecad49e71ffe785f8950981d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 2020-05-16 07:38, Anup Patel wrote:
> For multiple PLIC instances, the plic_init() is called once for each
> PLIC instance. Due to this we have two issues:
> 1. cpuhp_setup_state() is called multiple times
> 2. plic_starting_cpu() can crash for boot CPU if cpuhp_setup_state()
>    is called before boot CPU PLIC handler is available.
> 
> This patch fixes both above issues.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index 822e074c0600..7dc23edb3267 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -76,6 +76,7 @@ struct plic_handler {
>  	void __iomem		*enable_base;
>  	struct plic_priv	*priv;
>  };
> +static bool plic_cpuhp_setup_done;
>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> 
>  static inline void plic_toggle(struct plic_handler *handler,
> @@ -282,6 +283,7 @@ static int __init plic_init(struct device_node 
> *node,
>  	int error = 0, nr_contexts, nr_handlers = 0, i;
>  	u32 nr_irqs;
>  	struct plic_priv *priv;
> +	struct plic_handler *handler;
> 
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -310,7 +312,6 @@ static int __init plic_init(struct device_node 
> *node,
> 
>  	for (i = 0; i < nr_contexts; i++) {
>  		struct of_phandle_args parent;
> -		struct plic_handler *handler;
>  		irq_hw_number_t hwirq;
>  		int cpu, hartid;
> 
> @@ -364,9 +365,18 @@ static int __init plic_init(struct device_node 
> *node,
>  		nr_handlers++;
>  	}
> 
> -	cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> +	/*
> +	 * We can have multiple PLIC instances so setup cpuhp state only
> +	 * when context handler for current/boot CPU is present.
> +	 */
> +	handler = this_cpu_ptr(&plic_handlers);
> +	if (handler->present && !plic_cpuhp_setup_done) {

If there is no context handler for the boot CPU, the system is doomed,
right? It isn't able to get any interrupt, and you don't register
the hotplug notifier that could allow secondary CPUs to boot.

So what is the point? It feels like you should just give up here.

Also, the boot CPU is always CPU 0. So checking that you only register
the hotplug notifier from CPU 0 should be enough.

> +		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>  				  "irqchip/sifive/plic:starting",
>  				  plic_starting_cpu, plic_dying_cpu);
> +		plic_cpuhp_setup_done = true;
> +	}
> +
>  	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
>  		nr_irqs, nr_handlers, nr_contexts);
>  	set_handle_irq(plic_handle_irq);

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
