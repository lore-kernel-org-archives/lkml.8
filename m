Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1014C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CEB20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Iu45R/h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgGVRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:19:34 -0400
Received: from crapouillou.net ([89.234.176.41]:37268 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgGVRTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595438370; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXKShU6bcyALeSYPEd+6LzT86GWsAOmo+1LcD0YApEI=;
        b=Iu45R/h/X+MGbF7yxaPCKZXycEcyg729NvrAg6ncui3xroBL7kHUCo+SPN6xGixXYgLJH6
        AO3/DsUOMw5DBCwHc0JU20Wwr8TsOhtVRDru6PmT7/K1s+ofeIY5O06Nql/hgyhmRTXP9o
        cg4JfDE89DnCCQfFqptjSIBOj7G2fXI=
Date:   Wed, 22 Jul 2020 19:19:20 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/3] USB: PHY: JZ4770: Add support for new Ingenic
 SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prasannatsmkumar@gmail.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <84SVDQ.U2WOG9BOMMYN1@crapouillou.net>
In-Reply-To: <20200722063355.67781-3-zhouyanjie@wanyeetech.com>
References: <20200722063355.67781-1-zhouyanjie@wanyeetech.com>
        <20200722063355.67781-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le mer. 22 juil. 2020 =C3=A0 14:33, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanji=
e)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add support for probing the phy-jz4770 driver on the JZ4780 SoC,
> the X1000 SoC and the X1830 SoC from Ingenic.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>
> Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingen=
ic.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v1->v2:
>     Add bindings for the JZ4780 SoC.
>=20
>     v2->v3:
>     Use "of_device_get_match_data" instead "of_match_device"
>     to get version information.
>=20
>     v3->v4:
>     Fix typos.
>=20
>  drivers/usb/phy/Kconfig      |   4 +-
>  drivers/usb/phy/phy-jz4770.c | 174=20
> ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 133 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 4b3fa78995cf..775f0dd7b5f5 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -185,11 +185,11 @@ config USB_ULPI_VIEWPORT
>  	  controllers with a viewport register (e.g. Chipidea/ARC=20
> controllers).
>=20
>  config JZ4770_PHY
> -	tristate "Ingenic JZ4770 Transceiver Driver"
> +	tristate "Ingenic SoCs Transceiver Driver"
>  	depends on MIPS || COMPILE_TEST
>  	select USB_PHY
>  	help
>  	  This driver provides PHY support for the USB controller found
> -	  on the JZ4770 SoC from Ingenic.
> +	  on the JZ4770/JZ4780/X1000/X1830 SoC from Ingenic.

'JZ-series / X-series SoCs' would be more future-proof :)

>=20
>  endmenu
> diff --git a/drivers/usb/phy/phy-jz4770.c=20
> b/drivers/usb/phy/phy-jz4770.c
> index 8f62dc2a90ff..cd49b32b4c13 100644
> --- a/drivers/usb/phy/phy-jz4770.c
> +++ b/drivers/usb/phy/phy-jz4770.c
> @@ -1,27 +1,30 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Ingenic JZ4770 USB PHY driver
> + * Ingenic SoCs USB PHY driver
>   * Copyright (c) Paul Cercueil <paul@crapouillou.net>
> + * Copyright (c) =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@in=
genic.com>
> + * Copyright (c) =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@w=
anyeetech.com>
>   */
>=20
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/phy.h>
>=20
> +/* OTGPHY register offsets */
>  #define REG_USBPCR_OFFSET	0x00
>  #define REG_USBRDT_OFFSET	0x04
>  #define REG_USBVBFIL_OFFSET	0x08
>  #define REG_USBPCR1_OFFSET	0x0c
>=20
> -/* USBPCR */
> +/* bits within the USBPCR register */
>  #define USBPCR_USB_MODE		BIT(31)
>  #define USBPCR_AVLD_REG		BIT(30)
> -#define USBPCR_INCRM		BIT(27)
> -#define USBPCR_CLK12_EN		BIT(26)
> +#define USBPCR_INCR_MASK	BIT(27)

