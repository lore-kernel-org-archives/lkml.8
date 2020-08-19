Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B20E2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHSJDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:03:01 -0400
Received: from gecko.sbs.de ([194.138.37.40]:58563 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgHSJDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:03:00 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07J92gdZ019875
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 11:02:42 +0200
Received: from [167.87.31.209] ([167.87.31.209])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07J92fJD018281;
        Wed, 19 Aug 2020 11:02:42 +0200
Subject: Re: [PATCH v4 3/3] phy: omap-usb2-phy: disable PHY charger detect
To:     Roger Quadros <rogerq@ti.com>, kishon@ti.com
Cc:     robh+dt@kernel.org, nsekhar@ti.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bin Liu <b-liu@ti.com>
References: <20200716082252.21266-1-rogerq@ti.com>
 <20200716082252.21266-4-rogerq@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ef391fb2-c75e-5b35-b3e2-96db21c66ab3@siemens.com>
Date:   Wed, 19 Aug 2020 11:02:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200716082252.21266-4-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.20 10:22, Roger Quadros wrote:
> AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
> could cause enumeration failure with some USB hubs.  Disabling the
> USB2_PHY Charger Detect function will put D+ into the normal state.
> 
> Using property "ti,disable-charger-det" in the DT usb2-phy node to
> enable this workaround for AM654x PG1.0.
> 
> This addresses Silicon Errata:
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
> Presence"
> 
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/phy/ti/phy-omap-usb2.c | 35 +++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index cb2dd3230fa7..21c3904d4efc 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -26,6 +26,10 @@
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
> @@ -43,6 +47,7 @@
>  #define OMAP_USB2_HAS_START_SRP			BIT(0)
>  #define OMAP_USB2_HAS_SET_VBUS			BIT(1)
>  #define OMAP_USB2_CALIBRATE_FALSE_DISCONNECT	BIT(2)
> +#define OMAP_USB2_DISABLE_CHRG_DET		BIT(3)
>  
>  struct omap_usb {
>  	struct usb_phy		phy;
> @@ -236,6 +241,13 @@ static int omap_usb_init(struct phy *x)
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
> @@ -366,14 +378,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
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
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(phy->phy_base))
> +		return PTR_ERR(phy->phy_base);
>  
>  	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
>  							"syscon-phy-power");
> @@ -405,6 +415,17 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * Errata i2075: USB2PHY: USB2PHY Charger Detect is Enabled by
> +	 * Default Without VBUS Presence.
> +	 *
> +	 * AM654x SR1.0 has a silicon bug due to which D+ is pulled high after
> +	 * POR, which could cause enumeration failure with some USB hubs.
> +	 * Disabling the USB2_PHY Charger Detect function will put D+
> +	 * into the normal state.
> +	 */
> +	if (of_property_read_bool(node, "ti,disable-charger-det"))
> +		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
>  
>  	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
>  	if (IS_ERR(phy->wkupclk)) {
> 

Why a property, rather than SoC detection like in [1] and your previous
downstream version?

Jan

[1] https://patchwork.kernel.org/patch/11710643/

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
