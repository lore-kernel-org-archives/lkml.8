Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8444C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C9F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgIHUXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:23:46 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60523 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgIHUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:23:46 -0400
Received: from localhost (unknown [82.66.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id AF126100002;
        Tue,  8 Sep 2020 20:23:39 +0000 (UTC)
Date:   Tue, 8 Sep 2020 22:31:23 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: amlogic: phy-meson-axg-mipi-pcie-analog: add
 support for MIPI DSI analog
Message-ID: <20200908203123.GA20108@pilgrim>
References: <20200907073402.26674-1-narmstrong@baylibre.com>
 <20200907073402.26674-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907073402.26674-4-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 07, 2020 at 09:34:02AM +0200, Neil Armstrong wrote:
> The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
> thus we need to have inclusive support for both interfaces at runtime.
> 
> This fixes the regmap get from parent node, removes cell param
> to select a mode and implement runtime configuration & power on/off
> for both functions since they are not exclusive.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/phy/amlogic/Kconfig                   |   1 +
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 204 ++++++++++++------
>  2 files changed, 136 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 99e8a4c7f1f3..db5d0cd757e3 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -66,6 +66,7 @@ config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>  	depends on OF && (ARCH_MESON || COMPILE_TEST)
>  	select GENERIC_PHY
>  	select REGMAP_MMIO
> +	select GENERIC_PHY_MIPI_DPHY
>  	help
>  	  Enable this to support the Meson MIPI + PCIE analog PHY
>  	  found in Meson AXG SoCs.
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> index 1431cbf885e1..6eb21551bdd9 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> @@ -4,9 +4,13 @@
>   *
>   * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
>   */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <dt-bindings/phy/phy.h>
>  
> @@ -14,10 +18,10 @@
>  #define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
>  #define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
>  #define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
> -#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
> -#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(25, 16)
> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
>  
> -#define HHI_MIPI_CNTL1 0x01
> +#define HHI_MIPI_CNTL1 0x04
>  #define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
>  #define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
>  #define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
> @@ -25,100 +29,170 @@
>  #define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
>  #define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
>  
> -#define HHI_MIPI_CNTL2 0x02
> +#define HHI_MIPI_CNTL2 0x08
>  #define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
>  #define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
>  #define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
>  #define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
>  #define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
> -#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
> +#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
>  #define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
>  
> +#define DSI_LANE_0              (1 << 4)
> +#define DSI_LANE_1              (1 << 3)
> +#define DSI_LANE_CLK            (1 << 2)
> +#define DSI_LANE_2              (1 << 1)
> +#define DSI_LANE_3              (1 << 0)
> +#define DSI_LANE_MASK		(0x1F)
> +
>  struct phy_axg_mipi_pcie_analog_priv {
>  	struct phy *phy;
> -	unsigned int mode;
>  	struct regmap *regmap;
> +	bool dsi_configured;
> +	bool dsi_enabled;
> +	bool powered;
> +	struct phy_configure_opts_mipi_dphy config;
>  };
>  
> -static const struct regmap_config phy_axg_mipi_pcie_analog_regmap_conf = {
> -	.reg_bits = 8,
> -	.val_bits = 32,
> -	.reg_stride = 4,
> -	.max_register = HHI_MIPI_CNTL2,
> -};
> +static void phy_bandgap_enable(struct phy_axg_mipi_pcie_analog_priv *priv)
> +{
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
>  
> -static int phy_axg_mipi_pcie_analog_power_on(struct phy *phy)
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
> +}
> +
> +static void phy_bandgap_disable(struct phy_axg_mipi_pcie_analog_priv *priv)
>  {
> -	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_BANDGAP, 0);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_ENABLE, 0);
> +}
>  
> -	/* MIPI not supported yet */
> -	if (priv->mode != PHY_TYPE_PCIE)
> -		return -EINVAL;
> +static void phy_dsi_analog_enable(struct phy_axg_mipi_pcie_analog_priv *priv)
> +{
> +	u32 reg;
>  
>  	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
> +			   HHI_MIPI_CNTL0_DIF_REF_CTL1,
> +			   FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0x1b8));
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   BIT(31), BIT(31));
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_DIF_REF_CTL0,
> +			   FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL0, 0x8));
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0x001e);
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
> +		     (0x26e0 << 16) | (0x459 << 0));
> +
> +	reg = DSI_LANE_CLK;
> +	switch (priv->config.lanes) {
> +	case 4:
> +		reg |= DSI_LANE_3;
> +		fallthrough;
> +	case 3:
> +		reg |= DSI_LANE_2;
> +		fallthrough;
> +	case 2:
> +		reg |= DSI_LANE_1;
> +		fallthrough;
> +	case 1:
> +		reg |= DSI_LANE_0;
> +		break;
> +	default:
> +		reg = 0;
> +	}
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL2,
> +			   HHI_MIPI_CNTL2_CH_EN,
> +			   FIELD_PREP(HHI_MIPI_CNTL2_CH_EN, reg));
> +
> +	priv->dsi_enabled = true;
> +}
>  
> +static void phy_dsi_analog_disable(struct phy_axg_mipi_pcie_analog_priv *priv)
> +{
>  	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
> -	return 0;
> +			HHI_MIPI_CNTL0_DIF_REF_CTL1,
> +			FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0));
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0, BIT(31), 0);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_DIF_REF_CTL1, 0);
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0x6);
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL2, 0x00200000);
> +
> +	priv->dsi_enabled = false;
>  }
>  
> -static int phy_axg_mipi_pcie_analog_power_off(struct phy *phy)
> +static int phy_axg_mipi_pcie_analog_configure(struct phy *phy,
> +					      union phy_configure_opts *opts)
>  {
>  	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +	int ret;
>  
> -	/* MIPI not supported yet */
> -	if (priv->mode != PHY_TYPE_PCIE)
> -		return -EINVAL;
> +	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(&priv->config, opts, sizeof(priv->config));
> +
> +	priv->dsi_configured = true;
> +
> +	/* If PHY was already powered on, setup the DSI analog part */
> +	if (priv->powered) {
> +		/* If reconfiguring, disable & reconfigure */
> +		if (priv->dsi_enabled)
> +			phy_dsi_analog_disable(priv);
> +
> +		usleep_range(100, 200);
> +
> +		phy_dsi_analog_enable(priv);
> +	}
>  
> -	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_BANDGAP, 0);
> -	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_ENABLE, 0);
>  	return 0;
>  }
>  
> -static int phy_axg_mipi_pcie_analog_init(struct phy *phy)
> +static int phy_axg_mipi_pcie_analog_power_on(struct phy *phy)
>  {
> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +
> +	phy_bandgap_enable(priv);
> +
> +	if (priv->dsi_configured)
> +		phy_dsi_analog_enable(priv);
> +
> +	priv->powered = true;
> +
>  	return 0;
>  }
>  
> -static int phy_axg_mipi_pcie_analog_exit(struct phy *phy)
> +static int phy_axg_mipi_pcie_analog_power_off(struct phy *phy)
>  {
> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +
> +	phy_bandgap_disable(priv);
> +
> +	if (priv->dsi_enabled)
> +		phy_dsi_analog_disable(priv);
> +
> +	priv->powered = false;
> +
>  	return 0;
>  }
>  
>  static const struct phy_ops phy_axg_mipi_pcie_analog_ops = {
> -	.init = phy_axg_mipi_pcie_analog_init,
> -	.exit = phy_axg_mipi_pcie_analog_exit,
> +	.configure = phy_axg_mipi_pcie_analog_configure,
>  	.power_on = phy_axg_mipi_pcie_analog_power_on,
>  	.power_off = phy_axg_mipi_pcie_analog_power_off,
>  	.owner = THIS_MODULE,
>  };
>  
> -static struct phy *phy_axg_mipi_pcie_analog_xlate(struct device *dev,
> -						  struct of_phandle_args *args)
> -{
> -	struct phy_axg_mipi_pcie_analog_priv *priv = dev_get_drvdata(dev);
> -	unsigned int mode;
> -
> -	if (args->args_count != 1) {
> -		dev_err(dev, "invalid number of arguments\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	mode = args->args[0];
> -
> -	/* MIPI mode is not supported yet */
> -	if (mode != PHY_TYPE_PCIE) {
> -		dev_err(dev, "invalid phy mode select argument\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	priv->mode = mode;
> -	return priv->phy;
> -}
> -
>  static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy;
> @@ -126,27 +200,20 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  	struct phy_axg_mipi_pcie_analog_priv *priv;
>  	struct device_node *np = dev->of_node;
>  	struct regmap *map;
> -	struct resource *res;
> -	void __iomem *base;
>  	int ret;
>  
>  	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base)) {
> -		dev_err(dev, "failed to get regmap base\n");
> -		return PTR_ERR(base);
> -	}
> -
> -	map = devm_regmap_init_mmio(dev, base,
> -				    &phy_axg_mipi_pcie_analog_regmap_conf);
> +	/* Get the hhi system controller node */
> +	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>  	if (IS_ERR(map)) {
> -		dev_err(dev, "failed to get HHI regmap\n");
> +		dev_err(dev,
> +			"failed to get HHI regmap\n");
>  		return PTR_ERR(map);
>  	}
> +
>  	priv->regmap = map;
>  
>  	priv->phy = devm_phy_create(dev, np, &phy_axg_mipi_pcie_analog_ops);
> @@ -160,8 +227,7 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  	phy_set_drvdata(priv->phy, priv);
>  	dev_set_drvdata(dev, priv);
>  
> -	phy = devm_of_phy_provider_register(dev,
> -					    phy_axg_mipi_pcie_analog_xlate);
> +	phy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>  
>  	return PTR_ERR_OR_ZERO(phy);
>  }

Thanks for that. As discussed offline, and contrary to what was discussed
here [0], syscon is in fact used here to avoid collision with the hiu
mfd.

FWIW,

Reviewed-by: Remi Pommarel <repk@triplefau.lt>

[0] https://patchwork.ozlabs.org/project/linux-pci/patch/20191223214529.20377-2-repk@triplefau.lt/#2331686

-- 
Remi
