Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0124C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8992F20787
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgDMNbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:31:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50846 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgDMNbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:31:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E92320001B;
        Mon, 13 Apr 2020 15:31:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F3DDF200008;
        Mon, 13 Apr 2020 15:31:18 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DC5732039E;
        Mon, 13 Apr 2020 15:31:18 +0200 (CEST)
Date:   Mon, 13 Apr 2020 16:31:18 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 12/13] reset: imx: Add audiomix reset controller
 support
Message-ID: <20200413133118.3qtf5znahvvgmnfw@fsr-ub1664-175>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
 <1585150731-3354-13-git-send-email-abel.vesa@nxp.com>
 <3e31d193605897bdfad3a3e7cde66bd03a3a8acd.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e31d193605897bdfad3a3e7cde66bd03a3a8acd.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-26 11:50:47, Philipp Zabel wrote:

Sorry for the late response. Please see my inline comments.

> Hi Abel,
> 
> On Wed, 2020-03-25 at 17:38 +0200, Abel Vesa wrote:
> > The imx-mix MFD driver registers some devices, one of which, in case of
> > audiomix, maps correctly to a reset controller type. This driver registers
> > a reset controller for that. For now, only the EARC specific resets are added.
> 
> I am still confused about what the runtime PM actually does. Maybe it
> would help me understand if you could point me to the EARC driver that
> is using this reset controller.
> 

The documentation for the i.MX8MP is not public yet, so I'll try to explain
with my own words how this works.

The audiomix is a HW mix that concentrates multiple GPRs that are audio subsystem
related into one single IP. These mixes (hdmitx, mediamix, etc) have their own power
domains, that's why the runtime PM.

> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/reset/Kconfig              |   7 +++
> >  drivers/reset/Makefile             |   1 +
> >  drivers/reset/reset-imx-audiomix.c | 122 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 130 insertions(+)
> >  create mode 100644 drivers/reset/reset-imx-audiomix.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index d9efbfd..2f8d9b3 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -81,6 +81,13 @@ config RESET_INTEL_GW
> >  	  Say Y to control the reset signals provided by reset controller.
> >  	  Otherwise, say N.
> >  
> > +config RESET_IMX_AUDIOMIX
> > +	bool "i.MX Audiomix Reset Driver" if COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	default ARCH_MXC
> > +	help
> > +	  This enables the audiomix reset controller driver for i.MX SoCs.
> > +
> >  config RESET_LANTIQ
> >  	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
> >  	default SOC_TYPE_XWAY
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index 249ed35..cf23d38 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> >  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
> >  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> >  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> > +obj-$(CONFIG_RESET_IMX_AUDIOMIX) += reset-imx-audiomix.o
> 
> The cover letter mentions hdmimix, dispmix and mediamix. Are there going
> to be a bunch of those mix reset drivers? How do they differ?

Well, each mix will deal with a different bunch of GPRs. Again, the mix
is a conglomerate of GPRs specific to one subsystem (like audio, display, hdmi, and so on).

> 
> >  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> >  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
> >  obj-$(CONFIG_RESET_MESON) += reset-meson.o
> > diff --git a/drivers/reset/reset-imx-audiomix.c b/drivers/reset/reset-imx-audiomix.c
> > new file mode 100644
> > index 00000000..d1c62ef
> > --- /dev/null
> > +++ b/drivers/reset/reset-imx-audiomix.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> I think GPL-2.0 has been deprecated in the SPDX license list, better use
> GPL-2.0-only for new files.

Will fix in the next version.

