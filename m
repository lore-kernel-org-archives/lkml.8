Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF4C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8681C2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199043;
	bh=y+p42uaIJRU0A6A1mK6c1EEMZS77qwTA9XDh2t+6/nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A0IMI6zaC5TYryvQNIyK3EzUE2LgSiDV9Pvz/VojUIIyi8N0LGtjr/Ba+emejQHVn
	 KQB/s7Ox0TOv31fVTkUJtw1Q0mmZVxFIvNZJm/+6A0KQ6n2gz8qX1EqLXmL4khFjkf
	 UsPmvvykZ912MucYuFkwUnnUzYf9B+b1Gfs/6g7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHWQKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgHWQKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:10:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F79204FD;
        Sun, 23 Aug 2020 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199040;
        bh=y+p42uaIJRU0A6A1mK6c1EEMZS77qwTA9XDh2t+6/nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zU/EWfU0b33+P65zCqO2q0L85Hw/GGYREtFZ8WY21iu3W/jEbLOlheQ4Y7RxxBsSF
         Ni9QwO0PH8YXT7g2YEqZ8W4e+cnleW829M/7T1N+EqJuzCCrRurEhmac6JTOaUKe5F
         GmUlZBQH/xT4mOlkKI5cN+jTiITQQvs+V6DPdwt0=
Date:   Sun, 23 Aug 2020 21:40:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, nsekhar@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] phy: omap-usb2-phy: disable PHY charger detect
Message-ID: <20200823161036.GY2639@vkoul-mobl>
References: <20200821080356.17103-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821080356.17103-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 11:03, Roger Quadros wrote:
> AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
> could cause enumeration failure with some USB hubs.  Disabling the
> USB2_PHY Charger Detect function will put D+ into the normal state.
> 
> This addresses Silicon Errata:
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
> Presence"
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> Vinod/Kishon,
> 
> As this is an errata fix, it should be targetted for 5.9-rc cycle.
> Thanks.
> 
> cheers,
> -roger
> 
> Changelog:
> v5
> - don't use dt property to enable workaround. Use soc_device_match() instead.
> 
> v4
> - fix example to fix dt_binding_check warnings
> - '#phy-cells' -> "#phy-cells"
> - Add 'oneOf' to compatible logic to allow just "ti,omap-usb2" as valid
> 
> v3
> - Removed quotes from compatibles
> - changed property to "ti,disable-charger-det"
> 
> v2
> - Address Rob's comments on YAML schema.
> 
>  drivers/phy/ti/phy-omap-usb2.c | 70 +++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index cb2dd3230fa7..65d73142d4ec 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -6,26 +6,31 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/of.h>
> -#include <linux/io.h>
> -#include <linux/phy/omap_usb.h>
> -#include <linux/usb/phy_companion.h>
>  #include <linux/clk.h>
> -#include <linux/err.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/phy/omap_control_phy.h>
> +#include <linux/phy/omap_usb.h>
>  #include <linux/phy/phy.h>
> -#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> -#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/usb/phy_companion.h>

Can we do reorder in a separate patch and not in a fixes patch

>  static int omap_usb2_probe(struct platform_device *pdev)
>  {
>  	struct omap_usb	*phy;
> @@ -366,14 +399,14 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  	phy->mask		= phy_data->mask;
>  	phy->power_on		= phy_data->power_on;
>  	phy->power_off		= phy_data->power_off;
> +	phy->flags		= phy_data->flags;
>  
> -	if (phy_data->flags & OMAP_USB2_CALIBRATE_FALSE_DISCONNECT) {
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
> -		if (IS_ERR(phy->phy_base))
> -			return PTR_ERR(phy->phy_base);
> -		phy->flags |= OMAP_USB2_CALIBRATE_FALSE_DISCONNECT;
> -	}
> +	omap_usb2_init_errata(phy);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(phy->phy_base))
> +		return PTR_ERR(phy->phy_base);
>  
>  	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
>  							"syscon-phy-power");
> @@ -405,7 +438,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -

this does not belong to this patch, pls feel free to send a separate one
for this

-- 
~Vinod
