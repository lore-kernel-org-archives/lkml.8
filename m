Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C24FC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB8A2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jgFmY+s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgIFRPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:15:40 -0400
Received: from crapouillou.net ([89.234.176.41]:56610 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgIFRPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599412535; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUga/Q7EWuqkPhxmMxJRmOQGSBs/t2z8k9zTKAn14yQ=;
        b=jgFmY+s9GJr9WRLIn1WnEiqxtTrV17bDqTlQccexQKr1C0c+Ie9QfJU/0Yn/uTRT94gokB
        ljBwU0+JurQDTI2o4TjqhJlwpeUlWfg/5Os4Hyh1aAy7EhgJLYWST0mczEhoU7AvVYIEYg
        JHKP4xj3BZRh2+NXGyiBiux+K5Ec1ns=
Date:   Sun, 06 Sep 2020 19:15:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/1] USB: PHY: JZ4770: Use the generic PHY framework.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     kishon@ti.com, vkoul@kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        aric.pzqi@ingenic.com, dongsheng.qiu@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <LLY8GQ.91N2RLJL8H3B@crapouillou.net>
In-Reply-To: <eaec3d3f-6c6f-ed29-804c-27d58545fd51@wanyeetech.com>
References: <20200831135046.54460-1-zhouyanjie@wanyeetech.com>
        <20200831135046.54460-2-zhouyanjie@wanyeetech.com>
        <UP05GQ.XQT4W4AH5E8W1@crapouillou.net>
        <eaec3d3f-6c6f-ed29-804c-27d58545fd51@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 7 sept. 2020 =C3=A0 1:06, Zhou Yanjie <zhouyanjie@wanyeetech.com> a=
