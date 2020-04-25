Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE57AC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 21:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79DC2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 21:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDYVSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 17:18:20 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39208 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgDYVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 17:18:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0ED1B1C0239; Sat, 25 Apr 2020 23:18:19 +0200 (CEST)
Date:   Sat, 25 Apr 2020 23:18:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hadar Gat <Hadar.Gat@arm.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Gilad Ben Yossef <Gilad.BenYossef@arm.com>, nd <nd@arm.com>
Subject: Re: Arm CryptoCell driver -- default Y, even on machines where it is
 obviously useless
Message-ID: <20200425211818.GB27781@amd>
References: <20200418104343.GA5132@amd>
 <DB6PR0802MB2533670AFC1473E5C5EDAD28E9D60@DB6PR0802MB2533.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <DB6PR0802MB2533670AFC1473E5C5EDAD28E9D60@DB6PR0802MB2533.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-04-18 20:31:00, Hadar Gat wrote:
> Hi Pavel,
> I think you got it right..
> Indeed, Arm CryptoCell CCTRNG driver couldn't be used and obviously
useless if the Arm CryptoCell HW does not exist in the system.

Yup.. So.. can authors fix it somehow?

Thanks,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6kqRoACgkQMOfwapXb+vJLAgCdG0KA+o2J3U/kf46p5vEWpdNU
+ZEAn3OcpgAxsq47L0TdINfa2jLTMUIm
=o0BU
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
