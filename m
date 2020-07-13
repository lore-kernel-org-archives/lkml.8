Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67353C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4105620724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594616926;
	bh=l9woS6qlWWRbrNRtwz0odix51LNFvdItegOJQMN4QOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UZV/rI1bdsWHFkO1Y2RN8KhWaf6sahnCVq0v7U33Jj4r+HuzzAet1SDYqWlCUmHaf
	 r3kgHY1pa/qRF4IBLCbxaNEmWS0riIZ1vx/AS4sdPKTywfNSV1FNpDWSMU7keEB+fu
	 clCS+z3un5h9XzPlgHJ0VY4Obou6kadeE6L/eyCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgGMFIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMFIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:08:44 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E4420724;
        Mon, 13 Jul 2020 05:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594616923;
        bh=l9woS6qlWWRbrNRtwz0odix51LNFvdItegOJQMN4QOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYiltRdQJZKiHRMk4Fr6TeJWi9EeeW1TfU3hOq0LI+1tD7pe/w6hlEfUE8I7aLrL7
         ETUVNB57QxqlVMatJrqRM6R/BKEk7vf0IyOH7xpS4j/7lr73Hsa7gd054VyIVkzTRt
         o77PmUklaw7BbAcaxgwTjWpL4vSTeqS6ZW5G2ZvY=
Date:   Mon, 13 Jul 2020 10:38:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <20200713050839.GS34333@vkoul-mobl>
References: <20200702010649.16323-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702010649.16323-1-liambeguin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 21:06, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Start by reading the content of the VENDOR_SPECIFIC2 register and update
> each bit field based on device properties when defined.
> 
> The use of bit masks prevents fields from overriding each other and
> enables users to clear bits which are set by default, like datapolarity
> in this instance.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/phy/ti/phy-tusb1210.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> index d8d0cc11d187..a957655ebd36 100644
> --- a/drivers/phy/ti/phy-tusb1210.c
> +++ b/drivers/phy/ti/phy-tusb1210.c
> @@ -13,9 +13,9 @@
>  #include <linux/phy/ulpi_phy.h>
>  
>  #define TUSB1210_VENDOR_SPECIFIC2		0x80
> -#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
> -#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
> -#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
> +#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	0x0f
> +#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	0x30

Why not be better and use GENMASK(3, 0) and GENMASK(5, 4) for these

> +#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
>  
>  struct tusb1210 {
>  	struct ulpi *ulpi;
> @@ -118,22 +118,25 @@ static int tusb1210_probe(struct ulpi *ulpi)
>  	 * diagram optimization and DP/DM swap.
>  	 */
>  
> +	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> +
>  	/* High speed output drive strength configuration */
> -	device_property_read_u8(&ulpi->dev, "ihstx", &val);
> -	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> +	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> +		reg = (reg & ~TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK) |
> +			(val & TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK);

It would be better to use a helper to do this

>  
>  	/* High speed output impedance configuration */
> -	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
> -	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
> +	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
> +		reg = (reg & ~TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK) |
> +			(val & TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK);
>  
>  	/* DP/DM swap control */
> -	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
> -	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
> +	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
> +		reg = (reg & ~TUSB1210_VENDOR_SPECIFIC2_DP_MASK) |
> +			(val & TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
>  
> -	if (reg) {
> -		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
> -		tusb->vendor_specific2 = reg;
> -	}
> +	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
> +	tusb->vendor_specific2 = reg;
>  
>  	tusb->phy = ulpi_phy_create(ulpi, &phy_ops);
>  	if (IS_ERR(tusb->phy))
> 
> base-commit: cd77006e01b3198c75fb7819b3d0ff89709539bb

fatal: bad object cd77006e01b3198c75fb7819b3d0ff89709539bb in
linux-phy.git

-- 
~Vinod
