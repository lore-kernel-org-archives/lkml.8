Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD790C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A848E206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHWVWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 17:22:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37292 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 17:22:47 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A701F1C0BC1; Sun, 23 Aug 2020 23:22:42 +0200 (CEST)
Date:   Sun, 23 Aug 2020 23:22:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Camera LED on Librem 5 was Re: [PATCH] backlight: add
 led-backlight driver
Message-ID: <20200823212242.incofjd73vemyazj@duo.ucw.cz>
References: <20200219191412.GA15905@amd>
 <20200220082956.GA3383@bogon.m.sigxcpu.org>
 <20200220234151.GB1544@amd>
 <20200814172320.GA740513@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gg7hbvnjpzpneq4x"
Content-Disposition: inline
In-Reply-To: <20200814172320.GA740513@bogon.m.sigxcpu.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gg7hbvnjpzpneq4x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > This patch adds a led-backlight driver (led_bl), which is similar to
> > > > pwm_bl except the driver uses a LED class driver to adjust the
> > > > brightness in the HW. Multiple LEDs can be used for a single backli=
ght.
> > >=20
> > > Tested-by: Guido G=FCnther <agx@sigxcpu.org>
> >=20
> > Thanks for testing!
> >=20
> > I noticed blog post about using Librem 5 torch. Unfortunately, it used
> > very strange/non-standard interface, first using LED as a GPIO to
> > enable LED controller, then direct i2c access. That is not acceptable
> > interface for mainline, and it would be better not to advertise such
> > code, as it will likely become broken in future.
>=20
> I agree, there's a driver for the lm3560 in media/ but how would one
> expose the torch part as a LED? It seems you hit something similar in
>=20
>     https://lkml.org/lkml/2018/5/6/30

(Actually, I might have been wrong in that comment).

> I also couldn't find an in tree driver that registers a flashlight
> as a v4l subdev. Did i miss that?

You should get interface similar to this:

https://wiki.postmarketos.org/wiki/PINE64_PinePhone_(pine64-pinephone)

and the driver to enable that should already be in the mainline:

drivers/leds/leds-sgm3140.c

Best regards and good luck,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gg7hbvnjpzpneq4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0LeIgAKCRAw5/Bqldv6
8mOkAJ9i0ElcQe6nlwYWmbWd59+TzDAYLACfcpiN96u+qQNzuooxieY/IFWL4cc=
=io6p
-----END PGP SIGNATURE-----

--gg7hbvnjpzpneq4x--