Please don't rename macros, it adds a lot of noise to the patch.

>  #define USBPCR_COMMONONN	BIT(25)
>  #define USBPCR_VBUSVLDEXT	BIT(24)
>  #define USBPCR_VBUSVLDEXTSEL	BIT(23)
> @@ -32,46 +35,80 @@
>=20
>  #define USBPCR_IDPULLUP_LSB	28
>  #define USBPCR_IDPULLUP_MASK	GENMASK(29, USBPCR_IDPULLUP_LSB)
> -#define USBPCR_IDPULLUP_ALWAYS	(3 << USBPCR_IDPULLUP_LSB)
> -#define USBPCR_IDPULLUP_SUSPEND	(1 << USBPCR_IDPULLUP_LSB)
> -#define USBPCR_IDPULLUP_OTG	(0 << USBPCR_IDPULLUP_LSB)
> +#define USBPCR_IDPULLUP_ALWAYS	(0x2 << USBPCR_IDPULLUP_LSB)
> +#define USBPCR_IDPULLUP_SUSPEND	(0x1 << USBPCR_IDPULLUP_LSB)
> +#define USBPCR_IDPULLUP_OTG	(0x0 << USBPCR_IDPULLUP_LSB)

a '3' turned into a '2' here...

>=20
>  #define USBPCR_COMPDISTUNE_LSB	17
>  #define USBPCR_COMPDISTUNE_MASK	GENMASK(19, USBPCR_COMPDISTUNE_LSB)
> -#define USBPCR_COMPDISTUNE_DFT	4
> +#define USBPCR_COMPDISTUNE_DFT	(0x4 << USBPCR_COMPDISTUNE_LSB)

Why? Even if you have a valid reason to do that, it does not belong in=20
this patch.

