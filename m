Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B95C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85C420656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C9llSBpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgG0Lgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:36:44 -0400
Received: from ozlabs.org ([203.11.71.1]:37375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgG0Lgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:36:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFd7F5Vdpz9sPf;
        Mon, 27 Jul 2020 21:36:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595849801;
        bh=m9gc4f7+OGMwWWb8875YFApZLF4dDGweR1HdKuefN4o=;
        h=Date:From:To:Cc:Subject:From;
        b=C9llSBpLAma7XaRwCN1GASQ17Spte8zUiVKgoA08qhcpHBUGHZso7oa09NRfRGij+
         huQucz0zhRLa0SyO56B2+S0amhn88Dij3WoZzuFDQVrsps2L8uriOuOfVe3mVy72cU
         lJzzm177kzs0BLf5bdye6jEoNG+tMS3cYNxPkaZjOBPAFqQzJsqq7blmSKuLp14w3J
         eg0UH6t/rBQ1IPmKndEbF9QizMVLMGHTV8QhitaUIkjI3EXrii33L4w1kHL+IH9iyN
         YNCclOejWfXhuOj5Eg7LmXFr8vZ0SBEhgEgFuRKZblFYxv8qdx4vbF5RewwbHUjlMO
         nup5iVNCgY9Kw==
Date:   Mon, 27 Jul 2020 21:36:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the drivers-memory tree
Message-ID: <20200727213641.3491e3d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vEHPzkFRjVv/UCLif86hy81";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vEHPzkFRjVv/UCLif86hy81
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-memory tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/memory/omap-gpmc.c:36:10: fatal error: asm/mach-types.h: No such fi=
le or directory
   36 | #include <asm/mach-types.h>
      |          ^~~~~~~~~~~~~~~~~~

Caused by commit

  99b42df9d57e ("memory: Enable compile testing for most of the drivers")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vEHPzkFRjVv/UCLif86hy81
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8evEkACgkQAVBC80lX
0Gzcrgf/cApgcv2qsKozvok3vzE9Fee8xb11fyqzoP8nth88YUB2VryZbDUwi/xJ
mXbbnSceKqe/oKMS1gnIHq44DLc5Zr7EdQ4Lt5FhlS7DXSIP3PGPe0EVFZJ9rnts
ATdhnAEqwVmIDAZp9NzzSsTmf/r+N7vmA0uamU9ncoouRGAL8ofnRO5lQfb657Bw
2Qy1jEvTylNInzexf1F5eOipSrP6ln1VEEv+mC8sOcKdZ1nBi4GruWq8teZommeT
duVBICoEIYMFMqwBk11wWSPn0fZn9SSY1RY5o1/ew7/uZki5lN4mzO9FUMtIrZZ2
I5wMvU8ZiUoSf+Lt2VzrWxK6lRmw1Q==
=sMae
-----END PGP SIGNATURE-----

--Sig_/vEHPzkFRjVv/UCLif86hy81--
