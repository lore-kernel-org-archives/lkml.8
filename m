Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C6C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4122522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAWJJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:09:32 -0500
Received: from sauhun.de ([88.99.104.3]:50922 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWJJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:09:31 -0500
Received: from localhost (p54B335E9.dip0.t-ipconnect.de [84.179.53.233])
        by pokefinder.org (Postfix) with ESMTPSA id 6B3B42C00DA;
        Thu, 23 Jan 2020 10:09:29 +0100 (CET)
Date:   Thu, 23 Jan 2020 10:09:26 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: Tree for Jan 23 (PHY_EXYNOS5250_SATA in
 drivers/phy/samsung/Kconfig)
Message-ID: <20200123090926.GA1105@ninjato>
References: <20200123172101.2f31947c@canb.auug.org.au>
 <beb9e3a3-4824-6328-12f8-3d005f376374@infradead.org>
 <CAJKOXPcJ8V+bLDeJGg+emCaYHtDjuKa--yMk_HRCsB_DrwJGrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <CAJKOXPcJ8V+bLDeJGg+emCaYHtDjuKa--yMk_HRCsB_DrwJGrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 09:03:02AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 23 Jan 2020 at 08:00, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 1/22/20 10:21 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20200122:
> > >
> >
> > Is linux-next missing some of the COMPILE_TEST fixes?  I am still seeing
> > this warning (that I reported on Jan. 9-2020 and that Arnd has sent a
> > possible patch for):
> >
> >
> > on i386 or x86_64:
> >
> > WARNING: unmet direct dependencies detected for I2C_S3C2410
> >   Depends on [n]: I2C [=3Dy] && HAS_IOMEM [=3Dy] && HAVE_S3C2410_I2C [=
=3Dn]
> >   Selected by [y]:
> >   - PHY_EXYNOS5250_SATA [=3Dy] && (SOC_EXYNOS5250 || COMPILE_TEST [=3Dy=
]) && HAS_IOMEM [=3Dy] && OF [=3Dy]
>=20
> Hi Randy,
>=20
> The fix was posted quite some time ago - next to the patches
> (unfortunately) introducing the issue.  I posted v2, after review, on
> 7th of January:
> https://lore.kernel.org/linux-arm-kernel/1578384779-15487-1-git-send-emai=
l-krzk@kernel.org/T/#t
>=20
> Maybe I missed someone on Cc there?

Sorry, it slipped through the cracks that this patch is not only adding
build coverage but also fixing an issue. Will have a look now.


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4pYsIACgkQFA3kzBSg
Kbb8FhAAgy0Vzbe3MckPqBrhCQFqbTunAN6buihJEM+l/qVzFKvj7aLnPgIgewCW
6tUOQHrWnTVWrfYX8vY/Yccu6FemXducdnvH/IWbr1akz8MERU0C11eQ05lEzexg
tU6mC2rEGJ2FJ5uBBYddiAKdFee2OQ72Q70YhuYgETf4ry6cNqwomDKpXR21odGq
o1q5mstU1EOu8hrxqRCiz2zx3V2sSxveG2Z0Qcy6lOK3t17n2rdaQ4iuKu2Q+sPs
4qg0guucCWltEkCP46OYGYPKicxR5gIgXrjR6k3NI7qc99694y6F4p/JKLeoRAG8
ZlwtdMLVBoXCRUR07cpIfiFCMkn4V9JDfxI54Lu9fiSyA+txluHi1zsLYM0a+rf0
SIgHOx8tr6N2QTazUXAK0ulPt9hp0nEe2RR6QeWgjOcCg4q8PhwKnZG7t51XRw35
0jivXNPwFjBXO2EqJpLScxhICLP8vGuH4oQPGvQQ1crb53S8B9pAkWsjwRcu3zZw
0vbvRYm+dXjBpWEa6aHPgxc6j8uQmkvUVGpUy5gIz6+cSsiQr868r4g5utk95zQj
bWWqjEHlAJfkM96Qbsu6eDlbNen4UEnJfqSHDfG5dCpELg5w+cSKFVm90v0L3awG
X0rsKoWGiUYkzeqRXIzc2znEm9MbI9EiTKZMfrNZa280EFaAoJw=
=4jsM
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
