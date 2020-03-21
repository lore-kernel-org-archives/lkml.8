Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01176C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64BE20776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCUPqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:46:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56376 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:46:51 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F2D0B1C032C; Sat, 21 Mar 2020 16:46:49 +0100 (CET)
Date:   Sat, 21 Mar 2020 16:46:49 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     jacek.anaszewski@gmail.com, dmurphy@ti.com, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: common: fix example for gpio-leds
Message-ID: <20200321154649.GH8386@duo.ucw.cz>
References: <20200313165700.15569-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline
In-Reply-To: <20200313165700.15569-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-03-13 17:57:00, Johan Jonker wrote:
> The preferred form for gpio-leds compatible subnodes is:
> ^led-[0-9a-f]$
> Fix example by changing led0 and led1 to led-0 and led-1.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnY26QAKCRAw5/Bqldv6
8oaTAJ45ChWWxAnpkZnlebtt8+PuNDzWDgCgocAj6aGt8TUO6Ll+Iisfx8tx+ak=
=TS8d
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
