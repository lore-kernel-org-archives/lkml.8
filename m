Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18835C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000012072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgD2NOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:14:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38659 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgD2NOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:14:08 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id F36E26000C;
        Wed, 29 Apr 2020 13:13:59 +0000 (UTC)
Date:   Wed, 29 Apr 2020 15:13:59 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sun6i: dsi: fix gcc-4.8
Message-ID: <20200429131359.GJ610776@aptenodytes>
References: <20200428215105.3928459-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <20200428215105.3928459-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 28 Apr 20, 23:50, Arnd Bergmann wrote:
> Older compilers warn about initializers with incorrect curly
> braces:
>=20
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: In function 'sun6i_dsi_encoder_en=
able':
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:720:8: error: missing braces aroun=
d initializer [-Werror=3Dmissing-braces]
>   union phy_configure_opts opts =3D { 0 };
>         ^
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:720:8: error: (near initialization=
 for 'opts.mipi_dphy') [-Werror=3Dmissing-braces]
>=20
> Use the GNU empty initializer extension to avoid this.

Looks good to me:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

But maybe use the drm/sun4i: dsi: prefix instead (granted, it wasn't used in
the commit being fixed).

Cheers,

Paul

> Fixes: bb3b6fcb6849 ("sun6i: dsi: Convert to generic phy handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index f6c67dd87a05..aa67cb037e9d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -718,7 +718,7 @@ static void sun6i_dsi_encoder_enable(struct drm_encod=
er *encoder)
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct sun6i_dsi *dsi =3D encoder_to_sun6i_dsi(encoder);
>  	struct mipi_dsi_device *device =3D dsi->device;
> -	union phy_configure_opts opts =3D { 0 };
> +	union phy_configure_opts opts =3D { };
>  	struct phy_configure_opts_mipi_dphy *cfg =3D &opts.mipi_dphy;
>  	u16 delay;
>  	int err;
> --=20
> 2.26.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl6pfZcACgkQ3cLmz3+f
v9EZuwf/c+11FwGVP8LmF3ZNopR32d3cDoA0mLr1vizGfseJVldesiJUy/VuZI7I
ppIjTfjte/iBHuyGcv8oAc0GQfkJaCvLFlcSkDUGgH5UfPEqxCTGvPLvV0doT77g
MAUZw1EnVM2zHZ9IvjLmmes2/nvRMs/knC4qf8H8VW2LcFbDqUt+P9SioDHMEOzz
ZpKNqa7C6Ll/KK7RljKfhk/i1bzakwyEw5Mv31bMBjJ5QeiP+OnLBDBD6ltBfjM7
f4ODxc85UpxYB9uoRfgQoE2Dk2aN2h2OMTGt7USnEA3HesH1oxRpP7xWpefwHGfY
oHhO7JHJ8TOwoWS/iIN+wsbHxbDpWw==
=QQXf
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
