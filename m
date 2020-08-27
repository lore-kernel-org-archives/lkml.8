Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4737C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13DB22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598535102;
	bh=nq5+PCguov0nBPnuBUE5YRB4tRsLuPvU3wHdjfwz+6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=QUBDx9JTvSl2ecHGejamYfmBg/obBkALNUdxwyPdp/DFMNxYHe5wiYKSAheI/F6iV
	 AjTfNQpvFvBezyj/6M/pl8trYnVPJeinVP6rK06JJyRE9N/nEUplcxh/x3keRDRC1p
	 DnWjGjW0EYK3XfG+p5hOLdVgOPkAuFWBomCMEKA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgH0Nbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgH0N0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:26:25 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CB02177B;
        Thu, 27 Aug 2020 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598534725;
        bh=nq5+PCguov0nBPnuBUE5YRB4tRsLuPvU3wHdjfwz+6w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pV09dhj0HqFaav1SauxvQbsAUbF8O8lanGpHV0Ra0sHSzuCutOC77h/Voqy59JPOO
         MXZs6YjjpgdzUAJmKLkoJ927yX77xFe9MhUFYiTHfF3e0VVwQMVkkrEnGyGQg43gPA
         G38VttbF8iDsrQkf5tXMZSLrx4jp+zEjq28dA2Ek=
From:   Felipe Balbi <balbi@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?utf-8?B?5ZGo?= =?utf-8?B?5q2j?= <sernia.zhou@foxmail.com>,
        =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>, od@zcrc.me,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written
 to HW register
In-Reply-To: <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net>
References: <20200827124308.71963-1-paul@crapouillou.net>
 <20200827124308.71963-2-paul@crapouillou.net> <87v9h4i6t5.fsf@kernel.org>
 <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net>
Date:   Thu, 27 Aug 2020 16:25:18 +0300
Message-ID: <87bliwi5kx.fsf@kernel.org>
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
>>>  @@ -172,7 +172,8 @@ static int ingenic_usb_phy_init(struct usb_phy=20
>>> *phy)
>>>   		return err;
>>>   	}
>>>=20
>>>  -	priv->soc_info->usb_phy_init(phy);
>>>  +	reg =3D priv->soc_info->usb_phy_init(phy);
>>>  +	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>=20
>> not fixing any bug.
>>=20
>> Looking at the code, the bug follows after this line. It would suffice
>> to read REG_USBPCR_OFFSET in order to initialize reg. This bug fix=20
>> could
>> have been a one liner.
>
> There's no need to re-read a register when you have the value readily=20
> available. It just needs to be returned from the usb_phy_init=20
> callbacks. But yes, it's not a one-liner.

there's a difference between making a bug fix and reworking the behavior
of the driver ;-)

