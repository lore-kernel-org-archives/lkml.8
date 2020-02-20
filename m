Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF2C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F68E207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgBTXlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:41:53 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51358 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbgBTXlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:41:52 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5FD9B1C0141; Fri, 21 Feb 2020 00:41:51 +0100 (CET)
Date:   Fri, 21 Feb 2020 00:41:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Camera LED on Librem 5 was Re: [PATCH] backlight: add led-backlight
 driver
Message-ID: <20200220234151.GB1544@amd>
References: <20200219191412.GA15905@amd>
 <20200220082956.GA3383@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20200220082956.GA3383@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch adds a led-backlight driver (led_bl), which is similar to
> > pwm_bl except the driver uses a LED class driver to adjust the
> > brightness in the HW. Multiple LEDs can be used for a single backlight.
>=20
> Tested-by: Guido G=FCnther <agx@sigxcpu.org>

Thanks for testing!

I noticed blog post about using Librem 5 torch. Unfortunately, it used
very strange/non-standard interface, first using LED as a GPIO to
enable LED controller, then direct i2c access. That is not acceptable
interface for mainline, and it would be better not to advertise such
code, as it will likely become broken in future.

https://puri.sm/posts/easy-librem-5-app-development-flashlight/

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAl5PGT8ACgkQMOfwapXb+vKXXACgieHtSmG/OaQuYS/IMFe6SvbQ
kJgAmL4xWRvXq6Hjsr2Tnlx3h5AuUig=
=Poch
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
