Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70544C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F57520774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Q/LSsYXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbgF3LzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:55:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57292 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgF3LzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593518102; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLivQZbuAtImOA556A9/GwUMm1HUXka6DPlyQAzwKuo=;
        b=Q/LSsYXZWBuyh3RUShBSmnkCNm3OyljvBxuq7YsUziu9aEZs299XhTkBGr9tr0Vk/6OK0l
        0ehGwufTYFqKBASWXDhdCexfbuQqnfAcYbmJZLcPrEdMC6yBgFauZJXyceTNFvTKj/2stY
        u8pTDrig8VjQB57LdZpNC3n9/a9sxxo=
Date:   Tue, 30 Jun 2020 13:54:51 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 06/10] drm/ingenic: Set DMA descriptor chain address in
 probe
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
Message-Id: <FFMQCQ.LQ37IHUC6U3Z@crapouillou.net>
In-Reply-To: <20200630114453.GB560155@ravnborg.org>
References: <20200629235210.441709-1-paul@crapouillou.net>
        <20200629235210.441709-6-paul@crapouillou.net>
        <20200630114453.GB560155@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le mar. 30 juin 2020 =E0 13:44, Sam Ravnborg <sam@ravnborg.org> a =E9crit=20
:
> Hi Paul.
>=20
> On Tue, Jun 30, 2020 at 01:52:06AM +0200, Paul Cercueil wrote:
>>  The address of the DMA descriptor never changes. It can therefore=20
>> be set
>>  in the probe function.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: No change
>>=20
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index 924c8daf071a..f7b0c5dc8cd8 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -358,8 +358,6 @@ static void=20
>> ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>>   		ingenic_drm_crtc_update_ctrl(priv, finfo);
>>=20
>>   		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
>>  -
>>  -		regmap_write(priv->map, JZ_REG_LCD_DA0, priv->dma_hwdesc->next);
>>   	}
>>=20
>>   	if (event) {
>>  @@ -757,6 +755,9 @@ static int ingenic_drm_probe(struct=20
>> platform_device *pdev)
>>   		}
>>   	}
>>=20
>>  +	/* Set address of our DMA descriptor chain */
>>  +	regmap_write(priv->map, JZ_REG_LCD_DA0, priv->dma_hwdesc_phys);
>>  +
>=20
>=20
> What is the purpose of this code after the assignment was moved:
>=20
> static int ingenic_drm_probe(struct platform_device *pdev)
> {
> ...
> 	priv->dma_hwdesc->next =3D priv->dma_hwdesc_phys;
>=20
> I do not see ->next used anymore.
> Could this assignment be dropped?
>=20
>=20
> And the following line:
> 	priv->dma_hwdesc->id =3D 0xdeafbead;
>=20
> I can only see ->id be assingned, it is never referenced??
>=20
> Maybe this is all related to the structure assumed by the data pointed
> to by JZ_REG_LCD_DA0?

As its name suggests, 'dma_hwdesc' points to a DMA hardware descriptor.=20
Setting ->next sets the address of the next descriptor (which is itself=20
since we only use one descriptor). The 'id' field will be copied by the=20
hardware to a register when the DMA descriptor is loaded, so we can=20
know from userspace (debugfs) what DMA descriptors are loaded by=20
looking up the IDs.

-Paul

> 	Sam
>=20
>>   	ret =3D drm_dev_register(drm, 0);
>>   	if (ret) {
>>   		dev_err(dev, "Failed to register DRM driver\n");
>>  --
>>  2.27.0
>>=20
>>  _______________________________________________
>>  dri-devel mailing list
>>  dri-devel@lists.freedesktop.org
>>  https://lists.freedesktop.org/mailman/listinfo/dri-devel


