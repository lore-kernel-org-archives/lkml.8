Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222EC35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C3A20801
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAYMuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 07:50:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46370 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAYMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 07:50:15 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3536E1C213B; Sat, 25 Jan 2020 13:50:13 +0100 (CET)
Date:   Sat, 25 Jan 2020 13:50:12 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 151/639] arm64: dts: allwinner: h6: Move GIC device
 node fix base address ordering
Message-ID: <20200125125012.GC14064@duo.ucw.cz>
References: <20200124093047.008739095@linuxfoundation.org>
 <20200124093106.145118596@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20200124093106.145118596@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-01-24 10:25:21, Greg Kroah-Hartman wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> [ Upstream commit 52d9bcb3d0de3fa1e07aff3800f857836d30410d ]
>=20
> The GIC device node was placed out of order in the initial device tree
> submission. Move it so the nodes are correctly sorted by base address
> again.

I don't think this and 146/ is suitable -stable material.

It fixes style problem, not a real bug.

> Fixes: e54be32d0273 ("arm64: allwinner: h6: add the basical
>  Allwinner H6 DTSI file")

Maybe everything with Fixes: tag should not automatically go to
-stable? Not all such patches fix serious bugs.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXiw5hAAKCRAw5/Bqldv6
8s3oAJ9fJidl9vHIsTYhzlq/A2sYYICEgQCgpK7Ks4pO/73BHydoWOS5z30bSCk=
=kDUA
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
