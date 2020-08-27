Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D2DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EA42078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgH0JUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:20:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0JUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:20:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C446CB70C;
        Thu, 27 Aug 2020 09:21:06 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Removed the dependency on the mmu
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1598428528-49046-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <6f0110db-e99c-f3aa-7384-0c94b103df46@suse.de>
Date:   Thu, 27 Aug 2020 11:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598428528-49046-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KULVXC8S39wiYcq8slr4cOQpojIehEohB"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KULVXC8S39wiYcq8slr4cOQpojIehEohB
Content-Type: multipart/mixed; boundary="qbNIdt43Js2p80Ombq6tt2QVpDl3hq9xC";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <6f0110db-e99c-f3aa-7384-0c94b103df46@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Removed the dependency on the mmu
References: <1598428528-49046-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1598428528-49046-1-git-send-email-tiantao6@hisilicon.com>

--qbNIdt43Js2p80Ombq6tt2QVpDl3hq9xC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.08.20 um 09:55 schrieb Tian Tao:
> hibmc can only be used in ARM64 architectures, and mmu defaults to y
> in arch/arm64/Kconfig, so there is no need to add a dependency on mmu
> in hibmc's kconfig.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/hisilicon/hibmc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/=
hisilicon/hibmc/Kconfig
> index dfc5aef..43943e9 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_HISI_HIBMC
>  	tristate "DRM Support for Hisilicon Hibmc"
> -	depends on DRM && PCI && MMU && ARM64
> +	depends on DRM && PCI && ARM64
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
>  	select DRM_TTM
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--qbNIdt43Js2p80Ombq6tt2QVpDl3hq9xC--

--KULVXC8S39wiYcq8slr4cOQpojIehEohB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9HeuEUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiNVLQgAhJP85eJllBaaDomuKaFMd771xpMM
oAASYd3aocuf0yMRW+VUsOKP93l0FrRCdgMX5PkcuUpUMfpRvX0z583IMjcKXP90
Kcf9wSiTr6UfFfMBWsCXpxwg6KbDJsDBO3D1cRWwhN0zU9ZI7Q/5yfiYT9/iZVY+
zxJJHzfxT+Mob59phfY1MVQJppLbQdtJAKyK4EU0o1FBC7EL6/TK4vvH8k1Hj7ts
rVPjaZRxUqmZnsgJRyrIEEqzHctiU71JMwjsWlKjfbcwnOONIdPKOhYakDQhyeyt
Fo0jACY0wr5e3qfIEuRWFCT98aeP1co/S4dhrIBPvwpGFDXh3Bw0HfeWog==
=rU1j
-----END PGP SIGNATURE-----

--KULVXC8S39wiYcq8slr4cOQpojIehEohB--
