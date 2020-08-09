Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C85DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DAB206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHIRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:37:14 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:44347 "EHLO
        5.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 13:37:13 -0400
Received: from player786.ha.ovh.net (unknown [10.110.208.245])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 731ED147CEB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 19:18:38 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player786.ha.ovh.net (Postfix) with ESMTPSA id E71D4154A57BB;
        Sun,  9 Aug 2020 17:18:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005786e44e3-536c-4e5d-8a3b-a89e4d0b380b,
                    949AEE3423C323647D875781C307A391B5D7792E) smtp.auth=steve@sk2.org
Date:   Sun, 9 Aug 2020 19:18:27 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/arm: use simple i2c probe function
Message-ID: <20200809191819.3eb1a26e@heffalump.sk2.org>
In-Reply-To: <20200809083858.GA7517@kozik-lap>
References: <20200807153100.384845-1-steve@sk2.org>
        <20200809083858.GA7517@kozik-lap>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/r8FuAjjB0+jvxp._ZcfcNev"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3453697967987576217
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkeeigddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejkeffvdfhjeekffdukeehvddtvdfhieehhedvheekteekudefjeffueeuvedvvdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r8FuAjjB0+jvxp._ZcfcNev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 9 Aug 2020 10:38:58 +0200, Krzysztof Kozlowski <krzk@kernel.org>
wrote:
> On Fri, Aug 07, 2020 at 05:31:00PM +0200, Stephen Kitt wrote:
> > The i2c probe functions here don't use the id information provided in
> > their second argument, so the single-parameter i2c probe function
> > ("probe_new") can be used instead.
> >=20
> > This avoids scanning the identifier tables during probes.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> >  arch/arm/mach-davinci/board-dm644x-evm.c     |  5 ++---
> >  arch/arm/mach-davinci/board-dm646x-evm.c     | 10 ++++------
> >  arch/arm/mach-s3c64xx/mach-crag6410-module.c |  5 ++---
> >  3 files changed, 8 insertions(+), 12 deletions(-)
>=20
> You need to split it per sub architecture maintainers.  The subject
> prefix is then for example: "ARM: s3c64xx: ".

Thanks, will do!

Regards,

Stephen

--Sig_/r8FuAjjB0+jvxp._ZcfcNev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl8wL+MACgkQgNMC9Yht
g5ynpQ/+JCiOZ6kn0uvccrDB1MG/W3gaD6/G1SZiDlxSo9amrPhH7XkYfPGuNaLe
PKtvkx6o13jAf7L5vdWv41PtqbKYaZqNvh2Nd4rqTsm/LQEUezL4KsruqglS8nGW
Z4avzwQVc58MqI1IK9EbdxWJgioSMhTj1/HpvXCyLfVL8jXvT7Ap6IEgw3BOL635
3B7oFpAh7D6eLb14AakA3nCtvpD6Bcm7UITKCdMCCoW9J+dTqAae56Fw00iAkoJy
1iQKtRA5eZ+UxM1f6dcDY118jjbpFQjFb3Aed6RNu6fH/4l1UK70opcdZdNIcRCw
QTG1t23czA7BWC6h37lEOUIbMLwwjoeZ+rAWRH2Q5Ennr+5UttUpBlbIOE5Lx7d5
blEy5iSwqTHOEYl0zPHYgMeXSEJZp+kar4jYZsTDEKoX7YaY4fU42jMfGHHzcUNY
mK33nPBAhfbd+dq/+zRW9xYPmw7PXDJGOOTFG+Wzi0ux6w4K0NqavDOGkuikQQJw
ebRVxkmReY7XG9G4TL4fjoabrVIIBWkrraG2peidB0N+hF2lqgdKqOCtiwrjNWr8
Fg89RuAkep6ZorVIr2IRena2b9UtFcUkhnwTN7DpzAKQG37WmaYUjvQ5jAMPKLOK
8RRVz55ygKMf48p+pZ2kKEQvnQoeqxftWKC6rtAthn3alIKBGGI=
=XZqW
-----END PGP SIGNATURE-----

--Sig_/r8FuAjjB0+jvxp._ZcfcNev--
