Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E42C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685642083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgFKOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFKOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:11:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:11:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 3800A2A4ACF
Date:   Thu, 11 Jun 2020 10:11:27 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] panfrost: Make sure GPU is powered on when reading
 GPU_LATEST_FLUSH_ID
Message-ID: <20200611141127.GA1834@kevin>
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both patches are Reviewed-by: Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com>

On Thu, Jun 11, 2020 at 10:58:43AM +0200, Tomeu Vizoso wrote:
> Bifrost devices do support the flush reduction feature, so on first job
> submit we were trying to read the register while still powered off.
>=20
> If the GPU is powered off, the feature doesn't bring any benefit, so
> don't try to read.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gpu.c
> index f2c1ddc41a9b..e0f190e43813 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
> @@ -368,7 +369,16 @@ void panfrost_gpu_fini(struct panfrost_device *pfdev)
> =20
>  u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev)
>  {
> -	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION))
> -		return gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
> +	u32 flush_id;
> +
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION)) {
> +		/* Flush reduction only makes sense when the GPU is kept powered on be=
tween jobs */
> +		if (pm_runtime_get_if_in_use(pfdev->dev)) {
> +			flush_id =3D gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
> +			pm_runtime_put(pfdev->dev);
> +			return flush_id;
> +		}
> +	}
> +
>  	return 0;
>  }
> --=20
> 2.21.0
>=20

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl7iO4YACgkQ/v5QWgr1
WA0tPBAArzmVDiuBFirXaT97r1Ge78bboVEyZU99PhlWzzQsuA9Cxn5THkpl1Od+
BYGXVCycozrZNwEvHnTzI6NruL1ZgLK9NrIT/afZSK4dzg6lLiZplyi7dCul/YAU
J/UWU5/g4ae8aPWMXz2v1wiwcpA0N2PS/5WQxKwm6f45B7aBudchG7Ofdhpg8LrW
EFP7ScKMWYmnGYzfwUZ2uXawnHpBrNoXS1ZQ21EfA22V4LOJvmH7zzh2o/ldhq5P
3FHu8MdNyiNgrSyU07Fe+zJ3jt5MkGI4EiR36r90vvBlv3C75ov7wtPcPgyEsURI
b51D5+osyt1Q9GmHYrpxFo73H/qPYqxCnZW1cVSrd74h2VKdv/QzSeALg2VHfQNW
W9d1U3SjD+BKzwgCvNCEppken3nG5nsHPc39CXwoetZ5hOrzy0iQMCJ2rzjxLC3d
TCIzOU6MbHvUVNYqeBqe+bkftoN98Gf9+JUnKyZJSbolkbaUF0vZyI3xoP5ga+wm
PMyx89WjZauM0VQP6rUbkDmzhzQihvWYId276r37CTYrKY/jLo52b5RChWDUnIJb
dfMZ6BF7fDoUPszOSEeaqkYmf8HtyLYl95h7FMLD56ewdMDUAKSujXyXq9D3+wYc
1JSQEGBHIPhMw783zOmGWp+nVozQ/O2+9R28NJLYbDdQClQ4Gcc=
=K7V+
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
