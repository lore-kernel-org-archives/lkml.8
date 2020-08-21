Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389F120732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHUFxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:53:04 -0400
Received: from david.siemens.de ([192.35.17.14]:48803 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHUFxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:53:03 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07L5qvHm020591
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 07:52:57 +0200
Received: from [167.87.31.209] ([167.87.31.209])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07L5quhT004494;
        Fri, 21 Aug 2020 07:52:56 +0200
Subject: Re: [PATCH v5] phy: omap-usb2-phy: disable PHY charger detect
To:     Roger Quadros <rogerq@ti.com>, kishon@ti.com
Cc:     nsekhar@ti.com, vigneshr@ti.com, linux-kernel@vger.kernel.org
References: <20200820133937.32504-1-rogerq@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a7eb78d8-e6af-e204-49ac-1bc12a706053@siemens.com>
Date:   Fri, 21 Aug 2020 07:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820133937.32504-1-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.20 15:39, Roger Quadros wrote:
> AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
> could cause enumeration failure with some USB hubs.  Disabling the
> USB2_PHY Charger Detect function will put D+ into the normal state.
> 
> This addresses Silicon Errata:
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
> Presence"
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
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
>  
>  #define USB2PHY_ANA_CONFIG1		0x4c
>  #define USB2PHY_DISCON_BYP_LATCH	BIT(31)
>  
> +#define USB2PHY_CHRG_DET			0x14
> +#define USB2PHY_CHRG_DET_USE_CHG_DET_REG	BIT(29)
> +#define USB2PHY_CHRG_DET_DIS_CHG_DET		BIT(28)
> +
>  /* SoC Specific USB2_OTG register definitions */
>  #define AM654_USB2_OTG_PD		BIT(8)
>  #define AM654_USB2_VBUS_DET_EN		BIT(5)
> @@ -43,6 +48,7 @@
>  #define OMAP_USB2_HAS_START_SRP			BIT(0)
>  #define OMAP_USB2_HAS_SET_VBUS			BIT(1)
>  #define OMAP_USB2_CALIBRATE_FALSE_DISCONNECT	BIT(2)
> +#define OMAP_USB2_DISABLE_CHRG_DET		BIT(3)
>  
>  struct omap_usb {
>  	struct usb_phy		phy;
> @@ -236,6 +242,13 @@ static int omap_usb_init(struct phy *x)
>  		omap_usb_writel(phy->phy_base, USB2PHY_ANA_CONFIG1, val);
>  	}
>  
> +	if (phy->flags & OMAP_USB2_DISABLE_CHRG_DET) {
> +		val = omap_usb_readl(phy->phy_base, USB2PHY_CHRG_DET);
> +		val |= USB2PHY_CHRG_DET_USE_CHG_DET_REG |
> +		       USB2PHY_CHRG_DET_DIS_CHG_DET;
> +		omap_usb_writel(phy->phy_base, USB2PHY_CHRG_DET, val);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -329,6 +342,26 @@ static const struct of_device_id omap_usb2_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
>  
> +static void omap_usb2_init_errata(struct omap_usb *phy)
> +{
> +	static const struct soc_device_attribute am65x_sr10_soc_devices[] = {
> +		{ .family = "AM65X", .revision = "SR1.0" },
> +		{ /* sentinel */ }
> +	};
> +
> +	/*
> +	 * Errata i2075: USB2PHY: USB2PHY Charger Detect is Enabled by
> +	 * Default Without VBUS Presence.
> +	 *
> +	 * AM654x SR1.0 has a silicon bug due to which D+ is pulled high after
> +	 * POR, which could cause enumeration failure with some USB hubs.
> +	 * Disabling the USB2_PHY Charger Detect function will put D+
> +	 * into the normal state.
> +	 */
> +	if (soc_device_match(am65x_sr10_soc_devices))
> +		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
> +}
> +
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
>  	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
>  	if (IS_ERR(phy->wkupclk)) {
>  		if (PTR_ERR(phy->wkupclk) == -EPROBE_DEFER)
> 

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
