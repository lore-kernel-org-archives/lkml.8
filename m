Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9DBC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 12:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F3206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 12:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgCHMLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 08:11:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47214 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCHMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 08:11:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DAAE71C0319; Sun,  8 Mar 2020 13:11:32 +0100 (CET)
Date:   Sun, 8 Mar 2020 13:11:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-leds@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] leds: add sgm3140 driver
Message-ID: <20200308121132.GB29321@duo.ucw.cz>
References: <20200227185015.212479-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20200227185015.212479-1-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add a driver for the SGMICRO SGM3140 Buck/Boost Charge Pump LED driver.
>=20
> This device is controller by two GPIO lines, one for enabling the LED
> and the second one for switching between torch and flash mode.
>=20
> The device will automatically switch to torch mode after being in flash
> mode for about 250-300ms, so after that time the driver will turn the
> LED off again automatically.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Cc: ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>, Jac=
ek Anaszewski

Strange entry in cc list...?

And btw if you get the dt parts, and simple LED-only driver w/o the
strobe functinality, you may be able to get it merged rather quickly.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmTg9AAKCRAw5/Bqldv6
8g6KAJ9JbTdbr+eAV0TMFZWrlbul+c9tngCePjE6ZehJL50yPl93bS1ASsIXq2M=
=9dcf
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
