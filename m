Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBBD20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgGBHUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:20:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGBHUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:20:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7D7CADD9;
        Thu,  2 Jul 2020 07:20:33 +0000 (UTC)
Subject: Re: [PATCH v2] drm/hisilicon: Use drmm_kzalloc() instead of
 devm_kzalloc()
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1593673602-49027-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <31a82ab1-e140-5e4d-774b-355a68f44add@suse.de>
Date:   Thu, 2 Jul 2020 09:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593673602-49027-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rRMyF5m1L3QxZNeFgEJed0wTPQUm0B0sO"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rRMyF5m1L3QxZNeFgEJed0wTPQUm0B0sO
Content-Type: multipart/mixed; boundary="cxHHqSSparaUC5MYFuCGNwSnEcHFGNJ4Q";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
 airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
 alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <31a82ab1-e140-5e4d-774b-355a68f44add@suse.de>
Subject: Re: [PATCH v2] drm/hisilicon: Use drmm_kzalloc() instead of
 devm_kzalloc()
References: <1593673602-49027-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1593673602-49027-1-git-send-email-tiantao6@hisilicon.com>

--cxHHqSSparaUC5MYFuCGNwSnEcHFGNJ4Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 02.07.20 um 09:06 schrieb Tian Tao:
> using the new API drmm_kzalloc() instead of devm_kzalloc()
>=20
> v2:
> keep the DRM include statements sorted alphabetically.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 18 +++++++++--------=
-
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a6fd0c2..b557728 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -11,18 +11,18 @@
>   *	Jianhua Li <lijianhua@huawei.com>
>   */
> =20
> +#include <drm/drm_gem_vram_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_print.h>
>  #include <linux/console.h>
>  #include <linux/module.h>
> -#include <linux/pci.h>
> -
> -#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
> -#include <drm/drm_gem_vram_helper.h>
>  #include <drm/drm_irq.h>
> -#include <drm/drm_print.h>
> -#include <drm/drm_probe_helper.h>
> -#include <drm/drm_vblank.h>
> +#include <linux/pci.h>

Ok, that's a bit too much. :D

First of all, it's still not alphabetically. Second, linux headers go
first, then drm headers follow. It should look like

 #include <linux/...>
 #include <linux/...>
 #include <linux/...>

 #include <drm/...>
 #include <drm/...>
 #include <drm/...>

with each block sorted alphabetically.

If you include drm_managed.h right before drm_print.h, it should be fine
already.

Best regards
Thomas

> =20
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
> @@ -267,7 +267,7 @@ static int hibmc_load(struct drm_device *dev)
>  	struct hibmc_drm_private *priv;
>  	int ret;
> =20
> -	priv =3D devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
> +	priv =3D drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
>  		DRM_ERROR("no memory to allocate for hibmc_drm_private\n");
>  		return -ENOMEM;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--cxHHqSSparaUC5MYFuCGNwSnEcHFGNJ4Q--

--rRMyF5m1L3QxZNeFgEJed0wTPQUm0B0sO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl79ir0UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiNxmwf/T+1KsEjCZPwfy7v4tgGrq3eZQkbB
KB3230daBqr8HMjjFOQJVbdXN92GDlvzFMh/7KY3C5epuJq+PfrQGj/bOvKa4esF
A1Tbwim0xe2W59bkYxKgjWWpcmsgw1PiXFNKiwWvfrmgdFplFGruXziaUg6RAKKL
qchgRC/7QVXNzHLIKxXKw0D/CtlVeEsE4MreKJz3ui/eufuaguAQ83CtSnTg2WiH
zwYeKN9iVwD2g5QNg+k/6ybg28h/pzcQUiniGcNstNspEac/kS9vWzBP9NITcjCO
CQkeShEUin57z4x0DlJNeE2vgVV4UQk01tyZGZqSms2kXSy2rXX8rfY/Dw==
=t20u
-----END PGP SIGNATURE-----

--rRMyF5m1L3QxZNeFgEJed0wTPQUm0B0sO--