=20
=C3=A9crit :
> Hi Paul,
>=20
> =E5=9C=A8 2020/9/4 =E4=B8=8B=E5=8D=8810:10, Paul Cercueil =E5=86=99=E9=81=
=93:
>> Hi Zhou,
>>=20
>> Le lun. 31 ao=C3=BBt 2020 =C3=A0 21:50, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zho=
u Yanjie)=20
>> =7F<zhouyanjie@wanyeetech.com> a =C3=A9crit :
>>> Used the generic PHY framework API to create the PHY,
>>> and move the driver to driver/phy/ingenic.
>>>=20
>>> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
>>> Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@i=
ngenic.com>
>>> Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>
>>> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wa=
nyeetech.com>
>>> ---
>>>=20
>>> Notes:
>>>     v1->v2:
>>>     Fix bug, ".of_match_table =3D=20
>>> =7F=7Fof_match_ptr(ingenic_usb_phy_of_matches)" is wrong
>>>     and should be replaced with ".of_match_table =3D=20
>>> =7F=7Fingenic_usb_phy_of_matches".
>>>=20
>>>  drivers/phy/Kconfig                                |   1 +
>>>  drivers/phy/Makefile                               |   1 +
>>>  drivers/phy/ingenic/Kconfig                        |  12 +
>>>  drivers/phy/ingenic/Makefile                       |   2 +
>>>  .../phy-jz4770.c =3D> phy/ingenic/phy-ingenic-usb.c} | 256=20
>>> =7F=7F++++++++++++---------
>>>  drivers/usb/phy/Kconfig                            |   8 -
>>>  drivers/usb/phy/Makefile                           |   1 -
>>>  7 files changed, 165 insertions(+), 116 deletions(-)
>>>  create mode 100644 drivers/phy/ingenic/Kconfig
>>>  create mode 100644 drivers/phy/ingenic/Makefile
>>>  rename drivers/{usb/phy/phy-jz4770.c =3D>=20
>>> =7F=7Fphy/ingenic/phy-ingenic-usb.c} (63%)
>>>=20
>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>> index de9362c25c07..0534b0fdd057 100644
>>> --- a/drivers/phy/Kconfig
>>> +++ b/drivers/phy/Kconfig
>>> @@ -55,6 +55,7 @@ source "drivers/phy/broadcom/Kconfig"
>>>  source "drivers/phy/cadence/Kconfig"
>>>  source "drivers/phy/freescale/Kconfig"
>>>  source "drivers/phy/hisilicon/Kconfig"
>>> +source "drivers/phy/ingenic/Kconfig"
>>>  source "drivers/phy/lantiq/Kconfig"
>>>  source "drivers/phy/marvell/Kconfig"
>>>  source "drivers/phy/mediatek/Kconfig"
>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>> index c27408e4daae..ab24f0d20763 100644
>>> --- a/drivers/phy/Makefile
>>> +++ b/drivers/phy/Makefile
>>> @@ -14,6 +14,7 @@ obj-y                    +=3D allwinner/    \
>>>                         cadence/    \
>>>                         freescale/    \
>>>                         hisilicon/    \
>>> +                       ingenic/    \
>>>                         intel/    \
>>>                         lantiq/    \
>>>                         marvell/    \
>>> diff --git a/drivers/phy/ingenic/Kconfig=20
>>> b/drivers/phy/ingenic/Kconfig
>>> new file mode 100644
>>> index 000000000000..b9581eae89dd
>>> --- /dev/null
>>> +++ b/drivers/phy/ingenic/Kconfig
>>> @@ -0,0 +1,12 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +#
>>> +# Phy drivers for Ingenic platforms
>>> +#
>>> +config PHY_INGENIC_USB
>>> +    tristate "Ingenic SoCs USB PHY Driver"
>>> +    depends on (MACH_INGENIC && MIPS) || COMPILE_TEST
>>=20
>> The original driver depends on MIPS || COMPILE_TEST, so you should=20
>> do =7Fthe same, otherwise you change more than what the patch=20
>> description =7Fsuggests.
>>=20
>=20
> Sure, I will change it in the next version.
>=20
>>> +    depends on USB_SUPPORT
>>> +    select GENERIC_PHY
>>> +    help
>>> +      This driver provides USB PHY support for the USB controller=20
>>> found
>>> +      on the JZ-series and X-series SoCs from Ingenic.
>>> diff --git a/drivers/phy/ingenic/Makefile=20
>>> b/drivers/phy/ingenic/Makefile
>>> new file mode 100644
>>> index 000000000000..65d5ea00fc9d
>>> --- /dev/null
>>> +++ b/drivers/phy/ingenic/Makefile
>>> @@ -0,0 +1,2 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +obj-y        +=3D phy-ingenic-usb.o
>>> diff --git a/drivers/usb/phy/phy-jz4770.c=20
>>> =7F=7Fb/drivers/phy/ingenic/phy-ingenic-usb.c
>>> similarity index 63%
>>> rename from drivers/usb/phy/phy-jz4770.c
>>> rename to drivers/phy/ingenic/phy-ingenic-usb.c
>>> index f6d3731581eb..86a95b498785 100644
>>> --- a/drivers/usb/phy/phy-jz4770.c
>>> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
>>> @@ -7,12 +7,12 @@
>>>   */
>>>=20
>>>  #include <linux/clk.h>
>>> +#include <linux/delay.h>
>>>  #include <linux/io.h>
>>>  #include <linux/module.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/regulator/consumer.h>
>>> -#include <linux/usb/otg.h>
>>> -#include <linux/usb/phy.h>
>>> +#include <linux/phy/phy.h>
>>>=20
>>>  /* OTGPHY register offsets */
>>>  #define REG_USBPCR_OFFSET            0x00
>>> @@ -97,68 +97,49 @@ enum ingenic_usb_phy_version {
>>>  struct ingenic_soc_info {
>>>      enum ingenic_usb_phy_version version;
>>>=20
>>> -    void (*usb_phy_init)(struct usb_phy *phy);
>>> +    void (*usb_phy_init)(struct phy *phy);
>>>  };
>>>=20
>>> -struct jz4770_phy {
>>> +struct ingenic_usb_phy {
>>>      const struct ingenic_soc_info *soc_info;
>>>=20
>>> -    struct usb_phy phy;
>>> -    struct usb_otg otg;
>>> +    struct phy *phy;
>>>      struct device *dev;
>>>      void __iomem *base;
>>>      struct clk *clk;
>>>      struct regulator *vcc_supply;
>>>  };
>>>=20
>>> -static inline struct jz4770_phy *otg_to_jz4770_phy(struct usb_otg=20
>>> *otg)
>>> +static int ingenic_usb_phy_init(struct phy *phy)
>>>  {
>>> -    return container_of(otg, struct jz4770_phy, otg);
>>> -}
>>> -
>>> -static inline struct jz4770_phy *phy_to_jz4770_phy(struct usb_phy=20
>>> *phy)
>>> -{
>>> -    return container_of(phy, struct jz4770_phy, phy);
>>> -}
>>> -
>>> -static int ingenic_usb_phy_set_peripheral(struct usb_otg *otg,
>>> -                     struct usb_gadget *gadget)
>>> -{
>>> -    struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
>>> -    u32 reg;
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>> +    int err;
>>>=20
>>> -    if (priv->soc_info->version >=3D ID_X1000) {
>>> -        reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
>>> -        reg |=3D USBPCR1_BVLD_REG;
>>> -        writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>> +    err =3D clk_prepare_enable(priv->clk);
>>> +    if (err) {
>>> +        dev_err(priv->dev, "Unable to start clock: %d\n", err);
>>> +        return err;
>>>      }
>>>=20
>>> -    reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>>> -    reg &=3D ~USBPCR_USB_MODE;
>>> -    reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
>>> =7F=7FUSBPCR_OTG_DISABLE;
>>> -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +    priv->soc_info->usb_phy_init(phy);
>>>=20
>>>      return 0;
>>>  }
>>>=20
>>> -static int ingenic_usb_phy_set_host(struct usb_otg *otg, struct=20
>>> =7F=7Fusb_bus *host)
>>> +static int ingenic_usb_phy_exit(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
>>> -    u32 reg;
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>=20
>>> -    reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>>> -    reg &=3D ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
>>> =7F=7FUSBPCR_OTG_DISABLE);
>>> -    reg |=3D USBPCR_USB_MODE;
>>> -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +    clk_disable_unprepare(priv->clk);
>>> +    regulator_disable(priv->vcc_supply);
>>>=20
>>>      return 0;
>>>  }
>>>=20
>>> -static int ingenic_usb_phy_init(struct usb_phy *phy)
>>> +static int ingenic_usb_phy_power_on(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>      int err;
>>> -    u32 reg;
>>>=20
>>>      err =3D regulator_enable(priv->vcc_supply);
>>>      if (err) {
>>> @@ -166,39 +147,71 @@ static int ingenic_usb_phy_init(struct=20
>>> usb_phy =7F=7F*phy)
>>>          return err;
>>>      }
>>>=20
>>> -    err =3D clk_prepare_enable(priv->clk);
>>> -    if (err) {
>>> -        dev_err(priv->dev, "Unable to start clock: %d\n", err);
>>> -        return err;
>>> -    }
>>> -
>>> -    priv->soc_info->usb_phy_init(phy);
>>> -
>>> -    /* Wait for PHY to reset */
>>> -    usleep_range(30, 300);
>>> -    reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>>> -    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>>> -    usleep_range(300, 1000);
>>> -
>>>      return 0;
>>>  }
>>>=20
>>> -static void ingenic_usb_phy_shutdown(struct usb_phy *phy)
>>> +static int ingenic_usb_phy_power_off(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>=20
>>> -    clk_disable_unprepare(priv->clk);
>>>      regulator_disable(priv->vcc_supply);
>>> +
>>> +    return 0;
>>>  }
>>>=20
>>> -static void ingenic_usb_phy_remove(void *phy)
>>> +static int ingenic_usb_phy_set_mode(struct phy *phy,
>>> +                  enum phy_mode mode, int submode)
>>>  {
>>> -    usb_remove_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>> +    u32 reg;
>>> +
>>> +    switch (mode) {
>>> +    case PHY_MODE_USB_HOST:
>>> +        reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>>> +        reg &=3D ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
>>> =7F=7FUSBPCR_OTG_DISABLE);
>>> +        reg |=3D USBPCR_USB_MODE;
>>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +        break;
>>> +    case PHY_MODE_USB_DEVICE:
>>> +        if (priv->soc_info->version >=3D ID_X1000) {
>>> +            reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
>>> +            reg |=3D USBPCR1_BVLD_REG;
>>> +            writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>> +        }
>>> +
>>> +        reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>>> +        reg &=3D ~USBPCR_USB_MODE;
>>> +        reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
>>> =7F=7FUSBPCR_OTG_DISABLE;
>>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +        break;
>>> +    case PHY_MODE_USB_OTG:
>>> +        reg =3D readl(priv->base + REG_USBPCR_OFFSET);
>>> +        reg &=3D ~USBPCR_OTG_DISABLE;
>>> +        reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
>>> =7F=7FUSBPCR_USB_MODE;
>>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>>  }
>>=20
>> I think the diff should be a bit smaller (and easier to review) if=20
>> you =7Fmove ingenic_usb_phy_init / ingenic_usb_phy_exit here, where=20
>> they used =7Fto be.
>>=20
>=20
> Sure.
>>>=20
>>> -static void jz4770_usb_phy_init(struct usb_phy *phy)
>>> +static const struct phy_ops ingenic_usb_phy_ops =3D {
>>> +    .init        =3D ingenic_usb_phy_init,
>>> +    .exit        =3D ingenic_usb_phy_exit,
>>> +    .power_on    =3D ingenic_usb_phy_power_on,
>>> +    .power_off    =3D ingenic_usb_phy_power_off,
>>> +    .set_mode    =3D ingenic_usb_phy_set_mode,
>>> +    .owner        =3D THIS_MODULE,
>>> +};
>>> +
>>> +static void jz4770_usb_phy_init(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>      u32 reg;
>>>=20
>>>      reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN |=20
>>> USBPCR_IDPULLUP_ALWAYS |
>>> @@ -206,11 +219,16 @@ static void jz4770_usb_phy_init(struct=20
>>> usb_phy =7F=7F*phy)
>>>          USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT |=20
>>> =7F=7FUSBPCR_TXVREFTUNE_DFT |
>>>          USBPCR_POR;
>>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +    /* Wait for PHY to reset */
>>> +    usleep_range(30, 300);
>>> +    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>>> +    usleep_range(300, 1000);
>>>  }
>>>=20
>>> -static void jz4780_usb_phy_init(struct usb_phy *phy)
>>> +static void jz4780_usb_phy_init(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>      u32 reg;
>>>=20
>>>      reg =3D readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL=20
>>> |
>>> @@ -219,11 +237,16 @@ static void jz4780_usb_phy_init(struct=20
>>> usb_phy =7F=7F*phy)
>>>=20
>>>      reg =3D USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +    /* Wait for PHY to reset */
>>> +    usleep_range(30, 300);
>>> +    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>>> +    usleep_range(300, 1000);
>>>  }
>>>=20
>>> -static void x1000_usb_phy_init(struct usb_phy *phy)
>>> +static void x1000_usb_phy_init(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>      u32 reg;
>>>=20
>>>      reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
>>> =7F=7FUSBPCR1_WORD_IF_16BIT;
>>> @@ -233,11 +256,16 @@ static void x1000_usb_phy_init(struct usb_phy=20
>>> =7F=7F*phy)
>>>          USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
>>>          USBPCR_COMMONONN | USBPCR_POR;
>>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +    /* Wait for PHY to reset */
>>> +    usleep_range(30, 300);
>>> +    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>>> +    usleep_range(300, 1000);
>>>  }
>>>=20
>>> -static void x1830_usb_phy_init(struct usb_phy *phy)
>>> +static void x1830_usb_phy_init(struct phy *phy)
>>>  {
>>> -    struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>> +    struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>>>      u32 reg;
>>>=20
>>>      /* rdt */
>>> @@ -250,6 +278,11 @@ static void x1830_usb_phy_init(struct usb_phy=20
>>> *phy)
>>>      reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |=20
>>> =7F=7FUSBPCR_TXPREEMPHTUNE |
>>>          USBPCR_COMMONONN | USBPCR_POR;
>>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>> +
>>> +    /* Wait for PHY to reset */
>>> +    usleep_range(30, 300);
>>> +    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>>> +    usleep_range(300, 1000);
>>=20
>> Why is that code repeated four times now? The old driver had that in=20
>> =7Fingenic_usb_phy_init().
>>=20
>=20
> This is my fault, I forgot to make the corresponding changes after I=20
> cherry-pick it from v6, I will fix this problem in the next version.
>=20
>>>  }
>>>=20
>>>  static const struct ingenic_soc_info jz4770_soc_info =3D {
>>> @@ -276,87 +309,96 @@ static const struct ingenic_soc_info=20
>>> =7F=7Fx1830_soc_info =3D {
>>>      .usb_phy_init =3D x1830_usb_phy_init,
>>>  };
>>>=20
>>> -static const struct of_device_id ingenic_usb_phy_of_matches[] =3D {
>>> -    { .compatible =3D "ingenic,jz4770-phy", .data =3D &jz4770_soc_info=
=20
>>> },
>>> -    { .compatible =3D "ingenic,jz4780-phy", .data =3D &jz4780_soc_info=
=20
>>> },
>>> -    { .compatible =3D "ingenic,x1000-phy", .data =3D &x1000_soc_info }=
,
>>> -    { .compatible =3D "ingenic,x1830-phy", .data =3D &x1830_soc_info }=
,
>>> -    { /* sentinel */ }
>>> -};
>>> -MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
>>> -
>>> -static int jz4770_phy_probe(struct platform_device *pdev)
>>> +static int ingenic_usb_phy_probe(struct platform_device *pdev)
>>>  {
>>> -    struct device *dev =3D &pdev->dev;
>>> -    struct jz4770_phy *priv;
>>> +    struct ingenic_usb_phy *priv;
>>> +    struct phy_provider *provider;
>>>      int err;
>>>=20
>>> -    priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +    priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>=20
>> I'd prefer that you keep a local 'dev' variable. Otherwise it only=20
>> =7Fmakes the diff bigger and it's harder to review.
>>=20
>=20
> Sure.
>=20
>>>      if (!priv)
>>>          return -ENOMEM;
>>>=20
>>> +    priv->dev =3D &pdev->dev;
>>> +
>>>      priv->soc_info =3D device_get_match_data(&pdev->dev);
>>>      if (!priv->soc_info) {
>>>          dev_err(&pdev->dev, "Error: No device match found\n");
>>>          return -ENODEV;
>>>      }
>>>=20
>>> -    platform_set_drvdata(pdev, priv);
>>> -    priv->dev =3D dev;
>>> -    priv->phy.dev =3D dev;
>>> -    priv->phy.otg =3D &priv->otg;
>>> -    priv->phy.label =3D "ingenic-usb-phy";
>>> -    priv->phy.init =3D ingenic_usb_phy_init;
>>> -    priv->phy.shutdown =3D ingenic_usb_phy_shutdown;
>>> -
>>> -    priv->otg.state =3D OTG_STATE_UNDEFINED;
>>> -    priv->otg.usb_phy =3D &priv->phy;
>>> -    priv->otg.set_host =3D ingenic_usb_phy_set_host;
>>> -    priv->otg.set_peripheral =3D ingenic_usb_phy_set_peripheral;
>>> -
>>>      priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>>>      if (IS_ERR(priv->base)) {
>>> -        dev_err(dev, "Failed to map registers\n");
>>> +        dev_err(priv->dev, "Failed to map registers\n");
>>>          return PTR_ERR(priv->base);
>>>      }
>>>=20
>>> -    priv->clk =3D devm_clk_get(dev, NULL);
>>> +    priv->clk =3D devm_clk_get(priv->dev, NULL);
>>>      if (IS_ERR(priv->clk)) {
>>>          err =3D PTR_ERR(priv->clk);
>>>          if (err !=3D -EPROBE_DEFER)
>>> -            dev_err(dev, "Failed to get clock\n");
>>> +            dev_err(priv->dev, "Failed to get clock\n");
>>>          return err;
>>>      }
>>>=20
>>> -    priv->vcc_supply =3D devm_regulator_get(dev, "vcc");
>>> +    priv->vcc_supply =3D devm_regulator_get(priv->dev, "vcc");
>>>      if (IS_ERR(priv->vcc_supply)) {
>>>          err =3D PTR_ERR(priv->vcc_supply);
>>>          if (err !=3D -EPROBE_DEFER)
>>> -            dev_err(dev, "Failed to get regulator\n");
>>> +            dev_err(priv->dev, "Failed to get regulator\n");
>>>          return err;
>>>      }
>>>=20
>>> -    err =3D usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
>>> -    if (err) {
>>> -        if (err !=3D -EPROBE_DEFER)
>>> -            dev_err(dev, "Unable to register PHY\n");
>>> -        return err;
>>> +    priv->phy =3D devm_phy_create(priv->dev, NULL,=20
>>> &ingenic_usb_phy_ops);
>>> +    if (IS_ERR(priv)) {
>>> +        dev_err(priv->dev, "Failed to create PHY: %ld\n",=20
>>> =7F=7FPTR_ERR(priv));
>>> +        return PTR_ERR(priv);
>>> +    }
>>=20
>> There's a stray tabulation character here.
>>=20
>> Also, no need to print error codes in the probe function - they will=20
>> =7Fbe printed anyway since the driver will fail to probe.
>>=20
> Sure.
>>> +
>>> +    provider =3D devm_of_phy_provider_register(priv->dev,=20
>>> =7F=7Fof_phy_simple_xlate);
>>> +    if (IS_ERR(provider)) {
>>> +        dev_err(priv->dev, "Failed to register PHY provider:=20
>>> %ld\n", =7F=7FPTR_ERR(provider));
>>> +        return PTR_ERR(provider);
>>>      }
>>=20
>> Same here.
>>=20
>>>=20
>>> -    return devm_add_action_or_reset(dev, ingenic_usb_phy_remove,=20
>>> =7F=7F&priv->phy);
>>> +    platform_set_drvdata(pdev, priv);
>>> +    phy_set_drvdata(priv->phy, priv);
>>=20
>> These two do the same thing. Also, you must do it before registering=20
>> =7Fthe PHY, otherwise you have a race.
>>=20
> OK, I will fix it in the next version.
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int ingenic_usb_phy_remove(struct platform_device *pdev)
>>> +{
>>> +    struct ingenic_usb_phy *priv =3D platform_get_drvdata(pdev);
>>> +
>>> +    clk_disable_unprepare(priv->clk);
>>> +    regulator_disable(priv->vcc_supply);
>>=20
>> I assume that ingenic_usb_phy_power_off() and ingenic_usb_phy_exit()=20
>> =7Fare automatically called when the module is removed, did you test=20
>> =7Fmodule removal?
>>=20
>=20
> I think I have an oversignt, only the module install was tested, but=20
> the module removal was not tested.
>=20
>>> +
>>> +    return 0;
>>>  }
>>>=20
>>> -static struct platform_driver ingenic_phy_driver =3D {
>>> -    .probe        =3D jz4770_phy_probe,
>>> +static const struct of_device_id ingenic_usb_phy_of_matches[] =3D {
>>> +    { .compatible =3D "ingenic,jz4770-phy", .data =3D &jz4770_soc_info=
=20
>>> },
>>> +    { .compatible =3D "ingenic,jz4780-phy", .data =3D &jz4780_soc_info=
=20
>>> },
>>> +    { .compatible =3D "ingenic,x1000-phy", .data =3D &x1000_soc_info }=
,
>>> +    { .compatible =3D "ingenic,x1830-phy", .data =3D &x1830_soc_info }=
,
>>> +    { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
>>=20
>> You moved that code around, which only made the diff bigger and=20
>> harder =7Fto review. Please keep it where it was.
>>=20
>=20
> Sure.
>=20
>>> +
>>> +static struct platform_driver ingenic_usb_phy_driver =3D {
>>> +    .probe        =3D ingenic_usb_phy_probe,
>>> +    .remove        =3D ingenic_usb_phy_remove,
>>>      .driver        =3D {
>>> -        .name    =3D "jz4770-phy",
>>> -        .of_match_table =3D of_match_ptr(ingenic_usb_phy_of_matches),
>>> +        .name    =3D "ingenic-usb-phy",
>>> +        .of_match_table =3D ingenic_usb_phy_of_matches,
>>=20
>> You removed of_match_ptr(), which is a valid change (Ingenic SoCs=20
>> all =7Fdepend on Device Tree), but is unrelated to this patch.
>>=20
>=20
> It was not removed in the previous version, so the test robot sent me=20
> an email. In this case, should I remove it directly herer or remove=20
> it in a separate patch?

Separate patch please, before the move to the generic PHY.

Cheers,
-Paul

>>>      },
>>>  };
>>> -module_platform_driver(ingenic_phy_driver);
>>> +module_platform_driver(ingenic_usb_phy_driver);
>>>=20
>>>  MODULE_AUTHOR("=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=20
>>> <zhouyanjie@wanyeetech.com>");
>>>  MODULE_AUTHOR("=E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@in=
genic.com>");
>>>  MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>>  MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
>>> +MODULE_ALIAS("jz4770_phy");
>>=20
>> Actually that would be "jz4770-phy".
>>=20
>=20
> Sure, I'll change it in the next version.
>=20
> Thanks and best regards!
>=20
>> Cheers,
>> -Paul
>>=20
>>>  MODULE_LICENSE("GPL");
>>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>>> index ef4787cd3d37..ff24fca0a2d9 100644
>>> --- a/drivers/usb/phy/Kconfig
>>> +++ b/drivers/usb/phy/Kconfig
>>> @@ -184,12 +184,4 @@ config USB_ULPI_VIEWPORT
>>>        Provides read/write operations to the ULPI phy register set=20
>>> for
>>>        controllers with a viewport register (e.g. Chipidea/ARC=20
>>> =7F=7Fcontrollers).
>>>=20
>>> -config JZ4770_PHY
>>> -    tristate "Ingenic SoCs Transceiver Driver"
>>> -    depends on MIPS || COMPILE_TEST
>>> -    select USB_PHY
>>> -    help
>>> -      This driver provides PHY support for the USB controller found
>>> -      on the JZ-series and X-series SoCs from Ingenic.
>>> -
>>>  endmenu
>>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>>> index b352bdbe8712..df1d99010079 100644
>>> --- a/drivers/usb/phy/Makefile
>>> +++ b/drivers/usb/phy/Makefile
>>> @@ -24,4 +24,3 @@ obj-$(CONFIG_USB_MXS_PHY)        +=3D phy-mxs-usb.o
>>>  obj-$(CONFIG_USB_ULPI)            +=3D phy-ulpi.o
>>>  obj-$(CONFIG_USB_ULPI_VIEWPORT)        +=3D phy-ulpi-viewport.o
>>>  obj-$(CONFIG_KEYSTONE_USB_PHY)        +=3D phy-keystone.o
>>> -obj-$(CONFIG_JZ4770_PHY)        +=3D phy-jz4770.o
>>> --
>>> 2.11.0
>>>=20
>>=20


