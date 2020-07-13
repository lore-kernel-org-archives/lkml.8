Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008DC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E490206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WAgRrgmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgGMB4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:56:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMB4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:56:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B4mw32SB4z9sR4;
        Mon, 13 Jul 2020 11:56:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594605379;
        bh=S3DekknS5Db3vpTQmHZCmzd6fKM7tj2AAD3xpwqxj5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WAgRrgmTeiC+TXfTyPQKiTy6kC7yo4oUOLMCSh5S2GUJ/GImballElNTWqzIujDu8
         z7MBGkWdS0OHBjdQ0vKUu5ATbgVX11CWiWZQt14y8YBwRcUOQk7sjsqjBf1jdrwg/O
         aeE4oItXqOCg+oUCeULYdaSqIn3LCpBWzd1+P+M12iULppkHrjgnCu3eT1VK/TjsXP
         ZvIcmQlFkvm3GEKJGMRHM/ybTIOwG17xkPt3Ys2uphDmdleO7B4cSeGNJ+NcwCcJPX
         v9oXvTtF3zDsHEBMMdDlGQmsdM1MBf66HJbfXfnKc9SQr9SDuRSguxLQYIW6n8tSrt
         LvwsfhhlGmKwA==
Date:   Mon, 13 Jul 2020 11:56:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20200713115618.5e07a783@canb.auug.org.au>
In-Reply-To: <20200707170720.55be721f@canb.auug.org.au>
References: <20200707170720.55be721f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SqpINmfPhut1RqXugvzbqg1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SqpINmfPhut1RqXugvzbqg1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 7 Jul 2020 17:07:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
>=20
> cc1: fatal error: opening output file arch/powerpc/boot/dts/.ebony.dtb.dt=
s.tmp: No such file or directory
>=20
> and directory arch/powerpc/boot/dts/ does, indeed, not exist in the
> separate object directory.
>=20
> Caused by commit
>=20
>   ea4679253288 ("kbuild: always create directories of targets")
>=20
> at least, reverting that commit makes the build work again.

I am still reverting that commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/SqpINmfPhut1RqXugvzbqg1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8Lv0IACgkQAVBC80lX
0GzUsQf/V4yY7O8fRZ0Qnj6y/90EZHvwRSyV2ru1AqBN4k3gyskZyo5+AWZUT7Tt
b9y8XYsc7u5cXlDN4zW89xQ4N2TpPeLtBn5Yq296y9MMyIfYuvEHuM/Ga65/BC/H
1C64QGpqE+9ogBLZNL5g5Tx87nTMcD2L7HWQlhnEuwbwwTFuwW73ZZbRWxYAUk1j
QQ972y/rGzyZ5wtrQswpVLH32oHuhLrLR+W9A6sAyI1C4NYd3pWp6rJyfJyeNKkQ
hdihvj/nI3LKuGaru53mzDI8BB1p2hu2dKRg8X0Zf/7D+IOZQZ8u5rcKaO37dzv2
taySdLnWCl5KFQLhAwbGLX0t4hNxsw==
=B9n/
-----END PGP SIGNATURE-----

--Sig_/SqpINmfPhut1RqXugvzbqg1--
