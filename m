Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578B020829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbgGaHsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:48:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgGaHsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:48:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91AA9ADF2;
        Fri, 31 Jul 2020 07:48:16 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon 2/2] drm/hisilicon: Code refactoring for
 hibmc_drv_de
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1596157532-50049-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ae28fdc6-c409-1710-3e84-5dcbb5a6478f@suse.de>
Date:   Fri, 31 Jul 2020 09:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596157532-50049-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OuWaq4yCIfTfMSXOb4GdF37N26epaaMs7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OuWaq4yCIfTfMSXOb4GdF37N26epaaMs7
Content-Type: multipart/mixed; boundary="C35tXy3tnkvc3WT1Acjk7q65xQMnh4dun";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <ae28fdc6-c409-1710-3e84-5dcbb5a6478f@suse.de>
Subject: Re: [PATCH drm/hisilicon 2/2] drm/hisilicon: Code refactoring for
 hibmc_drv_de
References: <1596157532-50049-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1596157532-50049-1-git-send-email-tiantao6@hisilicon.com>

--C35tXy3tnkvc3WT1Acjk7q65xQMnh4dun
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 31.07.20 um 03:05 schrieb Tian Tao:
> code refactoring for hibmc_drv_de.c, no actual function changes.

No, there's tons of functional changes. The memory used to be allocated
with devres helpers and released automatically. In rare circumstances,
the memory's release could have happened before the DRM device got
released, which would have caused memory corruption of some kind.

Now you're embedding the data structures in struct hibmc_drm_private,
which is good. The whole release problem has been resolved, because
struct hibmc_drm_private is allocated with drmm_kzalloc and always
released with the DRM device. You're commit message should mention all th=
is.

>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 55 ++++++-----------=
--------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  2 +
>  2 files changed, 15 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/g=
pu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 66132eb..af24c72 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -157,37 +157,6 @@ static const struct drm_plane_helper_funcs hibmc_p=
lane_helper_funcs =3D {
>  	.atomic_update =3D hibmc_plane_atomic_update,
>  };
> =20
> -static struct drm_plane *hibmc_plane_init(struct hibmc_drm_private *pr=
iv)
> -{
> -	struct drm_device *dev =3D priv->dev;
> -	struct drm_plane *plane;
> -	int ret =3D 0;
> -
> -	plane =3D devm_kzalloc(dev->dev, sizeof(*plane), GFP_KERNEL);
> -	if (!plane) {
> -		DRM_ERROR("failed to alloc memory when init plane\n");
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	/*
> -	 * plane init
> -	 * TODO: Now only support primary plane, overlay planes
> -	 * need to do.
> -	 */
> -	ret =3D drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
> -				       channel_formats1,
> -				       ARRAY_SIZE(channel_formats1),
> -				       NULL,
> -				       DRM_PLANE_TYPE_PRIMARY,
> -				       NULL);
> -	if (ret) {
> -		DRM_ERROR("failed to init plane: %d\n", ret);
> -		return ERR_PTR(ret);
> -	}
> -
> -	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
> -	return plane;
> -}
> -
>  static void hibmc_crtc_dpms(struct drm_crtc *crtc, int dpms)
>  {
>  	struct hibmc_drm_private *priv =3D crtc->dev->dev_private;
> @@ -534,22 +503,24 @@ static const struct drm_crtc_helper_funcs hibmc_c=
rtc_helper_funcs =3D {
>  int hibmc_de_init(struct hibmc_drm_private *priv)
>  {
>  	struct drm_device *dev =3D priv->dev;
> -	struct drm_crtc *crtc;
> -	struct drm_plane *plane;
> +	struct drm_crtc *crtc =3D &priv->crtc;
> +	struct drm_plane *plane =3D &priv->plane;
>  	int ret;
> =20
> -	plane =3D hibmc_plane_init(priv);
> -	if (IS_ERR(plane)) {
> -		DRM_ERROR("failed to create plane: %ld\n", PTR_ERR(plane));
> -		return PTR_ERR(plane);
> -	}
> +	ret =3D drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
> +				       channel_formats1,
> +				       ARRAY_SIZE(channel_formats1),
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY,
> +				       NULL);
> =20
> -	crtc =3D devm_kzalloc(dev->dev, sizeof(*crtc), GFP_KERNEL);
> -	if (!crtc) {
> -		DRM_ERROR("failed to alloc memory when init crtc\n");
> -		return -ENOMEM;
> +	if (ret) {
> +		DRM_ERROR("failed to init plane: %d\n", ret);
> +		return ret;
>  	}
> =20
> +	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
> +
>  	ret =3D drm_crtc_init_with_planes(dev, crtc, plane,
>  					NULL, &hibmc_crtc_funcs, NULL);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index a683763..91ef15c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -28,6 +28,8 @@ struct hibmc_drm_private {
> =20
>  	/* drm */
>  	struct drm_device  *dev;
> +	struct drm_plane plane;

There was a TODO comment that mentioned overlay planes. I suggest
calling this field primary_plane, so it's clear which plane it represents=
=2E

Best regards
Thomas

> +	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
>  	struct drm_connector connector;
>  	bool mode_config_initialized;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--C35tXy3tnkvc3WT1Acjk7q65xQMnh4dun--

--OuWaq4yCIfTfMSXOb4GdF37N26epaaMs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8jzK8UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiN3Ygf+M1+j2BcTkur8DFIvImXpIJvQmZ7P
LvWIbfKEwuhDG4lv2NATKBE/pIoCyDgbO12vJvud1WrkImKLxZFY9QKVqWOM5bsi
OEHppRpH30F7fGGc5G1PLUK+S1ch9OmAblhxLOiLGiiWeFCnBCcWkKohGnC/vhkt
jruTbWSUBp0OEYzJBPWJLacz84kjzTVVogpzrBD8vhw9s4dqn/IsIEkAtClgpQXS
xjyoZjLSxo3H9lgdwGk7UOSBTccQgOg17d+zqjq5CTt4DmwtqjegTWlhAEr+89fm
0fTcZXZVqt6sNRlcfFmlmh1fc5aEytWHcxIeRdL7LPuff/Icg7NtBYAj0w==
=vmWJ
-----END PGP SIGNATURE-----

--OuWaq4yCIfTfMSXOb4GdF37N26epaaMs7--
