Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93757C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D43A206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CHFiawnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgF0FB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgF0FB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:01:58 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BEC03E979;
        Fri, 26 Jun 2020 22:01:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49v1nb0Y4Rz9sRk;
        Sat, 27 Jun 2020 15:01:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593234115;
        bh=8Px2UOteBnGdLvihbOqrT/45BjCePL4czx2Z+7vrf6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CHFiawnVOsgzz0vPm5c01DiBv0YBOUwqhoWxSCBimbPbQhviedR6noUNh/RlOgpvP
         5oR4k6Q88qr/FB+MN8d1LSrB+bTfSiDdb/VvZx3ebxL3Q70xu5/qrc47cbPvC9j5RC
         l9+dXLBi7dYkbrR46sWLwO6pu7WOC7VuNRkvxDVlPaHFvvfidFefk+hUfkIImc8FlC
         pF53ARbUWljbowS+ohSv43f8BsRv1O+1+a5uGgXw5UfzouF11oY36eG3sHtIMF6KZe
         GUOAd818gzvJD5rAt/jzAimwYh5MHTj4zMdC85JDXSEbcSNxJoVgHBGEcgVLJHxI92
         RJO8VUVYbkVMA==
Date:   Sat, 27 Jun 2020 15:01:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20200627150153.331c66e7@canb.auug.org.au>
In-Reply-To: <20200627015605.goc2btyq6z3wwb5z@chatter.i7.local>
References: <20200627090740.683308fd@canb.auug.org.au>
        <6920f023-5909-6ebf-606c-dbf467a31c7c@kernel.dk>
        <20200627015605.goc2btyq6z3wwb5z@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.lqzE9yONqv//iwsCcE6pvs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.lqzE9yONqv//iwsCcE6pvs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Konstantin,

On Fri, 26 Jun 2020 21:56:05 -0400 Konstantin Ryabitsev <konstantin@linuxfo=
undation.org> wrote:
>
> On Fri, Jun 26, 2020 at 07:32:15PM -0600, Jens Axboe wrote:
> > On 6/26/20 5:07 PM, Stephen Rothwell wrote: =20
> > > Hi all,
> > >=20
> > > In commit
> > >=20
> > >   cd664b0e35cb ("io_uring: fix hanging iopoll in case of -EAGAIN")
> > >=20
> > > Fixes tag
> > >=20
> > >   Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
> > >=20
> > > has these problem(s):
> > >=20
> > >   - Subject has leading but no trailing parentheses
> > >   - Subject has leading but no trailing quotes
> > >=20
> > > Please do not split Fixes tags over more than one line. =20
> >=20
> > Gah, that's b4 messing it up. I've actually seen this before, but
> > I caught it. If you look at the actual commit, this is what the b4
> > output ends up being for the fixes line:
> >=20
> > [snip]
> > io_kiocb's result and iopoll_completed")
> >=20
> > Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
> >=20
> > even though it's correct in the email. I'm guessing some issue having to
> > do with the longer line? =20
>=20
> Yeah, I'll try to see if there's something I can do here, but it's going=
=20
> to be largely guesswork. Here's the original email:
>=20
> https://lore.kernel.org/lkml/22111b29e298f5f606130fcf4307bda99dbec089.159=
3077359.git.asml.silence@gmail.com/raw
>=20
> The Fixes: footer really does get split into two. It's not that hard to=20
> add logic just for the Fixes tag (since it conveniently follows a set=20
> pattern), but finding a universal fix for split footers will be more=20
> difficult.
>=20
> I'll see what I can do.

But (what am I missing?) the Fixes: tag has been split over 2 lines in
the original message ... on lore and my copy.  There is nothing for b4
to do here, the author needs to do this right.

--=20
Cheers,
Stephen Rothwell

--Sig_/.lqzE9yONqv//iwsCcE6pvs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl720sEACgkQAVBC80lX
0Gykmgf/UDfTAtLD25u57q78AG7JKwLQ4PaOMcVNfAB7arKFfPMbadbdSsIN458e
jm7jaUqMLBWwLrUXiJNUoRsmzf030LiIIOkngLYzuMd6Ril0cgJq095axMUK/vS5
bmad5nwYZnO7niCltmUeQGjphPfd2mUkvpGrIMEuTDVsAAzZqeG57sFW0PwvplKB
6WAMD2dt88PrVuf6bDmHp3u9XYSYXoB6AeJxFIBOXo7BPS+7au4oea2Fy7CTTNLy
lQGdVY/jo+RFh0KRA6dUIjO1T/02VTYLrVof0bFRNjzmJM/GBBW+bbmI0+3hhdFA
CuLkUEuCiywgS1y0wzMtBaM1T323qw==
=pXT/
-----END PGP SIGNATURE-----

--Sig_/.lqzE9yONqv//iwsCcE6pvs--
