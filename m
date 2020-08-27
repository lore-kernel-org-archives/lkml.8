Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A380C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8470922CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgH0JVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:21:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0JVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:21:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B7D7B712;
        Thu, 27 Aug 2020 09:22:07 +0000 (UTC)
Subject: Re: [PATCH] drm/mgag200: fix spelling mistake "expeced" -> "expected"
To:     Colin King <colin.king@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200826084727.42703-1-colin.king@canonical.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <63a54e7a-38ce-d32f-f7c0-ca04707ae8de@suse.de>
Date:   Thu, 27 Aug 2020 11:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826084727.42703-1-colin.king@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fPWsxPpPJj3E4g7J17m5zELBoVw8eziG9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fPWsxPpPJj3E4g7J17m5zELBoVw8eziG9
Content-Type: multipart/mixed; boundary="FoGFcXpSXbDSMaDgetwZhxIi6Q8ObDg3w";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Colin King <colin.king@canonical.com>, Dave Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <63a54e7a-38ce-d32f-f7c0-ca04707ae8de@suse.de>
Subject: Re: [PATCH] drm/mgag200: fix spelling mistake "expeced" -> "expected"
References: <20200826084727.42703-1-colin.king@canonical.com>
In-Reply-To: <20200826084727.42703-1-colin.king@canonical.com>

--FoGFcXpSXbDSMaDgetwZhxIi6Q8ObDg3w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.08.20 um 10:47 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a drm_warn message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks! Applied to drm-misc-next.

Best regards
Thomas

> ---
>  drivers/gpu/drm/mgag200/mgag200_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mg=
ag200/mgag200_drv.c
> index b282b0e42c2d..771b26aeee19 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -168,7 +168,7 @@ static void mgag200_g200_interpret_bios(struct mga_=
device *mdev,
>  		return;
>  	}
>  	if (pins_len !=3D expected_length[version]) {
> -		drm_warn(dev, "Unexpected BIOS PInS size: %d expeced: %d\n",
> +		drm_warn(dev, "Unexpected BIOS PInS size: %d expected: %d\n",
>  			 pins_len, expected_length[version]);
>  		return;
>  	}
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--FoGFcXpSXbDSMaDgetwZhxIi6Q8ObDg3w--

--fPWsxPpPJj3E4g7J17m5zELBoVw8eziG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9Hex4UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiOBQAgAiL4kFTimHbHupiRn5WOvA4vbyT6w
lwXW36ZGshiV84ZvnTQ0/IboK15tbYUBcf/AgfkoVDsG4DTyI40z5W/e/ULzM7EA
ePIjzJb0dPPyAEzo2GIL6Xxp8zfAwP3U6OXrlYYPlVLaIh53qYVD9+oTHgRln2LZ
e/hVlpck4I4ZknAWnvSEi3h2dfWSdgUe7BwfJkr6aha0REAO0sZ5KQ7WMQL4a3Xs
dGti4fST0KPjaNVsj01ism/v0Vso3J7Hn8bNrc0UqHOS/Vy1gwJw1hLr3KU9Tras
S9MFDhVG7t6EzdjtJ86dBQ6Us+b8XGbiUUGO0ivrbbfsi6pg7y3eNp4SaA==
=jjLa
-----END PGP SIGNATURE-----

--fPWsxPpPJj3E4g7J17m5zELBoVw8eziG9--
