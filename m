Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4672C20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgGKP5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:57:48 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46298 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:57:47 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EB88B1C0BD2; Sat, 11 Jul 2020 17:57:44 +0200 (CEST)
Date:   Sat, 11 Jul 2020 17:57:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v29 12/16] ARM: defconfig: u8500: Add LP55XX_COMMON
 config flag
Message-ID: <20200711155744.GA22715@amd>
References: <20200622185919.2131-1-dmurphy@ti.com>
 <20200622185919.2131-13-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20200622185919.2131-13-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-06-22 13:59:15, Dan Murphy wrote:
> The dependencies for the LP55XX LED drivers have been updated so that
> the child devices (i.e. LP5521) now depends on the LP55XX_COMMON config
> flag as opposed to the device selecting the LP55XX_COMMON flag.  The
> LP55XX_COMMON needs to be set in the defconfig.
>=20
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

=2E..but I don't think I'm right person to apply this.

Best regards,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8J4XgACgkQMOfwapXb+vJ8NgCgqkzLjqf4w2ECex1vblPUD9bp
+xMAoISlat0I/z8Fb53YeEI7/Ja4BKX7
=cSuE
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
