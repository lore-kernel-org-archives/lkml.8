Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB61C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A9920890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGBUJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:09:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39009 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:09:18 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D1CCFC0004;
        Thu,  2 Jul 2020 20:09:15 +0000 (UTC)
Date:   Thu, 2 Jul 2020 22:09:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ARM: at91: pm: add missing put_device() call in
 at91_pm_sram_init()
Message-ID: <20200702200915.GC6538@piout.net>
References: <20200604123301.3905837-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604123301.3905837-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/06/2020 20:33:01+0800, yu kuai wrote:
> if of_find_device_by_node() succeed, at91_pm_sram_init() doesn't have
> a corresponding put_device(). Thus add a jump target to fix the exception
> handling for this function implementation.
> 
> Fixes: d2e467905596 ("ARM: at91: pm: use the mmio-sram pool to access SRAM")
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  arch/arm/mach-at91/pm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 074bde64064e..2aab043441e8 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -592,13 +592,13 @@ static void __init at91_pm_sram_init(void)
>  	sram_pool = gen_pool_get(&pdev->dev, NULL);

Isn't the best solution to simply have put_device here?

>  	if (!sram_pool) {
>  		pr_warn("%s: sram pool unavailable!\n", __func__);
> -		return;
> +		goto out_put_device;
>  	}
>  
>  	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
>  	if (!sram_base) {
>  		pr_warn("%s: unable to alloc sram!\n", __func__);
> -		return;
> +		goto out_put_device;
>  	}
>  
>  	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> @@ -606,12 +606,17 @@ static void __init at91_pm_sram_init(void)
>  					at91_pm_suspend_in_sram_sz, false);
>  	if (!at91_suspend_sram_fn) {
>  		pr_warn("SRAM: Could not map\n");
> -		return;
> +		goto out_put_device;
>  	}
>  
>  	/* Copy the pm suspend handler to SRAM */
>  	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
>  			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
> +	return;
> +
> +out_put_device:
> +	put_device(&pdev->dev);
> +	return;
>  }
>  
>  static bool __init at91_is_pm_mode_active(int pm_mode)
> -- 
> 2.25.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
