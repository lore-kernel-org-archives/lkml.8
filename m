Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34AFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D99420771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLHEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:44752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgHLHEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:04:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB2CEADFE;
        Wed, 12 Aug 2020 07:04:42 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon v2 0/3] hibmc clean up and code refactoring
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <312b8060-f015-35ba-f4f6-ad992aa09aa9@suse.de>
Date:   Wed, 12 Aug 2020 09:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pd7FqbtFRSXyk2z4owLcdb89sjLdQZbgJ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pd7FqbtFRSXyk2z4owLcdb89sjLdQZbgJ
Content-Type: multipart/mixed; boundary="nGjH8xuPRunvhEnSa47CXG8cBqN68n4FF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <312b8060-f015-35ba-f4f6-ad992aa09aa9@suse.de>
Subject: Re: [PATCH drm/hisilicon v2 0/3] hibmc clean up and code refactoring
References: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>

--nGjH8xuPRunvhEnSa47CXG8cBqN68n4FF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.08.20 um 02:38 schrieb Tian Tao:
> patch #1 and #3 is clean up, patch #2 is for code refactoring

Sorry for all my reviews taking so long. Please merge patch #3 into
patch #2 and then the series is

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I noticed that hibmc use DRM_ERROR in several places. A good follow-up
patchset would be the conversion to drm_info/drm_warn/drm_error/etc.

Best regards
Thomas

>=20
> Changes since v1:
> - Rewrite the commits messages and patch name in #1
> - Rewrite the commits message in #2.
> - Add the new patch #3
>=20
> Tian Tao (3):
>   drm/hisilicon: Remove the unused include statements
>   drm/hisilicon: Code refactoring for hibmc_drv_de
>   drm/hisilicon: Rename variables to represent the correct meaning
>=20
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 58 ++++++----------=
--------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  5 --
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 -
>  4 files changed, 15 insertions(+), 52 deletions(-)
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--nGjH8xuPRunvhEnSa47CXG8cBqN68n4FF--

--Pd7FqbtFRSXyk2z4owLcdb89sjLdQZbgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8zlHMUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMGHQf/d5Q+dstGU+U5bfSVRMAxhoasCwSp
kppvxwFjRQYpkQMQKiBiEktgPIhJ4/KSna4T6HS+sDAHN9fbYDqpS6Xe8MNEt475
90qXCLUOVB3zZK4TdPBHWB4wf+pqlNhvNnilhj8RjfObTvTM89PELfGs01TVA9ry
QGwO7mTzj/DVjRGt5vcp7xYAr95hfILWsGIM1TMqYLGysNbJKcEVAXEOWU1B6hOo
qJvBTrBSMnj5Ua+QfI318D3OYD/YQI6VoGO1t6kW00N+XvnLsm5C4qh3G5Y8WOkZ
s6+rKC9oFRcpeLXvkNkdycPyD/XEppe1xUAIpR3pixEkmxPqJaPousHsRQ==
=xg+n
-----END PGP SIGNATURE-----

--Pd7FqbtFRSXyk2z4owLcdb89sjLdQZbgJ--
