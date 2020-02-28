Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3960C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B9A246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgB1LlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:41:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50510 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgB1LlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:41:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id E2D642969BB
Date:   Fri, 28 Feb 2020 06:41:18 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm: panfrost: Silence warnings during deferred probe
Message-ID: <20200228114118.GA1822@kevin>
References: <CGME20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed@eucas1p2.samsung.com>
 <20200228094026.26983-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20200228094026.26983-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Fri, Feb 28, 2020 at 10:40:26AM +0100, Marek Szyprowski wrote:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - fixed build warning
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 26 +++++++++++++++-------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 238fb6d54df4..2c4ada3041b1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -21,7 +21,9 @@ static int panfrost_reset_init(struct panfrost_device *=
pfdev)
> =20
>  	pfdev->rstc =3D devm_reset_control_array_get(pfdev->dev, false, true);
>  	if (IS_ERR(pfdev->rstc)) {
> -		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
> +		if (PTR_ERR(pfdev->rstc) !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "get reset failed %ld\n",
> +				PTR_ERR(pfdev->rstc));
>  		return PTR_ERR(pfdev->rstc);
>  	}
> =20
> @@ -44,7 +46,9 @@ static int panfrost_clk_init(struct panfrost_device *pf=
dev)
> =20
>  	pfdev->clock =3D devm_clk_get(pfdev->dev, NULL);
>  	if (IS_ERR(pfdev->clock)) {
> -		dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR(pfdev->clock));
> +		if (PTR_ERR(pfdev->clock) !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "get clock failed %ld\n",
> +				PTR_ERR(pfdev->clock));
>  		return PTR_ERR(pfdev->clock);
>  	}
> =20
> @@ -57,8 +61,9 @@ static int panfrost_clk_init(struct panfrost_device *pf=
dev)
> =20
>  	pfdev->bus_clock =3D devm_clk_get_optional(pfdev->dev, "bus");
>  	if (IS_ERR(pfdev->bus_clock)) {
> -		dev_err(pfdev->dev, "get bus_clock failed %ld\n",
> -			PTR_ERR(pfdev->bus_clock));
> +		if (PTR_ERR(pfdev->bus_clock) !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "get bus_clock failed %ld\n",
> +				PTR_ERR(pfdev->bus_clock));
>  		return PTR_ERR(pfdev->bus_clock);
>  	}
> =20
> @@ -92,7 +97,9 @@ static int panfrost_regulator_init(struct panfrost_devi=
ce *pfdev)
>  	pfdev->regulator =3D devm_regulator_get(pfdev->dev, "mali");
>  	if (IS_ERR(pfdev->regulator)) {
>  		ret =3D PTR_ERR(pfdev->regulator);
> -		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "failed to get regulator: %d\n",
> +				ret);
>  		return ret;
>  	}
> =20
> @@ -124,19 +131,22 @@ int panfrost_device_init(struct panfrost_device *pf=
dev)
> =20
>  	err =3D panfrost_clk_init(pfdev);
>  	if (err) {
> -		dev_err(pfdev->dev, "clk init failed %d\n", err);
> +		if (err !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "clk init failed %d\n", err);
>  		return err;
>  	}
> =20
>  	err =3D panfrost_regulator_init(pfdev);
>  	if (err) {
> -		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> +		if (err !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "regulator init failed %d\n", err);
>  		goto err_out0;
>  	}
> =20
>  	err =3D panfrost_reset_init(pfdev);
>  	if (err) {
> -		dev_err(pfdev->dev, "reset init failed %d\n", err);
> +		if (err !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "reset init failed %d\n", err);
>  		goto err_out1;
>  	}
> =20
> --=20
> 2.17.1
>=20

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl5Y/FgACgkQ/v5QWgr1
WA3hPA/8D8FD7YP04EmoAQJS3nr1VRTZ6AYjtocsQTMh/CKOy11fb1XKbch8Jhci
tlTF3Zd4/LA7UBS1Ki5eIXe7fpEbqsWMLcqQcl9h53e4EKuReg06NjM5f8uU9N79
T9DD2KaYytCq4WxXymItoFSbVQn9w3z6jDXal3zGrDlALmgOYfASe+Er4SNr23gO
J0ULpqCXk2kbU3Pbs1qfl0I2JnzGKBtLztv03Ijls8Oj/7DTwsGYqTnOack0giqb
wnqoc/hCO0zBKxXQnqfJmyGWvgFzU1ivwW9KkvE/b/MmNyBAheyHNr/bQ6jnbHt5
8A9WMh/VBCfhJklybWAL4vu6MQGKd5GEO8bZCusagO9w01LLyLC7D3b3YDsRLLW5
HNXZEWvtXcoN29YuFSVkZCXlNdkX7ruANcfZxTzV01NpJNuFRT2uHk1lal20UX51
FRDbC3FPpPp9riEMBRE3+6FinWZounaf4rKXlWuSCg+JmXlbNM6XxzNS36vkDQV1
o9roxzN0mk01r6ih8l+yu05DwrzMpT1v7jdeNC1GtKRMQWJbS3jrmxpLXWbauEY0
dYGfvwTEgohh0KCAk/s/I1LrYEGyBx9aEJHr+1DMLRLpfuEwO5FMhcF5UHzZvyBm
3pao5k3Ku6wPR7Z8XXxGMLCOYgGcU9m7+rITccw+uecgMpjJgN8=
=vJWj
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
