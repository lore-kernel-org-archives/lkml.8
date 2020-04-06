Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99570C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 02:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAC120738
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 02:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ESGoOHT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDFCeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 22:34:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43495 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDFCeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 22:34:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48wZNs0cPvz9sP7;
        Mon,  6 Apr 2020 12:34:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586140445;
        bh=U6eO/OF3fJaerYwuXFWM9RWCS5CHpktBx/iKBLdZcPk=;
        h=Date:From:To:Cc:Subject:From;
        b=ESGoOHT52uoZdBOnRQZe6t3yDh0JrcrUcRn28/kHGkyivem4kzCkcue7Wjm+i6qI2
         h8Ek2neGghpEorZuQy5Jx9OiscjMk/ueBH1PDWHTOH+uaTE7OjO/tMo7NyQmZyWIbu
         r47FnJBk0NrqoZECZVkgnqpsZuzCh4KC8ycLPwwm4O7BMh+5KA8WPm5fMMBsiwMupq
         JDneLwWHzweSfVf+w0FXBotRnHTMAKOBKyPSuN0EukPUy4/dT9aSvFY4L6Il99SZFS
         MVA2s5obZUFc4OS3cVL7kjGAqKq8bf+zBUf0XRvflN6/wA7Ulcn58xYS5aeUXayl5w
         rCa1x1s4gosMA==
Date:   Mon, 6 Apr 2020 12:34:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20200406123403.4f20fbb1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SsnSpdcqA_A.hKymK/vTDrw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SsnSpdcqA_A.hKymK/vTDrw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powercp
allyesconfig) failed like this:

In file included from net/netfilter/nft_set_pipapo.c:342:
net/netfilter/nft_set_pipapo_avx2.h:4:10: fatal error: asm/fpu/xstate.h: No=
 such file or directory
    4 | #include <asm/fpu/xstate.h>
      |          ^~~~~~~~~~~~~~~~~~

Caused by commit

  b851fc367202 ("x86: update AS_* macros to binutils >=3D2.23, supporting A=
DX and AVX2")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/SsnSpdcqA_A.hKymK/vTDrw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6KlRsACgkQAVBC80lX
0GwrUAgAorG+0i6QiBVmEtK+KyXDwsSkd6YG1UCfDpgXLG1/TDrRs9iJWSG9Nr+q
7iLjvMPM4bBRWpMh46XEXM4rM9fsWChJNwFG9GDUiTMLGfKUaFyguEyLGjUO4Emv
bJG5R3NAnUEZQbXdLHzB/yJmgvMaMFOkPnwy4K+WFiiJcDs+EPN5G8NFoTngJhR7
08T8rpcXoUJr/CG8+mHqw1jiRiBadmElcNYrfDwSur1OoRI7V79pXCgbwEoQZnys
gL41Hpv+vzAxq2nZ64H+zJDdIpi+CQGoTm+Xh75XJChJxhEWeAdi8GbL+IyPlIQE
Q9SFHs/0Sw56vR2BQAFvYbWU3vb64A==
=qoYF
-----END PGP SIGNATURE-----

--Sig_/SsnSpdcqA_A.hKymK/vTDrw--
