Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A59D206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgHLIdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:33:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:57590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgHLIdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:33:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BD8DB5E8;
        Wed, 12 Aug 2020 08:34:12 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon v3 0/2] hibmc clean up and code refactoring
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <07634d88-13a7-8767-032d-24ba9b5f5f8b@suse.de>
Date:   Wed, 12 Aug 2020 10:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cADU4EOi8UINnvVNbIZnML821TzzfUywE"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cADU4EOi8UINnvVNbIZnML821TzzfUywE
Content-Type: multipart/mixed; boundary="Mz5FlLSm8z4ugsRP0gL03sCCEZedpCSTW";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <07634d88-13a7-8767-032d-24ba9b5f5f8b@suse.de>
Subject: Re: [PATCH drm/hisilicon v3 0/2] hibmc clean up and code refactoring
References: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>

--Mz5FlLSm8z4ugsRP0gL03sCCEZedpCSTW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Merged into drm-misc-next

Am 12.08.20 um 09:42 schrieb Tian Tao:
> patch #1 and #3 is clean up, patch #2 is for code refactoring
>=20
> Changes since v1:
> - Rewrite the commits messages and patch name in #1
> - Rewrite the commits message in #2.
> - Add the new patch #3
>=20
> Changes since v2:
> - merge patch #3 into patch #2
>=20
> Tian Tao (2):
>   drm/hisilicon: Remove the unused include statements
>   drm/hisilicon: Code refactoring for hibmc_drv_de
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


--Mz5FlLSm8z4ugsRP0gL03sCCEZedpCSTW--

--cADU4EOi8UINnvVNbIZnML821TzzfUywE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8zqWsUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMmRQf+KrwSE3o3R6OiYW0liC6rO0ycoAO6
WGP0gfJvbZ48xQUx0vu7zmUmTH9TslNfBGPRUb3S2IhPjohVEBJeIMk189EDWuzh
TQIXkzbjAxP17WqzFUcyYpwnY4VNuQih0/l3VL4PBYskUaZYmTetxTQLv9WHLrMm
B/44rFsPQphbvmWCxyOc7k1lBxN7sCAXCKXN5yi1MavS7iODjQCUt9L2mvZfse1S
xcgKN+bUfctbbCjldUKV/yalBIHuZfqRsD+pENDYtecqrc7kRkSm4qTdF0S1vRuM
HXuF6KBzbEhTjpQxeVwnZN7vdNNCTvWKgYNQjFWZ90i5wRNS2kuvb+d3LQ==
=p+mv
-----END PGP SIGNATURE-----

--cADU4EOi8UINnvVNbIZnML821TzzfUywE--
