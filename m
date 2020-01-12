Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843B7C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F7C21556
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fAR8z+LJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgALUWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 15:22:25 -0500
Received: from ozlabs.org ([203.11.71.1]:60617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733252AbgALUWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 15:22:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47wp6k3Dhtz9sPW;
        Mon, 13 Jan 2020 07:22:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578860542;
        bh=TWjACBIuITD5+iRtXqdg9WcsJ8IQsCpM8+xX8Hbw8j8=;
        h=Date:From:To:Cc:Subject:From;
        b=fAR8z+LJT6Z3qGAY2MoFCUOUGr5/SXHUMCblfCQFUFLOMus0FGMB8a1NkxOxB05mb
         bKMgqykInwMypI0CrW2hTjYEVSEAsqeeBquqbEEaw/zs7Fy4DLZVGyPC/db5e5XvRK
         TKCZw9pr59N8btihMgG6Mxl+qq8UGYYdsYJPwIM4iF1a173hiD3fQZOxYoFrH6mYrn
         a/hNE71viKEaR8fRupawIbO/A1V66K2K9CFdHA4z+sURz8F6PRh/pMNXEAU+/YWhj4
         Z+xgLzNF2NSFhJ0losJPCBaQbunB6Glu1ReDArPmohlH3rr+UoRKpwmTnu3MxUbikC
         0BJVPuJw1VBaA==
Date:   Mon, 13 Jan 2020 07:22:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pidfd tree
Message-ID: <20200113072221.4c17f28a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/84duewguahvoZKXFL9gKXzK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/84duewguahvoZKXFL9gKXzK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  f8e8354b6b5f ("test: Add test for pidfd getfd")
  666c3470317f ("arch: wire up pidfd_getfd syscall")
  527051993a23 ("pid: Implement pidfd_getfd syscall")
  6fbe955c41ae ("vfs, fdtable: Add fget_task helper")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/84duewguahvoZKXFL9gKXzK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4bf/0ACgkQAVBC80lX
0GyJoggAnZsAzVoo99N6DfpwJBmA9u3NVA+2p/QHIi6b4f1eKcnOU5tNhDoziIyD
CyjH7HA/VDbkDTw3Wls3IVyEkFfPcKkxLLqu3IztPWzpZon1U1HPaFWHsY4SwNAQ
rM8aowpADnesFUCu5kmOIjn505X2SDxUnr/PH2YY02+0pHyzqtUcsfv4La7gICMt
e7eEtpMwCQOQlmfCa50W+A8A+0P0B6uPOfBNaIOBogvcqJYy1GBSEz8UaIjl9k/9
QDf+9nmOCSnO6v/cBTiOJqyxPXWzs91xkxQE+SeB+yV8/9FxXSqRrSbqUH4hIp9F
Dj5yKKdR07jjhqYnei8AWIljXD9gaQ==
=wTyA
-----END PGP SIGNATURE-----

--Sig_/84duewguahvoZKXFL9gKXzK--
