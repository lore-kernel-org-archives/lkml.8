Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4963C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD172073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598872919;
	bh=luuKNVi+KwBr1ekM6udfXcrivJveuP/tHqNrnFBYWzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2hoiHCj3QCll8Lyo2Y45QuKbEJ6R5C7YjqdPOJvUzNTCB1CfPONlsAMsXJPjvpPpj
	 qzA1nN9sPb0l5vUQen51wVOoBa1/33n3nmDcDPzad/Y29nJ+wFWiyUcNPukD8ahiIe
	 vFLIOo0wazHOq/3F9EEE8F90nusZ6Z+6ttACRRL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHaLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgHaLR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:17:58 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0162D206F0;
        Mon, 31 Aug 2020 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598872136;
        bh=luuKNVi+KwBr1ekM6udfXcrivJveuP/tHqNrnFBYWzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9i5JjFRgd6CT0v9YoaM43xpHDTkyeMvqzq3Ssb0Bwy66dDENHm+T2c4kSr9F6e5F
         yEMdfTYkuFjp5dQur7ohdLp0G40YvgqkgngONSvuR2XT1YwwpxfCQsGF1eAe8OHKhd
         h9qDDRaJm9JIIW54F64ilO+Gwlnky3sIxbz/qE8Y=
Date:   Mon, 31 Aug 2020 16:38:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     geert@linux-m68k.org, kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <20200831110852.GO2639@vkoul-mobl>
References: <20200822205320.9746-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822205320.9746-1-liambeguin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On 22-08-20, 16:53, Liam Beguin wrote:
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
> Changes since v1:
> - use set_mask_bits
> 
> Changes since v2:
> - fix missing bit shift dropped in v2
> - rebase on 5.9-rc1
> 
> Changes since v3:
> - switch to u8p_replace_bits() since there's little reason to protect
>   against concurrent access
> 
>  drivers/phy/ti/phy-tusb1210.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> index d8d0cc11d187..a63213f5972a 100644
> --- a/drivers/phy/ti/phy-tusb1210.c
> +++ b/drivers/phy/ti/phy-tusb1210.c
> @@ -7,15 +7,16 @@
>   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>   */
>  #include <linux/module.h>
> +#include <linux/bitfield.h>
>  #include <linux/ulpi/driver.h>
>  #include <linux/ulpi/regs.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/phy/ulpi_phy.h>
>  
>  #define TUSB1210_VENDOR_SPECIFIC2		0x80
> -#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
> -#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
> -#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
> +#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	GENMASK(3, 0)
> +#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	GENMASK(5, 4)
> +#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
>  
>  struct tusb1210 {
>  	struct ulpi *ulpi;
> @@ -118,22 +119,22 @@ static int tusb1210_probe(struct ulpi *ulpi)
>  	 * diagram optimization and DP/DM swap.
>  	 */
>  
> +	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> +
>  	/* High speed output drive strength configuration */
> -	device_property_read_u8(&ulpi->dev, "ihstx", &val);
> -	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> +	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> +		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK);

Any reason for using u8p_replace_bits and not u8_replace_bits? 

Also please drop the u8 casts above, they seem unnecessary here

>  
>  	/* High speed output impedance configuration */
> -	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
> -	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
> +	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
> +		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK);
>  
>  	/* DP/DM swap control */
> -	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
> -	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
> +	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
> +		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
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
> base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
> -- 
> 2.27.0

-- 
~Vinod
