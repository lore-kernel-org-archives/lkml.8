Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94351C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BD122CB3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGTG5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgGTG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:57:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFDFC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:57:46 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jxPjv-00026Q-NH; Mon, 20 Jul 2020 08:57:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jxPjv-0000j4-1T; Mon, 20 Jul 2020 08:57:31 +0200
Date:   Mon, 20 Jul 2020 08:57:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     robh+dt@kernel.org, kernel@pengutronix.de, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for v5.9] ARM: dts: efm32: Replace HTTP links with HTTPS
 ones
Message-ID: <20200720065732.pudnfzn4eyu33eig@pengutronix.de>
References: <20200719095958.57555-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igplwgecwcj5vega"
Content-Disposition: inline
In-Reply-To: <20200719095958.57555-1-grandmaster@al2klimov.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igplwgecwcj5vega
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jul 19, 2020 at 11:59:58AM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

I would have described this in prose instead. (Something like: Replace
http: URL scheme with https:. As of today the old and new URLs result in
the same content to be accessed.)

Other than that:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> diff --git a/arch/arm/mach-efm32/Makefile.boot b/arch/arm/mach-efm32/Make=
file.boot
> index cec195d4fcba..5dde7328a7a9 100644
> --- a/arch/arm/mach-efm32/Makefile.boot
> +++ b/arch/arm/mach-efm32/Makefile.boot
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # Empty file waiting for deletion once Makefile.boot isn't needed any mo=
re.
>  # Patch waits for application at
> -# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D7889/=
1 .
> +# https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D7889=
/1 .

:-|

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--igplwgecwcj5vega
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8VQFkACgkQwfwUeK3K
7AmsZQf/RhLZJkQ45VLwZJmaOR12/ZsWU29kLWYvQv3peDjl6mF7vNG3TjaZwD4G
DN8R92udQ+T/TRm2PnJ6+p8O1/aQNN7373Bh8x5k/MOTHqDFrxy9gKeTsMRTBXK4
oiaZh0r91vB7DEHVkr8UuIFsme91ItVtWhKuTy/C06N4OyzX/yKIFKbcscMq/xQO
OpzmvbhS8RDCJBo9rPG0V1cRzR9FVQVIG8aty/q0n0bFtYJ+ZhdiKsvS6mKMlsCA
tUd9JqW04TMzADHQmolWJOm35YkzaDG6RHigNP7vYjxJW74S2iy5bkgXcgk/SVUc
ApdMaoGFBMGrfOhs2coGjxaeu7foGA==
=NbK5
-----END PGP SIGNATURE-----

--igplwgecwcj5vega--
