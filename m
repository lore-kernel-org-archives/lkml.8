Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF8120786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGHGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:10:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgGHGKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:10:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E45BDAC85;
        Wed,  8 Jul 2020 06:10:48 +0000 (UTC)
Subject: Re: [PATCH 4/4] drm: fb-helper: Convert logging to drm_* functions.
To:     Suraj Upadhyay <usuraj35@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <cover.1594136880.git.usuraj35@gmail.com>
 <0d37c7a614eb0885f0f0bed18e48a4d26b345a8e.1594136880.git.usuraj35@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <801c7af4-3991-6422-e95f-6a867d27f697@suse.de>
Date:   Wed, 8 Jul 2020 08:10:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0d37c7a614eb0885f0f0bed18e48a4d26b345a8e.1594136880.git.usuraj35@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N6Vsy2mqhXxmQ3gZtTbQfTGcJfn3UBoh9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N6Vsy2mqhXxmQ3gZtTbQfTGcJfn3UBoh9
Content-Type: multipart/mixed; boundary="ayhMn1v1MzKH6si9D5WT2KLCxgXlyGr6I";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Suraj Upadhyay <usuraj35@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <801c7af4-3991-6422-e95f-6a867d27f697@suse.de>
Subject: Re: [PATCH 4/4] drm: fb-helper: Convert logging to drm_* functions.
References: <cover.1594136880.git.usuraj35@gmail.com>
 <0d37c7a614eb0885f0f0bed18e48a4d26b345a8e.1594136880.git.usuraj35@gmail.com>
In-Reply-To: <0d37c7a614eb0885f0f0bed18e48a4d26b345a8e.1594136880.git.usuraj35@gmail.com>

--ayhMn1v1MzKH6si9D5WT2KLCxgXlyGr6I
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 07.07.20 um 18:37 schrieb Suraj Upadhyay:
> Change logging information from dev_info() to drm_info().
>=20
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> index 5609e164805f..88146f7245c5 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1819,7 +1819,7 @@ __drm_fb_helper_initial_config_and_unlock(struct =
drm_fb_helper *fb_helper,
>  	if (ret < 0)
>  		return ret;
> =20
> -	dev_info(dev->dev, "fb%d: %s frame buffer device\n",
> +	drm_info(dev, "fb%d: %s frame buffer device\n",
>  		 info->node, info->fix.id);
> =20
>  	mutex_lock(&kernel_fb_helper_lock);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=FCrnberg, Germany
(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer


--ayhMn1v1MzKH6si9D5WT2KLCxgXlyGr6I--

--N6Vsy2mqhXxmQ3gZtTbQfTGcJfn3UBoh9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8FY2cUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPiVAf9Go8IAySbthZgUIcmxpZlWhrOOPhl
gSAQV4lLCHGrEZWPvyANtC5/o0+NmZk37NNYVGNB1XDh7gJmgDA4+3gbhiHitqy7
K61vXp5PyXYW7EIj5OZT0V+o8AH6+/AP9G/c9p0YC1LWcoH5EeawEDsfEergbePJ
4bshONnVpQYxUVsiR7QcMCrNtcvpbgF+x0BHCE61cmWbvm8DpO3HNQ1T3QfC9iYb
66ltWYsxY0W0gOuAVEky7Llnml5S7xSj9buYHgfyinowUJsY6qgLYXOX2oC1U6sI
XwZvSGKp91FZaB1WefUo7+EZq+Yam4pHiZUpEasOuS778D/6svYWXXFMqA==
=EGVC
-----END PGP SIGNATURE-----

--N6Vsy2mqhXxmQ3gZtTbQfTGcJfn3UBoh9--