>=20
>  #define USBPCR_OTGTUNE_LSB	14
>  #define USBPCR_OTGTUNE_MASK	GENMASK(16, USBPCR_OTGTUNE_LSB)
> -#define USBPCR_OTGTUNE_DFT	4
> +#define USBPCR_OTGTUNE_DFT	(0x4 << USBPCR_OTGTUNE_LSB)
>=20
>  #define USBPCR_SQRXTUNE_LSB	11
>  #define USBPCR_SQRXTUNE_MASK	GENMASK(13, USBPCR_SQRXTUNE_LSB)
> -#define USBPCR_SQRXTUNE_DFT	3
> +#define USBPCR_SQRXTUNE_DCR_20PCT	(0x7 << USBPCR_SQRXTUNE_LSB)
> +#define USBPCR_SQRXTUNE_DFT	(0x3 << USBPCR_SQRXTUNE_LSB)
>=20
>  #define USBPCR_TXFSLSTUNE_LSB	7
>  #define USBPCR_TXFSLSTUNE_MASK	GENMASK(10, USBPCR_TXFSLSTUNE_LSB)
> -#define USBPCR_TXFSLSTUNE_DFT	3
> +#define USBPCR_TXFSLSTUNE_DCR_50PPT	(0xf << USBPCR_TXFSLSTUNE_LSB)
> +#define USBPCR_TXFSLSTUNE_DCR_25PPT	(0x7 << USBPCR_TXFSLSTUNE_LSB)
> +#define USBPCR_TXFSLSTUNE_DFT	(0x3 << USBPCR_TXFSLSTUNE_LSB)
> +#define USBPCR_TXFSLSTUNE_INC_25PPT	(0x1 << USBPCR_TXFSLSTUNE_LSB)
> +#define USBPCR_TXFSLSTUNE_INC_50PPT	(0x0 << USBPCR_TXFSLSTUNE_LSB)
> +
> +#define USBPCR_TXHSXVTUNE_LSB	4
> +#define USBPCR_TXHSXVTUNE_MASK	GENMASK(5, USBPCR_TXHSXVTUNE_LSB)
> +#define USBPCR_TXHSXVTUNE_DFT	(0x3 << USBPCR_TXHSXVTUNE_LSB)
> +#define USBPCR_TXHSXVTUNE_DCR_15MV	(0x1 << USBPCR_TXHSXVTUNE_LSB)
>=20
>  #define USBPCR_TXRISETUNE_LSB	4
>  #define USBPCR_TXRISETUNE_MASK	GENMASK(5, USBPCR_TXRISETUNE_LSB)
> -#define USBPCR_TXRISETUNE_DFT	3
> +#define USBPCR_TXRISETUNE_DFT	(0x3 << USBPCR_TXRISETUNE_LSB)
>=20
>  #define USBPCR_TXVREFTUNE_LSB	0
>  #define USBPCR_TXVREFTUNE_MASK	GENMASK(3, USBPCR_TXVREFTUNE_LSB)
> -#define USBPCR_TXVREFTUNE_DFT	5
> +#define USBPCR_TXVREFTUNE_INC_25PPT	(0x7 << USBPCR_TXVREFTUNE_LSB)
> +#define USBPCR_TXVREFTUNE_DFT	(0x5 << USBPCR_TXVREFTUNE_LSB)
>=20
> -/* USBRDT */
> +/* bits within the USBRDTR register */
> +#define USBRDT_UTMI_RST		BIT(27)
> +#define USBRDT_HB_MASK		BIT(26)
>  #define USBRDT_VBFIL_LD_EN	BIT(25)
>  #define USBRDT_IDDIG_EN		BIT(24)
>  #define USBRDT_IDDIG_REG	BIT(23)
> -
> -#define USBRDT_USBRDT_LSB	0
> -#define USBRDT_USBRDT_MASK	GENMASK(22, USBRDT_USBRDT_LSB)
> -
> -/* USBPCR1 */
> -#define USBPCR1_UHC_POWON	BIT(5)
> +#define USBRDT_VBFIL_EN		BIT(2)
> +
> +/* bits within the USBPCR1 register */
> +#define USBPCR1_BVLD_REG			BIT(31)
> +#define USBPCR1_DPPD				BIT(29)
> +#define USBPCR1_DMPD				BIT(28)
> +#define USBPCR1_USB_SEL				BIT(28)
> +#define USBPCR1_WORD_IF_16BIT		BIT(19)
> +
> +#define USBPCR1_REFCLKSEL_LSB		26
> +#define USBPCR1_REFCLKSEL_MASK		GENMASK(27, USBPCR1_REFCLKDIV_LSB)
> +#define USBPCR1_REFCLKSEL_CLKCORE	(0x3 << USBPCR1_REFCLKSEL_LSB)
> +
> +#define USBPCR1_REFCLKDIV_LSB		24
> +#define USBPCR1_REFCLKDIV_MASK		GENMASK(25, USBPCR1_REFCLKDIV_LSB)
> +#define USBPCR1_REFCLKDIV_48M		(0x2 << USBPCR1_REFCLKDIV_LSB)
> +#define USBPCR1_REFCLKDIV_24M		(0x1 << USBPCR1_REFCLKDIV_LSB)
> +#define USBPCR1_REFCLKDIV_12M		(0x0 << USBPCR1_REFCLKDIV_LSB)
> +
> +enum ingenic_usb_phy_version {
> +	ID_JZ4770,
> +	ID_JZ4780,
> +	ID_X1000,
> +	ID_X1830,
> +};
>=20
>  struct jz4770_phy {
> +	enum ingenic_usb_phy_version version;
> +
>  	struct usb_phy phy;
>  	struct usb_otg otg;
>  	struct device *dev;
> @@ -96,6 +133,12 @@ static int jz4770_phy_set_peripheral(struct=20
> usb_otg *otg,
>  	struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
>  	u32 reg;
>=20
> +	if (priv->version >=3D ID_X1000) {
> +		reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
> +		reg |=3D USBPCR1_BVLD_REG;
> +		writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +	}
> +
>  	reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>  	reg &=3D ~USBPCR_USB_MODE;
>  	reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE;
> @@ -135,17 +178,59 @@ static int jz4770_phy_init(struct usb_phy *phy)
>  		return err;
>  	}
>=20
> -	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
> -		(USBPCR_COMPDISTUNE_DFT << USBPCR_COMPDISTUNE_LSB) |
> -		(USBPCR_OTGTUNE_DFT << USBPCR_OTGTUNE_LSB) |
> -		(USBPCR_SQRXTUNE_DFT << USBPCR_SQRXTUNE_LSB) |
> -		(USBPCR_TXFSLSTUNE_DFT << USBPCR_TXFSLSTUNE_LSB) |
> -		(USBPCR_TXRISETUNE_DFT << USBPCR_TXRISETUNE_LSB) |
> -		(USBPCR_TXVREFTUNE_DFT << USBPCR_TXVREFTUNE_LSB) |
> -		USBPCR_POR;
> +	if (priv->version >=3D ID_X1830) {
> +		/* rdt */
> +		writel(USBRDT_VBFIL_EN | USBRDT_UTMI_RST, priv->base +=20
> REG_USBRDT_OFFSET);
> +
> +		reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
> USBPCR1_WORD_IF_16BIT |
> +			USBPCR1_DMPD | USBPCR1_DPPD;
> +		writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +
> +		reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT=20
> |	USBPCR_TXPREEMPHTUNE;
> +	} else if (priv->version >=3D ID_X1000) {
> +		reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
> USBPCR1_WORD_IF_16BIT;
> +		writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +
> +		reg =3D USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
> +			USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT;
> +	} else if (priv->version >=3D ID_JZ4780) {
> +		reg =3D readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
> +			USBPCR1_WORD_IF_16BIT;
> +		writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +
> +		reg =3D USBPCR_TXPREEMPHTUNE;
> +	} else {
> +		reg =3D USBPCR_AVLD_REG | USBPCR_IDPULLUP_ALWAYS |
> +			USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT |
> +			USBPCR_SQRXTUNE_DFT | USBPCR_TXFSLSTUNE_DFT |
> +			USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT;
> +	}
> +
> +	reg |=3D USBPCR_COMMONONN | USBPCR_POR;
>  	writel(reg, priv->base + REG_USBPCR_OFFSET);
>=20
> -	/* Wait for PHY to reset */
> +	/*
> +	 * Power-On Reset(POR)
> +	 * Function:This customer-specific signal resets all test registers
> +	 * and state machines in the USB 2.0 nanoPHY.
> +	 * The POR signal must be asserted for a minimum of 10 =CE=BCs.
> +	 * For POR timing information:
> +	 *
> +	 * T0: Power-on reset (POR) is initiated. 0 (reference).
> +	 * T1: T1 indicates when POR can be set to 1=E2=80=99b0. (To provide=20
> examples,
> +	 * values for T2 and T3 are also shown where T1 =3D T0 + 30 =CE=BCs.);
> +	 * In general, T1 must be =E2=89=A5 T0 + 10 =CE=BCs. T0 + 10 =CE=BCs =
=E2=89=A4 T1.
> +	 * T2: T2 indicates when PHYCLOCK, CLK48MOHCI, and CLK12MOHCI are
> +	 * available at the macro output, based on the USB 2.0 nanoPHY
> +	 * reference clock source.
> +	 * Crystal:
> +	 *    =E2=80=A2 When T1 =3D T0 + 10 =CE=BCs:
> +	 *      T2 < T1 + 805 =CE=BCs =3D T0 + 815 =CE=BCs
> +	 *    =E2=80=A2 When T1 =3D T0 + 30 =CE=BCs:
> +	 *      T2 < T1 + 805 =CE=BCs =3D T0 + 835 =CE=BCs
> +	 * see "Reset and Power-Saving Signals" on page 60 an =E2=80=9CPowering=
 Up
> +	 * and Powering Down the USB 2.0 nanoPHY=E2=80=9D on page 73.
> +	 */

I don't think this comment is very interesting. The code already says=20
that the hardware needs at least 30 =C2=B5s to reset, all the low-level=20
details are in the programming manual for those who want to learn more.=20
Besides, since you don't actually modify the reset code, why update the=20
comment in this patch?

>  	usleep_range(30, 300);
>  	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>  	usleep_range(300, 1000);
> @@ -166,6 +251,15 @@ static void jz4770_phy_remove(void *phy)
>  	usb_remove_phy(phy);
>  }
>=20
> +static const struct of_device_id ingenic_usb_phy_of_matches[] =3D {
> +	{ .compatible =3D "ingenic,jz4770-phy", .data =3D (void *) ID_JZ4770 },
> +	{ .compatible =3D "ingenic,jz4780-phy", .data =3D (void *) ID_JZ4780 },
> +	{ .compatible =3D "ingenic,x1000-phy", .data =3D (void *) ID_X1000 },
> +	{ .compatible =3D "ingenic,x1830-phy", .data =3D (void *) ID_X1830 },

I'm not a fan of having ID_* as platform data. Create 'soc_info'=20
structures, one per supported SoC, and pass them here. Then you can add=20
a 'version' field of type 'enum ingenic_usb_phy_version'. And add a=20
'.phy_init' field as a function pointer, that would be called within=20
jz4770_phy_init(). That would make the jz4770_phy_init() function much=20
cleaner (no if/else/else/else/...).

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
> +
>  static int jz4770_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -176,11 +270,13 @@ static int jz4770_phy_probe(struct=20
> platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>=20
> +	priv->version =3D (enum=20
> ingenic_usb_phy_version)of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, priv);
>  	priv->dev =3D dev;
>  	priv->phy.dev =3D dev;
>  	priv->phy.otg =3D &priv->otg;
> -	priv->phy.label =3D "jz4770-phy";
> +	priv->phy.label =3D "ingenic-usb-phy";
>  	priv->phy.init =3D jz4770_phy_init;
>  	priv->phy.shutdown =3D jz4770_phy_shutdown;
>=20
> @@ -221,23 +317,15 @@ static int jz4770_phy_probe(struct=20
> platform_device *pdev)
>  	return devm_add_action_or_reset(dev, jz4770_phy_remove, &priv->phy);
>  }
>=20
> -#ifdef CONFIG_OF
> -static const struct of_device_id jz4770_phy_of_matches[] =3D {
> -	{ .compatible =3D "ingenic,jz4770-phy" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, jz4770_phy_of_matches);
> -#endif
> -
> -static struct platform_driver jz4770_phy_driver =3D {
> +static struct platform_driver ingenic_usb_phy_driver =3D {
>  	.probe		=3D jz4770_phy_probe,
>  	.driver		=3D {
> -		.name	=3D "jz4770-phy",
> -		.of_match_table =3D of_match_ptr(jz4770_phy_of_matches),
> +		.name	=3D "ingenic-usb-phy",
> +		.of_match_table =3D of_match_ptr(ingenic_usb_phy_of_matches),

It's preferred not to rename the functions unless you have a good=20
reason, and you definitely shouldn't rename the module. It's OK to have=20
a driver called 'jz4770-phy' even if it supports more SoCs. Renaming it=20
breaks userspace ABI.

Cheers,
-Paul

>  	},
>  };
> -module_platform_driver(jz4770_phy_driver);
> +module_platform_driver(ingenic_usb_phy_driver);
>=20
>  MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> -MODULE_DESCRIPTION("Ingenic JZ4770 USB PHY driver");
> +MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
>  MODULE_LICENSE("GPL");
> --
> 2.11.0
>=20


