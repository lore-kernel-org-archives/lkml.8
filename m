Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F52C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E23206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589631609;
	bh=nw2Sia0XA65XHVWMqYVds6MhO4JKpPbeVteRggM9X6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cM0yVzQl0sLaHY6GJ2DkcmzhoRKTpbjg1n4LBVJLceDNClKRopf2wQuWAEp/xQrxK
	 9omwRWbAFJ8WWW0v9XHNr1e/Ft2Y2e0MEAwKyGbLT3lQZMgHdf/mL1xaqqSkKVMzWN
	 Mux5BZgl4eba6jPXgZFonfKRMGQUHwiszb18P2/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEPMUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgEPMUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:20:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BC220671;
        Sat, 16 May 2020 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589631608;
        bh=nw2Sia0XA65XHVWMqYVds6MhO4JKpPbeVteRggM9X6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RywIqY9jUZ2i9yasZQmuX628UFtHs7uWrk2dHNRY7bBgka+03jIOAUDSmRRafYAPK
         cCry4nzPCL41GXZXcFgtU6XraqcDI1tHZeIFnTeA4VeVvokttXskYNiffcEWLDkcn5
         M21QP3h9D/SdqZbs40nwJX0FvS9bNAXUvWfp7QlQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZvnS-00Co8e-GD; Sat, 16 May 2020 13:20:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 13:20:06 +0100
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
Subject: Re: [PATCH 2/4] irqchip/sifive-plic: Improve boot prints for multiple
 PLIC instances
In-Reply-To: <20200516063901.18365-3-anup.patel@wdc.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-3-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <718b4b4fd894f74a178d3e38073ffdcc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-16 07:38, Anup Patel wrote:
> We improve PLIC banner to help distinguish multiple PLIC instances
> in boot time prints.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index 7dc23edb3267..2d3db927a551 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -284,6 +284,11 @@ static int __init plic_init(struct device_node 
> *node,
>  	u32 nr_irqs;
>  	struct plic_priv *priv;
>  	struct plic_handler *handler;
> +	struct resource iores;
> +
> +	error = of_address_to_resource(node, 0, &iores);
> +	if (error)
> +		return error;
> 
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -377,8 +382,10 @@ static int __init plic_init(struct device_node 
> *node,
>  		plic_cpuhp_setup_done = true;
>  	}
> 
> -	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
> -		nr_irqs, nr_handlers, nr_contexts);
> +	pr_info("interrupt-controller at 0x%llx "
> +		"(interrupts=%d, contexts=%d, handlers=%d)\n",
> +		(unsigned long long)iores.start, nr_irqs,
> +		nr_contexts, nr_handlers);

Instead of displaying "interrupt controller at ...", why not use the
existing printk format for OF nodes? Something along the lines of

     pr_info("%pOF : mapped %d interrupts with %d handlers for %d 
contexts\n",
             node, nr_irqs, nr_handlers, nr_contexts);

>  	set_handle_irq(plic_handle_irq);
>  	return 0;

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
