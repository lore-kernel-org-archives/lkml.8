Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE319C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A0B206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgHDIc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:32:57 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52832 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHDIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:32:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 82EB01C0BDD; Tue,  4 Aug 2020 10:32:51 +0200 (CEST)
Date:   Tue, 4 Aug 2020 10:32:36 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Terrell <nickrterrell@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Message-ID: <20200804083236.zjkmfer37z5rn3r4@duo.ucw.cz>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="unkgxepgdpqe5p3t"
Content-Disposition: inline
In-Reply-To: <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unkgxepgdpqe5p3t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I've measured the kernel decompression speed using QEMU before and aft=
er
> >> this patch for the x86_64 and i386 architectures. The speed-up is about
> >> 10x as shown below.
> >>=20
> >> Code	Arch	Kernel Size	Time	Speed
> >> v5.8	x86_64	11504832 B	148 ms	 79 MB/s
> >> patch	x86_64	11503872 B	 13 ms	885 MB/s
> >> v5.8	i386	 9621216 B	 91 ms	106 MB/s
> >> patch	i386	 9620224 B	 10 ms	962 MB/s
> >>=20
> >> I also measured the time to decompress the initramfs on x86_64, i386,
> >> and arm. All three show the same decompression speed before and after,
> >> as expected.
> >>=20
> >> [1] https://github.com/lz4/lz4/pull/890
> >>=20
> >=20
> > Hi Nick, would you be able to test the below patch's performance to
> > verify it gives the same speedup? It removes the #undef in misc.c which
> > causes the decompressors to not use the builtin version. It should be
> > equivalent to yours except for applying it to all the decompressors.
> >=20
> > Thanks.
>=20
> I will measure it. I would expect it to provide the same speed up. It wou=
ld be great to fix
> the problem for x86/i386 in general.
>=20
> But, I believe that this is also a problem for ARM, though I have a hard =
time measuring
> because I can=E2=80=99t get pre-boot print statements in QEMU. I will att=
empt to take a look at the
> assembly, because I=E2=80=99m fairly certain that memcpy() isn=E2=80=99t =
inlined in master.
>=20
> Even if we fix all the architectures, I would still like to merge the LZ4=
 patch. It seems like it
> is pretty easy to merge a patch that is a boot speed regression, because =
people aren=E2=80=99t
> actively measuring it. So I prefer a layered defense.


Layered defense against performance-only problem, happening on
emulation-only?

IMO that's a bit of overkill.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--unkgxepgdpqe5p3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXykdJAAKCRAw5/Bqldv6
8h/YAJ9snZA+NN1irCzUGWNHAFTqDZBRWwCfTSqvSSxHl3MvQJU0X6gUeYYRRQ8=
=6uB0
-----END PGP SIGNATURE-----

--unkgxepgdpqe5p3t--
