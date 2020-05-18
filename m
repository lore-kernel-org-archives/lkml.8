Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C5DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C909C20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgERL1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:27:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53178 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgERL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589801230; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tvn5nLaWGrzfShxUOvOGAY+B3v9oKV0REWchgAjg+ps=;
        b=qIFV6CKF52U3yd4k3ke3sIOnyAJmRhauaGV3FzX3WGiZNmRDhflWKDE0YQRdC5VuFgGyyE
        31fwL2ACyG91ZYgJ+yMID+k6fILOmdHEnYO+ZsoSFU9aI1lwZyt6tpLWMuEwvj6yTy5NUt
        aFjUKd/YRQCXMKn4IrMIFDDnuBl89vE=
Date:   Mon, 18 May 2020 13:26:58 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 11/12] gpu/drm: Ingenic: Add support for the IPU
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Message-Id: <YGYIAQ.7N9YGTBML0143@crapouillou.net>
In-Reply-To: <CACvgo50q=qJXk3nFSCm+S6JHBMxpY0C_HwH8KGB2EAcKwgL0oQ@mail.gmail.com>
References: <20200516215057.392609-1-paul@crapouillou.net>
        <20200516215057.392609-11-paul@crapouillou.net>
        <CACvgo50q=qJXk3nFSCm+S6JHBMxpY0C_HwH8KGB2EAcKwgL0oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

Le lun. 18 mai 2020 =E0 11:48, Emil Velikov <emil.l.velikov@gmail.com> a=20
=E9crit :
> Hi Paul,
>=20
> Disclaimer: I don't know much about the hardware :-P
>=20
> On Sun, 17 May 2020 at 00:31, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Add support for the Image Processing Unit (IPU) found in all Ingenic
>>  SoCs.
>>=20
> Since the IPU is present on all devices supported, does it make sense
> to have it as separate module?
> Didn't check closely although I suspect doing that will remove the
> need for the component patch.

It makes sense to me; you may not want to enable the IPU on platforms=20
where it doesn't add much, e.g. on the JZ4725B where it only handles=20
YUV and not RGB.

Besides, while the older JZ4740 SoC has a IPU, it's mem-to-mem and=20
cannot output directly to the CRTC, so it cannot be represented as a=20
plane. On this SoC the current IPU code cannot be used. So the Ingenic=20
DRM driver must still be able to probe with zero components.

>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  @@ -50,7 +50,7 @@ struct jz_soc_info {
>>=20
>>   struct ingenic_drm {
>>          struct drm_device drm;
>>  -       struct drm_plane f0, f1;
>>  +       struct drm_plane f0, f1, *ipu_plane;
>>          struct drm_crtc crtc;
>>          struct drm_encoder encoder;
>>=20
>>  @@ -186,13 +186,16 @@ static void=20
>> ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
>>          regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
>>                             JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16,
>>                             JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16);
>>  +
>>  +       regmap_write(priv->map, JZ_REG_LCD_IPUR, JZ_LCD_IPUR_IPUREN=20
>> |
>>  +                    (ht * vpe / 3) << JZ_LCD_IPUR_IPUR_LSB);
>=20
> This hunk also indicates that it may be better to merge the IPU within
> the existing driver.

This writes the IPUR register of the CRTC, nothing wrong here.

-Paul


