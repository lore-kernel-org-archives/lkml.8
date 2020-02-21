Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52713C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2409524650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285616;
	bh=MmIVHTIib5XbmYmKegaqzUGhvG/1JpO2JkcKz1UU/iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ousaXanrk5yRjhnL7JP4UmKWq+yfjR6cJPE8+5W6x9H4Qv2gNf9IdRuj4Yle9IlP3
	 pucvi0euY3gCa3XLE7Sg3cJEYFW0TxYvXGzRcNzAJuXTcauMmuiQwtzAewODtPzyyW
	 ADwf26dkXU6P3MuELthlsbUpakAaiEza45hQPD3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBULqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBULqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:46:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6054B222C4;
        Fri, 21 Feb 2020 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285613;
        bh=MmIVHTIib5XbmYmKegaqzUGhvG/1JpO2JkcKz1UU/iU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZxYbPIGj/8mA6Nfr1J3xw+Zvf3fhEmi1joXpCEUhS5YqujDjjv+PYVcZ9gRRfdb1
         1khysq58jXEigsFBPLX/Oin/BNF8m2o7gvoIx3t9mPJZwy2rgApci7LNJrFAzWB2jf
         4zmhqz+egyzJhjVZ5LTI0qNac+kJ4mS4QIV/ySkQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j56lf-0071gb-Ns; Fri, 21 Feb 2020 11:46:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 11:46:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] irqchip: xilinx: Use handle_domain_irq()
In-Reply-To: <49c5a093d7ba1f20930c7433ed632e7c9bc7a2cb.1581496793.git.michal.simek@xilinx.com>
References: <cover.1581496793.git.michal.simek@xilinx.com>
 <49c5a093d7ba1f20930c7433ed632e7c9bc7a2cb.1581496793.git.michal.simek@xilinx.com>
Message-ID: <f028666cf1b1af428ad0564c4f93688b@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michal.simek@xilinx.com, linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, stefan.asserhall@xilinx.com, jason@lakedaemon.net, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-12 08:39, Michal Simek wrote:
> Call generic domain specific irq handler which does the most of things
> self. Also get rid of concurrent_irq counting which hasn't been 
> exported
> anywhere.
> Based on this loop was also optimized by using do/while loop instead of
> goto loop.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> ---
> 
>  arch/microblaze/Kconfig           |  1 +
>  arch/microblaze/kernel/irq.c      |  5 ----
>  drivers/irqchip/irq-xilinx-intc.c | 44 +++++++++++--------------------
>  3 files changed, 16 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 3a314aa2efa1..242f58ec086b 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -48,6 +48,7 @@ config MICROBLAZE
>  	select MMU_GATHER_NO_RANGE if MMU
>  	select SPARSE_IRQ
>  	select GENERIC_IRQ_MULTI_HANDLER
> +	select HANDLE_DOMAIN_IRQ
> 
>  # Endianness selection
>  choice
> diff --git a/arch/microblaze/kernel/irq.c 
> b/arch/microblaze/kernel/irq.c
> index 1f8cb4c4f74f..0b37dde60a1e 100644
> --- a/arch/microblaze/kernel/irq.c
> +++ b/arch/microblaze/kernel/irq.c
> @@ -22,13 +22,8 @@
> 
>  void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
> -	struct pt_regs *old_regs = set_irq_regs(regs);
>  	trace_hardirqs_off();
> -
> -	irq_enter();
>  	handle_arch_irq(regs);
> -	irq_exit();
> -	set_irq_regs(old_regs);
>  	trace_hardirqs_on();
>  }
> 
> diff --git a/drivers/irqchip/irq-xilinx-intc.c
> b/drivers/irqchip/irq-xilinx-intc.c
> index ad9e678c24ac..fa468e618762 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -125,20 +125,6 @@ static unsigned int xintc_get_irq_local(struct
> xintc_irq_chip *irqc)
>  	return irq;
>  }
> 
> -static unsigned int xintc_get_irq(void)
> -{
> -	u32 hwirq;
> -	unsigned int irq = -1;
> -
> -	hwirq = xintc_read(primary_intc, IVR);
> -	if (hwirq != -1U)
> -		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
> -
> -	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
> -
> -	return irq;
> -}
> -
>  static int xintc_map(struct irq_domain *d, unsigned int irq,
> irq_hw_number_t hw)
>  {
>  	struct xintc_irq_chip *irqc = d->host_data;
> @@ -178,23 +164,23 @@ static void xil_intc_irq_handler(struct irq_desc 
> *desc)
>  	chained_irq_exit(chip, desc);
>  }
> 
> -static u32 concurrent_irq;
> -
>  static void xil_intc_handle_irq(struct pt_regs *regs)
>  {
> -	unsigned int irq;
> -
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
> +	u32 hwirq;
> +	struct xintc_irq_chip *irqc = primary_intc;
> +
> +	do {
> +		hwirq = xintc_read(irqc, IVR);
> +		if (hwirq != -1U) {
> +			int ret;
> +
> +			ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
> +			WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
> +			continue;
> +		}
> +
> +		break;
> +	} while (1);

OK, so this what I suggested already. Just squash the two patches
in one, there is no point in keeping them separate.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
