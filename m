Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E36CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB221D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgIHTL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:11:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56400 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgIHTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:11:29 -0400
Received: from kevin (unknown [IPv6:2607:fea8:55f:a950::68f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD43F295E47;
        Tue,  8 Sep 2020 20:11:26 +0100 (BST)
Date:   Tue, 8 Sep 2020 15:11:19 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 5/5] drm/panfrost: add Amlogic GPU integration quirks
Message-ID: <20200908191119.GC10568@kevin>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-6-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20200908151853.4837-6-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> This adds the required GPU quirks, including the quirk in the PWR registe=
rs at the GPU
> reset time and the IOMMU quirk for shareability issues observed on G52 in=
 Amlogic G12B SoCs.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 36463c89e966..efde5e2acc35 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -656,7 +656,25 @@ static const struct panfrost_compatible default_data=
 =3D {
>  	.pm_domain_names =3D NULL,
>  };
> =20
> +static const struct panfrost_compatible amlogic_gxm_data =3D {
> +	.num_supplies =3D ARRAY_SIZE(default_supplies),
> +	.supply_names =3D default_supplies,
> +	.vendor_reset_quirk =3D panfrost_gpu_amlogic_reset_quirk,
> +};
> +
> +static const struct panfrost_compatible amlogic_g12a_data =3D {
> +	.num_supplies =3D ARRAY_SIZE(default_supplies),
> +	.supply_names =3D default_supplies,
> +	.vendor_reset_quirk =3D panfrost_gpu_amlogic_reset_quirk,
> +	.pgtbl_quirks =3D IO_PGTABLE_QUIRK_ARM_BROKEN_SH,
> +};
> +
>  static const struct of_device_id dt_match[] =3D {
> +	/* Set first to probe before the generic compatibles */
> +	{ .compatible =3D "amlogic,meson-gxm-mali",
> +	  .data =3D &amlogic_gxm_data, },
> +	{ .compatible =3D "amlogic,meson-g12a-mali",
> +	  .data =3D &amlogic_g12a_data, },
>  	{ .compatible =3D "arm,mali-t604", .data =3D &default_data, },
>  	{ .compatible =3D "arm,mali-t624", .data =3D &default_data, },
>  	{ .compatible =3D "arm,mali-t628", .data =3D &default_data, },
> --=20
> 2.22.0
>=20

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl9X11YACgkQ/v5QWgr1
WA1SyhAAgVduu4bMRXVDtE5vLGTa6kOSM3YzDXPkd5eadv5cvcsZCPjzItTlpbV0
TdS7/SVgZZyDkGGCI2YzL5j7cNkso6ffe6y6LrUPkttYFfmsib3VuEUxLZG+evUD
rgq3BlmPI/4++/hmzaBRE8lD3TjhcY7cki3cpoz696GxstugGb2XkXuUpnUwS5f0
J4ZHmc5foIP3BtUUo2WVE2J4Ey0ljCM4pBjFtT72h1PMZDiTPo0nnNzZWbmu7ScM
eNQvFReKPVK9WTLYjpDzB1Da5jDB7ULPCLdQ2Dihb/QdPhjN7Ik47H+p82CxZ+2/
tMvJaPDEH8IzwkJTQojv148r+uWuUQV2Lqllkn4WTLvNwdWeIb8r/rr0ygiDqg9y
/poPMKnL+OIyvL4nBQMc+W1BWB4CPPjBYHEfKA95c2bb1djdsAYyF+uVhsbMbTPQ
q3YlWlJLadtYpSiHIVtVE9ISzE8+c9XnfruhZfniTTGHAI5bsagvYTh3ONdhI/I2
W2zNBiF0mqNBxoyAc14KURy0PMCNfgsvFiS/n+E4uB72NDdHhu7S7CbG96tsUQPX
zf2PrPHCarpFSK1mCr9OCdHWeJ1iWR7gNqrMYgZAzXNKtrqrFjle7KHnxIVU09l3
BxpldnOaHPD32usBXkAmlOWlSGv2qs3AEt5kpOCs8AM6LBZOCLk=
=14Ih
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
