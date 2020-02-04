Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B078FC3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E20221741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBDTMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:12:25 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59428 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbgBDTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:12:24 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 954011C013F; Tue,  4 Feb 2020 20:12:22 +0100 (CET)
Date:   Tue, 4 Feb 2020 20:12:21 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jason Anderson <jasona.594@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 38/70] platform/x86: GPD pocket fan: Allow somewhat
 lower/higher temperature limits
Message-ID: <20200204191221.GA19410@amd>
References: <20200203161912.158976871@linuxfoundation.org>
 <20200203161917.952945455@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20200203161917.952945455@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Hans de Goede <hdegoede@redhat.com>
>=20
> [ Upstream commit 1f27dbd8265dbb379926c8f6a4453fe7fe26d7a3 ]
>=20
> Allow the user to configure the fan to turn on / speed-up at lower
> thresholds then before (20 degrees Celcius as minimum instead of 40) and
> likewise also allow the user to delay the fan speeding-up till the
> temperature hits 90 degrees Celcius (was 70).

I see it does not break anything, but I don't quite see it as a stable
material.

That said... does lower limit make sense? Spinning fans 10C might be
interesting but not wrong.

Anyway, dev_err() text is now outdated.

Best regards,
								Pavel

>  	for (i =3D 0; i < ARRAY_SIZE(temp_limits); i++) {
> -		if (temp_limits[i] < 40000 || temp_limits[i] > 70000) {
> +		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
>  			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and=
 70000)\n",
>  				temp_limits[i]);
>  			temp_limits[0] =3D TEMP_LIMIT0_DEFAULT;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl45whUACgkQMOfwapXb+vKlaQCgthMtI4VpqP9aDyCw0KBAI+6V
WhgAoI+V/p2EY/e+PWCDPHPJNhp/jlf1
=nEj6
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