>>>  @@ -195,19 +196,15 @@ static void ingenic_usb_phy_remove(void *phy)
>>>   	usb_remove_phy(phy);
>>>   }
>>>=20
>>>  -static void jz4770_usb_phy_init(struct usb_phy *phy)
>>>  +static u32 jz4770_usb_phy_init(struct usb_phy *phy)
>>=20
>> not a bug fix
>>=20
>>>   {
>>>  -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>>  -	u32 reg;
>>>  -
>>>  -	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS=
=20
>>> |
>>>  +	return USBPCR_AVLD_REG | USBPCR_COMMONONN |=20
>>> USBPCR_IDPULLUP_ALWAYS |
>>>   		USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT |=20
>>> USBPCR_SQRXTUNE_DFT |
>>>   		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT |=20
>>> USBPCR_TXVREFTUNE_DFT |
>>>   		USBPCR_POR;
>>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>=20
>> not a bug fix
>>=20
>>>   }
>>>=20
>>>  -static void jz4780_usb_phy_init(struct usb_phy *phy)
>>>  +static u32 jz4780_usb_phy_init(struct usb_phy *phy)
>>=20
>> not a bug fix
>>=20
>>>  @@ -216,11 +213,10 @@ static void jz4780_usb_phy_init(struct=20
>>> usb_phy *phy)
>>>   		USBPCR1_WORD_IF_16BIT;
>>>   	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>=20
>>>  -	reg =3D USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>  +	return USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>=20
>> not a bug fix
>>=20
>>>   }
>>>=20
>>>  -static void x1000_usb_phy_init(struct usb_phy *phy)
>>>  +static u32 x1000_usb_phy_init(struct usb_phy *phy)
>>=20
>> not a bug fix
>>=20
>>>   {
>>>   	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>>   	u32 reg;
>>>  @@ -228,13 +224,12 @@ static void x1000_usb_phy_init(struct usb_phy=20
>>> *phy)
>>>   	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
>>> USBPCR1_WORD_IF_16BIT;
>>>   	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>=20
>>>  -	reg =3D USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>>  +	return USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>>   		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
>>>   		USBPCR_COMMONONN | USBPCR_POR;
>>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>=20
>> not a bug fix
>>=20
>>>   }
>>>=20
>>>  -static void x1830_usb_phy_init(struct usb_phy *phy)
>>>  +static u32 x1830_usb_phy_init(struct usb_phy *phy)
>>=20
>> not a bug fix
>>=20
>>>   {
>>>   	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>>   	u32 reg;
>>>  @@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy=20
>>> *phy)
>>>   		USBPCR1_DMPD | USBPCR1_DPPD;
>>>   	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>=20
>>>  -	reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT=20
>>> |	USBPCR_TXPREEMPHTUNE |
>>>  +	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |=20
>>> USBPCR_TXPREEMPHTUNE |
>>>   		USBPCR_COMMONONN | USBPCR_POR;
>>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>=20
>> not a bug fix
>
> Well, if you don't like my bug fix, next time wait for my Reviewed-by.

why so angry? Take a break every once in a while. Besides, someone else
already sent the oneliner before you ;-)

In any case, why should I wait for your Reviewed-by? Get maintainer
doesn't list you as the maintainer for it. Do you want to update
MAINTAINERS by any chance?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9HtD4RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbmkg/6A6su3CbiM5/EDQM0TPLxiJMmFN+kRX5F
vXp7xxu1B7iYEfai8fmXfR/rEdiQQgwBnAhigqNUHhzyzuhsxPbZ2jvDoIoY9e1o
0egUHicDVH10gWj9Od3ZiLHVdG1K7x2AC3cddePtN82om/sUJrRWxqDAR2MfCNzN
aARpImMPai7C9i0uAHkj4aLAbryk9zXzpZUbOP6DYm6VrQqHCPVRkLvt09EUvVQZ
iIkxWz2/MjWPMNhuGZ1xQnHvcBBFRdW9lRcEBidhWEKjevRSFFN/FsiFcfOsLpG7
gHxFVoCz8TWEBGASDCoVi1hZOTTcs+S0PkO9L5efY+Z3Kb9VTmnGe379hfBA88Gs
NlVLm1xPviJS+GdVmEHjvDD03P/jlESmAcAv5bo8eJd3e0HcSedwYnKflL7Tez8R
04CkUo9m0HS7pZ3Dj0QlHVG5+n2kB6q5SuegSepAPhu0o1T3FEWS0kVOJ8x/4JBO
pH3HbroqbayuCUQVPXex6/jfLiVbu/Oq+mqx/YOgaE8LTk2i7pHxv/DuhG7desN+
4bGm4CYaR2UeMTiqSKdXN8FX4sQk8vGvvNo26gx7klYDLGR2w6OWtYTu2OGTvJkD
RyS8l5e9acIH6nU64fK8BPRrirkX2Hwa/yy/pCXYPyeR+NYOwotn2XDUHmuLCWVX
E2iIpBBsrvg=
=TuCC
-----END PGP SIGNATURE-----
--=-=-=--
