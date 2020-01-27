Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE590C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5C524125
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgA0IOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:14:23 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:59729 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:14:23 -0500
Received: from aptenodytes (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D6AE0100016;
        Mon, 27 Jan 2020 08:14:19 +0000 (UTC)
Date:   Mon, 27 Jan 2020 09:14:19 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/sun4i: drv: Allow framebuffer modifiers in
 mode config"
Message-ID: <20200127081419.GA25668@aptenodytes>
References: <20200126065937.9564-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200126065937.9564-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Sun 26 Jan 20, 07:59, Jernej Skrabec wrote:
> This reverts commit 9db9c0cf5895e4ddde2814360cae7bea9282edd2.
>=20
> Setting mode_config.allow_fb_modifiers manually is completely
> unnecessary. It is set automatically by drm_universal_plane_init() based
> on the fact if modifier list is provided or not. Even more, it breaks
> DE2 and DE3 as they don't support any modifiers beside linear. Modifiers
> aware applications can be confused by provided empty modifier list - at
> least linear modifier should be included, but it's not for DE2 and DE3.

Makes sense and it's apparently the norm to not report any modifier blob
when only linear is supported, so let's stick to that.

Note that when the reverted patch was applied, the core didn't set
allow_fb_modifiers on its own yet. But it does now so let's rely on it inst=
ead.

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Fixes: 9db9c0cf5895 ("drm/sun4i: drv: Allow framebuffer modifiers in mode=
 config")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/su=
n4i_drv.c
> index 5ae67d526b1d..328272ff77d8 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -85,7 +85,6 @@ static int sun4i_drv_bind(struct device *dev)
>  	}
> =20
>  	drm_mode_config_init(drm);
> -	drm->mode_config.allow_fb_modifiers =3D true;
> =20
>  	ret =3D component_bind_all(drm->dev, drm);
>  	if (ret) {
> --=20
> 2.25.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl4um9sACgkQ3cLmz3+f
v9GVMgf+Kc3KZDcNNctctpvlPceDVaF7D4PqnI4YqaMprQkDYXgo2FwW/lu16lNQ
NrFx8PXex2bkporLkE2jcJRIA9B1A0Wbfoy86MagAJtCtFCgCaQIXM+Y/7yGSbn6
wfDytjFPdpngw7hZrfh9AljDP6w907SmNvvugVTG6eEKH8xRtYl3NYDFDvms1Fns
2jQTT67palIJs10fIPCfTU0HJd2fN92lqVDiwzx0HReR4nCqVA4BTd6wxn5sieiQ
iI3AIXJawMv0xdUs0idpRfKavaPoRWVxolUPg4Umr1RHJmxV/HS4ERRK+T4KlJmk
EdW2EIlo4bmuFeFhog1Q8X1XURDJ1g==
=lFH+
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
