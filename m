Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79195C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EACC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgHTVwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:52:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45420 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTVwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:52:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8ECAC1C0BB3; Thu, 20 Aug 2020 23:51:57 +0200 (CEST)
Date:   Thu, 20 Aug 2020 23:51:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: s3c24xx: Remove unused machine header include
Message-ID: <20200820215156.GB18063@amd>
References: <20200803091936.24984-1-krzk@kernel.org>
 <20200805215730.h6434lief5drnnu2@duo.ucw.cz>
 <20200820160816.GB21395@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20200820160816.GB21395@kozik-lap>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-08-20 18:08:16, Krzysztof Kozlowski wrote:
> On Wed, Aug 05, 2020 at 11:57:30PM +0200, Pavel Machek wrote:
> > On Mon 2020-08-03 11:19:36, Krzysztof Kozlowski wrote:
> > > The driver includes machine header for GPIO registers but actually do=
es
> > > not use them.
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >=20
> > Thanks, applied.
>=20
> Hi Pavel,
>=20
> I am confused because I had impression this will go into v5.9-rc1 but
> it's not there.  My further S3C cleanup depends on it [1] and now
> applying of the patches stuck in the middle.

It was too late for -rc1 at that moment. It is on my for-next branch
now.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8+8HwACgkQMOfwapXb+vLFNgCfSV6+xtBjjojcryBGj5H+qmEY
Nw8Ani6mjaqSwajJN0MdWMWPYz5VJOOs
=CAcR
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
