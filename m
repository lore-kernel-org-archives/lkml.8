Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC5DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F6F22522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lPm3yog7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAWJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:44:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55485 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgAWJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:44:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so1807470wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Puy0zvPoy+smX6jP38nlXJMKhbfeim2bcE9YEw+E3AY=;
        b=lPm3yog7rQtPNo3GpWUesOwI4uKEzIKyWW0vwWGanwC7fJvAd1JOQLmc5p0zzyZy8S
         5ICEUN0QYB/Mq38qn9mhe/yIkLm9QG0HY7dfBtU1pdSXXPiFsqvy1ksFqWaMf4/7aC5h
         VqV7I7GrsvyZoUSOl5iBEfd/SxG2QseIwpzuYWxzgljRpPJDRNBAglwWForNW+W5XKDl
         eBjQFuBwY3RlioChiCDNVYH4/nwfz1YCqi/+Y8giTipw9lAp44yFIjTw2cqQdDnZAIkq
         IozwcSHwjxEXqpNSzt9VHUwcgC0m5wsW8M1MMQfjiTMy4Q7/ZR8QS2GFsL1twoy/pO6t
         1o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Puy0zvPoy+smX6jP38nlXJMKhbfeim2bcE9YEw+E3AY=;
        b=gSDekOEcrvcRAQtLJ4zRVPB/fQOJEqFsdRNv57Jbh8CDDmhE+6oxPD/El+HfBUqfOV
         m3kZRKTBv9tKyNaI1+bgASHqQCriUOx1qRzVDInCJ9Nq0jNmCFgyytrpnxqvQqPD/U1+
         nJtJhvkNQBRBKxv7albq+Lu1ExMmxQb5tahPmdTcQihRtn0Wojn2Cz/cjcNF47BFY7De
         e1d3kBWWKnqWOaag6ppmWtuMI14WTzWh18BKXHnh1aKoHbtaS4PUqS8spxgVqJe1xCu3
         oR2xyTy8TsyMjXFzcPxrCAQdWhZv8IXxfiO+S6uJTe8aNw9aCIBz0Xn3KSalfkYQZFN4
         4Vyw==
X-Gm-Message-State: APjAAAV284brARbog0/MF2Tc7xQWGdcn3I7oBe70Hk5G4dw6oijg8WVg
        DifFLKY+CxFOL/nJnmIK2gm62g==
X-Google-Smtp-Source: APXvYqxg7CP1QcOkc92UyGep9EIBYT60gxG40dqcUbf9VCCoT7OV6hXfAjtpaIqp8ZuFpCmUav06XA==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr3109977wma.159.1579772684453;
        Thu, 23 Jan 2020 01:44:44 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q6sm2467847wrx.72.2020.01.23.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 01:44:43 -0800 (PST)
References: <20200116111850.23690-1-repk@triplefau.lt> <20200116111850.23690-7-repk@triplefau.lt>
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
Subject: Re: [PATCH v5 6/7] phy: amlogic: Add Amlogic AXG PCIE PHY Driver
In-reply-to: <20200116111850.23690-7-repk@triplefau.lt>
Date:   Thu, 23 Jan 2020 10:44:43 +0100
Message-ID: <1jzheev75g.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 16 Jan 2020 at 12:18, Remi Pommarel <repk@triplefau.lt> wrote:

