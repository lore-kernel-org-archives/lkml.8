Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00172072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598198804;
	bh=M+qKs4sYHB7a/nNMfZ2lf2B03KJZbRiuAwhGXzJaCF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AX1IeYa+CKQ17CPFiLPKSfhgQl6sxAgcBz9SJoxiPOAUtX5AjFfvlV47/Imf30BEc
	 kIhIlydhAbqUEzhLMgIxWer+9RJCZPA/iornuga+Pdf3+HXgiftKcD59WrW43O3DBX
	 v5MQ5jipvxvIaaWKM6uUZ05QF/KkKHreY4vZ/T9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHWQGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgHWQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:06:42 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F43120706;
        Sun, 23 Aug 2020 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598198802;
        bh=M+qKs4sYHB7a/nNMfZ2lf2B03KJZbRiuAwhGXzJaCF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPZlD7r5evfFyQ5spG8BYVTagLvCkBlkLuE4t5MvKza0ygAJV2JGCYXsfQLpoV22q
         aij4q+ucmdMWRxh4H7MyJnV0SkiXLmygftz/dI+p8xLvyAWp2/pq/LqDTZjHzU35HS
         371+OEyrYjNlSlI4JJ2tceBt8d84AC4JFP5BUDnA=
Date:   Sun, 23 Aug 2020 21:36:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        balbi@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [RESEND PATCH v8 2/2] phy: Add USB3 PHY support for Intel LGM SoC
Message-ID: <20200823160637.GW2639@vkoul-mobl>
References: <20200817070513.34376-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200817070513.34376-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817070513.34376-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 15:05, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for USB PHY on Intel LGM SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/phy/Kconfig       |  11 ++
>  drivers/phy/Makefile      |   1 +
>  drivers/phy/phy-lgm-usb.c | 278 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/phy/phy-lgm-usb.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index de9362c25c07..01b53f86004c 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -49,6 +49,17 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>  
> +config USB_LGM_PHY
> +	tristate "INTEL Lightning Mountain USB PHY Driver"
> +	depends on USB_SUPPORT

Why is the dependent on USB..? Should that not be other way around?

> +static int get_flipped(struct tca_apb *ta, bool *flipped)
> +{
> +	union extcon_property_value property;
> +	int ret;
> +
> +	ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
> +				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
> +	if (ret) {
> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");
> +		return ret;
> +	}
> +
> +	*flipped = property.intval;
> +
> +	return ret;

return 0 here?

> +static int phy_init(struct usb_phy *phy)
> +{
> +	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);
> +	void __iomem *ctrl1 = phy->io_priv + CTRL1_OFFSET;
> +	int val, ret, i;
> +
> +	if (ta->phy_initialized)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
> +		reset_control_deassert(ta->resets[i]);
> +
> +	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE, 10, 10 * 1000);
> +	if (ret) {
> +		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
> +		return ret;
> +	}
> +
> +	writel(readl(ctrl1) | SRAM_EXT_LD_DONE, ctrl1);
> +
> +	ta->phy_initialized = true;
> +	if (!ta->phy.edev) {
> +		writel(TCPC_CONN, ta->phy.io_priv + TCPC_OFFSET);
> +		return phy->set_vbus(phy, true);
> +	}
> +
> +	schedule_work(&ta->wk);

why work for init?

> +static void tca_work(struct work_struct *work)
> +{
> +	struct tca_apb *ta = container_of(work, struct tca_apb, wk);
> +	bool connected;
> +	bool flipped = false;
> +	u32 val;
> +	int ret;
> +
> +	ret = get_flipped(ta, &flipped);

so every time this work is scheduled you are reading from firmware, why..
Typically we should read in probe and store it..

> +	connected = extcon_get_state(ta->phy.edev, EXTCON_USB_HOST) && !ret;

lets handle ret and extcon_get_state separately please

> +	if (connected == ta->connected)
> +		return;
> +
> +	ta->connected = connected;
> +	if (connected) {
> +		val = TCPC_CONN;
> +		if (flipped)
> +			val |= TCPC_FLIPPED;
> +		dev_info(ta->phy.dev, "connected%s\n", flipped ? " flipped" : "");

debug perhaps

> +	} else {
> +		val = TCPC_DISCONN;
> +		dev_info(ta->phy.dev, "disconnected\n");

here too

> +static int vbus_notifier(struct notifier_block *nb, unsigned long evnt, void *ptr)
> +{
> +	return NOTIFY_DONE;
> +}

empty notifier, why bother?

> +static int phy_probe(struct platform_device *pdev)
> +{
> +	struct reset_control *resets[ARRAY_SIZE(CTL_RESETS)];
> +	struct device *dev = &pdev->dev;
> +	struct usb_phy *phy;
> +	struct tca_apb *ta;
> +	int i;
> +
> +	ta = devm_kzalloc(dev, sizeof(*ta), GFP_KERNEL);
> +	if (!ta)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ta);
> +	INIT_WORK(&ta->wk, tca_work);
> +
> +	phy = &ta->phy;
> +	phy->dev = dev;
> +	phy->label = dev_name(dev);
> +	phy->type = USB_PHY_TYPE_USB3;
> +	phy->init = phy_init;
> +	phy->shutdown = phy_shutdown;
> +	phy->set_vbus = phy_set_vbus;
> +	phy->id_nb.notifier_call = id_notifier;
> +	phy->vbus_nb.notifier_call = vbus_notifier;
> +
> +	phy->io_priv = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(phy->io_priv))
> +		return PTR_ERR(phy->io_priv);
> +
> +	ta->vbus = devm_regulator_get(dev, "vbus");
> +	if (IS_ERR(ta->vbus))
> +		return PTR_ERR(ta->vbus);
> +
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

no time lag b/w assert and dessert below?

> +	/*
> +	 * Out-of-band reset of the controller after PHY reset will cause
> +	 * controller malfunctioning, so we should use in-band controller
> +	 * reset only and leave the controller de-asserted here.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
> +		reset_control_deassert(resets[i]);
> +
> +	/* Need to wait at least 20us after de-assert the controller */
> +	usleep_range(20, 100);
> +
> +	return usb_add_phy_dev(phy);

aha, this is usb_phy stuff. 

Kishon this is not really a generic phy driver, should it be in
drivers/phy..?

-- 
~Vinod
