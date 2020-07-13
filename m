Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF08C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE6D2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594619488;
	bh=WqjUMsam9TwPcBeZzSP9ccMJT5xrxITFuIxjeD2l9z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qjpxkl4ExBSyjLVoi0GZ5A7O4Ih6+TvEVHS++kt1zD95McYOCccpoGmyeLVI5lbEU
	 pfjRadoEC8x5d030r5brPywv3IWmiLeejA7k444K9zfk0a/QxAnKaym5NPgocPcZx/
	 Vyl3zUAFY3GeduaLx4XAaXcy/3fb+T2e3rw9qCVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgGMFv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMFv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:51:27 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8C720724;
        Mon, 13 Jul 2020 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594619486;
        bh=WqjUMsam9TwPcBeZzSP9ccMJT5xrxITFuIxjeD2l9z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzclSa4FVIcYVTzLrOLcMdpqeHRmywH5zXkJj3m51Gm4gcCcmdmamqHjrcXaBk6xv
         FO+yEJOG1q8pQz/iLG0RiGvnana22+gsx5JVGzWM6YC1DL0cOrJjqxqaT2GHGSloQh
         z8/XjUQOgqY2hP9u8XwPSw8iGw1WKN7ww8YxOO2Q=
Date:   Mon, 13 Jul 2020 11:21:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Message-ID: <20200713055122.GA34333@vkoul-mobl>
References: <20200619100035.4032596-1-noltari@gmail.com>
 <20200619100035.4032596-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619100035.4032596-3-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-20, 12:00, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v5: use devm_reset_control_get_exclusive.
>  v4: several improvements:
>   - Use devm_platform_ioremap_resource.
>   - Code cleanups.
>   - Improve device mode config:
>     - Move USBH_SWAP_CONTROL device mode value to variant variable.
>     - Set USBH_UTMI_CONTROL1 register value (variant variable).
>  v3: introduce changes suggested by Florian:
>   - Add support for device mode.
>  v2: introduce changes suggested by Florian:
>   - Drop OF dependency (use device_get_match_data).
>   - Drop __initconst from variant tables.
>   - Use devm_clk_get_optional.
> 
>  drivers/phy/broadcom/Kconfig            |   9 +
>  drivers/phy/broadcom/Makefile           |   1 +
>  drivers/phy/broadcom/phy-bcm63xx-usbh.c | 457 ++++++++++++++++++++++++
>  3 files changed, 467 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c
> 
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index b29f11c19155..a7889df8c541 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -2,6 +2,15 @@
>  #
>  # Phy drivers for Broadcom platforms
>  #
> +config PHY_BCM63XX_USBH
> +	tristate "BCM63xx USBH PHY driver"
> +	depends on BMIPS_GENERIC || COMPILE_TEST
> +	select GENERIC_PHY
> +	default BMIPS_GENERIC

you depend on BMIPS_GENERIC and also use as default?

> +static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm63xx_usbh_phy	*usbh;
> +	const struct bcm63xx_usbh_phy_variant *variant;
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +
> +	usbh = devm_kzalloc(dev, sizeof(*usbh), GFP_KERNEL);
> +	if (!usbh)
> +		return -ENOMEM;
> +
> +	variant = device_get_match_data(dev);
> +	if (!variant)
> +		return -EINVAL;
> +	usbh->variant = variant;
> +
> +	usbh->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(usbh->base))
> +		return PTR_ERR(usbh->base);
> +
> +	usbh->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(usbh->reset)) {
> +		if (PTR_ERR(usbh->reset) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(usbh->reset);
> +	}
> +
> +	usbh->usbh_clk = devm_clk_get_optional(dev, "usbh");
> +	if (IS_ERR(usbh->usbh_clk))
> +		return PTR_ERR(usbh->usbh_clk);
> +
> +	usbh->usb_ref_clk = devm_clk_get_optional(dev, "usb_ref");
> +	if (IS_ERR(usbh->usb_ref_clk))
> +		return PTR_ERR(usbh->usb_ref_clk);
> +
> +	phy = devm_phy_create(dev, NULL, &bcm63xx_usbh_phy_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(phy);
> +	}
> +
> +	platform_set_drvdata(pdev, usbh);
> +	phy_set_drvdata(phy, usbh);
> +
> +	phy_provider = devm_of_phy_provider_register(dev,
> +						     bcm63xx_usbh_phy_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		dev_err(dev, "failed to register PHY provider\n");
> +		return PTR_ERR(phy_provider);
> +	}
> +
> +	dev_info(dev, "Registered BCM63xx USB PHY driver\n");

debug level?
-- 
~Vinod
