Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B24C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A822070B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGLIHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:07:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49404 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgGLIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 04:06:59 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 002381C0BDD; Sun, 12 Jul 2020 10:06:56 +0200 (CEST)
Date:   Sun, 12 Jul 2020 10:06:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: trigger: gpio: Avoid warning on update of inverted
Message-ID: <20200712080656.GF8295@amd>
References: <d560d3eb-774d-8d9f-a8e3-09c371fc03eb@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <d560d3eb-774d-8d9f-a8e3-09c371fc03eb@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-06-13 09:15:06, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> If the GPIO has not been configured yet, writing to inverted will raise
> a kernel warning.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks, applied.
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8KxKAACgkQMOfwapXb+vL8nQCfV8g91PicAOhlEzC9f9TFMa8M
KxIAn2fuk/1BltVvoHuBmfN5ACyMFaEv
=Kus2
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
