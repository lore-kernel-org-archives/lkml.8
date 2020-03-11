Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC48C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E826220873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCKGSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:18:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57420 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgCKGSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:18:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5597968C4E; Wed, 11 Mar 2020 07:18:06 +0100 (CET)
Date:   Wed, 11 Mar 2020 07:18:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] mfd: mfd-core: inherit only valid dma_masks/flags
 from parent
Message-ID: <20200311061806.GB10902@lst.de>
References: <20200310230935.23962-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310230935.23962-1-michael@walle.cc>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:09:35AM +0100, Michael Walle wrote:
> Only copy the dma_masks and flags from the parent device, if the parent
> has a valid dma_mask/flags. Commit cdfee5623290 ("driver core:
> initialize a default DMA mask for platform device") initialize the DMA
> masks of a platform device. But if the parent doesn't have a dma_mask
> set, for example if it's an I2C device, the dma_mask of the child
> platform device will be set to zero again. Which leads to many "DMA mask
> not set" warnings, if the MFD cell has the of_compatible property set.
> 
> [    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
> [    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
> [    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set
> 
> Thus a MFD child should just inherit valid dma_masks and keep the
> platform default otherwise.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> Hi,
> 
> I don't know if that is the correct way of handling things. Maybe I'm
> also doing something wrong in my driver, I had a look at other I2C MFD
> drivers but couldn't find a clue why they shouldn't have the same
> problem.
> 
> There was also a thread [1] about this topic, but there seems to be no
> conclusion.
> 
> [1] https://www.spinics.net/lists/linux-renesas-soc/msg31581.html
> 
>  drivers/mfd/mfd-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index b9eb8f40c073..5d8ea5e8e93c 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -139,9 +139,12 @@ static int mfd_add_device(struct device *parent, int id,
>  
>  	pdev->dev.parent = parent;
>  	pdev->dev.type = &mfd_dev_type;
> -	pdev->dev.dma_mask = parent->dma_mask;
> -	pdev->dev.dma_parms = parent->dma_parms;
> -	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
> +	if (parent->dma_mask)
> +		pdev->dev.dma_mask = parent->dma_mask;
> +	if (parent->dma_parms)
> +		pdev->dev.dma_parms = parent->dma_parms;

Both of these are pointers, and we can't just share them.  You need
to allocate storage for them and the allocate the values over.
