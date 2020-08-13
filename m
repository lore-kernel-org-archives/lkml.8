Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA51C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5381420781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMIDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:03:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMIDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:03:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85F89AF82;
        Thu, 13 Aug 2020 08:03:44 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Fix build error of no type of module_init
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597289955-27381-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5e7ed4d6-8961-bdd0-6698-47571066357a@suse.de>
Date:   Thu, 13 Aug 2020 10:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597289955-27381-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PViowPfbaTjNTU6mKv6gbP9xhigU5xjHJ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PViowPfbaTjNTU6mKv6gbP9xhigU5xjHJ
Content-Type: multipart/mixed; boundary="DZf0ynl3KQRcR4aueZHBhokv6F5d3B8Fx";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <5e7ed4d6-8961-bdd0-6698-47571066357a@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Fix build error of no type of module_init
References: <1597289955-27381-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1597289955-27381-1-git-send-email-tiantao6@hisilicon.com>

--DZf0ynl3KQRcR4aueZHBhokv6F5d3B8Fx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.08.20 um 05:39 schrieb Tian Tao:
> Add missing include to fix build error:
> hibmc_drm_drv.c:385:1: warning: data definition has no type or storage
> class [enabled by default]
> hibmc_drm_drv.c:385:1: error: type defaults to =E2=80=98int=E2=80=99 in=
 declaration
> of =E2=80=98module_init=E2=80=99 [-Werror=3Dimplicit-int]
> hibmc_drm_drv.c:385:1: warning: parameter names (without types) in func=
tion
> of =E2=80=98module_exit=E2=80=99 [-Werror=3Dimplicit-int]
> hibmc_drm_drv.c:385:292:1: warning: parameter names (without types) in
> function declaration [enabled by default]
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I pushed the patch to drm-misc-next, but forgot to add my R-b tag. If
anyone complains, it's my fault.

Best regards
Thomas

> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 1ae360d..2b4f821 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -11,6 +11,7 @@
>   *	Jianhua Li <lijianhua@huawei.com>
>   */
> =20
> +#include <linux/module.h>
>  #include <linux/pci.h>
> =20
>  #include <drm/drm_atomic_helper.h>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--DZf0ynl3KQRcR4aueZHBhokv6F5d3B8Fx--

--PViowPfbaTjNTU6mKv6gbP9xhigU5xjHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8088kUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiNqzAgArHim/VrpwqUX42uX6B5W6rBex4/V
RoHBJMg8n9IEPDN5Bc8jtambx64LixZjCGPMIudkUCpcCuXr7NMPMAEz4/00btSu
b4MLSv6k0pZM1BoIsvaAqzetDYS3J/JFY4a53gEgWA3vMj18490rXuyqpt/wcr7N
lFiQfx0Qaf2uCI5/xBe0y0HIvRj/JXlTUeIAlsvKvDnnNq2ElSIqpe94BrR4qQEV
tpf2QLovX7emOFlPho0TVsQvVTlvbxykVnNIZxWSPwUy+os85gUJOxIH/YvI5mg4
QagqAlBDsIiZd5PcdEiF+O0VSvz2JRSjq4oaxWEh7YScArmvovGaeR6XAQ==
=7zSe
-----END PGP SIGNATURE-----

--PViowPfbaTjNTU6mKv6gbP9xhigU5xjHJ--
