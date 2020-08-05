Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB8B2245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IbihYlJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHEFpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:45:15 -0400
Received: from ozlabs.org ([203.11.71.1]:60519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEFpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:45:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BM0vY058Pz9s1x;
        Wed,  5 Aug 2020 15:45:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596606313;
        bh=NzlaBPMcet68MRThHWBED544AXpBFsunpqHG4FwhiHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IbihYlJjtFxCDgnyq6LpT7wHEldmZlcBzwEcQzo2bqUls+uE67qZNKFrlC+V7mQMw
         GCsTRlHnfE25NQuoQdVlE4mF52gpp9M/4lltTqkCHCEg4BjSZ5kDqlv+04RCymKhHz
         q6fF3jhxyBQtv+1eEMuImIVdvuA+N5gJ3+39pGhUXwd3T6N3JuBkNeGk3VMC5+TFRY
         d1nipxIIFpwdr10N7Wb6p/ZNY3ulM3IVR+MsSxJtGhcgMsW693Hgi4a8C5ZeTzi3Js
         rW5DUq9pbj1Z7KQaXeckZu87fJofHsWh40TZCjxF1fsVO9iKLS1l1EMMrCJ6jyhTQ2
         pZMPTvWoxcXFQ==
Date:   Wed, 5 Aug 2020 15:45:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the seccomp tree with the kselftest
 tree
Message-ID: <20200805154511.698d76d0@canb.auug.org.au>
In-Reply-To: <20200720155917.607fff9b@canb.auug.org.au>
References: <20200720155917.607fff9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//OcwuG_Hnd6Y469Wk63sQWn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//OcwuG_Hnd6Y469Wk63sQWn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Jul 2020 15:59:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> Today's linux-next merge of the seccomp tree got a conflict in:
>=20
>   tools/testing/selftests/seccomp/seccomp_bpf.c
>=20
> between commit:
>=20
>   4c6614dc86ad ("selftests/seccomp: Check ENOSYS under tracing")
>=20
> from the kselftest tree and commit:
>=20
>   11eb004ef7ea ("selftests/seccomp: Check ENOSYS under tracing")
>=20
> from the seccomp tree.
>=20
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the kselftest tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//OcwuG_Hnd6Y469Wk63sQWn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8qR2cACgkQAVBC80lX
0Gw0pAf/W6TwKUxKg3P5QQPYUyF5sIxMMJjo+uO8MbNouRI5yMlFcft8YsdE6Wnq
zZwZPXKHBja+1c8ZJOY1blAMVRYVYk0g7jSIcPJCqW/4MDW4SzhxoD6AOnSvjnhG
8BOaQ+xbD16q9xrhbsSPmHuDHa3Qzpd8XtZA/dFF0Fef6D0KojXM7QsaRBssJyQJ
XhG+mg0R4NSdsM9dg0GgN6fGzWtrEBQlMej6mgCRTbQEvuy3uUePLc4ixKt2PYRt
OQXOjX69nrIdrqMx9jvkp92EBAwPvn8YDwQ7DNSm8RodEiPWUMLJApNwSY4u2e44
P6NCZf6dVSBiWI10Oia47IGJatRSkw==
=fWyi
-----END PGP SIGNATURE-----

--Sig_//OcwuG_Hnd6Y469Wk63sQWn--
