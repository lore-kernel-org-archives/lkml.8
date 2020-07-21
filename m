Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AEA2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgGUUyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:54:05 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43306 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:54:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D8B751C0BD8; Tue, 21 Jul 2020 22:54:02 +0200 (CEST)
Date:   Tue, 21 Jul 2020 22:54:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next 1/3] leds: trigger: add support for
 LED-private device triggers
Message-ID: <20200721205402.GB5966@amd>
References: <20200716171730.13227-1-marek.behun@nic.cz>
 <20200716171730.13227-2-marek.behun@nic.cz>
 <fe339634-bf0a-cbb0-cc46-223195482ea6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <fe339634-bf0a-cbb0-cc46-223195482ea6@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >This adds support for registering such triggers.
> >
> >This code is based on work by Pavel Machek <pavel@ucw.cz> and
> >Ond=C5=99ej Jirman <megous@megous.com>.
> >
> >Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>


Thanks, applied.
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8XVeoACgkQMOfwapXb+vKXrQCgjnDljx5ZoMZ+xfQx6DrplpFK
QFIAnRrghZDEVtGx90n2Ss2GRkgNP/SZ
=Vc2H
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
