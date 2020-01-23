Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF1C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3212E21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ktkaHHGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWJiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:38:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55678 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAWJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:38:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so1784780wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Pl30t2p0DZEv//+ZOxYJPjsW2WPNOjjv7GXr4RZPqxk=;
        b=ktkaHHGWLkYT+fQWlvYiF1ftoufa4Vps6S3bKHoJnc9CLGnXA5rv563mUPpLiCEaSA
         oC/FPdjvrdSUY/s+PjF1HazrmHnoLB0QGX1aT4088BJrVv2XUtIu2cEL4HebPsO4cCI0
         n2Kb9nOFaUOMaf4tWPjvi/vefv1PBiH4gqeda8sDLAR9pSGw/I+MmHABln7anEW6pUPm
         HKisnlQRosGoaMAkcvARTutv3g1GSvvfZh+5AayX3OLgUBInppjOcai7FklaXyKW0f5h
         ka+sPzQeGMjN61zxGcp4+JzeX1Fi3QGsdcNbFADGIieYMLVL3IUxA0mShP/AMizm3Y3q
         pHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Pl30t2p0DZEv//+ZOxYJPjsW2WPNOjjv7GXr4RZPqxk=;
        b=LzSTmIV1lvI38P1pVEqHVz1QU8QFn0ox95Ffi7qFYgYuL1Xm53iMQtERMm6nb1bS6q
         MmBxg3VXx6k+aDqaWfXdMeE3Tf5Gn+6rpwO/L094uEgLMc1NFV47fSV7q/jl7hIILkjJ
         5Uw6hvp206FO3g/4KzqkRLcojJTNwoKI+STcqbosi5wwcAdk79kT+KUDyrK/saHkebct
         GSmDQiolcominoTMO4NHoHpwlSjW2oO+KTKuphHZ3wrMDP1ygMIR7mhEju9KMDw693QN
         syilwWsQG/FtfOL9K4jHKVOx3O+4cfr037koRX/iBBvZiOp24421OtouJP4QEtGygg7H
         dhjQ==
X-Gm-Message-State: APjAAAVvIV6ylm8pQpCxVVEyZIcmdaer2+E48jNdgttaeN1EInjQAWhG
        YOvdEmH0QPM4NbROSDO336JHAA==
X-Google-Smtp-Source: APXvYqw7wbplq/nz/enf7h6FSpV/dsuerJfW9yYA5vxGwE3O3p8JI2KP+aVyCDbHG8O2uN19X3FdcA==
X-Received: by 2002:a05:600c:30a:: with SMTP id q10mr3210758wmd.84.1579772278750;
        Thu, 23 Jan 2020 01:37:58 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n10sm2279969wrt.14.2020.01.23.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 01:37:58 -0800 (PST)
References: <20200116111850.23690-1-repk@triplefau.lt> <20200116111850.23690-6-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/7] phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY Driver
In-reply-to: <20200116111850.23690-6-repk@triplefau.lt>
Date:   Thu, 23 Jan 2020 10:37:57 +0100
Message-ID: <1j1rrqwm16.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 16 Jan 2020 at 12:18, Remi Pommarel <repk@triplefau.lt> wrote:

> This adds support for the MIPI analog PHY which is also used for PCIE
> found in the Amlogic AXG SoC Family.
>
> MIPI or PCIE selection is done by the #phy-cells, making the mode
> static and exclusive.
>
> For now only PCIE fonctionality is supported.
>
> This PHY will be used to replace the mipi_enable clock gating logic
> which was mistakenly added in the clock subsystem. This also activate
> a non documented band gap bit in those registers that allows reliable
> PCIE clock signal generation on AXG platforms.
>

I don't the phy subsystem much but this looks sane and aligned with what
was discussed for this Amlogic SoC.

