Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA7C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BDA20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgDXJc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:32:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49362 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgDXJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:32:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9E5541C0223; Fri, 24 Apr 2020 11:32:27 +0200 (CEST)
Date:   Fri, 24 Apr 2020 11:32:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>, Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Message-ID: <20200424093226.GB2647@amd>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20200416145123.73039-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-04-16 16:51:23, Sebastian Reichel wrote:
> From: Ian Ray <ian.ray@ge.com>
>=20
> Use kernel LED interface for the alarm LEDs.

Could we get these changes cced to LED maintainers?

> +		alarm1 {
> +			label =3D "alarm:red";
> +			gpios =3D <&gpio7 3 GPIO_ACTIVE_HIGH>;
> +		};

So... What is function of these leds, and can we get naming more
consistent with rest of the kernel?
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6isioACgkQMOfwapXb+vKH7gCeLfTNWUhERXHz8WjUp/cao3Fb
WiwAnjuTTY27A4qHvE7yF23fhRewBJeL
=Nhs2
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
