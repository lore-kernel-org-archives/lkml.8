Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B95C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9DE2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgCDLlo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:41:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgCDLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:41:44 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9SP7-0001eR-T3; Wed, 04 Mar 2020 12:41:33 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9SP7-0005kZ-6Z; Wed, 04 Mar 2020 12:41:33 +0100
Message-ID: <ac6eb54c01cce4ec52560ac622e024ab47f2136c.camel@pengutronix.de>
Subject: Re: [RFC 10/11] reset: imx: Add audiomix reset controller support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 04 Mar 2020 12:41:33 +0100
In-Reply-To: <1583226206-19758-11-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
         <1583226206-19758-11-git-send-email-abel.vesa@nxp.com>
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

Hi Abel,

On Tue, 2020-03-03 at 11:03 +0200, Abel Vesa wrote:
> The imx-mix MFD driver registers some devices, one of which, in case of
> audiomix, maps correctly to a reset controller type. This driver registers
> a reset controller for that. For now, only the EARC specific resets are added.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/reset/Kconfig                          |   7 ++
>  drivers/reset/Makefile                         |   1 +
>  drivers/reset/reset-imx-audiomix.c             | 122 +++++++++++++++++++++++++
>  include/dt-bindings/reset/imx-audiomix-reset.h |  15 +++
>  4 files changed, 145 insertions(+)
>  create mode 100644 drivers/reset/reset-imx-audiomix.c
>  create mode 100644 include/dt-bindings/reset/imx-audiomix-reset.h
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d9efbfd..2f8d9b3 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -81,6 +81,13 @@ config RESET_INTEL_GW
>  	  Say Y to control the reset signals provided by reset controller.
>  	  Otherwise, say N.
>  
> +config RESET_IMX_AUDIOMIX
> +	bool "i.MX Audiomix Reset Driver" if COMPILE_TEST
> +	depends on HAS_IOMEM
> +	default ARCH_MXC
> +	help
> +	  This enables the audiomix reset controller driver for i.MX SoCs.
> +
>  config RESET_LANTIQ
>  	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
>  	default SOC_TYPE_XWAY
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 249ed35..cf23d38 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> +obj-$(CONFIG_RESET_IMX_AUDIOMIX) += reset-imx-audiomix.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
> diff --git a/drivers/reset/reset-imx-audiomix.c b/drivers/reset/reset-imx-audiomix.c
> new file mode 100644
> index 00000000..d1c62ef
> --- /dev/null
> +++ b/drivers/reset/reset-imx-audiomix.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#include <dt-bindings/reset/imx-audiomix-reset.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset-controller.h>
> +
> +#define IMX_AUDIOMIX_EARC_CTRL_REG	0x200
> +
> +#define IMX_AUDIOMIX_EARC_RESET_BIT	0x0
> +#define IMX_AUDIOMIX_EARC_PHY_RESET_BIT	0x1
> +
> +struct imx_audiomix_reset_data {
> +	void __iomem *base;
> +	struct reset_controller_dev rcdev;
> +	spinlock_t lock;
> +};
> +
> +static int imx_audiomix_reset_set(struct reset_controller_dev *rcdev,
> +			  unsigned long id, bool assert)
> +{
> +	struct imx_audiomix_reset_data *drvdata = container_of(rcdev,
> +			struct imx_audiomix_reset_data, rcdev);
> +	void __iomem *reg_addr = drvdata->base;
> +	unsigned long flags;
> +	unsigned int offset;
> +	u32 reg;
> +
> +	switch (id) {
> +	case IMX_AUDIOMIX_EARC_PHY_RESET:
> +		reg_addr += IMX_AUDIOMIX_EARC_CTRL_REG;
> +		offset = IMX_AUDIOMIX_EARC_PHY_RESET_BIT;
> +		break;
> +	case IMX_AUDIOMIX_EARC_RESET:
> +		reg_addr += IMX_AUDIOMIX_EARC_CTRL_REG;
> +		offset = IMX_AUDIOMIX_EARC_RESET_BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (assert) {
> +		pm_runtime_get_sync(rcdev->dev);

This seems wrong. Why is the runtime PM reference count incremented when
a reset is asserted ...

> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		reg = readl(reg_addr);
> +		writel(reg & ~BIT(offset), reg_addr);
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +	} else {
> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		reg = readl(reg_addr);
> +		writel(reg | BIT(offset), reg_addr);
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +		pm_runtime_put(rcdev->dev);

... and decremented when a reset is deasserted?

Apart from the runtime PM handling this looks like it could reuse reset-
simple.

> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	return imx_audiomix_reset_set(rcdev, id, true);
> +}
> +
> +static int imx_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	return imx_audiomix_reset_set(rcdev, id, false);
> +}
> +
> +static const struct reset_control_ops imx_audiomix_reset_ops = {
> +	.assert		= imx_audiomix_reset_assert,
> +	.deassert	= imx_audiomix_reset_deassert,
> +};
> +
> +static int imx_audiomix_reset_probe(struct platform_device *pdev)
> +{
> +	struct imx_audiomix_reset_data *drvdata;
> +	struct device *dev = &pdev->dev;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (drvdata == NULL)
> +		return -ENOMEM;
> +
> +	drvdata->base = dev_get_drvdata(dev->parent);
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	pm_runtime_enable(dev);
> +
> +	spin_lock_init(&drvdata->lock);
> +
> +	drvdata->rcdev.owner     = THIS_MODULE;
> +	drvdata->rcdev.nr_resets = IMX_AUDIOMIX_RESET_NUM;
> +	drvdata->rcdev.ops       = &imx_audiomix_reset_ops;
> +	drvdata->rcdev.of_node   = dev->of_node;
> +	drvdata->rcdev.dev	 = dev;
> +
> +	return devm_reset_controller_register(dev, &drvdata->rcdev);
> +}
> +
> +static const struct of_device_id imx_audiomix_reset_dt_ids[] = {
> +	{ .compatible = "fsl,imx8mp-audiomix-reset", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver imx_audiomix_reset_driver = {
> +	.probe	= imx_audiomix_reset_probe,
> +	.driver = {
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table	= imx_audiomix_reset_dt_ids,
> +	},
> +};
> +module_platform_driver(imx_audiomix_reset_driver);
> diff --git a/include/dt-bindings/reset/imx-audiomix-reset.h b/include/dt-bindings/reset/imx-audiomix-reset.h
> new file mode 100644
> index 00000000..2e26878
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx-audiomix-reset.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX_AUDIOMIX_H
> +#define DT_BINDING_RESET_IMX_AUDIOMIX_H
> +
> +#define IMX_AUDIOMIX_EARC_RESET		0x0
> +#define IMX_AUDIOMIX_EARC_PHY_RESET	0x1
> +
> +#define IMX_AUDIOMIX_RESET_NUM		2
> +
> +#endif
> +

The imx-audiomix-reset.h change should go into a separate patch,
together with the binding docs for fsl,imx8mp-audiomix-reset.

regards
Philipp
