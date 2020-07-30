Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B233C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261B620838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lcmdvNQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgG3QVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:21:17 -0400
Received: from crapouillou.net ([89.234.176.41]:53504 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgG3QVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596126074; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLywFInFbZpsDWDDgkVCtHSQx1nOq8RfSg1sbqqGqrc=;
        b=lcmdvNQVbj+DlLOZwcGS+JUlh+v7lQJ4ZPJYFbLEiFzficmHr7lqicyHxRIoYnw1sxvJnG
        8C89/bQKHAB5fus62ESfN6xAf3mB0oYeUC3qHMlnspX5TE5/2d2pwZiX5gSLtoLHdz+B/D
        ayrjUH08OFO7gTXOYbfdHFP1v4cbv7U=
Date:   Thu, 30 Jul 2020 18:21:05 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/3] drm/ingenic: ipu: Only enable clock when needed
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <6RIAEQ.2KRLCE1YRKKB1@crapouillou.net>
In-Reply-To: <20200730152958.GB1474381@ravnborg.org>
References: <20200730144830.10479-1-paul@crapouillou.net>
        <20200730144830.10479-4-paul@crapouillou.net>
        <20200730152958.GB1474381@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 30 juil. 2020 =E0 17:29, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> On Thu, Jul 30, 2020 at 04:48:30PM +0200, Paul Cercueil wrote:
>>  Instead of keeping the IPU clock enabled constantly, enable and=20
>> disable
>>  it on demand, when the IPU plane is used. That way, we won't use any
>>  extra power when the IPU is not used.
>>=20
>>  v2: Explain the reason of this patch
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> And thanks for the quick update!

Pushed to drm-misc-next. Thanks!

Cheers,
-Paul

>=20
> 	Sam
>=20
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-ipu.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-ipu.c
>>  index 7dd2a6ae4994..fc8c6e970ee3 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
>>  @@ -49,6 +49,7 @@ struct ingenic_ipu {
>>   	struct regmap *map;
>>   	struct clk *clk;
>>   	const struct soc_info *soc_info;
>>  +	bool clk_enabled;
>>=20
>>   	unsigned int num_w, num_h, denom_w, denom_h;
>>=20
>>  @@ -288,12 +289,23 @@ static void=20
>> ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
>>   	const struct drm_format_info *finfo;
>>   	u32 ctrl, stride =3D 0, coef_index =3D 0, format =3D 0;
>>   	bool needs_modeset, upscaling_w, upscaling_h;
>>  +	int err;
>>=20
>>   	if (!state || !state->fb)
>>   		return;
>>=20
>>   	finfo =3D drm_format_info(state->fb->format->format);
>>=20
>>  +	if (!ipu->clk_enabled) {
>>  +		err =3D clk_enable(ipu->clk);
>>  +		if (err) {
>>  +			dev_err(ipu->dev, "Unable to enable clock: %d\n", err);
>>  +			return;
>>  +		}
>>  +
>>  +		ipu->clk_enabled =3D true;
>>  +	}
>>  +
>>   	/* Reset all the registers if needed */
>>   	needs_modeset =3D drm_atomic_crtc_needs_modeset(state->crtc->state);
>>   	if (needs_modeset) {
>>  @@ -578,6 +590,11 @@ static void=20
>> ingenic_ipu_plane_atomic_disable(struct drm_plane *plane,
>>   	regmap_clear_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_CHIP_EN);
>>=20
>>   	ingenic_drm_plane_disable(ipu->master, plane);
>>  +
>>  +	if (ipu->clk_enabled) {
>>  +		clk_disable(ipu->clk);
>>  +		ipu->clk_enabled =3D false;
>>  +	}
>>   }
>>=20
>>   static const struct drm_plane_helper_funcs=20
>> ingenic_ipu_plane_helper_funcs =3D {
>>  @@ -761,9 +778,9 @@ static int ingenic_ipu_bind(struct device *dev,=20
>> struct device *master, void *d)
>>   	drm_object_attach_property(&plane->base, ipu->sharpness_prop,
>>   				   ipu->sharpness);
>>=20
>>  -	err =3D clk_prepare_enable(ipu->clk);
>>  +	err =3D clk_prepare(ipu->clk);
>>   	if (err) {
>>  -		dev_err(dev, "Unable to enable clock\n");
>>  +		dev_err(dev, "Unable to prepare clock\n");
>>   		return err;
>>   	}
>>=20
>>  @@ -775,7 +792,7 @@ static void ingenic_ipu_unbind(struct device=20
>> *dev,
>>   {
>>   	struct ingenic_ipu *ipu =3D dev_get_drvdata(dev);
>>=20
>>  -	clk_disable_unprepare(ipu->clk);
>>  +	clk_unprepare(ipu->clk);
>>   }
>>=20
>>   static const struct component_ops ingenic_ipu_ops =3D {
>>  --
>>  2.27.0


