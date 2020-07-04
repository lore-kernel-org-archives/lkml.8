Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26088C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5AE20885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGDMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:05:04 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43786 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgGDMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:05:03 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A3E961C0BD2; Sat,  4 Jul 2020 14:05:00 +0200 (CEST)
Date:   Sat, 4 Jul 2020 14:04:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH RFC] leds: Add support for per-LED device triggers
Message-ID: <20200704120459.GE16083@amd>
References: <20200702144712.1994685-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20200702144712.1994685-1-megous@megous.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support for registering per-LED device trigger.
>=20
> Names of private triggers need to be globally unique, but may clash
> with other private triggers. This is enforced during trigger

Globally unique name is going to be a problem, no? If you have two
keyboards with automatical backlight support...

Otherwise... yes, we need something like this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8AcGsACgkQMOfwapXb+vIj0wCdGDvEySafJEW9w5aIgTPyVt1K
Jj0AoJ86k8ag83wnxNicqBhZ8tDLGmyy
=p9pK
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
