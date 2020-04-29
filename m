Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC67CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE832083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgD2VeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:34:20 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:59286 "EHLO
        7.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2VeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:34:18 -0400
X-Greylist: delayed 2228 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 17:34:18 EDT
Received: from player787.ha.ovh.net (unknown [10.110.115.149])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id B50BD139AF8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:57:08 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player787.ha.ovh.net (Postfix) with ESMTPSA id C950B12118E6D;
        Wed, 29 Apr 2020 20:56:57 +0000 (UTC)
Date:   Wed, 29 Apr 2020 22:56:56 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] docs: sysctl/kernel: document ftrace entries
Message-ID: <20200429225656.43aed6f9@heffalump.sk2.org>
In-Reply-To: <20200428124133.0fbaf7c5@lwn.net>
References: <20200423183651.15365-1-steve@sk2.org>
        <20200423183651.15365-2-steve@sk2.org>
        <20200428124133.0fbaf7c5@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/FW_R1QjDCvmBdAlezO_Ci08"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 16871610105530371461
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeevledvueefvdeivefftdeugeekveethefftdffteelheejkeejjeduffeiudetkeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FW_R1QjDCvmBdAlezO_Ci08
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2020 12:41:33 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> On Thu, 23 Apr 2020 20:36:50 +0200
> Stephen Kitt <steve@sk2.org> wrote:
> > Based on the ftrace documentation, the tp_printk boot parameter
> > documentation, and the implementation in kernel/trace/trace.c.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> This one could benefit from an ack from Steve (CC'd).  Also one other
> little nit below:

Thanks (and thanks for the review Steve). I=E2=80=99ll follow up with v2 sh=
ortly,
fixing the spelling and grammar here:

> > +the console.  This is very useful for capturing traces that lead to
> > +crashes and outputing it to a serial console.

in addition to this:

> > +will stop tracepoints from being sent to printk(), and
> > +
> > +:: =20
>=20
> I would just make that ", and::" and avoid the separate line.

Regards,

Stephen

--Sig_/FW_R1QjDCvmBdAlezO_Ci08
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl6p6hgACgkQgNMC9Yht
g5z7Mw/9HsTuQXsity9hRkNzrwr4hTozShBtlUDgcUSictJoPGuhOGChizQsCQUU
6yOvLYAEEqj9ywVInKXWG30lne3dQGdVTSlUj3rRLBt96aVbr0JfzksS8Ea6aFkU
0YHZrdOBcdScpAy8W6Fx3bwEdue4Tv1/vihE6nS10SAIq6YaJOPMmTC9oNCPmxx3
3url0e6O753LM8PNoPngonA5SA6KBLfDEuTTPrmokE6Pte6nJbo0fkL0naCOJ/t7
yD21WuNtvc2Jep62foDoyFkTzIleek2Vl+ALxqNhCXAJ/bNktrl87gBU1UMaRkXk
AP6MD3WRBwQ8VQaqMB7Af91vH7zVyVbbAyZ7bJ3+XBy2A5n34x7CdMreTV8EOH7j
kLidI9NrHJCJgc3W08TF1ZF6MW79YmOT+knyvDFmtk/a7RgBTPeqLu/3qAvxz5xN
Jl5lXwkxcDAshHbpGSPcfiOXATC6IjdaWe93jiIZy47YEcNgNKVDwef8/wEXWSyq
SpVSCDj1fAFV78CAhUdKjlP7WqKEv1kqHeWEJoz4LFRU6OP+Efpj7Sb/ftzYFQ1H
cKE0DUGK0bxFRHqXR2r68tNbHlzUq6jNxiRAuCueTYZSVR1fjKp+TsVuSuJ6+nKX
GLrXsyTPhD+1I6NTVXkJJi6Zw1PKP68UFONxGKYAxDF4LsTmegY=
=JIW3
-----END PGP SIGNATURE-----

--Sig_/FW_R1QjDCvmBdAlezO_Ci08--
