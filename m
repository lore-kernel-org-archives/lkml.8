Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8FC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C61206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgD0Jh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:37:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58528 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0Jh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:37:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 23E971C0244; Mon, 27 Apr 2020 11:37:26 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:37:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4] leds: ariel: Add driver for status LEDs on Dell Wyse
 3020
Message-ID: <20200427093725.GB20954@duo.ucw.cz>
References: <20200424220240.106055-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20200424220240.106055-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-04-25 00:02:40, Lubomir Rintel wrote:
> This adds support for controlling the LEDs attached to the Embedded
> Controller on a Dell Wyse 3020 "Ariel" board.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks, applied.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXqan1QAKCRAw5/Bqldv6
8hE2AJ9Wzkb6ej0KNyPfOpI1b3uHUl2E0wCfatrpKCjXosmLSqEnFKUY4ZXwEAg=
=4D97
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
