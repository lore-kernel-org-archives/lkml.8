Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5845C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50C520768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGQWzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:55:46 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33509 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:55:45 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6DEB7E0004;
        Fri, 17 Jul 2020 22:55:43 +0000 (UTC)
Date:   Sat, 18 Jul 2020 00:55:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ARM: at91: pm: add missing put_device() call in
 at91_pm_sram_init()
Message-ID: <20200717225542.GZ3428@piout.net>
References: <20200604123301.3905837-1-yukuai3@huawei.com>
 <20200702200915.GC6538@piout.net>
 <01fd6279-524e-3cee-4c16-5b748a49d0f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fd6279-524e-3cee-4c16-5b748a49d0f0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 09:15:20+0800, yukuai (C) wrote:
> 
> On 2020/7/3 4:09, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 04/06/2020 20:33:01+0800, yu kuai wrote:
> > > if of_find_device_by_node() succeed, at91_pm_sram_init() doesn't have
> > > a corresponding put_device(). Thus add a jump target to fix the exception
> > > handling for this function implementation.
> > > 
> > > Fixes: d2e467905596 ("ARM: at91: pm: use the mmio-sram pool to access SRAM")
> > > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > > ---
> > >   arch/arm/mach-at91/pm.c | 11 ++++++++---
> > >   1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> > > index 074bde64064e..2aab043441e8 100644
> > > --- a/arch/arm/mach-at91/pm.c
> > > +++ b/arch/arm/mach-at91/pm.c
> > > @@ -592,13 +592,13 @@ static void __init at91_pm_sram_init(void)
> > >   	sram_pool = gen_pool_get(&pdev->dev, NULL);
> > 
> > Isn't the best solution to simply have put_device hereHi, Alexandre !
> 
> I think put_device() is supposed to be called in the exception handling
> path.
> 
> > 
> > >   	if (!sram_pool) {
> > >   		pr_warn("%s: sram pool unavailable!\n", __func__);
> > > -		return;
> > > +		goto out_put_device;
> > >   	}
> > >   	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
> > >   	if (!sram_base) {
> > >   		pr_warn("%s: unable to alloc sram!\n", __func__);
> > > -		return;
> > > +		goto out_put_device;
> > >   	}
> > >   	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> > > @@ -606,12 +606,17 @@ static void __init at91_pm_sram_init(void)
> > >   					at91_pm_suspend_in_sram_sz, false);
> > >   	if (!at91_suspend_sram_fn) {
> > >   		pr_warn("SRAM: Could not map\n");
> > > -		return;
> > > +		goto out_put_device;
> > >   	}
> > >   	/* Copy the pm suspend handler to SRAM */
> > >   	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
> > >   			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
> 
> If nothing is wrong, maybe put_device shounld't be called?
> 

I don't think this is the case but as the reference implementation
(imx6) is carrying the patch, I'm going to apply this one.

A better fix would have been to also factorize imx_suspend_alloc_ocram,
imx6q_suspend_init, socfpga_setup_ocram_self_refresh and
at91_pm_sram_init as they were all copied from pm-imx6.c


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
