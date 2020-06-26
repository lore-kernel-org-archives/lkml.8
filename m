Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F0220656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgFZNlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:41:53 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38084 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:41:53 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B245E1C0BD2; Fri, 26 Jun 2020 15:41:51 +0200 (CEST)
Date:   Fri, 26 Jun 2020 15:41:51 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 023/206] PCI: aardvark: Dont blindly enable ASPM L0s
 and dont write to read-only register
Message-ID: <20200626134151.GA1635@duo.ucw.cz>
References: <20200623195316.864547658@linuxfoundation.org>
 <20200623195318.115434987@linuxfoundation.org>
 <20200626125350.GA29985@duo.ucw.cz>
 <20200626132322.j5wwyps7rj3c3eeg@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20200626132322.j5wwyps7rj3c3eeg@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > [ Upstream commit 90c6cb4a355e7befcb557d217d1d8b8bd5875a05 ]
> > >=20
> > > Trying to change Link Status register does not have any effect as this
> > > is a read-only register. Trying to overwrite bits for Negotiated Link
> > > Width does not make sense.
> >=20
> > I don't quite get it. This says register is read only...
> >=20
> > > In future proper change of link width can be done via Lane Count Sele=
ct
> > > bits in PCIe Control 0 register.
> > >=20
> > > Trying to unconditionally enable ASPM L0s via ASPM Control bits in Li=
nk
> > > Control register is wrong. There should be at least some detection if
> > > endpoint supports L0s as isn't mandatory.
> >=20
> > ....and this says it is wrong to set the bits as ASPM L0 is not
> > mandatory.
>=20
> Negotiated Link Width is in read-only 16bit Link Status register.
>=20
> ASPM Control bits are in read-write 16bit Link Control register.
>=20
>=20
> That single write was via 32bit memory access which tried to overwrite
> both registers (Link Status and Link Control) at the same time.

Aha, thanks for explanation and sorry for the noise.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvX7HwAKCRAw5/Bqldv6
8h+EAJwMOS9oWHgo+KLSnZBHuyScNjpXgwCfWp4VcJPjRDoZDeD+tn7b/DowPfY=
=g2sD
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
