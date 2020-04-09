Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D420857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bT828Miu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgDIXeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:34:08 -0400
Received: from ozlabs.org ([203.11.71.1]:37169 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgDIXeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:34:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48yyCG5dd0z9sQt;
        Fri, 10 Apr 2020 09:34:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586475243;
        bh=iDTVLKuqXJrCBfSTzDq+b5Cuz3DDrj7b2y5pTvSP+lA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bT828MiueJAlvr8WUvLkOGX5mDc99OjEY+pWZ04WC5QeQAMpxFeWVrQ2RvlTfEPD5
         rG/YEtMF/ET7pkpt3zzgddG7LtkP5ZdhJV3H0Kcdgw9eowu8ethxrWB6a6MziYtc06
         ujObB8s6lSOLjmRoH+nzMqUVrgIRH/gJ44bO9Ur5cmb5KauQ9sKvf8CnPpLjY6ae/r
         jX4wJExOT3ktEAraOSocj2fmjiRNZXmrHkgSNh40mB5gzuNQhKyY0wXek+WnklqWIm
         JWQVsxBR/jndTbTjayibKrCigCAFL7TFRNIBcSaFJPovvDQf9QyU48KZDlj1gEXOJH
         Lp+TK4j08SlPw==
Date:   Fri, 10 Apr 2020 09:34:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200410093402.304ac89b@canb.auug.org.au>
In-Reply-To: <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
        <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
        <20200409114940.GT21484@bombadil.infradead.org>
        <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
        <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
        <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
        <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
        <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
        <20200409195633.GZ21484@bombadil.infradead.org>
        <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
        <20200409202751.GA7976@gmail.com>
        <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Cyo+WHzp6CCvCDaVjoZLMqd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cyo+WHzp6CCvCDaVjoZLMqd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 9 Apr 2020 13:34:18 -0700 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> On Thu, Apr 9, 2020 at 1:27 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Would it help if bugs blocking testing on linux-next were Cc'ed to
> > linux-next@vger.kernel.org, so that Stephen could investigate? =20
>=20
> Maybe. I'll let Stephen say.

It would certainly help so I could at least chase people and maybe
revert commits.  Dropping trees can be problematic once Andrew has
built his quilt series on top of them, so I try not to drop whole trees.
I can also use a previous version of a tree (which is usually what I
do if I discover a build problem).

--=20
Cheers,
Stephen Rothwell

--Sig_/Cyo+WHzp6CCvCDaVjoZLMqd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6PsOoACgkQAVBC80lX
0GxWLggAgmL7x+eqNfGwjUwzwkR4SsmGhiMBB64I7FHl3YEYFmnGcpuy45CJRUTF
QE4pclJV1QJEFbJ6ubyevuNvdp/kEbSiJZd/XeuGTc4SNX16sY+I4DHEKIe28zlO
RU767VR4GGrZWICQKsIWygH/qn1vIwvRTNmxK/jxcSLabxVmth9gmLH1VOIeIUvz
JwtpFkk+ZlvCw3vdm7XZ9UnsCimylrr3Nd4DdkxFtq6bwLIepCGQ0MW5Rg8nVUE5
wM5qMKStGjDt4BJnjJ3WvaabpIq45X8msM6/YWzVgxXEGlIsU4Tk8OABEyY9to0f
ez0nXrcOZ5h0tfYSpSNIXfN+Ninjcw==
=7JuK
-----END PGP SIGNATURE-----

--Sig_/Cyo+WHzp6CCvCDaVjoZLMqd--
