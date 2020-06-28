Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BBEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D86A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="J8mMFdfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbgF2UqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:46:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56648 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731528AbgF2TNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593419632; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pcSDSwgUSuwtmdTXnj1hE1ZhuHhZcqyX9IrlTZ70LY=;
        b=J8mMFdfS4LbHS2W2QN+nDOGiibNBoCBvBDww2AltiMvROayVRYt74optfglLs6so8k8lf+
        eFhA3TnHvtREID7EL8tK0QsRAiQzumxcfHNhyW47VLEF5K/SofsE/xyarGJ1VXile7DXDM
        Oh4m2H1br/6WmpI25mbWB1D0UqtKcXY=
Date:   Sun, 28 Jun 2020 19:03:54 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] clk: X1000: Add support for calculat REFCLK of USB
 PHY.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <IEBNCQ.EWU8F7SNWRJK2@crapouillou.net>
In-Reply-To: <b0a3a0b0-4ae8-3905-8d0c-50e44511fa95@wanyeetech.com>
References: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
        <20200626164844.25436-3-zhouyanjie@wanyeetech.com>
        <AKNJCQ.6UUHR0DBDE8E2@crapouillou.net>
        <b0a3a0b0-4ae8-3905-8d0c-50e44511fa95@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le lun. 29 juin 2020 =C3=A0 0:18, Zhou Yanjie <zhouyanjie@wanyeetech.com> a=
