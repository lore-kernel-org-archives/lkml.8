Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A28EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14EA322B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FSWu/Chr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgH0NSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:18:25 -0400
Received: from crapouillou.net ([89.234.176.41]:37006 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgH0NMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598533920; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mq/0F8UbeXY3Pqih2k8p1w6/ERNeaq1vUKEH8bis0Sc=;
        b=FSWu/ChrO6m3aqF4WvOluzzLTotjPD5+xJiLy1DDHnA09hWuOS5dVkh66xV9kJMZeSDI+U
        idrPUynBOLcgq0XA+R5pgDVxeUQGLG60K9ITh9B64onMPNYytRUchw+RW8XPSSiQcOTnvo
        gMXosxaVspVpJtfHDWebqzuQ5ql4c/8=
Date:   Thu, 27 Aug 2020 15:11:49 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written to
 HW register
To:     Felipe Balbi <balbi@kernel.org>
Cc:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?UTF-8?b?5ZGo5q2j?= <sernia.zhou@foxmail.com>,
        =?UTF-8?b?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>, od@zcrc.me,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net>
In-Reply-To: <87v9h4i6t5.fsf@kernel.org>
References: <20200827124308.71963-1-paul@crapouillou.net>
        <20200827124308.71963-2-paul@crapouillou.net> <87v9h4i6t5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Le jeu. 27 ao=FBt 2020 =E0 15:58, Felipe Balbi <balbi@kernel.org> a=20
=E9crit :
>=20
> Hi,
>=20
> Paul Cercueil <paul@crapouillou.net> writes:
>>  The 'reg' value was written to a hardware register in
>>  ingenic_usb_phy_init(), while not being initialized anywhere.
>=20
> your patch does a lot more than fix the bug :-)
>=20
>>  Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new Ingenic=20
>> SoCs.")
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/usb/phy/phy-jz4770.c | 28 +++++++++++-----------------
>>   1 file changed, 11 insertions(+), 17 deletions(-)
>>=20
>>  diff --git a/drivers/usb/phy/phy-jz4770.c=20
>> b/drivers/usb/phy/phy-jz4770.c
>>  index d4ee3cb721ea..58771a8688f2 100644
>>  --- a/drivers/usb/phy/phy-jz4770.c
>>  +++ b/drivers/usb/phy/phy-jz4770.c
>>  @@ -97,7 +97,7 @@ enum ingenic_usb_phy_version {
>>   struct ingenic_soc_info {
>>   	enum ingenic_usb_phy_version version;
>>=20
>>  -	void (*usb_phy_init)(struct usb_phy *phy);
>>  +	u32 (*usb_phy_init)(struct usb_phy *phy);
>=20
> this is not fixing any bug
>=20
>>  @@ -172,7 +172,8 @@ static int ingenic_usb_phy_init(struct usb_phy=20
>> *phy)
>>   		return err;
>>   	}
>>=20
>>  -	priv->soc_info->usb_phy_init(phy);
>>  +	reg =3D priv->soc_info->usb_phy_init(phy);
>>  +	writel(reg, priv->base + REG_USBPCR_OFFSET);
>=20
> not fixing any bug.
>=20
> Looking at the code, the bug follows after this line. It would suffice
> to read REG_USBPCR_OFFSET in order to initialize reg. This bug fix=20
> could
> have been a one liner.

There's no need to re-read a register when you have the value readily=20
available. It just needs to be returned from the usb_phy_init=20
callbacks. But yes, it's not a one-liner.

>=20
>>  @@ -195,19 +196,15 @@ static void ingenic_usb_phy_remove(void *phy)
>>   	usb_remove_phy(phy);
>>   }
>>=20
>>  -static void jz4770_usb_phy_init(struct usb_phy *phy)
>>  +static u32 jz4770_usb_phy_init(struct usb_phy *phy)
>=20
> not a bug fix
>=20
>>   {
>>  -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>  -	u32 reg;
>>  -
>>  -	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS=20
>> |
>>  +	return USBPCR_AVLD_REG | USBPCR_COMMONONN |=20
>> USBPCR_IDPULLUP_ALWAYS |
>>   		USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT |=20
>> USBPCR_SQRXTUNE_DFT |
>>   		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT |=20
>> USBPCR_TXVREFTUNE_DFT |
>>   		USBPCR_POR;
>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>=20
> not a bug fix
>=20
>>   }
>>=20
>>  -static void jz4780_usb_phy_init(struct usb_phy *phy)
>>  +static u32 jz4780_usb_phy_init(struct usb_phy *phy)
>=20
> not a bug fix
>=20
>>  @@ -216,11 +213,10 @@ static void jz4780_usb_phy_init(struct=20
>> usb_phy *phy)
>>   		USBPCR1_WORD_IF_16BIT;
>>   	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>=20
>>  -	reg =3D USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>  +	return USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>=20
> not a bug fix
>=20
>>   }
>>=20
>>  -static void x1000_usb_phy_init(struct usb_phy *phy)
>>  +static u32 x1000_usb_phy_init(struct usb_phy *phy)
>=20
> not a bug fix
>=20
>>   {
>>   	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>   	u32 reg;
>>  @@ -228,13 +224,12 @@ static void x1000_usb_phy_init(struct usb_phy=20
>> *phy)
>>   	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
>> USBPCR1_WORD_IF_16BIT;
>>   	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>=20
>>  -	reg =3D USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>  +	return USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>   		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
>>   		USBPCR_COMMONONN | USBPCR_POR;
>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>=20
> not a bug fix
>=20
>>   }
>>=20
>>  -static void x1830_usb_phy_init(struct usb_phy *phy)
>>  +static u32 x1830_usb_phy_init(struct usb_phy *phy)
>=20
> not a bug fix
>=20
>>   {
>>   	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
>>   	u32 reg;
>>  @@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy=20
>> *phy)
>>   		USBPCR1_DMPD | USBPCR1_DPPD;
>>   	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>=20
>>  -	reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT=20
>> |	USBPCR_TXPREEMPHTUNE |
>>  +	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |=20
>> USBPCR_TXPREEMPHTUNE |
>>   		USBPCR_COMMONONN | USBPCR_POR;
>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>=20
> not a bug fix

Well, if you don't like my bug fix, next time wait for my Reviewed-by.

Cheers,
-Paul


