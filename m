Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA2BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C6320884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGBGmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:42:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgGBGmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:42:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4347AB7D;
        Thu,  2 Jul 2020 06:42:37 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Use drmm_kzalloc() instead of
 devm_kzalloc()
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     inuxarm@huawei.com
References: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <50ea833a-7d8d-a1ad-3622-3456afc87719@suse.de>
Date:   Thu, 2 Jul 2020 08:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HkQdo8CuyD11ZMY15qc1sXizDvmjfLw22"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HkQdo8CuyD11ZMY15qc1sXizDvmjfLw22
Content-Type: multipart/mixed; boundary="29yr6CmlInDzUlDanFunYns2V6k80gprO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
 airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
 alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: inuxarm@huawei.com
Message-ID: <50ea833a-7d8d-a1ad-3622-3456afc87719@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Use drmm_kzalloc() instead of
 devm_kzalloc()
References: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>

--29yr6CmlInDzUlDanFunYns2V6k80gprO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 02.07.20 um 03:21 schrieb Tian Tao:
> using the new API drmm_kzalloc() instead of devm_kzalloc()
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a6fd0c2..2f20704 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -23,6 +23,7 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_managed.h>

Please keep the DRM include statements sorted alphabetically.

With this fixed

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> =20
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
> @@ -267,7 +268,7 @@ static int hibmc_load(struct drm_device *dev)
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


--29yr6CmlInDzUlDanFunYns2V6k80gprO--

--HkQdo8CuyD11ZMY15qc1sXizDvmjfLw22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl79gd0UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiNm1wf/d7B9/p6rLC/KHbnag1cY9+sy59pp
5ahpPxXK/NQX7TIyaaDc6b3o1lwP8ytXJ28vI9ptltsH3cWHzKflyYoSpW/rvXyG
3OPW0kH6CP3WbICVPS0PPpuThZfn2YyX3VfdrO3fug3JRaX6AaTH2wqQTXC7X2Xu
/hOoQtP/+nzD9ihqiepuS8qu60fKF5MoEwV+jcjgJ6GclrYuPcDSI+B5lfDgErlL
Z8x0HD4C4BMgW44qzDAKZihAjFJ99f4WLEK0b2xSgSRBTP5+ucLuxOFfUzrgTXxV
Hz18e9xVpYg6BOpT42pnVa8Z023OesL3Db6h6Ar0KmTFxz+lIlcdr+LIog==
=7BsW
-----END PGP SIGNATURE-----

--HkQdo8CuyD11ZMY15qc1sXizDvmjfLw22--
