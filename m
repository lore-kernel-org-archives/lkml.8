Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC39CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6B7206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590138888;
	bh=sNvSw3IbUgU0YNH4rTVZO9VBdhyYR82XfdDnZlIa0rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pnxq/LhVRb4ksbD0NnEFtK1emQ8/UHb7DBZGdg8LLx8hO9Tk3lYwonjXiZCcJOA8N
	 oSI9kjAJKm6PEagr53/g6i11d+eqTZfNsXRmjydHor2/HC9aDaeUk3UJMKOf3k5ecI
	 1mgFtWjr6YoyjNhWY/j8+UbiM9BEm0gbuB3Yy9QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgEVJOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgEVJOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:14:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47AB5206B6;
        Fri, 22 May 2020 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590138886;
        bh=sNvSw3IbUgU0YNH4rTVZO9VBdhyYR82XfdDnZlIa0rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXioF3YwAd9SccnnH0Vwzkf7appN5O5A2JBs1r134NbiujCNdF61xveBClGlRSz9l
         T1mZmmw0YcxTDfaoutIHZhJzo76p0GFmlJT2WCshGAxucu8+NITyzOgewRd+mlxfVb
         PlQn04S9bumxHTHG+UctXkOVsu8ERheW2ZGdRu5U=
Date:   Fri, 22 May 2020 11:14:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thommy Jakobsson <thommyj@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: disable lazy irq disable to avoid double fire
Message-ID: <20200522091444.GA1192483@kroah.com>
References: <20200521144209.19413-1-thommyj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521144209.19413-1-thommyj@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:42:09PM +0200, Thommy Jakobsson wrote:
> uio_pdrv_genirq and uio_dmem_genirq interrupts are handled in
> userspace. So the condition for the interrupt hasn't normally not been
> cleared when top half returns. disable_irq_nosync is called in top half,
> but since that normally is lazy the irq isn't actually disabled.
> 
> For level triggered interrupts this will always result in a spurious
> additional fire since the level in to the interrupt controller still is
> active. The actual interrupt handler isn't run though since this
> spurious irq is just recorded, and later on discared (for level).
> 
> This commit disables lazy masking for level triggered interrupts. It
> leaves edge triggered interrupts as before, because they work with the
> lazy scheme.
> 
> All other UIO drivers already seem to clear the interrupt cause at
> driver levels.
> 
> Example of double fire. First goes all the way up to
> uio_pdrv_genirq_handler, second is terminated in handle_fasteoi_irq and
> marked as pending.
> 
> <idle>-0 [000] d... 8.245870: gic_handle_irq: irq 29
> <idle>-0 [000] d.h. 8.245873: uio_pdrv_genirq_handler: disable irq 29
> <idle>-0 [000] d... 8.245878: gic_handle_irq: irq 29
> <idle>-0 [000] d.h. 8.245880: handle_fasteoi_irq: irq 29 PENDING
> HInt-34  [001] d... 8.245897: uio_pdrv_genirq_irqcontrol: enable irq 29
> 
> Tested on 5.7rc2 using uio_pdrv_genirq and a custom Xilinx MPSoC board.
> 
> Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
> ---
>  drivers/uio/uio_dmem_genirq.c | 24 ++++++++++++++++++++++++
>  drivers/uio/uio_pdrv_genirq.c | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
> index f6ab3f28c838..14899ed19143 100644
> --- a/drivers/uio/uio_dmem_genirq.c
> +++ b/drivers/uio/uio_dmem_genirq.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
> +#include <linux/irq.h>
>  
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -200,6 +201,29 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
>  			goto bad1;
>  		uioinfo->irq = ret;
>  	}
> +
> +	if (uioinfo->irq) {

How is this not true at this point in time based on the code above this?
->irq should always be set here, right?

> +		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
> +
> +		/*
> +		 * If a level interrupt, dont do lazy disable. Otherwise the
> +		 * irq will fire again since clearing of the actual cause, on
> +		 * device level, is done in userspace
> +		 */
> +		if (!irq_data) {
> +			dev_err(&pdev->dev, "unable to get irq data\n");
> +			ret = -ENXIO;
> +			goto bad1;

Why is not having this information all of a sudden an error for this
code?  What could cause that info to not be there?  Existing systems
without this set would work just fine before this change, and I think
this breaks them, right?

> +		}
> +		/*
> +		 * irqd_is_level_type() isn't used since isn't valid unitil
> +		 * irq is configured.
> +		 */
> +		if (irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
> +			dev_info(&pdev->dev, "disable lazy unmask\n");

Why dev_info?  If drivers are working properly, they should be quiet.
dev_dbg() is fine to use here if you want to debug things to see what is
happening.

> +			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
> +		}
> +	}
>  	uiomem = &uioinfo->mem[0];
>  
>  	for (i = 0; i < pdev->num_resources; ++i) {
> diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
> index ae319ef3a832..abf8e21d7158 100644
> --- a/drivers/uio/uio_pdrv_genirq.c
> +++ b/drivers/uio/uio_pdrv_genirq.c
> @@ -20,6 +20,7 @@
>  #include <linux/stringify.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include <linux/irq.h>
>  
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -171,6 +172,29 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (uioinfo->irq) {

<snip>

All of the same comments I made above in the other file, also apply
here.

thanks,

greg k-h
