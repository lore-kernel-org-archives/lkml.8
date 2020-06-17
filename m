Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA97C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CBD214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgFQJXP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgFQJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:23:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:23:14 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUHl-0006Tm-AZ; Wed, 17 Jun 2020 11:23:09 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUHj-0001aP-SH; Wed, 17 Jun 2020 11:23:07 +0200
Message-ID: <4897543a82b601b6e568130f749265a794763eaa.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, balbi@kernel.org, robh@kernel.org
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com
Date:   Wed, 17 Jun 2020 11:23:07 +0200
In-Reply-To: <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
         <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
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

Hi Vadivel,

On Wed, 2020-06-17 at 11:58 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for USB PHY on Intel LGM SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/usb/phy/Kconfig       |  11 ++
>  drivers/usb/phy/Makefile      |   1 +
>  drivers/usb/phy/phy-lgm-usb.c | 275 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-lgm-usb.c
> 
[...]
> diff --git a/drivers/usb/phy/phy-lgm-usb.c b/drivers/usb/phy/phy-lgm-usb.c
> new file mode 100644
> index 000000000000..3da772dfd736
> --- /dev/null
> +++ b/drivers/usb/phy/phy-lgm-usb.c
> @@ -0,0 +1,275 @@
[...]
> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++) {
> +		resets[i] = devm_reset_control_get_exclusive(dev, CTL_RESETS[i]);
> +		if (IS_ERR(resets[i])) {
> +			dev_err(dev, "%s reset not found\n", CTL_RESETS[i]);
> +			return PTR_ERR(resets[i]);
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++) {
> +		ta->resets[i] = devm_reset_control_get_exclusive(dev, PHY_RESETS[i]);
> +		if (IS_ERR(ta->resets[i])) {
> +			dev_err(dev, "%s reset not found\n", PHY_RESETS[i]);
> +			return PTR_ERR(ta->resets[i]);
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
> +		reset_control_assert(resets[i]);
> +
> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
> +		reset_control_assert(ta->resets[i]);
> +	/*
> +	 * Out-of-band reset of the controller after PHY reset will cause
> +	 * controller malfunctioning, so we should use in-band controller
> +	 * reset only and leave the controller de-asserted here.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
> +		reset_control_deassert(resets[i]);

This driver could probably benefit from a reset_bulk API similar to the
clk_bulk and regulator_bulk APIs, but that doesn't exist yet.

For the reset handling in this driver,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
