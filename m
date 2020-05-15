Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4972AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9F420643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEOVge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:36:34 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:37851 "EHLO
        9.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgEOVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:36:33 -0400
Received: from player730.ha.ovh.net (unknown [10.110.208.124])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 324A58D1ED
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 23:17:22 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player730.ha.ovh.net (Postfix) with ESMTPSA id 6DB3312444F3A;
        Fri, 15 May 2020 21:17:17 +0000 (UTC)
Date:   Fri, 15 May 2020 23:17:01 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl/kernel: document unaligned controls
Message-ID: <20200515231701.7dc1e6b2@heffalump.sk2.org>
In-Reply-To: <20200515203601.401a46a9@heffalump.sk2.org>
References: <20200515160406.8649-1-steve@sk2.org>
        <20200515112735.67ee1148@lwn.net>
        <20200515203601.401a46a9@heffalump.sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/9ft7adtb_zW.icq2dphbXhV"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 495958913122520453
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdduheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeevledvueefvdeivefftdeugeekveethefftdffteelheejkeejjeduffeiudetkeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9ft7adtb_zW.icq2dphbXhV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2020 20:36:01 +0200, Stephen Kitt <steve@sk2.org> wrote:

> On Fri, 15 May 2020 11:27:35 -0600, Jonathan Corbet <corbet@lwn.net> wrot=
e:
> > On Fri, 15 May 2020 18:04:06 +0200
> > Stephen Kitt <steve@sk2.org> wrote:
> >  =20
> > > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > > index 9599c0f3eea8..17c38d899572 100644
> > > --- a/Documentation/index.rst
> > > +++ b/Documentation/index.rst
> > > @@ -143,6 +143,7 @@ Architecture-agnostic documentation
> > >     :maxdepth: 2
> > > =20
> > >     asm-annotations
> > > +   unaligned-memory-access
> > > =20
> > >  Architecture-specific documentation
> > >  -----------------------------------
> > > diff --git a/Documentation/unaligned-memory-access.txt
> > > b/Documentation/unaligned-memory-access.rst similarity index 100%
> > > rename from Documentation/unaligned-memory-access.txt
> > > rename to Documentation/unaligned-memory-access.rst   =20
> >=20
> > Adding this to the toctree is great, but I'd just as soon not leave it =
in
> > the top-level directory while we do that.  Since you're renaming it
> > anyway, can you move it into process/?  It's not a perfect fit, but tha=
t's
> > where that type of material has been going so far. =20
>=20
> I can indeed. Should it still be listed in the main toctree, or in the
> process toctree?

Never mind, I found the answer, =E2=80=9Csome overall technical guides that=
 have been
put here for now for lack of a better place=E2=80=9D ;-).

Regards,

Stephen

--Sig_/9ft7adtb_zW.icq2dphbXhV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl6/Bs0ACgkQgNMC9Yht
g5ywhw/7Bu2YpW1FvW89RSQHRuV7ZdECufLxUkKFP7tUo+q0ocnt9pY4qiQfJCuu
nZCJUtCjNX9eietABq9szmiOg5wXuJCDSgcJ/WGEcZ+FSqXsMIod8/rnnycOcdAr
7ofwrWGUNkN51sDYowtNK2+/kaRj1xDIwKmciR1qI3P6EX2owLf7G6mrzm7V3QBi
lfrEZKOjzfurMGosMDH27oomJKSZXzrGiR8ozJcX23jiAIw2R6Vt+wlBG6oyeM6x
NKHibprJFNU6eXlQRHaxjo1Q/eSYv2y4KmkISvy6J26cJuW3RgxJWbVAUq7V4dDE
D1t7f09GWYPBv5iZewZvJAUkE+UhwwPUvWZ0OvWT/3rg13ddsaI4dB9ywQdN0Iy4
hs9izvpZlZEj/jUxumm99F3Y2gOac0xwVUSg45qwuy/RvK81ZNTL9f84UA2T37pp
fN2YY6KXQHsKwda4WqeDS7GstgmU1GXWlE2iR1d/MRwo0TsrP4FuiV/g/HGmUeed
Pg0jftUKnkjdZ52Ch2TNmSYhyBqDib84y/nhuDvoUyG5TJxIE8bjWF4xg7iiXFhq
6PAbgg5pYuhgqWaJECiHd+GGYf7SvnyYP8LswYoYdhXdn3W5Rh+4q0iaFiNA3P+1
mFDzvfgGShFzjK2Sntg6+a0l9c2Sf6QNBi4krTRooB44gM50JZw=
=7I5b
-----END PGP SIGNATURE-----

--Sig_/9ft7adtb_zW.icq2dphbXhV--
