Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4389C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AB2207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHRHmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgHRHmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:42:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA283ABCC;
        Tue, 18 Aug 2020 07:42:28 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon 0/4] Use drv_err instead of DRM_ERROR in
 hibmc driver
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ddeac968-cbea-9441-2fe5-d1223aa4d5f2@suse.de>
Date:   Tue, 18 Aug 2020 09:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="csRgyoghWyrutzR6kOCvUjcF7OhhuwMjJ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--csRgyoghWyrutzR6kOCvUjcF7OhhuwMjJ
Content-Type: multipart/mixed; boundary="WxrrzYJaIrqhxDw9UDVpkbavTe5rN0CrA";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <ddeac968-cbea-9441-2fe5-d1223aa4d5f2@suse.de>
Subject: Re: [PATCH drm/hisilicon 0/4] Use drv_err instead of DRM_ERROR in
 hibmc driver
References: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>

--WxrrzYJaIrqhxDw9UDVpkbavTe5rN0CrA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.08.20 um 08:51 schrieb Tian Tao:
> patch #1 is using the drv_err instead of DRM_ERROR in hibmc_ttm.c
> patch #2 is using the drv_err instead of DRM_ERROR in hibmc_drm_vdac.c
> patch #3 is using the drv_err and drm_dbg_atomic  instead of DRM_ERROR
> and DRM_DEBUG_ATOMIC  in hibmc_drm_de.c
> patch #4 is using the drv_err and drm_warn instead of DRM_ERROR and
> DRM_WARN in hibmc_drm_drv.c
>=20
> Tian Tao (4):
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_ttm
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_vdac
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_de
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_drv

Series is

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

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


--WxrrzYJaIrqhxDw9UDVpkbavTe5rN0CrA--

--csRgyoghWyrutzR6kOCvUjcF7OhhuwMjJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl87hkoUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiP5fQf+NLJld/8hS8rL0w7LexD93Kjje1Gp
yeaT/2rZDTZ//vC9+BZBNDdSKYwO1WAlhNILfJO12j8zXkVsa1NQEOLlL/dy8pFc
KKBSoVQEeWxHPjbFnIMOXzj5NbNOYQGXNyWeY8LA2PdbgNRtvjO3RbqeI067Q/z8
nAxS/md+SyKXQafqzZNQCpW9DDT/07ktrNeRWCoNsbrEmVkzwUA4nOOGhGUR/YoJ
1k6TFxdyRHfyJKvxxnE5ehpAFGDfKTDuCeMPF5ghX7/PAiJDQwjatH2YlbBIpuxO
KMj1B6q+Vt5iobC4HnSC1Q7qcpmVL3eScntTFN8Q33SKTpPRcceyTgYSUA==
=8YPe
-----END PGP SIGNATURE-----

--csRgyoghWyrutzR6kOCvUjcF7OhhuwMjJ--
