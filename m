Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B55C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E57207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ahiJhq8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgFQIGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:06:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQIGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:06:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49myLy0ZB8z9sRh;
        Wed, 17 Jun 2020 18:06:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592381178;
        bh=7cdmiAE9EG/i09Attx7Op+wfkId2lPt1WP3cvD+UbR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ahiJhq8YWhdLlolVgIgr2bVuINbtdrU0meaOgbW+HWe4UhMGWK3uwoYo7xqFU/rsO
         MRwG301TIXr8o3NmRkv+57aOMcPzgP2tKwyGGVz/t05ygTTJEmf0N1nL74A4rhCCG5
         2740u1PBAi5uJuVGATq60CpxE5H3VfI0/xjwcklJ0unVThD7hhaGkrRzUS8v2BNV6G
         FdtF73jcm6e6/UdxrpadiWLiVIaKJ6bNvEsUxtcb4sw2NyDHyJ9OLO30Jr66XSaMdD
         NGHH8SVlNuyV74qERPOA/vCM6UCRTAY/qHPvx+PZ3ZJA/e3jznPO9GJJkTW/ziiXQH
         rtBThJiMkSVOQ==
Date:   Wed, 17 Jun 2020 18:06:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: linux-next: build failures after merge of the vfs tree
Message-ID: <20200617180617.59e61438@canb.auug.org.au>
In-Reply-To: <20200617070316.GA30348@gondor.apana.org.au>
References: <20200616103330.2df51a58@canb.auug.org.au>
        <20200616103440.35a80b4b@canb.auug.org.au>
        <20200616010502.GA28834@gondor.apana.org.au>
        <20200616033849.GL23230@ZenIV.linux.org.uk>
        <20200616143807.GA1359@gondor.apana.org.au>
        <20200617165715.577aa76d@canb.auug.org.au>
        <20200617070316.GA30348@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rzaLdUCb00LybZJ4xG9HvTL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rzaLdUCb00LybZJ4xG9HvTL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Wed, 17 Jun 2020 17:03:17 +1000 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Wed, Jun 17, 2020 at 04:57:15PM +1000, Stephen Rothwell wrote:
> >=20
> > Presumably another include needed:
> >=20
> > arch/s390/lib/test_unwind.c:49:2: error: implicit declaration of functi=
on 'kmalloc' [-Werror=3Dimplicit-function-declaration]
> > arch/s390/lib/test_unwind.c:99:2: error: implicit declaration of functi=
on 'kfree' [-Werror=3Dimplicit-function-declaration] =20
>=20
> Hi Stephen:
>=20
> It's not clear how this file manages to include linux/uio.h but

arch/s390/lib/test_unwind.c
arch/s390/include/asm/unwind.h
include/linux/ftrace.h
include/linux/kallsyms.h
include/linux/module.h
include/linux/elf.h
arch/s390/include/asm/elf.h
include/linux/compat.h
include/linux/socket.h
include/linux/uio.h

:-(

--=20
Cheers,
Stephen Rothwell

--Sig_/rzaLdUCb00LybZJ4xG9HvTL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7pzvkACgkQAVBC80lX
0Gydsgf8C0QacF7ALL4x+Jgm45jOWTwR+kv83Hhyu8gOqoGOEhEAbtHtBJ9lwHIf
mh7QdEzBLNAsomRZQox3GBUu4d4T9dhvHpftivmpprK7vWQl4whn9vZROwR1hOBA
8t5I/5OkZCpbiqNhlptZc2JfqBcV148Obv3qDFz+PqaKmgwoIkP+0RTgkeIKVGRN
cC/sswumVFgn4FcngB1HQFTtOPhj+UUshR5Qbm1FW4urzcyFNEQW+mY4OlvYtwoL
l74akTRZ7cbZUJ2wFl8On8ecUf5IoSRvBxeKufth9psiMCKmnk04+pmB3rS+X1W8
MVtSPS/ePn8r7F2mOchhptDGcgo2bA==
=ZeYJ
-----END PGP SIGNATURE-----

--Sig_/rzaLdUCb00LybZJ4xG9HvTL--
