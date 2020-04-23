Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2401C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B872166E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgDWPrn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729350AbgDWPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:47:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC6C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:47:42 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jRe4c-0007d9-C5; Thu, 23 Apr 2020 17:47:34 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jRe4b-0006Ow-Ja; Thu, 23 Apr 2020 17:47:33 +0200
Message-ID: <a32ab342e7e4928ec252815ab0023f81bb182b32.camel@pengutronix.de>
Subject: Re: [PATCH v3 12/13] reset: imx: Add audiomix reset controller
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 23 Apr 2020 17:47:33 +0200
In-Reply-To: <1586937773-5836-13-git-send-email-abel.vesa@nxp.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
         <1586937773-5836-13-git-send-email-abel.vesa@nxp.com>
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

On Wed, 2020-04-15 at 11:02 +0300, Abel Vesa wrote:
> The imx-mix MFD driver registers some devices, one of which, in case of
> audiomix, maps correctly to a reset controller type. This driver registers
> a reset controller for that. For now, only the EARC specific resets are added.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/reset/Kconfig              |   7 +++
>  drivers/reset/Makefile             |   1 +
>  drivers/reset/reset-imx-audiomix.c | 117 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 drivers/reset/reset-imx-audiomix.c
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
> index 00000000..9533e41
> --- /dev/null
> +++ b/drivers/reset/reset-imx-audiomix.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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

This switch is not necessary. Since reg_addr is the same for both bits,
you can just set it directly, once. And since (IMX_AUDIOMIX_EARC_RESET
== IMX_AUDIOMIX_EARC_RESET_BIT) and (IMX_AUDIOMIX_EARC_PHY_RESET ==
IMX_AUDIOMIX_EARC_PHY_RESET_BIT), you can just use BIT(id) instead of
BIT(offset) below.

> +	default:
> +		return -EINVAL;

This is already catched by the core, which doesn't allow
(id >= rcdev->nr_resets).

> +	}
> +
> +	if (assert) {
> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		reg = readl(reg_addr);
> +		writel(reg & ~BIT(offset), reg_addr);
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +	} else {
> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		reg = readl(reg_addr);
> +		writel(reg | BIT(offset), reg_addr);
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +	}

regards
Philipp
