Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DF7207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dpNh35xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgFZRgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:36:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35518 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593192981; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7Gk2/MvVNbeJ23s9omPDJ4FyKx8jvfy+MPVRv3ZRAU=;
        b=dpNh35xh6edz0TF4NGaNqhL0AX6pDWk/dLxCI8uu3H344xi3wR0ABwOmo/WJ6tcLplTMmk
        WZcpOv4RP1AFDBlRWOWBJYeOyegebjf6LDZ8V+ZmL5EQBeJDSt4GE7/+SXzR7Sae6cB9z+
        Sn/ch/qdtFVPPDJkWQZuAlRhaTdyTSw=
Date:   Fri, 26 Jun 2020 19:36:10 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] clk: X1000: Add support for calculat REFCLK of USB
 PHY.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <AKNJCQ.6UUHR0DBDE8E2@crapouillou.net>
In-Reply-To: <20200626164844.25436-3-zhouyanjie@wanyeetech.com>
References: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
        <20200626164844.25436-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le sam. 27 juin 2020 =C3=A0 0:48, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=
=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add new functions to "x1000_otg_phy_ops" to calculat the rate of=20
> REFCLK,
> which is needed by USB PHY in the Ingenic X1000 SoC.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>  drivers/clk/ingenic/x1000-cgu.c | 113=20
> ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>=20
> diff --git a/drivers/clk/ingenic/x1000-cgu.c=20
> b/drivers/clk/ingenic/x1000-cgu.c
> index 453f3323cb99..a61c16f98a11 100644
> --- a/drivers/clk/ingenic/x1000-cgu.c
> +++ b/drivers/clk/ingenic/x1000-cgu.c
> @@ -48,8 +48,114 @@
>  #define USBPCR_SIDDQ		BIT(21)
>  #define USBPCR_OTG_DISABLE	BIT(20)
>=20
> +/* bits within the USBPCR1 register */
> +#define USBPCR1_REFCLKSEL_SHIFT	26
> +#define USBPCR1_REFCLKSEL_MASK	(0x3 << USBPCR1_REFCLKSEL_SHIFT)
> +#define USBPCR1_REFCLKSEL_CORE	(0x2 << USBPCR1_REFCLKSEL_SHIFT)
> +#define USBPCR1_REFCLKDIV_SHIFT	24
> +#define USBPCR1_REFCLKDIV_MASK	(0x3 << USBPCR1_REFCLKDIV_SHIFT)
> +#define USBPCR1_REFCLKDIV_48	(0x2 << USBPCR1_REFCLKDIV_SHIFT)
> +#define USBPCR1_REFCLKDIV_24	(0x1 << USBPCR1_REFCLKDIV_SHIFT)
> +#define USBPCR1_REFCLKDIV_12	(0x0 << USBPCR1_REFCLKDIV_SHIFT)
> +
>  static struct ingenic_cgu *cgu;
>=20
> +static u8 x1000_otg_phy_get_parent(struct clk_hw *hw)
> +{
> +	/* we only use CLKCORE, revisit if that ever changes */
> +	return 0;
> +}
> +
> +static int x1000_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
> +{
> +	unsigned long flags;
> +	u32 usbpcr1;
> +
> +	if (idx > 0)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&cgu->lock, flags);
> +
> +	usbpcr1 =3D readl(cgu->base + CGU_REG_USBPCR1);
> +	usbpcr1 &=3D ~USBPCR1_REFCLKSEL_MASK;
> +	/* we only use CLKCORE */
> +	usbpcr1 |=3D USBPCR1_REFCLKSEL_CORE;
> +	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
> +
> +	spin_unlock_irqrestore(&cgu->lock, flags);
> +	return 0;
> +}

If you only support one parent, maybe set that bit in the=20
x1000_cgu_init(), then you can drop the get_parent/set_parent.

> +
> +static unsigned long x1000_otg_phy_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	u32 usbpcr1;
> +	unsigned refclk_div;
> +
> +	usbpcr1 =3D readl(cgu->base + CGU_REG_USBPCR1);
> +	refclk_div =3D usbpcr1 & USBPCR1_REFCLKDIV_MASK;
> +
> +	switch (refclk_div) {
> +	case USBPCR1_REFCLKDIV_12:
> +		return 12000000;
> +
> +	case USBPCR1_REFCLKDIV_24:
> +		return 24000000;
> +
> +	case USBPCR1_REFCLKDIV_48:
> +		return 48000000;
> +	}

On your setup, what frequency is configured for the "otg" clock? Is it=20
48 MHz?

I believe CLKCORE is the OTG core's clock (aka "otg"), and I'm pretty=20
sure that these fields only represent CLKCORE/4, CLKCORE/2, CLKCORE/1,=20
but the doc expects CLKCORE=3D=3D48MHz.

In that case the "otg_phy" should be parented to "otg", and the rate=20
should be computed according to the parent rate and the divider=20
configured.

> +
> +	BUG();

Don't use BUG() - it pisses off Linus :)
And it's reserved for bugs that will take the whole system down, I=20
think. Better use WARN().

Cheers,
-Paul

> +	return parent_rate;
> +}
> +
> +static long x1000_otg_phy_round_rate(struct clk_hw *hw, unsigned=20
> long req_rate,
> +				      unsigned long *parent_rate)
> +{
> +	if (req_rate < 18000000)
> +		return 12000000;
> +
> +	if (req_rate < 36000000)
> +		return 24000000;
> +
> +	return 48000000;
> +}
> +
> +static int x1000_otg_phy_set_rate(struct clk_hw *hw, unsigned long=20
> req_rate,
> +				   unsigned long parent_rate)
> +{
> +	unsigned long flags;
> +	u32 usbpcr1, div_bits;
> +
> +	switch (req_rate) {
> +	case 12000000:
> +		div_bits =3D USBPCR1_REFCLKDIV_12;
> +		break;
> +
> +	case 24000000:
> +		div_bits =3D USBPCR1_REFCLKDIV_24;
> +		break;
> +
> +	case 48000000:
> +		div_bits =3D USBPCR1_REFCLKDIV_48;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&cgu->lock, flags);
> +
> +	usbpcr1 =3D readl(cgu->base + CGU_REG_USBPCR1);
> +	usbpcr1 &=3D ~USBPCR1_REFCLKDIV_MASK;
> +	usbpcr1 |=3D div_bits;
> +	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
> +
> +	spin_unlock_irqrestore(&cgu->lock, flags);
> +	return 0;
> +}
> +
>  static int x1000_usb_phy_enable(struct clk_hw *hw)
>  {
>  	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> @@ -80,6 +186,13 @@ static int x1000_usb_phy_is_enabled(struct clk_hw=20
> *hw)
>  }
>=20
>  static const struct clk_ops x1000_otg_phy_ops =3D {
> +	.get_parent =3D x1000_otg_phy_get_parent,
> +	.set_parent =3D x1000_otg_phy_set_parent,
> +
> +	.recalc_rate =3D x1000_otg_phy_recalc_rate,
> +	.round_rate =3D x1000_otg_phy_round_rate,
> +	.set_rate =3D x1000_otg_phy_set_rate,
> +
>  	.enable		=3D x1000_usb_phy_enable,
>  	.disable	=3D x1000_usb_phy_disable,
>  	.is_enabled	=3D x1000_usb_phy_is_enabled,
> --
> 2.11.0
>=20


