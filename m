Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85402C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9C20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGNPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:15:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:57756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:15:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 874ABACD0;
        Fri,  7 Feb 2020 13:15:20 +0000 (UTC)
Subject: Re: [PATCH] drm/bochs: add drm_driver.release callback.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>
References: <20200207121312.25296-1-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <e1b86bba-ffc2-3c2e-6e6d-b58074072dcc@suse.de>
Date:   Fri, 7 Feb 2020 14:15:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207121312.25296-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1
Content-Type: multipart/mixed; boundary="roUT122ea9dVbbMdoLRaORWXJWNLO7PGu";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Message-ID: <e1b86bba-ffc2-3c2e-6e6d-b58074072dcc@suse.de>
Subject: Re: [PATCH] drm/bochs: add drm_driver.release callback.
References: <20200207121312.25296-1-kraxel@redhat.com>
In-Reply-To: <20200207121312.25296-1-kraxel@redhat.com>

--roUT122ea9dVbbMdoLRaORWXJWNLO7PGu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 07.02.20 um 13:13 schrieb Gerd Hoffmann:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
>=20
> Move bochs_unload call from bochs_remove() to the new bochs_release()
> callback.  Also call drm_dev_unregister() first in bochs_remove().
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/=
bochs_drv.c
> index 10460878414e..87ee1eb21a4d 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -60,6 +60,11 @@ static int bochs_load(struct drm_device *dev)
> =20
>  DEFINE_DRM_GEM_FOPS(bochs_fops);
> =20
> +static void bochs_release(struct drm_device *dev)
> +{
> +	bochs_unload(dev);
> +}
> +
>  static struct drm_driver bochs_driver =3D {
>  	.driver_features	=3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.fops			=3D &bochs_fops,
> @@ -69,6 +74,7 @@ static struct drm_driver bochs_driver =3D {
>  	.major			=3D 1,
>  	.minor			=3D 0,
>  	DRM_GEM_VRAM_DRIVER,
> +	.release                =3D bochs_release,
>  };
> =20
>  /* -------------------------------------------------------------------=
--- */
> @@ -148,9 +154,8 @@ static void bochs_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> =20
> -	drm_atomic_helper_shutdown(dev);
>  	drm_dev_unregister(dev);
> -	bochs_unload(dev);
> +	drm_atomic_helper_shutdown(dev);
>  	drm_dev_put(dev);
>  }
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--roUT122ea9dVbbMdoLRaORWXJWNLO7PGu--

--SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49YuQACgkQaA3BHVML
eiMIagf7BLAgwaxEZQ+WpNM3sl5Rvo6p8Ig5y87QonriAW9AtUkCkl3Gaf3P3XSj
/175Sb8DOrQbjTeXjo8oo4k3dLzGEpc6J+2FJkkflAQDAGlrj04HA60zNJnxY2KG
BUNALqPd1NXHSlnP518mudWwK4lHQ6lCCRys7X0aix0srjBgBy5VEaCA3BVMepRp
5IePxEKXzcLD2cy0oJGgosDaXtfyUcXwktTwUCirZ0V/cxzhNk30oZPWa8CyUh0r
EwXit075NrZ8/8W9DhN/YhvA6jolUwbuoUFUKWD1qFnaaINYEHdI5YjzLkriI7WJ
BtqNDK0JaWJYojTeAkHGtb2n9xIqFg==
=872b
-----END PGP SIGNATURE-----

--SUjmDviLONev2LDyp9jwJwtmaVjmvfGx1--
