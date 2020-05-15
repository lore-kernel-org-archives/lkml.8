Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D392070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEOSlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:41:45 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:52621 "EHLO
        17.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgEOSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:41:44 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 14:41:43 EDT
Received: from player770.ha.ovh.net (unknown [10.110.115.182])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0798C210447
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 20:36:18 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player770.ha.ovh.net (Postfix) with ESMTPSA id 2FA3F127F3DB2;
        Fri, 15 May 2020 18:36:08 +0000 (UTC)
Date:   Fri, 15 May 2020 20:36:01 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl/kernel: document unaligned controls
Message-ID: <20200515203601.401a46a9@heffalump.sk2.org>
In-Reply-To: <20200515112735.67ee1148@lwn.net>
References: <20200515160406.8649-1-steve@sk2.org>
        <20200515112735.67ee1148@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/NfKkTxFuCefmYlDAsI+Q.k4"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 16222528811018177925
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejkeffvdfhjeekffdukeehvddtvdfhieehhedvheekteekudefjeffueeuvedvvdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NfKkTxFuCefmYlDAsI+Q.k4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2020 11:27:35 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 15 May 2020 18:04:06 +0200
> Stephen Kitt <steve@sk2.org> wrote:
>=20
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 9599c0f3eea8..17c38d899572 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -143,6 +143,7 @@ Architecture-agnostic documentation
> >     :maxdepth: 2
> > =20
> >     asm-annotations
> > +   unaligned-memory-access
> > =20
> >  Architecture-specific documentation
> >  -----------------------------------
> > diff --git a/Documentation/unaligned-memory-access.txt
> > b/Documentation/unaligned-memory-access.rst similarity index 100%
> > rename from Documentation/unaligned-memory-access.txt
> > rename to Documentation/unaligned-memory-access.rst =20
>=20
> Adding this to the toctree is great, but I'd just as soon not leave it in
> the top-level directory while we do that.  Since you're renaming it
> anyway, can you move it into process/?  It's not a perfect fit, but that's
> where that type of material has been going so far.

I can indeed. Should it still be listed in the main toctree, or in the
process toctree?

Regards,

Stephen

--Sig_/NfKkTxFuCefmYlDAsI+Q.k4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl6+4REACgkQgNMC9Yht
g5w1kRAAkBV4HprjDLUML9+vxm4/2RzhUEp6iN3jvH4NYDsGgHpdMoBUy8Ssa5EO
3V4KOrLyMcAulHn5/jBt/9fEoOJXHmeR8bR7J/PcMpXeqxMI0fnp7weZebb+xZhV
5aygqbhIG277DX9Pvnd6ke5nVYjoQVwoDAaOvBx7ZOriE6wSl5v3r0GBYKQ2JOcf
Jolc6dxkuoiSV+szebdbq8Ucgq1wASxsA5NYeasOl/f1GeH7Yafv7X8zbKQzfz3H
UYIktCvJFvDX30NGC1Qhx2L2Q45wToWYY7COgdT9pxPpsZJ9ibwh9VLgu59UAzVR
Hs09rN0sN5cTqYuxGKQl7K+f/y9ipWb2R8KxwSEeXLT8PNu9OdsUsVqjernz1JgR
ef49rLz2pBByn12m8n21PLPQuOsETKx+N9CN9wn3fyEfUV3UqKC63ADvOBtEN8lr
3CoXoQZgGkMXnfI1nBQPp+/1F4gVEPAz1aPgG0pTuFprO0uG/4iTBUQt7Au2ZwXn
tM6effqFDvdex2KEXpISHv/VqHyNXlM4Lc5ypPan5wKpV+smoDbZbkmTagqJ8NSd
/TY3jngXCy/qBbfzTo6j3jI3EKzYUVZsO0rtLYcJhmxOr4nS3Spdni9cVdeoBQEH
Bwbh8/F4Pq/uoyhXhRTarzU+EZtK1ebzyjjiJTfaRMGoAQI79qU=
=GqR/
-----END PGP SIGNATURE-----

--Sig_/NfKkTxFuCefmYlDAsI+Q.k4--
