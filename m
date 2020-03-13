Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ADE2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JKpdRCCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCMLR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:17:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58514 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgCMLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:17:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02DBHMrE116004;
        Fri, 13 Mar 2020 06:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584098242;
        bh=5eFoG7L4luN6qLM76pThRh4yjy2iLp4D0eCwttdXJxE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JKpdRCCiaRIlZYCxCqsck2k3KfFOHKTMqp6+BWxGc08/Z7xgFQPeP8dAw7pQZt5oc
         KRFuyY3Un+4FFGlHcrLzyjRKtN8O/zuFD1zSqW6QuBmxQCsLdX67yqeaGtVmJAN0lD
         8WT4JehkN8keF8nW0S8h11Am49oZIwSWHh1NZmKw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DBHMPY009251;
        Fri, 13 Mar 2020 06:17:22 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 06:17:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 06:17:21 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DBHJWI119490;
        Fri, 13 Mar 2020 06:17:21 -0500
Subject: Re: [PATCH] phy: Add USB HSIC PHY driver for Marvell MMP3 SoC
To:     Lubomir Rintel <lkundrak@v3.sk>
CC:     <linux-kernel@vger.kernel.org>
References: <20200309125848.547664-1-lkundrak@v3.sk>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0d141fd7-274f-e9da-7cd0-68eb026d5c3c@ti.com>
Date:   Fri, 13 Mar 2020 16:52:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309125848.547664-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/03/20 6:28 pm, Lubomir Rintel wrote:
> Add PHY driver for the HSICs found on Marvell MMP3 SoC. The driver is
> rather straightforward -- the PHY essentially just needs to be enabled.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/phy/marvell/Kconfig         | 12 +++++
>  drivers/phy/marvell/Makefile        |  1 +
>  drivers/phy/marvell/phy-mmp3-hsic.c | 82 +++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 drivers/phy/marvell/phy-mmp3-hsic.c
> 
> diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> index 8f6273c837ec3..6c96f2bf52665 100644
> --- a/drivers/phy/marvell/Kconfig
> +++ b/drivers/phy/marvell/Kconfig
> @@ -116,3 +116,15 @@ config PHY_MMP3_USB
>  	  The PHY driver will be used by Marvell udc/ehci/otg driver.
>  
>  	  To compile this driver as a module, choose M here.
> +
> +config PHY_MMP3_HSIC
> +	tristate "Marvell MMP3 USB HSIC PHY Driver"
> +	depends on MACH_MMP3_DT || COMPILE_TEST
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support Marvell MMP3 USB HSIC PHY driver for
> +	  Marvell MMP3 SoC. This driver will be used my the Marvell EHCI
> +	  driver to initialize the interface to internal USB HSIC
> +	  components on MMP3-based boards.
> +
> +	  To compile this driver as a module, choose M here.
> diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
> index 5a106b1549f41..7f296ef028292 100644
> --- a/drivers/phy/marvell/Makefile
> +++ b/drivers/phy/marvell/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
>  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
>  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
>  obj-$(CONFIG_PHY_MMP3_USB)		+= phy-mmp3-usb.o
> +obj-$(CONFIG_PHY_MMP3_HSIC)		+= phy-mmp3-hsic.o
>  obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
>  obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+= phy-mvebu-a3700-utmi.o
>  obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
> diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/phy-mmp3-hsic.c
> new file mode 100644
> index 0000000000000..f7b430f6f6f05
> --- /dev/null
> +++ b/drivers/phy/marvell/phy-mmp3-hsic.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +#define HSIC_CTRL	0x08
> +#define HSIC_ENABLE	BIT(7)
> +#define PLL_BYPASS	BIT(4)
> +
> +static int mmp3_hsic_phy_init(struct phy *phy)
> +{
> +	void __iomem *base = phy_get_drvdata(phy);
> +	u32 hsic_ctrl;
> +
> +	hsic_ctrl = readl_relaxed(base + HSIC_CTRL);
> +	hsic_ctrl |= HSIC_ENABLE;
> +	hsic_ctrl |= PLL_BYPASS;
> +	writel_relaxed(hsic_ctrl, base + HSIC_CTRL);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops mmp3_hsic_phy_ops = {
> +	.init		= mmp3_hsic_phy_init,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct of_device_id mmp3_hsic_phy_of_match[] = {
> +	{ .compatible = "marvell,mmp3-hsic-phy", },

Where is the binding documentation for this?

Thanks
Kishon

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mmp3_hsic_phy_of_match);
> +
> +static int mmp3_hsic_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *provider;
> +	struct resource *resource;
> +	void __iomem *base;
> +	struct phy *phy;
> +
> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, resource);
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "failed to remap PHY regs\n");
> +		return PTR_ERR(base);
> +	}
> +
> +	phy = devm_phy_create(dev, NULL, &mmp3_hsic_phy_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(phy);
> +	}
> +
> +	phy_set_drvdata(phy, base);
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(dev, "failed to register PHY provider\n");
> +		return PTR_ERR(provider);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mmp3_hsic_phy_driver = {
> +	.probe		= mmp3_hsic_phy_probe,
> +	.driver		= {
> +		.name	= "mmp3-hsic-phy",
> +		.of_match_table = mmp3_hsic_phy_of_match,
> +	},
> +};
> +module_platform_driver(mmp3_hsic_phy_driver);
> +
> +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
> +MODULE_DESCRIPTION("Marvell MMP3 USB HSIC PHY Driver");
> +MODULE_LICENSE("GPL");
> 
