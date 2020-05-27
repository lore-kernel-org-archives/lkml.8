Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF996C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E842084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgE0Unm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:43:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46260 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgE0Unm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:43:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 299B22A3C1D
Date:   Wed, 27 May 2020 16:43:34 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/panfrost: Reduce the amount of logs on deferred
 probe
Message-ID: <20200527204334.GA15485@kevin>
References: <20200527200544.7849-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20200527200544.7849-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Wed, May 27, 2020 at 10:05:44PM +0200, Krzysztof Kozlowski wrote:
> There is no point to print deferred probe (and its failures to get
> resources) as an error.  Also there is no need to print regulator errors
> twice.
>=20
> In case of multiple probe tries this would pollute the dmesg.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Steven Price <steven.price@arm.com>
>=20
> ---
>=20
> Changes since v2:
> 1. Rebase
> 2. Add Steven's review
>=20
> Changes since v1:
> 1. Remove second error message from calling panfrost_regulator_init()
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 8136babd3ba9..b172087eee6a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -101,7 +101,9 @@ static int panfrost_regulator_init(struct panfrost_de=
vice *pfdev)
>  				      pfdev->comp->num_supplies,
>  				      pfdev->regulators);
>  	if (ret < 0) {
> -		dev_err(pfdev->dev, "failed to get regulators: %d\n", ret);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "failed to get regulators: %d\n",
> +				ret);
>  		return ret;
>  	}
> =20
> @@ -213,10 +215,8 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	}
> =20
>  	err =3D panfrost_regulator_init(pfdev);
> -	if (err) {
> -		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> +	if (err)
>  		goto err_out0;
> -	}
> =20
>  	err =3D panfrost_reset_init(pfdev);
>  	if (err) {
> --=20
> 2.17.1
>=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl7O0O8ACgkQ/v5QWgr1
WA3p3g/8DCZyn9SS5HpC/u7NXQd7gR9kT/h96A3UERjq1qb+BOg/Cll9aB/GzZ9v
c6ux7qhSOwGhHXRhrcM3ar/9XPZBasjIgMPdsu0To1G00Yl78LtYoM8csLjIQB7k
zGa3QHQj/m1G3/jCBNrBqiDLsBPsAI5wQEHrmDTakp6xW2qFsa8yy54+7rgbHmm0
oBefDrKUqukbBsaoiL/p1R1M3gTeTMinUy1/Ec2MMR7Vn/1ySpzGAQ7tgD04qnB4
uSgLcWGZHNSMKWiAjclsJLOgL1HpSFwXFzlWCe9bwdzoCroldKHC3vkhazzewpG9
q3MhbyDE4AhSl4v8sEieJvvAOpCQ9VtMLk/+a9COMDfQ0gYWnvzgFHcOrVJvyS8P
aQ2URoHkH0KRL6VRBwiSLi9IqUqMmR66GrCIG+69OfR1dMDaFyHCGBhM8yyUWBhh
AmVNnwUyaFJoUGx24o6HqlCY0M/f1PPeLh8o6wO+zfWWL8N4Sdp2D7XMSkYiNK5U
ZPWdFBCfY1KUENlco7k/AB6xMy6bpq7YSQkzwpHN5i7dTBmLi2MBGV7E8sm0QUdh
0UFCt7Qf9qHqP3uhHcZ+PGovkd2/5FA9lNFzVLLd52NYdsRognfHN4MfC/5JESx6
dv1aaqHmOKVck/eiA03/nW0l1Yjz9ScvVDz1p4x0Z47B6l17HrI=
=srst
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
