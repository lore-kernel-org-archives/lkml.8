Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF21C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B382076C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDYUjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:39:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57712 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:39:17 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 070FA1C0239; Sat, 25 Apr 2020 22:39:16 +0200 (CEST)
Date:   Sat, 25 Apr 2020 22:39:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 14/17] leds: lp5521: Add multicolor framework
 multicolor brightness support
Message-ID: <20200425203915.GF23926@amd>
References: <20200423155524.13971-1-dmurphy@ti.com>
 <20200423155524.13971-15-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20200423155524.13971-15-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-04-23 10:55:21, Dan Murphy wrote:
> Add the multicolor brightness call back to support the multicolor
> framework. This function allows setting the brightness across
> grouped LED channels in a single call.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

ACK.
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6kn/MACgkQMOfwapXb+vIGEQCeOX2NbcxwgHcaJ2DBQd7POGqv
JPYAn0vypIuT7a4AynUVCrau+cfK8ucQ
=BkJ+
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
