Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9249C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B260220897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgICUOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:14:18 -0400
Received: from mail.v3.sk ([167.172.186.51]:33502 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbgICUOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:14:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 847D3DF5E0;
        Thu,  3 Sep 2020 20:13:01 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id k3_MW6DJBbf3; Thu,  3 Sep 2020 20:13:00 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C74FBDF963;
        Thu,  3 Sep 2020 20:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jBGXY3EYfIlN; Thu,  3 Sep 2020 20:13:00 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0DED8DF5E0;
        Thu,  3 Sep 2020 20:12:59 +0000 (UTC)
Date:   Thu, 3 Sep 2020 22:14:04 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v3 3/3] phy: Add USB HSIC PHY driver for Marvell
 MMP3 SoC
Message-ID: <20200903201404.GA115604@demiurge.local>
References: <20200817223400.403505-1-lkundrak@v3.sk>
 <20200817223400.403505-4-lkundrak@v3.sk>
 <20200831085808.GH2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831085808.GH2639@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:28:08PM +0530, Vinod Koul wrote:
> On 18-08-20, 00:34, Lubomir Rintel wrote:
> > Add PHY driver for the HSICs found on Marvell MMP3 SoC. The driver is
> > rather straightforward -- the PHY essentially just needs to be enabled.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v1:
> > - Explicitely cast drvdata pointer to make sparse happy
> > 
> >  drivers/phy/marvell/Kconfig         | 12 +++++
> >  drivers/phy/marvell/Makefile        |  1 +
> >  drivers/phy/marvell/phy-mmp3-hsic.c | 82 +++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >  create mode 100644 drivers/phy/marvell/phy-mmp3-hsic.c
> > 
> > diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> > index 8f6273c837ec3..6c96f2bf52665 100644
> > --- a/drivers/phy/marvell/Kconfig
> > +++ b/drivers/phy/marvell/Kconfig
> > @@ -116,3 +116,15 @@ config PHY_MMP3_USB
> >  	  The PHY driver will be used by Marvell udc/ehci/otg driver.
> >  
> >  	  To compile this driver as a module, choose M here.
> > +
> > +config PHY_MMP3_HSIC
> > +	tristate "Marvell MMP3 USB HSIC PHY Driver"
> > +	depends on MACH_MMP3_DT || COMPILE_TEST
> > +	select GENERIC_PHY
> > +	help
> > +	  Enable this to support Marvell MMP3 USB HSIC PHY driver for
> > +	  Marvell MMP3 SoC. This driver will be used my the Marvell EHCI
> > +	  driver to initialize the interface to internal USB HSIC
> > +	  components on MMP3-based boards.
> > +
> > +	  To compile this driver as a module, choose M here.
> > diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
> > index 5a106b1549f41..7f296ef028292 100644
> > --- a/drivers/phy/marvell/Makefile
> > +++ b/drivers/phy/marvell/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
> >  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
> >  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
> >  obj-$(CONFIG_PHY_MMP3_USB)		+= phy-mmp3-usb.o
> > +obj-$(CONFIG_PHY_MMP3_HSIC)		+= phy-mmp3-hsic.o
> >  obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
> >  obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+= phy-mvebu-a3700-utmi.o
> >  obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
> > diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/phy-mmp3-hsic.c
> > new file mode 100644
> > index 0000000000000..47c1e8894939f
> > --- /dev/null
> > +++ b/drivers/phy/marvell/phy-mmp3-hsic.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define HSIC_CTRL	0x08
> > +#define HSIC_ENABLE	BIT(7)
> > +#define PLL_BYPASS	BIT(4)
> > +
> > +static int mmp3_hsic_phy_init(struct phy *phy)
> > +{
> > +	void __iomem *base = (void __iomem *)phy_get_drvdata(phy);
> 
> you are casting away from void * and casting to another void *,
> something doesn't look correct!

This is to make it explicit to sparse that the destination type is
supposed to have the __iomem annotation. Otherwise it complains:

  drivers/phy/marvell/phy-mmp3-hsic.c:61:31: warning: cast removes address space '__iomem' of expression

> > +	u32 hsic_ctrl;
> > +
> > +	hsic_ctrl = readl_relaxed(base + HSIC_CTRL);
> > +	hsic_ctrl |= HSIC_ENABLE;
> > +	hsic_ctrl |= PLL_BYPASS;
> > +	writel_relaxed(hsic_ctrl, base + HSIC_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct phy_ops mmp3_hsic_phy_ops = {
> > +	.init		= mmp3_hsic_phy_init,
> > +	.owner		= THIS_MODULE,
> > +};
> > +
> > +static const struct of_device_id mmp3_hsic_phy_of_match[] = {
> > +	{ .compatible = "marvell,mmp3-hsic-phy", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mmp3_hsic_phy_of_match);
> > +
> > +static int mmp3_hsic_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy_provider *provider;
> > +	struct resource *resource;
> > +	void __iomem *base;
> > +	struct phy *phy;
> > +
> > +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base = devm_ioremap_resource(dev, resource);
> > +	if (IS_ERR(base)) {
> > +		dev_err(dev, "failed to remap PHY regs\n");
> > +		return PTR_ERR(base);
> > +	}
> > +
> > +	phy = devm_phy_create(dev, NULL, &mmp3_hsic_phy_ops);
> > +	if (IS_ERR(phy)) {
> > +		dev_err(dev, "failed to create PHY\n");
> > +		return PTR_ERR(phy);
> > +	}
> > +
> > +	phy_set_drvdata(phy, (void *)base);
> 
> again skip the cast
> 
> > +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(provider)) {
> > +		dev_err(dev, "failed to register PHY provider\n");
> > +		return PTR_ERR(provider);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver mmp3_hsic_phy_driver = {
> > +	.probe		= mmp3_hsic_phy_probe,
> > +	.driver		= {
> > +		.name	= "mmp3-hsic-phy",
> > +		.of_match_table = mmp3_hsic_phy_of_match,
> > +	},
> > +};
> > +module_platform_driver(mmp3_hsic_phy_driver);
> > +
> > +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
> > +MODULE_DESCRIPTION("Marvell MMP3 USB HSIC PHY Driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.26.2
> 
> -- 
> ~Vinod
