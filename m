Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C114208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgEZJ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:28:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53354 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388274AbgEZJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:28:10 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 879FB1C02C5; Tue, 26 May 2020 11:28:08 +0200 (CEST)
Date:   Tue, 26 May 2020 11:28:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: leds: fix macro names for pca955x
Message-ID: <20200526092808.GC12838@amd>
References: <20200526092052.24172-1-f.suligoi@asem.it>
 <20200526092250.GB12838@amd>
 <b58a76bed46141a1a7952303ec466f66@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <b58a76bed46141a1a7952303ec466f66@asem.it>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-05-26 09:25:58, Flavio Suligoi wrote:
> > Subject: Re: [PATCH] dt-bindings: leds: fix macro names for pca955x
> >=20
> > On Tue 2020-05-26 11:20:52, Flavio Suligoi wrote:
> > > The documentation reports the wrong macro names
> > > related to the pca9532 instead of the pca955x
> > >
> > > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> >=20
> > Nothing obviously wrong, but why did you send it twice within half an
> > hour?
> > 								Pavel
>=20
> Sorry Pavel, with the first email I forgot to subscribe
> to the linux-leds mailing list! =F0=9F=98=8A

You really don't need to be subscribed on a list for trivial
cleanups... Normally people would reply-all, anyway.

BR,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7M4SgACgkQMOfwapXb+vLUzgCgkYMGaNZizROB8B8zSxTs76Iv
QMAAoL+RwE9cRcIEgqarPfQXWyaHuaXM
=+rFp
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
