Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189E7C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C5820661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgBMTWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:22:05 -0500
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:45674 "EHLO
        15.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgBMTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:22:05 -0500
Received: from player690.ha.ovh.net (unknown [10.108.54.172])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 032B32228B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:22:02 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player690.ha.ovh.net (Postfix) with ESMTPSA id 445BEF3B053F;
        Thu, 13 Feb 2020 19:21:57 +0000 (UTC)
Date:   Thu, 13 Feb 2020 20:21:46 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] docs: pretty up sysctl/kernel.rst
Message-ID: <20200213202146.02ebc959@heffalump.sk2.org>
In-Reply-To: <20200213115238.1cce0534@lwn.net>
References: <20200213174701.3200366-1-steve@sk2.org>
        <20200213174701.3200366-2-steve@sk2.org>
        <20200213115238.1cce0534@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/vQ1A=b3F2OMM8HMAf7dEm4o"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 11662634188804672901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkeekrdduvddvrdduvdeirdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeltddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vQ1A=b3F2OMM8HMAf7dEm4o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Thanks for the quick review!

On Thu, 13 Feb 2020 11:52:38 -0700, Jonathan Corbet <corbet@lwn.net> wrote:
> On Thu, 13 Feb 2020 18:46:56 +0100
> Stephen Kitt <steve@sk2.org> wrote:
[...]
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst
> > b/Documentation/admin-guide/sysctl/kernel.rst index
> > def074807cee..1de8f0b199b1 100644 ---
> > a/Documentation/admin-guide/sysctl/kernel.rst +++
> > b/Documentation/admin-guide/sysctl/kernel.rst @@ -2,262 +2,188 @@
> >  Documentation for /proc/sys/kernel/
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -kernel version 2.2.10
> > +Kernel version 2.2.10 =20
>=20
> I honestly can't see the value of fixing up a line like that.  When I
> encounter a kernel document that references something like 2.2.10, I assu=
me
> it's full of dust and cobwebs.  I'd just take that out.

Indeed, and I do intend to update it to 5.5. I was planning on ultimately
removing the line above, and only leaving the line mentioning the kernel
version below.

> >  Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
> > =20
> > -Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
> > +Copyright (c) 2009,        Shen Feng <shen@cn.fujitsu.com>

Would it also be OK to move these to the end of the document?

> > -For general info and legal blurb, please look in index.rst.
> > +For general info and legal blurb, please look in :doc:`index`.
> > =20
> >  ----------------------------------------------------------------------=
--------
> > =20
> >  This file contains documentation for the sysctl files in
> > -/proc/sys/kernel/ and is valid for Linux kernel version 2.2.
> > +``/proc/sys/kernel/`` and is valid for Linux kernel version 2.2. =20
>=20
> This could be tweaked as well.  If, after your work, you think it's still
> not current, a warning to that effect should be put in instead.
>=20
> There's some other dated stuff below that can go as well.  Probably this =
is
> best done in a separate patch.

Agreed.

Regards,

Stephen

--Sig_/vQ1A=b3F2OMM8HMAf7dEm4o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5FocsACgkQgNMC9Yht
g5ynTQ/5AaBP7ZjO4Ut+Q0ZPcaXLmIxr1d0eX0SqoIZsHaLeRnHJL3IuC2hI5dfo
nNWdWeeIJbqtjKb5tF5hO5RKoX38B40bNg52iJjhgmrggzD8nEq4wjIYYnKGqyBt
NNeT4fghJx74uIeHbA84GdMwgeqhwwJQJZtxqjo9X6EY81yVz/Q57S9Tu1jlbon2
2gshtOcCY/oSLnx/z8s+u3mr0EDLLuAirlzfYoUBklOuTOe0hJK/rpKwUpB1mwBz
xOBleoylnqlQLsR9Sg9zv4mbr/gD/m9exIk2I4+I5gNMzhgvQRSSKs82c9UXUro/
rJJCNFHzQmNVp9vJVQ6dK6/ND6vp/ClgFT/8fN68DfLo5nhCKj0WlF0dHIbY1xBt
1kBHe9la05MwjIetbnZGOVFJYFnub1/kSdDCxKwVcwYkp7LD+La+bjQpCkeZN9Dv
SvxvHkljQ2YOhaAuSlXtixotGaKKHlIs0is7b9R7rw0HWkhNqqmPZcd3yncBgH/W
ZxFJEcX29ZS1VKzr9jx5jbny2mJ0VvPvrimKMvDwWcFFiFSwN3E3Tn2+EKkkL4GU
qnIJtrXvnSVz8Q/uMXHh56d+DDa4ENd/QVp4cX1VvMQwpssWYERJICZs8ouvOFXf
0PFOaFwvAuj3LCO9SP/2hBjxcpOSCWr8uvL7gDLHI0+NCUSkKEU=
=+K7e
-----END PGP SIGNATURE-----

--Sig_/vQ1A=b3F2OMM8HMAf7dEm4o--
