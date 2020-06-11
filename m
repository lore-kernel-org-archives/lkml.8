Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAD3206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C/qX8qKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgFKAxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:53:04 -0400
Received: from ozlabs.org ([203.11.71.1]:41143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgFKAxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:53:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49j51h1KG3z9sRK;
        Thu, 11 Jun 2020 10:52:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591836782;
        bh=5kZq6mHKS7q2Ry+3IYHMd4r4qTNJFTFM7mky4n/cBY0=;
        h=Date:From:To:Cc:Subject:From;
        b=C/qX8qKLKi1Pwfp89JGLlF74A/FGpWfoklP54UsAyYFdMR2yH8PydR+Uhzj6EhCJT
         /wdZyQjyiiUd3CHDo009GPl+Jf7uZr3go4bAiPDkdYkO4c11vmqViO1BsdEReXCsV/
         8Q/f5aknHgs8r1BeRgDfRqSVa2Au5ruy5lIKvJY/wIUwdKfTnls+j3XGJB16xtBdnj
         UHBv5GYXOJzdIFwGj2UeQwfnuiNVMh1YQWWAtvyeft5dLu/Rq3vi7v7kw7gG2U//5B
         VeP/h1RxX30W52nKaS5wlyawC8635smaoGnsHgR30gsjcxfIrWynGO+VaWtJZGo1iV
         YSkU77+hxLmJg==
Date:   Thu, 11 Jun 2020 10:52:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20200611105254.1b14f070@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H5JkHsyQvcThSvj3eHfxx=V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H5JkHsyQvcThSvj3eHfxx=V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  include/linux/compiler.h

between commits:

  dee081bf8f82 ("READ_ONCE: Drop pointer qualifiers when reading from scala=
r types")
  9e343b467c70 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memor=
y accesses")
  a5460b5e5fb8 ("READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()=
")

from Linus' tree and commits:

  2ab3a0a02905 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memor=
y accesses")
  7b364f0949ae ("READ_ONCE: Drop pointer qualifiers when reading from scala=
r types")
  bbfa112b46bd ("READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()=
")
(and maybe others)

from the tip tree.

I fixed it up (I think - please check the final result when I release it)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/H5JkHsyQvcThSvj3eHfxx=V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7hgGYACgkQAVBC80lX
0GyA2Qf9F2/Rn8jbNE12T9bjsQu/o/MSyyJN31irZJ7a+IokZorI8L2UB5ApZu0l
diX6GUTfHkCgMmKukjTtbsrN+NSRB9YJRSB3Tdx8iAt/aXn8vSbPBy5XSJeTlZZt
XLe0bUhRPu1EMZFryW9hfLNieM3OCPoC1O44iCpuOoVmwDg6v488E6OAs86ZARKp
5MRQT7qxuGXnhAE9dBJvyvZ5qKmAJC0UwN2XJ3hvk/V3bikUxvU1rSppRtHRu46K
m7z7wUwndAF2FPfTXJ0P/wJv23EU/Vl5E/+6XSksaWS/vp0if7nbHgTum6W/lB+d
av1Bg4MjzwhPjtSJKKzeVci9bRx+kA==
=eV/3
-----END PGP SIGNATURE-----

--Sig_/H5JkHsyQvcThSvj3eHfxx=V--
