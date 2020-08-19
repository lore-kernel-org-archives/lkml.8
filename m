Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA95FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9864C20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHSSGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:06:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgHSSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:06:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CFDCB790;
        Wed, 19 Aug 2020 18:07:03 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon v2 0/4] Use drm_err instead of DRM_ERROR in
 hibmc driver
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <50f37353-a4fb-9b93-c48f-897cb7c6914b@suse.de>
Date:   Wed, 19 Aug 2020 20:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FyvNYwAnxF6sW6L71jwt75L6wO4E6DEIv"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FyvNYwAnxF6sW6L71jwt75L6wO4E6DEIv
Content-Type: multipart/mixed; boundary="WN6idnxKUAyH6JFXQUM9ADxPzxqyh6B4d";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <50f37353-a4fb-9b93-c48f-897cb7c6914b@suse.de>
Subject: Re: [PATCH drm/hisilicon v2 0/4] Use drm_err instead of DRM_ERROR in
 hibmc driver
References: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>

--WN6idnxKUAyH6JFXQUM9ADxPzxqyh6B4d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 19.08.20 um 11:23 schrieb Tian Tao:
> patch #1 is using the drm_err instead of DRM_ERROR in hibmc_ttm.c
> patch #2 is using the drm_err instead of DRM_ERROR in hibmc_drm_vdac.c
> patch #3 is using the drm_err and drm_dbg_atomic instead of DRM_ERROR
> and DRM_DEBUG_ATOMIC in hibmc_drm_de.c
> patch #4 is using the drm_err and drm_warn instead of DRM_ERROR and
> DRM_WARN in hibmc_drm_drv.c
>=20
> Changes since v1:
> -Fixed spelling errors in patch name.

Just a few formal nits: it's common to also log the changes in the
patches themselves. And as I already R-b'ed the patchset, the patches
should contain the tag.

So

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

for the whole series. If no one else has comments, it should be fine to
merge the patches by the end of the week.

Best regards
Thomas

>=20
> Tian Tao (4):
>   drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_ttm
>   drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_vdac
>   drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_de
>   drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_drv
>=20
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 14 +++++++-------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 24 ++++++++++++----=
--------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  4 ++--
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  2 +-
>  4 files changed, 22 insertions(+), 22 deletions(-)
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--WN6idnxKUAyH6JFXQUM9ADxPzxqyh6B4d--

--FyvNYwAnxF6sW6L71jwt75L6wO4E6DEIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl89aikUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPYzAgAqN/EtFtij0zI+bAxmXk0iA2Hv10E
2GKTG7OgOOAlt7VvL09ZVqLnggFpcQy/p8UKQ3uKGiCiwyc9DHQEDTog0wbld8v8
N/nZB7iKhlqDoTPaSy/sQi0aN/ZCp9q4/W84ncnKXU9WD9M/3CYaKf4LEmRsX6b9
deLy/fVV/UIuvvUdAgSWysmPkT9pbtpB3L73nfBdKjBlv/QcgWGWFxDZ2Lv+547S
xY1xAMvZWAPtxVOUPwfA4KYzo7HV81vJnrb04LmeDzUT3AE3C5BjyPlPNJI22qZm
sCmnIJ260/5EBISqPER55V3sxARCD47xDpDIRwAT0ry1f4tuLYxHPaw3kA==
=56wm
-----END PGP SIGNATURE-----

--FyvNYwAnxF6sW6L71jwt75L6wO4E6DEIv--
