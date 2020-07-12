Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A20C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D120720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgGLI0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:26:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50420 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 04:26:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8F3BB1C0BD2; Sun, 12 Jul 2020 10:26:40 +0200 (CEST)
Date:   Sun, 12 Jul 2020 10:26:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] leds: ns2: Use struct_size() in devm_kzalloc()
Message-ID: <20200712082639.GA12285@amd>
References: <20200617230757.GA21324@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20200617230757.GA21324@embeddedor>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-06-17 18:07:57, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> function sizeof_ns2_led_priv().
>=20
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, applied.
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8KyT8ACgkQMOfwapXb+vKXxwCgt4kLekRi6hdGqTLkCZwJlnJn
JVIAnAgYd1BInXZVgYW+tgJ2ycu5xSZg
=uuy2
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
