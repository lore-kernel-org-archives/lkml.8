Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90033C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6FD20674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="w8eIqQco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGYM7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:59:05 -0400
Received: from crapouillou.net ([89.234.176.41]:57722 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgGYM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595681941; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNUyJeyP16I90PYzVoeeQozAUAYH6uxu6YR45xwBtBY=;
        b=w8eIqQco6w0RfvECfW5efN5bP2SnV1DgxvcQIw4FopW5G5rv3EAqKvkMVl45kHSREnslQ/
        q2ld2jtaBq4w3nmPXCAK5m6VwCxGuvCp/TZ3jGQgZ76h9e9vguGJ4DOfWPWsqu9sddlfle
        7w9UxjSCCJwr4Bd3zZzcZ3NL/wh1MpE=
Date:   Sat, 25 Jul 2020 14:58:50 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND v6 5/5] USB: PHY: JZ4770: Use the generic PHY
 framework.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prasannatsmkumar@gmail.com,
        kishon@ti.com, vkoul@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, christophe.jaillet@wanadoo.fr,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <2201EQ.3JVH7TJO4AV3@crapouillou.net>
In-Reply-To: <20200725073327.64216-1-zhouyanjie@wanyeetech.com>
References: <20200725073327.64216-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

I'm a bit lost in all these JZ4770 PHY patchsets...

Anyway, the move from drivers/usb/phy to drivers/phy should be done=20
before adding anything else to the driver, so right after the=20
devicetree change. Here, your patch modifies things that were just=20
introduced in the previous patches; that adds a lot of noise for=20
nothing and is harder to review.

If you really want to rename the function names and comments from=20
jz4770_phy* to ingenic_usb_phy*, you can do it afterwards, within your=20
current "unify code style" patch. Then add the patch to reformat the=20
macros, and then finally finish the patchset by adding support for the=20
new SoCs, because right now the macros introduced in the "add SoCs"=20
patch are modified in the "reformat macros" patch.

So I think you got the content right, just some reordering to do.


