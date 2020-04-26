Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45110C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A8A206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 19:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgDZTsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:48:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55360 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgDZTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 15:48:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7F9EB1C0244; Sun, 26 Apr 2020 21:48:41 +0200 (CEST)
Date:   Sun, 26 Apr 2020 21:48:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 03/17] leds: multicolor: Introduce a multicolor class
 definition
Message-ID: <20200426194840.GA17668@duo.ucw.cz>
References: <20200423155524.13971-1-dmurphy@ti.com>
 <20200423155524.13971-4-dmurphy@ti.com>
 <20200425202306.GA23926@amd>
 <a19ff014-32f1-eb18-ceb6-581503821fcc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <a19ff014-32f1-eb18-ceb6-581503821fcc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Do we need to include these stubs? I guess it is okay to have them,
> > OTOH I'd expect drivers to depend on MULTICOLOR being available...
>=20
> Single driver can support both monochrome and multicolor LED class,
> which is chosen basing on DT. In this regard having no-ops for LED mc
> class is justified since it is a superset of monochrome LED class.

Ok, makes sense.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXqXlmAAKCRAw5/Bqldv6
8nK4AJ4rhy+wGHqevOWd+5jK8x3+agAoHwCeNDL98RczQOuBPloBa5zNETAjeFM=
=vnHD
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
