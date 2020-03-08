Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96689C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F132072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCHV6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:58:25 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:40601 "EHLO
        1.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgCHV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:58:25 -0400
Received: from player168.ha.ovh.net (unknown [10.110.208.147])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 671E7930CE
        for <linux-kernel@vger.kernel.org>; Sun,  8 Mar 2020 22:58:21 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id C05171027E84A;
        Sun,  8 Mar 2020 21:58:13 +0000 (UTC)
Date:   Sun, 8 Mar 2020 22:58:12 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document genhd capability flags
Message-ID: <20200308225812.3a24dd7a@heffalump.sk2.org>
In-Reply-To: <20200306172309.GD25710@bombadil.infradead.org>
References: <20200306171621.24134-1-steve@sk2.org>
        <20200306172309.GD25710@bombadil.infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/cy/n56Tsfr/.sxOIxO6BLlO"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 7673289344117198149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudduiedgudehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cy/n56Tsfr/.sxOIxO6BLlO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[Re-send, apparently this didn=E2=80=99t make it out of my computer.]

On Fri, 6 Mar 2020 09:23:09 -0800, Matthew Wilcox <willy@infradead.org> wro=
te:
> On Fri, Mar 06, 2020 at 06:16:21PM +0100, Stephen Kitt wrote:
> > The kernel documentation includes a brief section about genhd
> > capabilities, but it turns out that the only documented
> > capability (GENHD_FL_MEDIA_CHANGE_NOTIFY) isn't used any more.
> >=20
> > This patch removes that flag, and documents the rest, based on my
> > understanding of the current uses of these flags in the kernel. The
> > documentation is kept in the header file, alongside the declarations,
> > in the hope that it will be kept up-to-date in future; the kernel
> > documentation is changed to include the documentation generated from
> > the header file.
> >=20
> > Because the ultimate goal is to provide some end-user
> > documentation (or end-administrator documentation), the comments are
> > perhaps more user-oriented than might be expected. =20
>=20
> Thank you!  I have some suggestions for further improvement ...

Thanks for the quick review and the suggestions!

> > -capability is a hex word indicating which capabilities a specific disk
> > -supports.  For more information on bits not listed here, see
> > -include/linux/genhd.h
> > +``capability`` is a hex word indicating which capabilities a specific
> > +disk supports: =20
>=20
> ``capability`` is a bitfield, printed in hexadecimal, indicating ...
>=20
> > + * ``GENHD_FL_UP`` (16): indicates that the block device is "up", with
> > + * a similar meaning to network interfaces. =20
>=20
> Since we're printing it in hex, the value here should be displayed in hex
> to help the end-user.  So ``GENHD_FL_UP`` (0x10), etc.
>=20
> >  #define GENHD_FL_REMOVABLE			1
> > -/* 2 is unused */
> > -#define GENHD_FL_MEDIA_CHANGE_NOTIFY		4
> > +/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
> > +/* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
> >  #define GENHD_FL_CD				8
> >  #define GENHD_FL_UP				16
> >  #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
> > -#define GENHD_FL_EXT_DEVT			64 /* allow extended
> > devt */ +#define GENHD_FL_EXT_DEVT			64
> >  #define GENHD_FL_NATIVE_CAPACITY		128
> >  #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	256
> >  #define GENHD_FL_NO_PART_SCAN			512 =20
>=20
> Maybe these should also be converted to hex to match?

Yes, these are all excellent ideas, I=E2=80=99ll follow up with a v2 (also =
updating
the terminology in capability.rst since this is about block devices, not on=
ly
disks).

Regards,

Stephen

--Sig_/cy/n56Tsfr/.sxOIxO6BLlO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5lanQACgkQgNMC9Yht
g5xuaw/+M+raHBIWe0XUoHlQ35Q3ziAPsnUOP1Vho01HKhV2gpUgwiNObMyx5kcg
VibJ5OODzM80qkkG6ts59xJYhYhu/6CzNGdT3bRi8kR7BypoW5X4HBuAmumTw9r4
go0DOYWwqdDyDqWQE0WrZPIjfTk/R665Q7Opudo/ZymIVgaNj/ksNwX5owoL5HQf
ufiJk52C82wuTJDxPC9UMHAIDXloX27GBvgReWgkRtt7EJ6K/KXxKfOtHy585eJ7
KTr2D0XehuPiGjt1Ad5X4kSlb0k1Llb1+u91MEwcFR6l0G+LvnSfmmD3ImNobGZk
zUv51JZZi2UntjuPMO5s7un1bfSBMlIkCLQTixaSx1kyG2pgYYbkETiCpKTNFkOi
kqG7/7GT7a4qin2y52PxjJRNungbB9ylICZ7Ekm6WfSGmWB5NJQ5g7oAYwMhjgri
8ttPq5NOtqGjOVsSnoBmbPTgTMGR9tQLU3pQC++yZWpMpOqSsn6RTfWtS8UhvAtL
9jNqy3cVqCE6EsYoGCPUGCtENy5YLQC58G7//U++w0CpCaT2mjlhJi/Azq5iDvyt
W3c6IrqGdJ1jz7pwj/g7QqYh6zq8e5iin9ViIUBJM9l2TLGbZ5CW7CnbL+ftt/QK
v0GpWxhAa0qwBFABvO+rNJplGdhEOFxEiXiF3s2gtCDsVuPZv7E=
=Lr7a
-----END PGP SIGNATURE-----

--Sig_/cy/n56Tsfr/.sxOIxO6BLlO--