Thanks for this Remi !

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig                   |  11 +
>  drivers/phy/amlogic/Makefile                  |  11 +-
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 188 ++++++++++++++++++
>  3 files changed, 205 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index af774ac2b934..8c9cf2403591 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -59,3 +59,14 @@ config PHY_MESON_G12A_USB3_PCIE
>  	  Enable this to support the Meson USB3 + PCIE Combo PHY found
>  	  in Meson G12A SoCs.
>  	  If unsure, say N.
> +
> +config PHY_MESON_AXG_MIPI_PCIE_ANALOG
> +	tristate "Meson AXG MIPI + PCIE analog PHY driver"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Meson MIPI + PCIE analog PHY
> +	  found in Meson AXG SoCs.
> +	  If unsure, say N.
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 11d1c42ac2be..0aecf92d796a 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
> -obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
> -obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
> -obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
> -obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)	+= phy-meson-g12a-usb3-pcie.o
> +obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
> +obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
> +obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
> +obj-$(CONFIG_PHY_MESON_GXL_USB3)		+= phy-meson-gxl-usb3.o
> +obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
> +obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> new file mode 100644
> index 000000000000..1431cbf885e1
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Amlogic AXG MIPI + PCIE analog PHY driver
> + *
> + * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
> + */
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define HHI_MIPI_CNTL0 0x00
> +#define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
> +#define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
> +#define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
> +#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
> +#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
> +
> +#define HHI_MIPI_CNTL1 0x01
> +#define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
> +#define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
> +#define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
> +#define		HHI_MIPI_CNTL1_INPUT_SETTING	BIT(2)
> +#define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
> +#define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
> +
> +#define HHI_MIPI_CNTL2 0x02
> +#define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
> +#define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
> +#define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
> +#define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
> +#define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
> +#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
> +#define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
> +
> +struct phy_axg_mipi_pcie_analog_priv {
> +	struct phy *phy;
> +	unsigned int mode;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config phy_axg_mipi_pcie_analog_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = HHI_MIPI_CNTL2,
> +};
> +
> +static int phy_axg_mipi_pcie_analog_power_on(struct phy *phy)
> +{
> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +
> +	/* MIPI not supported yet */
> +	if (priv->mode != PHY_TYPE_PCIE)
> +		return -EINVAL;
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
> +	return 0;
> +}
> +
> +static int phy_axg_mipi_pcie_analog_power_off(struct phy *phy)
> +{
> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +
> +	/* MIPI not supported yet */
> +	if (priv->mode != PHY_TYPE_PCIE)
> +		return -EINVAL;
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_BANDGAP, 0);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_ENABLE, 0);
> +	return 0;
> +}
> +
> +static int phy_axg_mipi_pcie_analog_init(struct phy *phy)
> +{
> +	return 0;
> +}
> +
> +static int phy_axg_mipi_pcie_analog_exit(struct phy *phy)
> +{
> +	return 0;
> +}
> +
> +static const struct phy_ops phy_axg_mipi_pcie_analog_ops = {
> +	.init = phy_axg_mipi_pcie_analog_init,
> +	.exit = phy_axg_mipi_pcie_analog_exit,
> +	.power_on = phy_axg_mipi_pcie_analog_power_on,
> +	.power_off = phy_axg_mipi_pcie_analog_power_off,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct phy *phy_axg_mipi_pcie_analog_xlate(struct device *dev,
> +						  struct of_phandle_args *args)
> +{
> +	struct phy_axg_mipi_pcie_analog_priv *priv = dev_get_drvdata(dev);
> +	unsigned int mode;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "invalid number of arguments\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	mode = args->args[0];
> +
> +	/* MIPI mode is not supported yet */
> +	if (mode != PHY_TYPE_PCIE) {
> +		dev_err(dev, "invalid phy mode select argument\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	priv->mode = mode;
> +	return priv->phy;
> +}
> +
> +static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_axg_mipi_pcie_analog_priv *priv;
> +	struct device_node *np = dev->of_node;
> +	struct regmap *map;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "failed to get regmap base\n");
> +		return PTR_ERR(base);
> +	}
> +
> +	map = devm_regmap_init_mmio(dev, base,
> +				    &phy_axg_mipi_pcie_analog_regmap_conf);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "failed to get HHI regmap\n");
> +		return PTR_ERR(map);
> +	}
> +	priv->regmap = map;
> +
> +	priv->phy = devm_phy_create(dev, np, &phy_axg_mipi_pcie_analog_ops);
> +	if (IS_ERR(priv->phy)) {
> +		ret = PTR_ERR(priv->phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to create PHY\n");
> +		return ret;
> +	}
> +
> +	phy_set_drvdata(priv->phy, priv);
> +	dev_set_drvdata(dev, priv);
> +
> +	phy = devm_of_phy_provider_register(dev,
> +					    phy_axg_mipi_pcie_analog_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy);
> +}
> +
> +static const struct of_device_id phy_axg_mipi_pcie_analog_of_match[] = {
> +	{
> +		.compatible = "amlogic,axg-mipi-pcie-analog-phy",
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, phy_axg_mipi_pcie_analog_of_match);
> +
> +static struct platform_driver phy_axg_mipi_pcie_analog_driver = {
> +	.probe = phy_axg_mipi_pcie_analog_probe,
> +	.driver = {
> +		.name = "phy-axg-mipi-pcie-analog",
> +		.of_match_table = phy_axg_mipi_pcie_analog_of_match,
> +	},
> +};
> +module_platform_driver(phy_axg_mipi_pcie_analog_driver);
> +
> +MODULE_AUTHOR("Remi Pommarel <repk@triplefau.lt>");
> +MODULE_DESCRIPTION("Amlogic AXG MIPI + PCIE analog PHY driver");
> +MODULE_LICENSE("GPL v2");

