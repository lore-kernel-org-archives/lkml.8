Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C62C3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C86124656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSRvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:51:55 -0500
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:32778 "EHLO
        17.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:51:53 -0500
Received: from player732.ha.ovh.net (unknown [10.108.54.108])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8388D26DB78
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:25:44 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id B1DE9F6E8590;
        Wed, 19 Feb 2020 15:25:30 +0000 (UTC)
Date:   Wed, 19 Feb 2020 16:25:27 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] docs: add a script to check sysctl docs
Message-ID: <20200219162527.61f99f45@heffalump.sk2.org>
In-Reply-To: <20200219034416.4d82dc16@lwn.net>
References: <20200218125923.685-1-steve@sk2.org>
        <20200218125923.685-8-steve@sk2.org>
        <20200219034416.4d82dc16@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/8aiAfeT7zL00iNcRndrs1tp"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 6014557304425893253
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrkedtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuffhomhgrihhnpehsphgugidrohhrghenucfkpheptddrtddrtddrtddpkeekrdduvddvrdduvdeirdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8aiAfeT7zL00iNcRndrs1tp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Wed, 19 Feb 2020 03:44:16 -0700, Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 18 Feb 2020 13:59:22 +0100
> Stephen Kitt <steve@sk2.org> wrote:
>=20
> > This script allows sysctl documentation to be checked against the
> > kernel source code, to identify missing or obsolete entries. Running
> > it against 5.5 shows for example that sysctl/kernel.rst has two
> > obsolete entries and is missing 52 entries.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> So I like the idea here, but I have a couple of nits and one larger
> thought...
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst |   3 +
> >  scripts/check-sysctl-docs                   | 181 ++++++++++++++++++++
> >  2 files changed, 184 insertions(+)
> >  create mode 100755 scripts/check-sysctl-docs
> >=20
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst
> > b/Documentation/admin-guide/sysctl/kernel.rst index
> > a67c218c4066..3d21e076aea4 100644 ---
> > a/Documentation/admin-guide/sysctl/kernel.rst +++
> > b/Documentation/admin-guide/sysctl/kernel.rst @@ -2,6 +2,9 @@
> >  Documentation for /proc/sys/kernel/
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > +.. See scripts/check-sysctl-docs to keep this up to date
> > +
> > +
> >  Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
> > =20
> >  Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
> > diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
> > new file mode 100755
> > index 000000000000..b3b47c188a2d
> > --- /dev/null
> > +++ b/scripts/check-sysctl-docs
> > @@ -0,0 +1,181 @@
> > +#!/usr/bin/gawk -f
> > +# SPDX-License-Identifier: GPL-2.0-only =20
>=20
> By Documentation/process/license-rules.rst, that should be "GPL-2.0"; the
> absence of a "+" means "only".

Ah, thanks, I hadn=E2=80=99t noticed that. I=E2=80=99m used to the SPDX ide=
ntifiers listed on
the LF website, https://spdx.org/licenses/GPL-2.0-only.html in this case.
(I=E2=80=99m not alone apparently, see =E2=80=9Cgit grep GPL-2.0-only=E2=80=
=9D...)

> > +# Script to check sysctl documentation against source files
> > +#
> > +# Copyright =C2=A9 2020 Stephen Kitt =20
>=20
> Some people object to the introduction of unnecessary non-ASCII text, and
> this one would count; can we take the =C2=A9 symbol out?

Yes, of course!

> Now for the bigger thought...  I wonder if what we really want to do is
> to adopt some form of the kerneldoc format for sysctl knobs?  That would
> allow the documentation to be placed in the source right next to the
> table entries, which might, in the optimistic world I inhabit, help
> developers to keep them up to date.
>=20
> That, of course, is more work than what you've done; until somebody feels
> inspired to do that work I'll happily accept a tweaked version of this
> script.  But one can always dream...

Right, that occurred to me too. In fact, it seems to me that in an ideal
world, we wouldn=E2=80=99t even have the big tables of sysctl entries, sinc=
e that=E2=80=99s
another level of indirection =E2=80=94 in most cases, the relevant informat=
ion is
available where the sysctl variables are declared, not where they=E2=80=99re
registered in the tables. This leads to disconnects between the reality of
the code and sysctl table entries, for example ieee_emulation_warnings which
is (for now, I=E2=80=99ve submitted a patch which has been accepted) still =
present in
sysctl.c but isn=E2=80=99t used.

I=E2=80=99ll fix up the script and re-submit it.

Regards,

Stephen

--Sig_/8aiAfeT7zL00iNcRndrs1tp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5NU2cACgkQgNMC9Yht
g5z9fg//c1jrqDfffwelVx3N+CXd/LBNiLqg1IumxfFYP1rzs0OAAYmaNz0zhPXO
0uSjU8ajZULVBJQrmAYQh//sIz9g6O9K7R4UvpGm47rLAVg0ZTFEC5ieiUgl5EMs
5IHtNBs1EvJ7dMz7UW/QjCUeeKfDpvmOK+aEtMMsULB8kzdDiR+XAVKjwCvG+tcp
HQN3BBYlEiyyAq+TzdErYYbp67kGY+Fktnwz53JodyQSMBlC5vsvdA2I3PpBFaNh
kxb+3spvwqRr3Vit8wM55Cyy/b/8sE5bPtDkrNpGWrca47xJIUshF8zpQO5+IIXz
2HBV1SjP7Y9DjUAm1ayq7twMHDj2G9NgYrQRj+LGgy0x8bVCQEwblDjkoGdEoOCk
NisjujY/HFGLtbR+oyEi+yaCVTgY32mA5gkhU51wpDLOkvaQtivmqahVxasXJFDE
wfaYjkV618MJNrsAyu0FJ6XxSrwcVoqBaqiXqpk9ju15tdXJrqflJTzjQLBgwXIV
LnZerphOvcpdnPiYBIFrb/DfLlGfSMGUD63kOS9zT6Aeideh0/eGP+yQkNkExZL5
J41/6R6P7gBdygUbz95FtdetWTVSzhKQekjzyM1W1TVs4Fjlnz4bkyNEnPwK9d5Q
IA26Zu0qDAWwyoEzaUVshm60dX8HwBVLe48evT6FrRyUuj8t+y0=
=89jA
-----END PGP SIGNATURE-----

--Sig_/8aiAfeT7zL00iNcRndrs1tp--
