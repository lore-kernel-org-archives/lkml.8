Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E7022CBB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598533461;
	bh=d4Bbz6immrh2cuagoKGQb8dRAnNcJbLXhsZf4tTIDuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=nJR/yHQ7ITUnLhYOVk65wyG7YVjPmmPBdBM7zFe7jsKhFwRX0foOpcLtDCSDp1RAD
	 CUbMFkTMI25EuooO1QTBF9+tKKPaxKUNUJFzUhK7W4+YzPN6f+cpSH8bc/o2QyTwlK
	 YfDuM4FnY6smFuudgv30XXHMSgf5tyrCcCG7ZbIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0NDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgH0M7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:59:14 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E1D2177B;
        Thu, 27 Aug 2020 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598533134;
        bh=d4Bbz6immrh2cuagoKGQb8dRAnNcJbLXhsZf4tTIDuo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AQ/wQXnZJKoZcYs1/FwK94+TQjXENo2Hjf2OAsdhJNc5Et0ZXE6XJ1r5mXTmj3D9Z
         xIXd+o3pg9l25PF2JOobM50WTJK4Au0fCL1nLs+dugKc0tlEiIMdQdJ6aqXSt/CnKO
         to651qbL2bf1UTwBv8tnKPkMuV6WXpzmID7X2wP4=
From:   Felipe Balbi <balbi@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?utf-8?B?5ZGo5q2j?= <sernia.zhou@foxmail.com>,
        =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>
Cc:     od@zcrc.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written
 to HW register
In-Reply-To: <20200827124308.71963-2-paul@crapouillou.net>
References: <20200827124308.71963-1-paul@crapouillou.net>
 <20200827124308.71963-2-paul@crapouillou.net>
Date:   Thu, 27 Aug 2020 15:58:46 +0300
Message-ID: <87v9h4i6t5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Paul Cercueil <paul@crapouillou.net> writes:
> The 'reg' value was written to a hardware register in
> ingenic_usb_phy_init(), while not being initialized anywhere.

your patch does a lot more than fix the bug :-)

> Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new Ingenic SoCs.=
")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/phy/phy-jz4770.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
> index d4ee3cb721ea..58771a8688f2 100644
> --- a/drivers/usb/phy/phy-jz4770.c
> +++ b/drivers/usb/phy/phy-jz4770.c
> @@ -97,7 +97,7 @@ enum ingenic_usb_phy_version {
>  struct ingenic_soc_info {
>  	enum ingenic_usb_phy_version version;
>=20=20
> -	void (*usb_phy_init)(struct usb_phy *phy);
> +	u32 (*usb_phy_init)(struct usb_phy *phy);

this is not fixing any bug

> @@ -172,7 +172,8 @@ static int ingenic_usb_phy_init(struct usb_phy *phy)
>  		return err;
>  	}
>=20=20
> -	priv->soc_info->usb_phy_init(phy);
> +	reg =3D priv->soc_info->usb_phy_init(phy);
> +	writel(reg, priv->base + REG_USBPCR_OFFSET);

not fixing any bug.

Looking at the code, the bug follows after this line. It would suffice
to read REG_USBPCR_OFFSET in order to initialize reg. This bug fix could
have been a one liner.

> @@ -195,19 +196,15 @@ static void ingenic_usb_phy_remove(void *phy)
>  	usb_remove_phy(phy);
>  }
>=20=20
> -static void jz4770_usb_phy_init(struct usb_phy *phy)
> +static u32 jz4770_usb_phy_init(struct usb_phy *phy)

not a bug fix

>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> -	u32 reg;
> -
> -	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
> +	return USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
>  		USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT | USBPCR_SQRXTUNE_DFT |
>  		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT |
>  		USBPCR_POR;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);

not a bug fix

>  }
>=20=20
> -static void jz4780_usb_phy_init(struct usb_phy *phy)
> +static u32 jz4780_usb_phy_init(struct usb_phy *phy)

not a bug fix

> @@ -216,11 +213,10 @@ static void jz4780_usb_phy_init(struct usb_phy *phy)
>  		USBPCR1_WORD_IF_16BIT;
>  	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>=20=20
> -	reg =3D USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);
> +	return USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;

not a bug fix

>  }
>=20=20
> -static void x1000_usb_phy_init(struct usb_phy *phy)
> +static u32 x1000_usb_phy_init(struct usb_phy *phy)

not a bug fix

>  {
>  	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>  	u32 reg;
> @@ -228,13 +224,12 @@ static void x1000_usb_phy_init(struct usb_phy *phy)
>  	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_WORD_IF_16BIT;
>  	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>=20=20
> -	reg =3D USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
> +	return USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>  		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
>  		USBPCR_COMMONONN | USBPCR_POR;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);

not a bug fix

>  }
>=20=20
> -static void x1830_usb_phy_init(struct usb_phy *phy)
> +static u32 x1830_usb_phy_init(struct usb_phy *phy)

not a bug fix

>  {
>  	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>  	u32 reg;
> @@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy *phy)
>  		USBPCR1_DMPD | USBPCR1_DPPD;
>  	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>=20=20
> -	reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |	USBPCR_TXPREEMPHTUNE |
> +	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT | USBPCR_TXPREEMPHTUNE |
>  		USBPCR_COMMONONN | USBPCR_POR;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);

not a bug fix

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9HrgYRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaT/w/+JlNAlTBK+BeN8ZHhLCNQ6q9UGiD4uzhE
dROf/8FE7LYMOOu+gU/eP0srxyxnWaDFNINb2JTpwb+jlyPyzYCLgncIYdGN0thD
DgtItb3aGkq8o0pDKr/Ql/7+GP8NBcIxFHKz/MFp3hHOzccOqMzCsIeirIj0mvNT
S6UYLJUjkEMwed37CXKIt72kxnIv02H48opi8FxFd0Jx2je8PFl+/CL/V+Yq4Ovg
VmcSc2X8lIhIxcE24TNwBSNP8uvpB9beCqh9Olih+fbJRE0Di9SpZXJFQJx9gBm3
6zm0CpjaD3K1T50GIXaHNmBRBS94SqywhxTQyoDLAghqNKYLCVpMcfezJZQoqGr+
ExTY4aFgScrgNEubJ+aq1MPZsirhZW/wzW9Ov7//mQr/yahhUzNkQCkOeyiRdN1E
Qphcr3RFlucqEoDjASRYetQTwI761snTt1nBIfTtJgKqMOKuL4P9vJ3yblmKsqm6
5XXqDsfyI4oKjLLsEpDF1ckX3/IlXYFNPZ0tq95H8UOrO2x/X6e/jhToHG6DdPcJ
9578H9gk1ALmhnRqqyHUBmILgSDRynjOLssPN+OGiuLB1u5SEtt8ist7FLKkh9LU
upM9GjxAzLzdIb4/l5VprnMYPslkVKII0MXWkuM0pQcM/PslwB+HuyXmLa8jKDGf
JLBfkngI1QE=
=YW/H
-----END PGP SIGNATURE-----
--=-=-=--
