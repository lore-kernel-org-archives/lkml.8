Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB63FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46D32054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OcCw9HFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgH0OtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:00 -0400
Received: from crapouillou.net ([89.234.176.41]:45044 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgH0N6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598536659; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXO+rgQw15X1NqYEkxv8ngSYDPbmqHU2BHsKBTowoN4=;
        b=OcCw9HFpgmahQzfbw51wNLZGHul+MmTLwQtu3+zzRCklkZ2RHsqJsEBY+ZOoSR2nGctrxA
        +xXRh1Ce98O9xsa24PJVNrm7qM0Sm0S6L5VjAQGteHxVhROylf9apICMH5pd3+yBFEDju0
        gBq00ke4lZGXH9fw0sQYrVCGcqtrWT0=
Date:   Thu, 27 Aug 2020 15:50:41 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written to
 HW register
To:     Felipe Balbi <balbi@kernel.org>
Cc:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?UTF-8?b?5ZGo5q2j?= <sernia.zhou@foxmail.com>,
        =?UTF-8?b?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>, od@zcrc.me,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <HG6QFQ.KLMIR92DB2D02@crapouillou.net>
In-Reply-To: <87bliwi5kx.fsf@kernel.org>
References: <20200827124308.71963-1-paul@crapouillou.net>
        <20200827124308.71963-2-paul@crapouillou.net> <87v9h4i6t5.fsf@kernel.org>
        <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net> <87bliwi5kx.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 27 ao=FBt 2020 =E0 16:25, Felipe Balbi <balbi@kernel.org> a=20
=E9crit :
>=20
> Hi,
>=20
> Paul Cercueil <paul@crapouillou.net> writes:
>>>>   @@ -172,7 +172,8 @@ static int ingenic_usb_phy_init(struct=20
>>>> usb_phy
>>>>  *phy)
>>>>    		return err;
>>>>    	}
>>>>=20
>>>>   -	priv->soc_info->usb_phy_init(phy);
>>>>   +	reg =3D priv->soc_info->usb_phy_init(phy);
>>>>   +	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>=20
>>>  not fixing any bug.
>>>=20
>>>  Looking at the code, the bug follows after this line. It would=20
>>> suffice
>>>  to read REG_USBPCR_OFFSET in order to initialize reg. This bug fix
>>>  could
>>>  have been a one liner.
>>=20
>>  There's no need to re-read a register when you have the value=20
>> readily
>>  available. It just needs to be returned from the usb_phy_init
>>  callbacks. But yes, it's not a one-liner.
>=20
> there's a difference between making a bug fix and reworking the=20
> behavior
> of the driver ;-)

The one-liner is actually what changes the behavior of the driver,=20
since previously the code did not read back the register.

In this case I guess it's fine, because the register does not have=20
volatile bits.

>>>>   @@ -195,19 +196,15 @@ static void ingenic_usb_phy_remove(void=20
>>>> *phy)
>>>>    	usb_remove_phy(phy);
>>>>    }
>>>>=20
>>>>   -static void jz4770_usb_phy_init(struct usb_phy *phy)
>>>>   +static u32 jz4770_usb_phy_init(struct usb_phy *phy)
>>>=20
>>>  not a bug fix
>>>=20
>>>>    {
>>>>   -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>>>   -	u32 reg;
>>>>   -
>>>>   -	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN |=20
>>>> USBPCR_IDPULLUP_ALWAYS
>>>>  |
>>>>   +	return USBPCR_AVLD_REG | USBPCR_COMMONONN |
>>>>  USBPCR_IDPULLUP_ALWAYS |
>>>>    		USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT |
>>>>  USBPCR_SQRXTUNE_DFT |
>>>>    		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT |
>>>>  USBPCR_TXVREFTUNE_DFT |
>>>>    		USBPCR_POR;
>>>>   -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>=20
>>>  not a bug fix
>>>=20
>>>>    }
>>>>=20
>>>>   -static void jz4780_usb_phy_init(struct usb_phy *phy)
>>>>   +static u32 jz4780_usb_phy_init(struct usb_phy *phy)
>>>=20
>>>  not a bug fix
>>>=20
>>>>   @@ -216,11 +213,10 @@ static void jz4780_usb_phy_init(struct
>>>>  usb_phy *phy)
>>>>    		USBPCR1_WORD_IF_16BIT;
>>>>    	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>=20
>>>>   -	reg =3D USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>>>   -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>   +	return USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>>=20
>>>  not a bug fix
>>>=20
>>>>    }
>>>>=20
>>>>   -static void x1000_usb_phy_init(struct usb_phy *phy)
>>>>   +static u32 x1000_usb_phy_init(struct usb_phy *phy)
>>>=20
>>>  not a bug fix
>>>=20
>>>>    {
>>>>    	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>>>    	u32 reg;
>>>>   @@ -228,13 +224,12 @@ static void x1000_usb_phy_init(struct=20
>>>> usb_phy
>>>>  *phy)
>>>>    	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |
>>>>  USBPCR1_WORD_IF_16BIT;
>>>>    	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>=20
>>>>   -	reg =3D USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>>>   +	return USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>>>    		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
>>>>    		USBPCR_COMMONONN | USBPCR_POR;
>>>>   -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>=20
>>>  not a bug fix
>>>=20
>>>>    }
>>>>=20
>>>>   -static void x1830_usb_phy_init(struct usb_phy *phy)
>>>>   +static u32 x1830_usb_phy_init(struct usb_phy *phy)
>>>=20
>>>  not a bug fix
>>>=20
>>>>    {
>>>>    	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>>>    	u32 reg;
>>>>   @@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy
>>>>  *phy)
>>>>    		USBPCR1_DMPD | USBPCR1_DPPD;
>>>>    	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>=20
>>>>   -	reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT
>>>>  |	USBPCR_TXPREEMPHTUNE |
>>>>   +	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |
>>>>  USBPCR_TXPREEMPHTUNE |
>>>>    		USBPCR_COMMONONN | USBPCR_POR;
>>>>   -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>=20
>>>  not a bug fix
>>=20
>>  Well, if you don't like my bug fix, next time wait for my=20
>> Reviewed-by.
>=20
> why so angry? Take a break every once in a while. Besides, someone=20
> else
> already sent the oneliner before you ;-)

I'm just pissed that this patch has not been tested. I don't like=20
sloppy work.

> In any case, why should I wait for your Reviewed-by? Get maintainer
> doesn't list you as the maintainer for it. Do you want to update
> MAINTAINERS by any chance?

Yes, I thought I was (I'm maintainer of all Ingenic drivers), that also=20
explains why I wasn't Cc'd for the oneliner patch you mentioned...

IIRC Zhou has a patch to move the driver to drivers/phy/, I'll add=20
myself as maintainer once it's moved there.

-Paul


