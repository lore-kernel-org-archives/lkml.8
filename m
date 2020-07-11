Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8FC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 20:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287B20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 20:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGKUYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 16:24:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36066 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgGKUYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 16:24:23 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 371561C0BD2; Sat, 11 Jul 2020 22:24:20 +0200 (CEST)
Date:   Sat, 11 Jul 2020 22:24:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh@kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v29 13/16] leds: lp5523: Update the lp5523 code to add
 multicolor brightness function
Message-ID: <20200711202419.GA18347@duo.ucw.cz>
References: <20200622185919.2131-1-dmurphy@ti.com>
 <20200622185919.2131-14-dmurphy@ti.com>
 <20200711155749.GB22715@amd>
 <c9e20136-7226-2feb-b017-0a0742867f93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <c9e20136-7226-2feb-b017-0a0742867f93@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-07-11 19:19:22, Jacek Anaszewski wrote:
> On 7/11/20 5:57 PM, Pavel Machek wrote:
> > Hi!
> >=20
> > > Add the multicolor brightness call back to support the multicolor
> > > framework.  This call back allows setting  brightness on grouped chan=
nels
> >=20
> > Extra space before "brightness".
>=20
> And before "This".

That one is intentional, I believe.

https://www.independent.co.uk/life-style/gadgets-and-tech/news/one-space-or=
-two-spaces-after-a-full-stop-scientists-have-finally-found-the-answer-a833=
7646.html

We are using fixed width fonts, so typewriter rules still apply here.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXwof8wAKCRAw5/Bqldv6
8rAyAJ4hPt7IgHlyAtBRG2ArOmyZ8Mj29QCggA8ecmn08QOBVK7ziUsCW4evjuI=
=RSa+
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
