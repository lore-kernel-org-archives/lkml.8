Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B27C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B39024653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285509;
	bh=DN28cyesGvMLBRp+abQEK7tw6NRN/zFrBOEZl5ix8Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IH5TZrGKqYP5kxkXIg5MOKo8p6TVYvJ5zf7dGEdh6L7pIi/2YJIzSZIS4aOawHtQq
	 qDeD+Grm7YVoABuYUmbD2v1mR2uP/CYMYLEJNCtOzI5jNh8K8CGlYwi8ubVoGKNE96
	 HDqZzwg+AJ/u7Zaq7vcbpvhwgsSCc71UzXxfnMkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBULpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgBULpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:45:03 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C402222C4;
        Fri, 21 Feb 2020 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285502;
        bh=DN28cyesGvMLBRp+abQEK7tw6NRN/zFrBOEZl5ix8Ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vrdYqlaBIhgSHR9JsiBJAucF2E+rUbhixe/r+FaVNpFzd5VmdRKUAezofk3z8m+19
         wHX+u+Z3rScWBJfQX2djEUgunSSFnZJ2TSdE02EQwhUw0Wzw/wfyDY1XUNFG0nvj6Z
         ZFAE1hqVGGUaC16hqvy2lt0PXqh6eDrF5GvjLzE0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j56js-0071fC-Rr; Fri, 21 Feb 2020 11:45:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 11:45:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] irqchip: xilinx: Enable generic irq multi handler
In-Reply-To: <5813deafd27acf07b936ef7a2ac029b7a95ee7be.1581496793.git.michal.simek@xilinx.com>
References: <cover.1581496793.git.michal.simek@xilinx.com>
 <5813deafd27acf07b936ef7a2ac029b7a95ee7be.1581496793.git.michal.simek@xilinx.com>
Message-ID: <10c6d32ccb4c087275dab42e8c7f0d82@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michal.simek@xilinx.com, linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, stefan.asserhall@xilinx.com, jason@lakedaemon.net, mubinusm@xilinx.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,

On 2020-02-12 08:39, Michal Simek wrote:
> Register default arch handler via driver instead of directly pointing 
> to
> xilinx intc controller. This patch makes architecture code more 
> generic.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> ---
> 
>  arch/microblaze/Kconfig           |  1 +
>  arch/microblaze/include/asm/irq.h |  3 ---
>  arch/microblaze/kernel/irq.c      | 16 +---------------
>  drivers/irqchip/irq-xilinx-intc.c | 22 +++++++++++++++++++++-
>  4 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 6a331bd57ea8..3a314aa2efa1 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -47,6 +47,7 @@ config MICROBLAZE
>  	select CPU_NO_EFFICIENT_FFS
>  	select MMU_GATHER_NO_RANGE if MMU
>  	select SPARSE_IRQ
> +	select GENERIC_IRQ_MULTI_HANDLER
> 
>  # Endianness selection
>  choice
> diff --git a/arch/microblaze/include/asm/irq.h
> b/arch/microblaze/include/asm/irq.h
> index eac2fb4b3fb9..5166f0893e2b 100644
> --- a/arch/microblaze/include/asm/irq.h
> +++ b/arch/microblaze/include/asm/irq.h
> @@ -14,7 +14,4 @@
>  struct pt_regs;
>  extern void do_IRQ(struct pt_regs *regs);
> 
> -/* should be defined in each interrupt controller driver */
> -extern unsigned int xintc_get_irq(void);
> -
>  #endif /* _ASM_MICROBLAZE_IRQ_H */
> diff --git a/arch/microblaze/kernel/irq.c 
> b/arch/microblaze/kernel/irq.c
> index 903dad822fad..1f8cb4c4f74f 100644
> --- a/arch/microblaze/kernel/irq.c
> +++ b/arch/microblaze/kernel/irq.c
> @@ -20,27 +20,13 @@
>  #include <linux/irqchip.h>
>  #include <linux/of_irq.h>
> 
> -static u32 concurrent_irq;
> -
>  void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
> -	unsigned int irq;
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  	trace_hardirqs_off();
> 
>  	irq_enter();
> -	irq = xintc_get_irq();
> -next_irq:
> -	BUG_ON(!irq);
> -	generic_handle_irq(irq);
> -
> -	irq = xintc_get_irq();
> -	if (irq != -1U) {
> -		pr_debug("next irq: %d\n", irq);
> -		++concurrent_irq;
> -		goto next_irq;
> -	}
> -
> +	handle_arch_irq(regs);
>  	irq_exit();
>  	set_irq_regs(old_regs);

If you're going to embrace common code, maybe you should do it fully,
see below.

>  	trace_hardirqs_on();
> diff --git a/drivers/irqchip/irq-xilinx-intc.c
> b/drivers/irqchip/irq-xilinx-intc.c
> index cf1bb470d7b5..ad9e678c24ac 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -125,7 +125,7 @@ static unsigned int xintc_get_irq_local(struct
> xintc_irq_chip *irqc)
>  	return irq;
>  }
> 
> -unsigned int xintc_get_irq(void)
> +static unsigned int xintc_get_irq(void)
>  {
>  	u32 hwirq;
>  	unsigned int irq = -1;
> @@ -178,6 +178,25 @@ static void xil_intc_irq_handler(struct irq_desc 
> *desc)
>  	chained_irq_exit(chip, desc);
>  }
> 
> +static u32 concurrent_irq;
> +
> +static void xil_intc_handle_irq(struct pt_regs *regs)
> +{
> +	unsigned int irq;
> +
> +	irq = xintc_get_irq();
> +next_irq:
> +	BUG_ON(!irq);

Don't BUG_ON() for something that is probably a spurious interrupt.
Handle it gracefully instead.

> +	generic_handle_irq(irq);
> +
> +	irq = xintc_get_irq();
> +	if (irq != -1U) {
> +		pr_debug("next irq: %d\n", irq);

You already have debug information in xintc_get_irq(). Do you need more?

> +		++concurrent_irq;

What is the purpose of this "concurrent_irq"? It's not concurrent at all
(it is actually broken in an SMP context), and nothing reads it.

> +		goto next_irq;
> +	}

Overall, this could be written in a much more elegant way:

         irq_hw_number_t hwirq;
         do {
                 hwirq = xintc_read(IVR);
                 if (likely(irq != -1UL))
                         handle_domain_irq(xintc_irqc->root_domain,
                                           hwirq, regs);
         } while (hwirq != -1UL);

and you can get rid of most of do_IRQ() (all the set_irq_regs,
irq_enter logic is taken care of) as well as xintc_get_irq().

> +}
> +
>  static int __init xilinx_intc_of_init(struct device_node *intc,
>  					     struct device_node *parent)
>  {
> @@ -248,6 +267,7 @@ static int __init xilinx_intc_of_init(struct
> device_node *intc,
>  	} else {
>  		primary_intc = irqc;
>  		irq_set_default_host(primary_intc->root_domain);
> +		set_handle_irq(xil_intc_handle_irq);
>  	}
> 
>  	return 0;

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