=20
=C3=A9crit :
> Hi Paul,
>=20
> =E5=9C=A8 2020/6/27 =E4=B8=8A=E5=8D=881:36, Paul Cercueil =E5=86=99=E9=81=
=93:
>> Hi Zhou,
>>=20
>> Le sam. 27 juin 2020 =C3=A0 0:48, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanj=
ie)=20
>> =7F<zhouyanjie@wanyeetech.com> a =C3=A9crit :
>>> Add new functions to "x1000_otg_phy_ops" to calculat the rate of=20
>>> REFCLK,
>>> which is needed by USB PHY in the Ingenic X1000 SoC.
>>>=20
>>> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
>>> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wa=
nyeetech.com>
>>> ---
>>>  drivers/clk/ingenic/x1000-cgu.c | 113=20
>>> =7F=7F++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 113 insertions(+)
>>>=20
>>> diff --git a/drivers/clk/ingenic/x1000-cgu.c=20
>>> =7F=7Fb/drivers/clk/ingenic/x1000-cgu.c
>>> index 453f3323cb99..a61c16f98a11 100644
>>> --- a/drivers/clk/ingenic/x1000-cgu.c
>>> +++ b/drivers/clk/ingenic/x1000-cgu.c
>>> @@ -48,8 +48,114 @@
>>>  #define USBPCR_SIDDQ        BIT(21)
>>>  #define USBPCR_OTG_DISABLE    BIT(20)
>>>=20
>>> +/* bits within the USBPCR1 register */
>>> +#define USBPCR1_REFCLKSEL_SHIFT    26
>>> +#define USBPCR1_REFCLKSEL_MASK    (0x3 << USBPCR1_REFCLKSEL_SHIFT)
>>> +#define USBPCR1_REFCLKSEL_CORE    (0x2 << USBPCR1_REFCLKSEL_SHIFT)
>>> +#define USBPCR1_REFCLKDIV_SHIFT    24
>>> +#define USBPCR1_REFCLKDIV_MASK    (0x3 << USBPCR1_REFCLKDIV_SHIFT)
>>> +#define USBPCR1_REFCLKDIV_48    (0x2 << USBPCR1_REFCLKDIV_SHIFT)
>>> +#define USBPCR1_REFCLKDIV_24    (0x1 << USBPCR1_REFCLKDIV_SHIFT)
>>> +#define USBPCR1_REFCLKDIV_12    (0x0 << USBPCR1_REFCLKDIV_SHIFT)
>>> +
>>>  static struct ingenic_cgu *cgu;
>>>=20
>>> +static u8 x1000_otg_phy_get_parent(struct clk_hw *hw)
>>> +{
>>> +    /* we only use CLKCORE, revisit if that ever changes */
>>> +    return 0;
>>> +}
>>> +
>>> +static int x1000_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
>>> +{
>>> +    unsigned long flags;
>>> +    u32 usbpcr1;
>>> +
>>> +    if (idx > 0)
>>> +        return -EINVAL;
>>> +
>>> +    spin_lock_irqsave(&cgu->lock, flags);
>>> +
>>> +    usbpcr1 =3D readl(cgu->base + CGU_REG_USBPCR1);
>>> +    usbpcr1 &=3D ~USBPCR1_REFCLKSEL_MASK;
>>> +    /* we only use CLKCORE */
>>> +    usbpcr1 |=3D USBPCR1_REFCLKSEL_CORE;
>>> +    writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
>>> +
>>> +    spin_unlock_irqrestore(&cgu->lock, flags);
>>> +    return 0;
>>> +}
>>=20
>> If you only support one parent, maybe set that bit in the=20
>> =7Fx1000_cgu_init(), then you can drop the get_parent/set_parent.
>>=20
>=20
> Sure.
>=20
>=20
>>> +
>>> +static unsigned long x1000_otg_phy_recalc_rate(struct clk_hw *hw,
>>> +                        unsigned long parent_rate)
>>> +{
>>> +    u32 usbpcr1;
>>> +    unsigned refclk_div;
>>> +
>>> +    usbpcr1 =3D readl(cgu->base + CGU_REG_USBPCR1);
>>> +    refclk_div =3D usbpcr1 & USBPCR1_REFCLKDIV_MASK;
>>> +
>>> +    switch (refclk_div) {
>>> +    case USBPCR1_REFCLKDIV_12:
>>> +        return 12000000;
>>> +
>>> +    case USBPCR1_REFCLKDIV_24:
>>> +        return 24000000;
>>> +
>>> +    case USBPCR1_REFCLKDIV_48:
>>> +        return 48000000;
>>> +    }
>>=20
>> On your setup, what frequency is configured for the "otg" clock? Is=20
>> it =7F48 MHz?
>>=20
>> I believe CLKCORE is the OTG core's clock (aka "otg"), and I'm=20
>> pretty =7Fsure that these fields only represent CLKCORE/4, CLKCORE/2,=20
>> CLKCORE/1, =7Fbut the doc expects CLKCORE=3D=3D48MHz.
>>=20
>=20
> This is the REFCLKDIV in USBPCR1 reg, it's for the usb phy, so it is=20
> not the otg clock. In X1000 and X1500 it is 24MHz, in JZ4780 it is=20
> 48MHz.

I know it is for the OTG PHY clock, what I'm saying is that the OTG PHY=20
clock is derived from CLKCORE which I believe is the "otg" clock.=20
Unless the clock represents a crystal, it is derived from another=20
clock, and as a result the clock rate should be computed from the=20
parent clock rate.

-Paul

>=20
>> In that case the "otg_phy" should be parented to "otg", and the rate=20
>> =7Fshould be computed according to the parent rate and the divider=20
>> =7Fconfigured.
>>=20
>>> +
>>> +    BUG();
>>=20
>> Don't use BUG() - it pisses off Linus :)
>> And it's reserved for bugs that will take the whole system down, I=20
>> =7Fthink. Better use WARN().
>>=20
>=20
> Sure, I will change it in the next version.
>=20
> Thanks and best regards!
>=20
>=20
>> Cheers,
>> -Paul
>>=20
>>> +    return parent_rate;
>>> +}
>>> +
>>> +static long x1000_otg_phy_round_rate(struct clk_hw *hw, unsigned=20
>>> =7F=7Flong req_rate,
>>> +                      unsigned long *parent_rate)
>>> +{
>>> +    if (req_rate < 18000000)
>>> +        return 12000000;
>>> +
>>> +    if (req_rate < 36000000)
>>> +        return 24000000;
>>> +
>>> +    return 48000000;
>>> +}
>>> +
>>> +static int x1000_otg_phy_set_rate(struct clk_hw *hw, unsigned long=20
>>> =7F=7Freq_rate,
>>> +                   unsigned long parent_rate)
>>> +{
>>> +    unsigned long flags;
>>> +    u32 usbpcr1, div_bits;
>>> +
>>> +    switch (req_rate) {
>>> +    case 12000000:
>>> +        div_bits =3D USBPCR1_REFCLKDIV_12;
>>> +        break;
>>> +
>>> +    case 24000000:
>>> +        div_bits =3D USBPCR1_REFCLKDIV_24;
>>> +        break;
>>> +
>>> +    case 48000000:
>>> +        div_bits =3D USBPCR1_REFCLKDIV_48;
>>> +        break;
>>> +
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    spin_lock_irqsave(&cgu->lock, flags);
>>> +
>>> +    usbpcr1 =3D readl(cgu->base + CGU_REG_USBPCR1);
>>> +    usbpcr1 &=3D ~USBPCR1_REFCLKDIV_MASK;
>>> +    usbpcr1 |=3D div_bits;
>>> +    writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
>>> +
>>> +    spin_unlock_irqrestore(&cgu->lock, flags);
>>> +    return 0;
>>> +}
>>> +
>>>  static int x1000_usb_phy_enable(struct clk_hw *hw)
>>>  {
>>>      void __iomem *reg_opcr        =3D cgu->base + CGU_REG_OPCR;
>>> @@ -80,6 +186,13 @@ static int x1000_usb_phy_is_enabled(struct=20
>>> clk_hw =7F=7F*hw)
>>>  }
>>>=20
>>>  static const struct clk_ops x1000_otg_phy_ops =3D {
>>> +    .get_parent =3D x1000_otg_phy_get_parent,
>>> +    .set_parent =3D x1000_otg_phy_set_parent,
>>> +
>>> +    .recalc_rate =3D x1000_otg_phy_recalc_rate,
>>> +    .round_rate =3D x1000_otg_phy_round_rate,
>>> +    .set_rate =3D x1000_otg_phy_set_rate,
>>> +
>>>      .enable        =3D x1000_usb_phy_enable,
>>>      .disable    =3D x1000_usb_phy_disable,
>>>      .is_enabled    =3D x1000_usb_phy_is_enabled,
>>> --
>>> 2.11.0
>>>=20
>>=20


