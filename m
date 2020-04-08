Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8FAC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74920753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ELHwDl0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDHJwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:52:01 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56974 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586339518; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQzclyuBGPes56NpSwBGhrVH6MMCe3VetYkAXSQBNG8=;
        b=ELHwDl0kyArSfk3beIp7b3ZqYSeJ0IgOiRbei11KJTTFvQZwRQZn9Jm/8uRpOHL23Yuqyq
        Lb+YgbnyUqesw2fqyk2k03PKdMWdSMysRF3rZUQE/FK/PZs6m5p4dh3rn4UOk5kOeL6MIr
        WDZagi7EtMEU8WC28520+yNcD+dZkyw=
Date:   Wed, 08 Apr 2020 11:51:47 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] gpu/drm: ingenic: Add trick to support 16bpp on
 24-bit panels
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <BERG8Q.6W7J6M63PE2V2@crapouillou.net>
In-Reply-To: <20200226043041.289764-1-paul@crapouillou.net>
References: <20200226043041.289764-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any feedback for this patchset?

Thanks,
-Paul


Le mer. 26 f=E9vr. 2020 =E0 1:30, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> If the panel interface is 24-bit but our primary plane is 16bpp,
> configure as if the panel was 18-bit. This tricks permits the display
> of 16bpp data on a 24-bit panel by wiring each color component to the
> MSBs of the 24-bit interface.
>=20
> v2: Check bytes-per-pixel count instead of fourcc format
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c=20
> b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 6d47ef7b148c..5493a80d7d2f 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -400,6 +400,8 @@ static void=20
> ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
>  	struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
>  	struct drm_connector *conn =3D conn_state->connector;
>  	struct drm_display_info *info =3D &conn->display_info;
> +	struct drm_plane_state *plane_state =3D=20
> crtc_state->crtc->primary->state;
> +	const struct drm_format_info *finfo =3D NULL;
>  	unsigned int cfg;
>=20
>  	priv->panel_is_sharp =3D info->bus_flags & DRM_BUS_FLAG_SHARP_SIGNALS;
> @@ -435,7 +437,21 @@ static void=20
> ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
>  				cfg |=3D JZ_LCD_CFG_MODE_GENERIC_18BIT;
>  				break;
>  			case MEDIA_BUS_FMT_RGB888_1X24:
> -				cfg |=3D JZ_LCD_CFG_MODE_GENERIC_24BIT;
> +				if (plane_state && plane_state->fb)
> +					finfo =3D plane_state->fb->format;
> +
> +				/*
> +				 * If the panel interface is 24-bit but our
> +				 * primary plane is 16bpp, configure as if the
> +				 * panel was 18-bit. This tricks permits the
> +				 * display of 16bpp data on a 24-bit panel by
> +				 * wiring each color component to the MSBs of
> +				 * the 24-bit interface.
> +				 */
> +				if (finfo && finfo->cpp[0] < 3)
> +					cfg |=3D JZ_LCD_CFG_MODE_GENERIC_18BIT;
> +				else
> +					cfg |=3D JZ_LCD_CFG_MODE_GENERIC_24BIT;
>  				break;
>  			case MEDIA_BUS_FMT_RGB888_3X8:
>  				cfg |=3D JZ_LCD_CFG_MODE_8BIT_SERIAL;
> --
> 2.25.0
>=20


