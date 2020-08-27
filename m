Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7D22CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgH0MuT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:50:19 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43647 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgH0MqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:46:19 -0400
X-Originating-IP: 77.204.107.57
Received: from xps13 (57.107.204.77.rev.sfr.net [77.204.107.57])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 37F96E0008;
        Thu, 27 Aug 2020 12:46:02 +0000 (UTC)
Date:   Thu, 27 Aug 2020 14:46:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     James Bond <jameslouisebond@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryan Jackson <rjackson@lnxi.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: ck804xrom: fix missing pci device put in error
 paths
Message-ID: <20200827144600.2ec7c4ab@xps13>
In-Reply-To: <20200821070537.30317-1-jameslouisebond@gmail.com>
References: <20200821070537.30317-1-jameslouisebond@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

James Bond <jameslouisebond@gmail.com> wrote on Fri, 21 Aug 2020
02:05:36 -0500:

> pci_dev_get increases the refcount of "pdev".
> In the error paths, pci_dev_put should be called
> to handle the "pdev" and decrease the corresponding refcount.
> 
> Fixes: 90afffc8bd79 ("[MTD] [MAPS] Support for BIOS flash chips on the nvidia ck804 southbridge")
> Signed-off-by: James Bond <jameslouisebond@gmail.com>
> ---
>  drivers/mtd/maps/ck804xrom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
> index 460494212f6a..16af8b5ee653 100644
> --- a/drivers/mtd/maps/ck804xrom.c
> +++ b/drivers/mtd/maps/ck804xrom.c
> @@ -195,6 +195,7 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
>  	if (!window->virt) {
>  		printk(KERN_ERR MOD_NAME ": ioremap(%08lx, %08lx) failed\n",
>  			window->phys, window->size);
> +		pci_dev_put(pdev);
>  		goto out;
>  	}
>  
> @@ -222,6 +223,7 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
>  
>  		if (!map) {
>  			printk(KERN_ERR MOD_NAME ": kmalloc failed");
> +			pci_dev_put(pdev);
>  			goto out;
>  		}
>  		memset(map, 0, sizeof(*map));
> @@ -295,6 +297,7 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
>  		if (mtd_device_register(map->mtd, NULL, 0)) {
>  			map_destroy(map->mtd);
>  			map->mtd = NULL;
> +			pci_dev_put(pdev);
>  			goto out;
>  		}
>  

I suppose in these three cases, the window->maps list will be empty and
you will end up returning -ENODEV and the bottom of the function? If
yes, it woudl probably be better to move these pci_dev_put() calls to
this location.

Otherwise, it might bit interesting to clean up a little bit the error
path and perhaps have a distinct success vs. failure path.


Thanks,
Miquèl
