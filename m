Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E885C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3EF206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgBUWV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:21:56 -0500
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:55923 "EHLO
        13.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:21:56 -0500
X-Greylist: delayed 1497 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 17:21:56 EST
Received: from player691.ha.ovh.net (unknown [10.108.57.140])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 874EA26A280
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 22:56:57 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id 15BC4FBA4A9C;
        Fri, 21 Feb 2020 21:56:49 +0000 (UTC)
Date:   Fri, 21 Feb 2020 22:56:42 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove MPX from the x86 toc
Message-ID: <20200221225642.006495c9@heffalump.sk2.org>
In-Reply-To: <cc401ede-c94e-3688-5295-fd4d4a1806a4@intel.com>
References: <20200221205733.26351-1-steve@sk2.org>
        <cc401ede-c94e-3688-5295-fd4d4a1806a4@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ihKFjSlpszGJc1baMk1NeBZ"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 5920263185231203636
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrkeeggdduheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ihKFjSlpszGJc1baMk1NeBZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 13:03:46 -0800, Dave Hansen <dave.hansen@intel.com> wro=
te:
> On 2/21/20 12:57 PM, Stephen Kitt wrote:
> > MPX was removed in commit 45fc24e89b7c ("x86/mpx: remove MPX from
> > arch/x86"), this removes the corresponding entry in the x86 toc.
> >=20
> > This was suggested by a Sphinx warning. =20
>=20
> Pretty obvious miss on my part.  Thanks for finding and fixing it.
>=20
> It might be nice to add:
>=20
> Fixes: 45fc24e89b7cc ("x86/mpx: remove MPX from arch/x86")

Ah yes, it would be. What=E2=80=99s the etiquette here? Should I respin, or=
 can
whoever merges this (Jon?) add this to the commit message?

> In any case:
>=20
> Acked-by: Dave Hansen <dave.hansen@intel.com>

Thanks!

Stephen

--Sig_/ihKFjSlpszGJc1baMk1NeBZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5QUhoACgkQgNMC9Yht
g5x5mQ//a6qVDMQffPy2kF6FlGU9g/Vd/M0mU7P7XaZ1xl/COpAFzFcP1ZjK6HWl
oWA/HVAEHimBAxVI4T5+DiExj0H90sGu9bD8VoHVuZZHQSfHubHS1Ynw/4+HGkUl
3Mchb5DT1LoQqq7Hy49lbNbNeaWmC1VW3Z3LNq6rmdGsex78xJ0SWkd3eknj92n5
AQ7BKpSqt7dmN6+sEmhQ46fZ41JoXV1fZ8NRIHGoPKHmU9AUA6CCSzSA2JO/Hu4e
k1Ua6vACPMvs/fByE1ug6uBiWeWD+4CfwuX1AoJSedgipWc8v3najtjUt+u3rYDh
tALuPbQ1SFach6PLFB8mVHb8wjTwVTgnwE+T7utFu5OssKgwKMUOAgh0+zMPr0xV
mI740ofTm3pjV21pZHEygAuHK7wSCwWTwlh2rz9Lxu9HLBCmZD5tw2Tvj9ShsE4c
3fGRowjdL43d1X1zhBBJ8hI6E/JVpissSkfoD275ffbqtIyZ7Iw/+8/jSeLFyGBj
SWEIHji+7S68k1l0CAoNdQYppWS+TP1XZpWMU65mp1XEIhD1+5F/Nj1V0kwFN2sP
ETE2EIoI33le9mANu5JzY7lGs/SguILmky3nyw84Td2ekNvVMssEDV68LWlQwY/a
U2yi49NSGURrLR/Vo2EV9eUGSyLY3goQgrjpfFM8pqPrmem1gLI=
=VQbm
-----END PGP SIGNATURE-----

--Sig_/ihKFjSlpszGJc1baMk1NeBZ--