> This adds support for the PCI PHY found in the Amlogic AXG SoC Family.
> This will allow to mutualize code in pci-meson.c between AXG and G12A
> SoC.
>
> This PHY can chain and use an optional analog PHY, which is used on
> AXG platform to have reliable PCIe communication.
>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig              |  11 ++
>  drivers/phy/amlogic/Makefile             |   1 +
>  drivers/phy/amlogic/phy-meson-axg-pcie.c | 192 +++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 8c9cf2403591..71801e30d601 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -60,6 +60,17 @@ config PHY_MESON_G12A_USB3_PCIE
>  	  in Meson G12A SoCs.
>  	  If unsure, say N.
>  
> +config PHY_MESON_AXG_PCIE
> +	tristate "Meson AXG PCIE PHY driver"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Meson MIPI + PCIE PHY found
> +	  in Meson AXG SoCs.
> +	  If unsure, say N.
> +
>  config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>  	tristate "Meson AXG MIPI + PCIE analog PHY driver"
>  	default ARCH_MESON
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 0aecf92d796a..e2baa133f7af 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)		+= phy-meson-gxl-usb3.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
> +obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
>  obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> new file mode 100644
> index 000000000000..0c5d0732cd1c
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Amlogic AXG PCIE PHY driver
> + *
> + * Copyright (C) 2020 Remi Pommarel <repk@triplefau.lt>
> + */
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitfield.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define MESON_PCIE_REG0 0x00
> +#define		MESON_PCIE_COMMON_CLK	BIT(4)
> +#define		MESON_PCIE_PORT_SEL	GENMASK(3, 2)
> +#define		MESON_PCIE_CLK		BIT(1)
> +#define		MESON_PCIE_POWERDOWN	BIT(0)
> +
> +#define MESON_PCIE_TWO_X1		FIELD_PREP(MESON_PCIE_PORT_SEL, 0x3)
> +#define MESON_PCIE_COMMON_REF_CLK	FIELD_PREP(MESON_PCIE_COMMON_CLK, 0x1)
> +#define MESON_PCIE_PHY_INIT		(MESON_PCIE_TWO_X1 |		\
> +					 MESON_PCIE_COMMON_REF_CLK)
> +#define MESON_PCIE_RESET_DELAY		500
> +
> +struct phy_axg_pcie_priv {
> +	struct phy *phy;
> +	struct phy *analog;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +};
> +
> +static const struct regmap_config phy_axg_pcie_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MESON_PCIE_REG0,
> +};
> +
> +static int phy_axg_pcie_power_on(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_power_on(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
> +			   MESON_PCIE_POWERDOWN, 0);
> +	return 0;
> +}
> +
> +static int phy_axg_pcie_power_off(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_power_off(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
> +			   MESON_PCIE_POWERDOWN, 1);
> +	return 0;
> +}
> +
> +static int phy_axg_pcie_init(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_init(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	regmap_write(priv->regmap, MESON_PCIE_REG0, MESON_PCIE_PHY_INIT);
> +	return reset_control_reset(priv->reset);
> +}
> +
> +static int phy_axg_pcie_exit(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_exit(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	return reset_control_reset(priv->reset);
> +}
> +
> +static int phy_axg_pcie_reset(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	ret = phy_reset(priv->analog);
> +	if (ret != 0)
> +		goto out;
> +
> +	ret = reset_control_assert(priv->reset);
> +	if (ret != 0)
> +		goto out;
> +	udelay(MESON_PCIE_RESET_DELAY);
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret != 0)
> +		goto out;
> +	udelay(MESON_PCIE_RESET_DELAY);
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct phy_ops phy_axg_pcie_ops = {
> +	.init = phy_axg_pcie_init,
> +	.exit = phy_axg_pcie_exit,
> +	.power_on = phy_axg_pcie_power_on,
> +	.power_off = phy_axg_pcie_power_off,
> +	.reset = phy_axg_pcie_reset,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int phy_axg_pcie_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *pphy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_axg_pcie_priv *priv;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->phy = devm_phy_create(dev, np, &phy_axg_pcie_ops);
> +	if (IS_ERR(priv->phy)) {
> +		ret = PTR_ERR(priv->phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to create PHY\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> +					     &phy_axg_pcie_regmap_conf);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->reset = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	priv->analog = devm_phy_optional_get(dev, "analog");
> +	if (IS_ERR(priv->analog))
> +		return PTR_ERR(priv->analog);

Isn't required for on the axg platform for the pcie to work reliably ?
Does this driver support another SoC ?

> +
> +	phy_set_drvdata(priv->phy, priv);
> +	dev_set_drvdata(dev, priv);
> +	pphy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(pphy);
> +}
> +
> +static const struct of_device_id phy_axg_pcie_of_match[] = {
> +	{
> +		.compatible = "amlogic,axg-pcie-phy",
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, phy_axg_pcie_of_match);
> +
> +static struct platform_driver phy_axg_pcie_driver = {
> +	.probe = phy_axg_pcie_probe,
> +	.driver = {
> +		.name = "phy-axg-pcie",
> +		.of_match_table = phy_axg_pcie_of_match,
> +	},
> +};
> +module_platform_driver(phy_axg_pcie_driver);
> +
> +MODULE_AUTHOR("Remi Pommarel <repk@triplefau.lt>");
> +MODULE_DESCRIPTION("Amlogic AXG PCIE PHY driver");
> +MODULE_LICENSE("GPL v2");

