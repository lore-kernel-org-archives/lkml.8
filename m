Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D89DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0726C207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgFSJYL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFSJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:24:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D9C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:24:10 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jmDFj-0003J1-B5; Fri, 19 Jun 2020 11:24:03 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jmDFc-0005gQ-2L; Fri, 19 Jun 2020 11:23:56 +0200
Message-ID: <8eca5ec8f892f38d2b174c4d4b26c7d4fbdd69c4.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 19 Jun 2020 11:23:55 +0200
In-Reply-To: <20200619085124.4029400-3-noltari@gmail.com>
References: <20200619085124.4029400-1-noltari@gmail.com>
         <20200619085124.4029400-3-noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Álvaro,

On Fri, 2020-06-19 at 10:51 +0200, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
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
[...]
> diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> new file mode 100644
> index 000000000000..79f913d86def
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
[...]
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
> +	usbh->reset = devm_reset_control_get(dev, NULL);

Please use devm_reset_control_get_exclusive() instead.

regards
Philipp
