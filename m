Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C906FC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A5A2137B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WbeVJMO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGPXJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGPXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:18 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5526C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:14:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B77pk0wbsz9sRW;
        Fri, 17 Jul 2020 08:14:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594937694;
        bh=WbKC4vHYjG/L2xjR4Kz3ljWUlwM3GL392sM2wMXaNrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WbeVJMO3HzRvwKZlCho9ai47gUDSvbuccBnDFYWCNgDn2zYBd0RqwZFSVuRbE9gl4
         o5RTRy/rbPJMMgUlwkSPTloOdWdW5+a6YxH8O7V5AWIvMjGecPVwehFemqXTciIWzc
         QM9YCdEBumkD0Et9g0rCX8fLEureocjN5jmpABTWqcQrowf/Y1GAoZCmbSobc45o5g
         0SeihO3zR6jGRCsxqivoDPNerQAHfQ4jd6LJ+uYIfu9hxOnU2IbIwfdWESpu85r3Wx
         opSnS2wQWHyUYgurjJ42IbU7TY/iBOoQPEkuN6/wdyXA82024RzJuhtE6Vcwepp8Ix
         Q0/CK7s56q7wQ==
Date:   Fri, 17 Jul 2020 08:14:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: please add the init/ cleanup tree to linux-next
Message-ID: <20200717081453.38d96678@canb.auug.org.au>
In-Reply-To: <20200716150511.GA25454@lst.de>
References: <20200716150511.GA25454@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f7lswCwx9ckTWPhEyYK4qI/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f7lswCwx9ckTWPhEyYK4qI/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, 16 Jul 2020 17:05:11 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> can you add the init/ cleanup tree:
>=20
>    git://git.infradead.org/users/hch/misc.git init-user-pointers
>=20
> to linux-next?

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/f7lswCwx9ckTWPhEyYK4qI/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8Q0V0ACgkQAVBC80lX
0GzkpAf/QmU8ueZ/h/AcYnKoBI3pRAViPC6nxDx2t7xDZYoUSFYqQih0PoTl5HT7
K03sU11ewf06v3HUIP6PaHHtk45LVCM1l1wBJqwcw0rY+bqEHz0YCPXkxUKbrLn4
zgXaY/rpxFJ7TTcLe9vlk0Yss7oo1Kt9PZw9ZzELE+Y3ii3ACMvyAA0gXpx+xg7u
XG6vVwGs4JL/iez944GCIUbjBTZeuEzPjbNX/uH+qo4mNDMt8GvkgSpnRz/rVEAw
dx3k3wEAtDa/C3tZyfUMg2DTE36TF3kL/felzkLY8ffpGXY77lHD2rqpncxw4XSf
/SKftrZcw4NRW5NHF9VGN6nHNtBuKA==
=1ucm
-----END PGP SIGNATURE-----

--Sig_/f7lswCwx9ckTWPhEyYK4qI/--
