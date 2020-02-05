Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D19C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C9E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBEMY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:24:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:24:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 4104628DAA6
Date:   Wed, 5 Feb 2020 07:24:23 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panfrost: Don't try to map on error faults
Message-ID: <20200205122423.GA2903@kevin>
References: <20200205100719.24999-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200205100719.24999-1-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>=20

Although it might be nice to

	#define TRANSLATION_FAULT_LEVEL1 0xC1
	...
	#define TRANSLATION_FAULT_LEVEL4 0xC4

and then use semantic names instead of magic values. Minimally maybe add
a comment explaining that.

On Wed, Feb 05, 2020 at 11:07:16AM +0100, Tomeu Vizoso wrote:
> If the exception type isn't one of the normal faults, don't try to map
> and instead go straight to a terminal fault.
>=20
> Otherwise, we can get flooded by kernel warnings and further faults.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 763cfca886a7..80abddb4544c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -596,8 +596,9 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(in=
t irq, void *data)
>  		source_id =3D (fault_status >> 16);
> =20
>  		/* Page fault only */
> -		if ((status & mask) =3D=3D BIT(i)) {
> -			WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
> +		if ((status & mask) =3D=3D BIT(i) &&
> +		     exception_type >=3D 0xC1 &&
> +		     exception_type <=3D 0xC4) {
> =20
>  			ret =3D panfrost_mmu_map_fault_addr(pfdev, i, addr);
>  			if (!ret) {
> --=20
> 2.21.0
>=20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl46s+0ACgkQ/v5QWgr1
WA3Xtw//WjS7YeR6jL+CSEjw3qqi00m2hORBCxE2+yrEUv3RgF9pYj8ugBAZIV20
TdvPTpZulaMFU8v3eV8T9e5RyrUrlUCjPBodW9Sc1VUXLSSUXAeE+gnMpUAB12pR
f14Tmqc7q6e0eJsuFmA+cICJqkzmWQcnhBMhaXxaW0uF2ziew4/GaHo8F5tFyzue
mu/t6u/RYB/GRIMtrAElsVGKGzgjw6TpCB4TiAjK20OTNkJfeZLHfpFop/nEwPcO
VrY+J43BJikSleYbyUhxbpfhTDfmxaeg8TJPsRvXayeJ17oIh1Cz1gV/TrR6AGLF
jrxfL+bkQ3QiOPJevtFy3w7G7uyC5LdpFdSYdYCiadctmhdJC8R/yFAMyxhV+HIv
0MGEWvUnNobNBP88nnVT7JoBcbYIc4ncfJB9+L4X4wWpGCy6JOFc5Gz36re0pI4t
7L5E7/CkI+zapX14ffqYlCNvuXM3kXcWavBcsiwGmW9gNUB5iu8dJPCwsShCICSl
1zdePzXDjj8VVFy6aE8agY03hhTDG9qPT/Btxbt/Jj5W3UtMKGrl+u65V8HtZ9Jt
PW/2Dsh7rwGHcqCya/zyNEZmlBQk1VZKQkcc3V22bH1pyb1VTdklQZ1PCwQPIafp
aCzVPpgtKocCZTf30LVncWNnMxAFspoSppBE3jPBtk8VTLWdSqo=
=AhWm
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
