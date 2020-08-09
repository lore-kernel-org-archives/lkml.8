Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B826FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9716B206D8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHIWdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 18:33:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55022 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 18:33:06 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2D58E1C0BD7; Mon, 10 Aug 2020 00:33:03 +0200 (CEST)
Date:   Mon, 10 Aug 2020 00:33:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     trix@redhat.com
Cc:     sean.wang@mediatek.com, dmurphy@ti.com, matthias.bgg@gmail.com,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: mt6323: move period calculation
Message-ID: <20200809223302.qdsv2ghuju5jrhvw@duo.ucw.cz>
References: <20200809163221.32413-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6pmfl3utzqfdvq76"
Content-Disposition: inline
In-Reply-To: <20200809163221.32413-1-trix@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6pmfl3utzqfdvq76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Setting the delay_on/off means period needs to be recalculated
> anyway.  So move the period statements after this check.
>=20
> Fixes: 216ec6cc4c19 ("leds: Add LED support for MT6323 PMIC")

Makes sense, thanks, applied.

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6pmfl3utzqfdvq76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXzB5ngAKCRAw5/Bqldv6
8uf3AKC8otj4qmrAy7nXmwkFnaclBh7UEQCgl72i78Bq13jVd6zxnZFWIzOE6vc=
=/+iR
-----END PGP SIGNATURE-----

--6pmfl3utzqfdvq76--
