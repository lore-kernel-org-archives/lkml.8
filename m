Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D012C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7E2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qeMTYdMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgDAWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:01:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbgDAWBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:01:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48t0WX17Mmz9sR4;
        Thu,  2 Apr 2020 09:00:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585778459;
        bh=r5b2piY6/n72uqJFBNUFlpkDoMERU0WoLrX1VqgXSkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qeMTYdMz0vIBNJyd5+3em9tWCEcQD0RhARuMLoCxU3Ib6sSaQLaSDSMSFflGLD54g
         UJoLZMIqokLiFWXBVsnJgQlqIuxcatpNwoaNR7fT+qDuhpyvWcKLKTVASxIPOwceJI
         sSY3ZdauN4YMNFnkWj34v32hcBuO3I+szSxmGLh2JjmHr444piTkl2UlvRYntMbY7F
         eKojTMrQ0tZesHuGNYR45AuVlopRj3SKqtfZYxm0lP6yuMQmZuLebGqyP+fe5Bmk1c
         PEtmGkr/MITwjU/hb0qmtJtqWuCu6RcvrKPacvU4rmozwoLwxcx/3R2zXeM/26GvWy
         gr7/r1VUudZ3w==
Date:   Thu, 2 Apr 2020 09:00:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20200402090051.741905cd@canb.auug.org.au>
In-Reply-To: <877dyzv6y2.fsf@nanos.tec.linutronix.de>
References: <20200330134746.627dcd93@canb.auug.org.au>
        <20200401085753.617c1636@canb.auug.org.au>
        <877dyzv6y2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T9rRW9/VqPZ6kK6l61A6RfB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T9rRW9/VqPZ6kK6l61A6RfB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, 01 Apr 2020 12:25:25 +0200 Thomas Gleixner <tglx@linutronix.de> wro=
te:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >
> > On Mon, 30 Mar 2020 13:47:46 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> >>
> >> After merging the tip tree, today's linux-next build (arm
> >> multi_v7_defconfig) produced this warning:
> >>=20
> >> kernel/futex.c: In function 'do_futex':
> >> kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in=
 this function [-Wmaybe-uninitialized]
> >>  1676 |   return oldval =3D=3D cmparg;
> >>       |          ~~~~~~~^~~~~~~~~
> >> kernel/futex.c:1652:6: note: 'oldval' was declared here
> >>  1652 |  int oldval, ret;
> >>       |      ^~~~~~
> >>=20
> >> Introduced by commit
> >>=20
> >>   a08971e9488d ("futex: arch_futex_atomic_op_inuser() calling
> >>   conventions change") =20
>=20
> Huch?
> =20
> >> but I don't arm-linux-gnueabi-gcc (Debian 9.2.1-21) 9.2.1 20191130see =
how it makes this difference :-( =20
>=20
> Me neither. Which compiler version?

arm-linux-gnueabi-gcc (Debian 9.2.1-21) 9.2.1 20191130

> I'm using arm-linux-gnueabi-gcc (Debian 8.3.0-2) 8.3.0 which does not
> show that oddity.

I assume it is because of the change to arch_futex_atomic_op_inuser()
for arm and the compiler is not clever enough to work out that the early
return from arch_futex_atomic_op_inuser() means that oldval is not
referenced in its caller.

--=20
Cheers,
Stephen Rothwell

--Sig_/T9rRW9/VqPZ6kK6l61A6RfB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6FDxMACgkQAVBC80lX
0GwG+gf+KqrhLJkMSli8yzd+KnzQb3yhRcFWOx59V+ogiuf7SuvAa6/i+bIroF/c
9vS7QbDSom9B4KmUpTmUO2HG9Hr3w9F9lidZ1x3PwR23zIDOQasevQ7BvdjTNi05
KHWurUi8wpcrF8Szse8VnzznAwKzkpnzPbi8sJHVqfUMY+2BN6AmhY6yCZ/66YlD
iSLzX9l+qkBeiEA7d+VMwRv4GHZTZ8lZyw+1bDotwJRE3YBrDNSpfcoolg2v/0xd
U3bP2+6WMDOhFnWkyDtGGPNus3aCBipOuUHKNDeOuQK186j1jWVXQ08DyOVcOeT/
knRVY5Ku0NhkXHbl1/v3ppt9DOm5UQ==
=suJO
-----END PGP SIGNATURE-----

--Sig_/T9rRW9/VqPZ6kK6l61A6RfB--