Le sam. 25 juil. 2020 =C3=A0 15:33, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanji=
e)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Used the generic PHY framework API to create the PHY,
> and move the driver to driver/phy/ingenic.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Suggested-by: Felipe Balbi <balbi@kernel.org>
> Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>
> Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingen=
ic.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v6:
>     New patch.
>=20
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/ingenic/Kconfig                        |  12 ++
>  drivers/phy/ingenic/Makefile                       |   2 +
>  .../phy-jz4770.c =3D> phy/ingenic/phy-ingenic-usb.c} | 208=20
> ++++++++++++---------
>  drivers/usb/phy/Kconfig                            |   8 -
>  drivers/usb/phy/Makefile                           |   1 -
>  7 files changed, 134 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/phy/ingenic/Kconfig
>  create mode 100644 drivers/phy/ingenic/Makefile
>  rename drivers/{usb/phy/phy-jz4770.c =3D>=20
> phy/ingenic/phy-ingenic-usb.c} (67%)
>=20
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index b3ed94b98d9b..96d7bb85f595 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -55,6 +55,7 @@ source "drivers/phy/broadcom/Kconfig"
>  source "drivers/phy/cadence/Kconfig"
>  source "drivers/phy/freescale/Kconfig"
>  source "drivers/phy/hisilicon/Kconfig"
> +source "drivers/phy/ingenic/Kconfig"
>  source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
>  source "drivers/phy/mediatek/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 310c149a9df5..0f88724b4387 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -18,6 +18,7 @@ obj-y					+=3D broadcom/	\
>  					   cadence/	\
>  					   freescale/	\
>  					   hisilicon/	\
> +					   ingenic/	\
>  					   intel/	\
>  					   lantiq/	\
>  					   marvell/	\
> diff --git a/drivers/phy/ingenic/Kconfig b/drivers/phy/ingenic/Kconfig
> new file mode 100644
> index 000000000000..b9581eae89dd
> --- /dev/null
> +++ b/drivers/phy/ingenic/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Phy drivers for Ingenic platforms
> +#
> +config PHY_INGENIC_USB
> +	tristate "Ingenic SoCs USB PHY Driver"
> +	depends on (MACH_INGENIC && MIPS) || COMPILE_TEST
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	help
> +	  This driver provides USB PHY support for the USB controller found
> +	  on the JZ-series and X-series SoCs from Ingenic.
> diff --git a/drivers/phy/ingenic/Makefile=20
> b/drivers/phy/ingenic/Makefile
> new file mode 100644
> index 000000000000..65d5ea00fc9d
> --- /dev/null
> +++ b/drivers/phy/ingenic/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y		+=3D phy-ingenic-usb.o
> diff --git a/drivers/usb/phy/phy-jz4770.c=20
> b/drivers/phy/ingenic/phy-ingenic-usb.c
> similarity index 67%
> rename from drivers/usb/phy/phy-jz4770.c
> rename to drivers/phy/ingenic/phy-ingenic-usb.c
> index 23d38cbc150e..c43d53b235d3 100644
> --- a/drivers/usb/phy/phy-jz4770.c
> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
> @@ -7,12 +7,12 @@
>   */
>=20
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/usb/otg.h>
> -#include <linux/usb/phy.h>
> +#include <linux/phy/phy.h>
>=20
>  /* OTGPHY register offsets */
>  #define REG_USBPCR_OFFSET			0x00
> @@ -97,66 +97,48 @@ enum ingenic_usb_phy_version {
>  struct ingenic_soc_info {
>  	enum ingenic_usb_phy_version version;
>=20
> -	void (*usb_phy_init)(struct usb_phy *phy);
> +	void (*usb_phy_init)(struct phy *phy);
>  };
>=20
> -struct jz4770_phy {
> +struct ingenic_usb_phy {
>  	const struct ingenic_soc_info *soc_info;
>=20
> -	struct usb_phy phy;
> -	struct usb_otg otg;
> +	struct phy *phy;
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk *clk;
>  	struct regulator *vcc_supply;
>  };
>=20
> -static inline struct jz4770_phy *otg_to_jz4770_phy(struct usb_otg=20
> *otg)
> +static int ingenic_usb_phy_init(struct phy *phy)
>  {
> -	return container_of(otg, struct jz4770_phy, otg);
> -}
> -
> -static inline struct jz4770_phy *phy_to_jz4770_phy(struct usb_phy=20
> *phy)
> -{
> -	return container_of(phy, struct jz4770_phy, phy);
> -}
> -
> -static int ingenic_usb_phy_set_peripheral(struct usb_otg *otg,
> -				     struct usb_gadget *gadget)
> -{
> -	struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
> -	u32 reg;
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
> +	int err;
>=20
> -	if (priv->soc_info->version >=3D ID_X1000) {
> -		reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
> -		reg |=3D USBPCR1_BVLD_REG;
> -		writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +	err =3D clk_prepare_enable(priv->clk);
> +	if (err) {
> +		dev_err(priv->dev, "Unable to start clock: %d\n", err);
> +		return err;
>  	}
>=20
> -	reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> -	reg &=3D ~USBPCR_USB_MODE;
> -	reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);
> +	priv->soc_info->usb_phy_init(phy);
>=20
>  	return 0;
>  }
>=20
> -static int ingenic_usb_phy_set_host(struct usb_otg *otg, struct=20
> usb_bus *host)
> +static int ingenic_usb_phy_exit(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
> -	u32 reg;
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>=20
> -	reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> -	reg &=3D ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE);
> -	reg |=3D USBPCR_USB_MODE;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);
> +	clk_disable_unprepare(priv->clk);
> +	regulator_disable(priv->vcc_supply);
>=20
>  	return 0;
>  }
>=20
> -static int ingenic_usb_phy_init(struct usb_phy *phy)
> +static int ingenic_usb_phy_power_on(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	int err;
>=20
>  	err =3D regulator_enable(priv->vcc_supply);
> @@ -165,33 +147,71 @@ static int ingenic_usb_phy_init(struct usb_phy=20
> *phy)
>  		return err;
>  	}
>=20
> -	err =3D clk_prepare_enable(priv->clk);
> -	if (err) {
> -		dev_err(priv->dev, "Unable to start clock: %d\n", err);
> -		return err;
> -	}
> -
> -	priv->soc_info->usb_phy_init(phy);
> -
>  	return 0;
>  }
>=20
> -static void ingenic_usb_phy_shutdown(struct usb_phy *phy)
> +static int ingenic_usb_phy_power_off(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>=20
> -	clk_disable_unprepare(priv->clk);
>  	regulator_disable(priv->vcc_supply);
> +
> +	return 0;
>  }
>=20
> -static void ingenic_usb_phy_remove(void *phy)
> +static int ingenic_usb_phy_set_mode(struct phy *phy,
> +				  enum phy_mode mode, int submode)
>  {
> -	usb_remove_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +		reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &=3D ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE);
> +		reg |=3D USBPCR_USB_MODE;
> +		writel(reg, priv->base + REG_USBPCR_OFFSET);
> +
> +		break;
> +	case PHY_MODE_USB_DEVICE:
> +		if (priv->soc_info->version >=3D ID_X1000) {
> +			reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
> +			reg |=3D USBPCR1_BVLD_REG;
> +			writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +		}
> +
> +		reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &=3D ~USBPCR_USB_MODE;
> +		reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE;
> +		writel(reg, priv->base + REG_USBPCR_OFFSET);
> +
> +		break;
> +	case PHY_MODE_USB_OTG:
> +		reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &=3D ~USBPCR_OTG_DISABLE;
> +		reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_USB_MODE;
> +		writel(reg, priv->base + REG_USBPCR_OFFSET);
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>=20
> -static void jz4770_usb_phy_init(struct usb_phy *phy)
> +static const struct phy_ops ingenic_usb_phy_ops =3D {
> +	.init		=3D ingenic_usb_phy_init,
> +	.exit		=3D ingenic_usb_phy_exit,
> +	.power_on	=3D ingenic_usb_phy_power_on,
> +	.power_off	=3D ingenic_usb_phy_power_off,
> +	.set_mode	=3D ingenic_usb_phy_set_mode,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static void jz4770_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
> @@ -206,9 +226,9 @@ static void jz4770_usb_phy_init(struct usb_phy=20
> *phy)
>  	usleep_range(300, 1000);
>  }
>=20
> -static void jz4780_usb_phy_init(struct usb_phy *phy)
> +static void jz4780_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
> @@ -224,9 +244,9 @@ static void jz4780_usb_phy_init(struct usb_phy=20
> *phy)
>  	usleep_range(300, 1000);
>  }
>=20
> -static void x1000_usb_phy_init(struct usb_phy *phy)
> +static void x1000_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
> USBPCR1_WORD_IF_16BIT;
> @@ -243,9 +263,9 @@ static void x1000_usb_phy_init(struct usb_phy=20
> *phy)
>  	usleep_range(300, 1000);
>  }
>=20
> -static void x1830_usb_phy_init(struct usb_phy *phy)
> +static void x1830_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	/* rdt */
> @@ -298,75 +318,83 @@ static const struct of_device_id=20
> ingenic_usb_phy_of_matches[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
>=20
> -static int jz4770_phy_probe(struct platform_device *pdev)
> +static int ingenic_usb_phy_probe(struct platform_device *pdev)
>  {
> -	struct device *dev =3D &pdev->dev;
> -	struct jz4770_phy *priv;
> +	struct ingenic_usb_phy *priv;
> +	struct phy_provider *provider;
>  	int err;
>=20
> -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>=20
> +	priv->dev =3D &pdev->dev;
> +
>  	priv->soc_info =3D device_get_match_data(&pdev->dev);
>  	if (!priv->soc_info) {
>  		dev_err(&pdev->dev, "Error: No device match found\n");
>  		return -ENODEV;
>  	}
>=20
> -	platform_set_drvdata(pdev, priv);
> -	priv->dev =3D dev;
> -	priv->phy.dev =3D dev;
> -	priv->phy.otg =3D &priv->otg;
> -	priv->phy.label =3D "ingenic-usb-phy";
> -	priv->phy.init =3D ingenic_usb_phy_init;
> -	priv->phy.shutdown =3D ingenic_usb_phy_shutdown;
> -
> -	priv->otg.state =3D OTG_STATE_UNDEFINED;
> -	priv->otg.usb_phy =3D &priv->phy;
> -	priv->otg.set_host =3D ingenic_usb_phy_set_host;
> -	priv->otg.set_peripheral =3D ingenic_usb_phy_set_peripheral;
> -
>  	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base)) {
> -		dev_err(dev, "Failed to map registers\n");
> +		dev_err(priv->dev, "Failed to map registers\n");
>  		return PTR_ERR(priv->base);
>  	}
>=20
> -	priv->clk =3D devm_clk_get(dev, NULL);
> +	priv->clk =3D devm_clk_get(priv->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		err =3D PTR_ERR(priv->clk);
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get clock\n");
> +			dev_err(priv->dev, "Failed to get clock\n");
>  		return err;
>  	}
>=20
> -	priv->vcc_supply =3D devm_regulator_get(dev, "vcc");
> +	priv->vcc_supply =3D devm_regulator_get(priv->dev, "vcc");
>  	if (IS_ERR(priv->vcc_supply)) {
>  		err =3D PTR_ERR(priv->vcc_supply);
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get regulator\n");
> +			dev_err(priv->dev, "Failed to get regulator\n");
>  		return err;
>  	}
>=20
> -	err =3D usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
> -	if (err) {
> -		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "Unable to register PHY\n");
> -		return err;
> +	priv->phy =3D devm_phy_create(priv->dev, NULL, &ingenic_usb_phy_ops);
> +	if (IS_ERR(priv)) {
> +		dev_err(priv->dev, "Failed to create PHY: %ld\n",	PTR_ERR(priv));
> +		return PTR_ERR(priv);
>  	}
>=20
> -	return devm_add_action_or_reset(dev, ingenic_usb_phy_remove,=20
> &priv->phy);
> +	provider =3D devm_of_phy_provider_register(priv->dev,=20
> of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(priv->dev, "Failed to register PHY provider: %ld\n",=20
> PTR_ERR(provider));
> +		return PTR_ERR(provider);
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +	phy_set_drvdata(priv->phy, priv);
> +
> +	return 0;
> +}
> +
> +static int ingenic_usb_phy_remove(struct platform_device *pdev)
> +{
> +	struct ingenic_usb_phy *priv =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(priv->clk);
> +	regulator_disable(priv->vcc_supply);
> +
> +	return 0;
>  }
>=20
> -static struct platform_driver ingenic_phy_driver =3D {
> -	.probe		=3D jz4770_phy_probe,
> +static struct platform_driver ingenic_usb_phy_driver =3D {
> +	.probe		=3D ingenic_usb_phy_probe,
> +	.remove		=3D ingenic_usb_phy_remove,
>  	.driver		=3D {
> -		.name	=3D "jz4770-phy",
> +		.name	=3D "ingenic-usb-phy",
>  		.of_match_table =3D of_match_ptr(ingenic_usb_phy_of_matches),
>  	},
>  };
> -module_platform_driver(ingenic_phy_driver);
> +module_platform_driver(ingenic_usb_phy_driver);
>=20
>  MODULE_AUTHOR("=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wan=
yeetech.com>");
>  MODULE_AUTHOR("=E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@inge=
nic.com>");

Finally, because of the renaming, the module name changed. To keep=20
compatibility with userspace, I think you need to add a=20
MODULE_ALIAS(jz4770_phy) here (but I'm not sure and maybe someone else=20
should confirm that).

Cheers,
-Paul

> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index ef4787cd3d37..ff24fca0a2d9 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -184,12 +184,4 @@ config USB_ULPI_VIEWPORT
>  	  Provides read/write operations to the ULPI phy register set for
>  	  controllers with a viewport register (e.g. Chipidea/ARC=20
> controllers).
>=20
> -config JZ4770_PHY
> -	tristate "Ingenic SoCs Transceiver Driver"
> -	depends on MIPS || COMPILE_TEST
> -	select USB_PHY
> -	help
> -	  This driver provides PHY support for the USB controller found
> -	  on the JZ-series and X-series SoCs from Ingenic.
> -
>  endmenu
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index b352bdbe8712..df1d99010079 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -24,4 +24,3 @@ obj-$(CONFIG_USB_MXS_PHY)		+=3D phy-mxs-usb.o
>  obj-$(CONFIG_USB_ULPI)			+=3D phy-ulpi.o
>  obj-$(CONFIG_USB_ULPI_VIEWPORT)		+=3D phy-ulpi-viewport.o
>  obj-$(CONFIG_KEYSTONE_USB_PHY)		+=3D phy-keystone.o
> -obj-$(CONFIG_JZ4770_PHY)		+=3D phy-jz4770.o
> --
> 2.11.0