> 
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <dt-bindings/reset/imx-audiomix-reset.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset-controller.h>
> > +
> > +#define IMX_AUDIOMIX_EARC_CTRL_REG	0x200
> > +
> > +#define IMX_AUDIOMIX_EARC_RESET_BIT	0x0
> > +#define IMX_AUDIOMIX_EARC_PHY_RESET_BIT	0x1
> > +
> > +struct imx_audiomix_reset_data {
> > +	void __iomem *base;
> > +	struct reset_controller_dev rcdev;
> > +	spinlock_t lock;
> > +};
> > +
> > +static int imx_audiomix_reset_set(struct reset_controller_dev *rcdev,
> > +			  unsigned long id, bool assert)
> > +{
> > +	struct imx_audiomix_reset_data *drvdata = container_of(rcdev,
> > +			struct imx_audiomix_reset_data, rcdev);
> > +	void __iomem *reg_addr = drvdata->base;
> > +	unsigned long flags;
> > +	unsigned int offset;
> > +	u32 reg;
> > +
> > +	switch (id) {
> > +	case IMX_AUDIOMIX_EARC_PHY_RESET:
> > +		reg_addr += IMX_AUDIOMIX_EARC_CTRL_REG;
> > +		offset = IMX_AUDIOMIX_EARC_PHY_RESET_BIT;
> > +		break;
> > +	case IMX_AUDIOMIX_EARC_RESET:
> > +		reg_addr += IMX_AUDIOMIX_EARC_CTRL_REG;
> > +		offset = IMX_AUDIOMIX_EARC_RESET_BIT;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (assert) {
> > +		pm_runtime_get_sync(rcdev->dev);
> 
> This driver and the parent MFD driver do not implement runtime PM ops,
> and the device tree bindings do not specify any power domains. What does
> this actually do?

The power domains will be sent in the near future. Maybe I should just drop
the pm_runtime for now and submit that part when the PD are already in.

> 
> > +		spin_lock_irqsave(&drvdata->lock, flags);
> > +		reg = readl(reg_addr);
> > +		writel(reg & ~BIT(offset), reg_addr);
> > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > +	} else {
> > +		spin_lock_irqsave(&drvdata->lock, flags);
> > +		reg = readl(reg_addr);
> > +		writel(reg | BIT(offset), reg_addr);
> > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > +		pm_runtime_put(rcdev->dev);
> 
> Assuming this disables the power domain that powers the whole Audiomix,
> what happens to the reset lines in this case? Do they float? Are they
> guaranteed to stay deasserted?

AFAIK, they stay deasserted. But this audiomix should only be suspended
only after all the resets and clocks users have already suspended. So the
actual state of the resets should not matter at that point.

> 
> Note that the reset API does not require consumers to call
> reset_control_assert() on an exclusive reset control before calling
> reset_control_deassert(), so this could easily lead to issues with the
> device usage counter.

Hmm, you're right. It seems I need to keep count of each assertion/deassertion
for each reset id. As I said before, maybe for now I should drop the runtime pm
for the entire thing.

Am I the first one to make use of runtime PM for a reset controller ?!
Is the 'reset controller with its own PD" something I'm the only one dealing with EVER ?
Grepping the drivers/reset for the runtime, it seems I am. THAT'S WEIRD ! :D

> 
> Shared reset controls call deassert first, and assert after the last
> user is gone, so if the driver would start with deasserting both EARC
> and EARC_PHY reset lines via shared reset controls, this would underflow
> the device usage counter right away.

Right again. I'll definitely drop the runtime PM for now.

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> > +			     unsigned long id)
> > +{
> > +	return imx_audiomix_reset_set(rcdev, id, true);
> > +}
> > +
> > +static int imx_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
> > +			       unsigned long id)
> > +{
> > +	return imx_audiomix_reset_set(rcdev, id, false);
> > +}
> > +
> > +static const struct reset_control_ops imx_audiomix_reset_ops = {
> > +	.assert		= imx_audiomix_reset_assert,
> > +	.deassert	= imx_audiomix_reset_deassert,
> > +};
> > +
> > +static int imx_audiomix_reset_probe(struct platform_device *pdev)
> > +{
> > +	struct imx_audiomix_reset_data *drvdata;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (drvdata == NULL)
> > +		return -ENOMEM;
> > +
> > +	drvdata->base = dev_get_drvdata(dev->parent);
> > +
> > +	platform_set_drvdata(pdev, drvdata);
> > +
> > +	pm_runtime_enable(dev);
> > +
> > +	spin_lock_init(&drvdata->lock);
> > +
> > +	drvdata->rcdev.owner     = THIS_MODULE;
> > +	drvdata->rcdev.nr_resets = IMX_AUDIOMIX_RESET_NUM;
> > +	drvdata->rcdev.ops       = &imx_audiomix_reset_ops;
> > +	drvdata->rcdev.of_node   = dev->of_node;
> > +	drvdata->rcdev.dev	 = dev;
> > +
> > +	return devm_reset_controller_register(dev, &drvdata->rcdev);
> > +}
> > +
> > +static const struct of_device_id imx_audiomix_reset_dt_ids[] = {
> > +	{ .compatible = "fsl,imx8mp-audiomix-reset", },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +static struct platform_driver imx_audiomix_reset_driver = {
> > +	.probe	= imx_audiomix_reset_probe,
> > +	.driver = {
> > +		.name		= KBUILD_MODNAME,
> > +		.of_match_table	= imx_audiomix_reset_dt_ids,
> > +	},
> > +};
> > +module_platform_driver(imx_audiomix_reset_driver);
> 
> regards
> Philipp
