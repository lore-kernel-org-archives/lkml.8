Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D0FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD4221655
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgE2Q1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:27:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35204 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Q1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:27:30 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7ADB11C0385; Fri, 29 May 2020 18:27:29 +0200 (CEST)
Date:   Fri, 29 May 2020 18:27:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v3 4/5] arm64: dts: sun50i-a64-pinephone: Enable LCD
 support on PinePhone
Message-ID: <20200529162728.GB3709@amd>
References: <20200513212451.1919013-1-megous@megous.com>
 <20200513212451.1919013-5-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20200513212451.1919013-5-megous@megous.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> PinePhone uses PWM backlight and a XBD599 LCD panel over DSI for
> display.
>=20
> Backlight levels curve was optimized by Martijn Braam using a
> lux meter.

If it was possible to preserve lux values for individual settings in
the comment somewhere... that would be nice :-).

One day, it would be nice to have brightness settings in lux, so I
could easily set matching levels on multiple devices, for example...

Best regards,

								Pavel

> +
> +&backlight {
> +	power-supply =3D <&reg_ldo_io0>;
> +	/*
> +	 * PWM backlight circuit on this PinePhone revision was changed since
> +	 * 1.0, and the lowest PWM duty cycle that doesn't lead to backlight
> +	 * being off is around 20%. Duty cycle for the lowest brightness level
> +	 * also varries quite a bit between individual boards, so the lowest
> +	 * value here was chosen as a safe default.
> +	 */
> +	brightness-levels =3D <
> +		774  793  814  842
> +		882  935  1003 1088
> +		1192 1316 1462 1633
> +		1830 2054 2309 2596
> +		2916 3271 3664 4096>;
> +	num-interpolated-steps =3D <50>;
> +	default-brightness-level =3D <400>;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7RN/AACgkQMOfwapXb+vKbHQCgpslUZBfZdvt5G0n+46mybETz
vjcAnj6Q0OeuWlJccqmIncSEyhdvvZh2
=w+1i
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
