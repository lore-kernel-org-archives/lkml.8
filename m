Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E17C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12447215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GLpcWwZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCDFIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:08:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39585 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgCDFII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:08:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48XMMp0NZTz9sSG;
        Wed,  4 Mar 2020 16:08:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583298486;
        bh=2AGvzSo4s7yhovCwuUDqMjs/grp1mZuL0AMqAnlZklM=;
        h=Date:From:To:Cc:Subject:From;
        b=GLpcWwZfIAXZpPi4bzUvT3dJeKXxNG6lhocAyBNQR0KsJvnu9etxsVgkmlNj5snfh
         b59YfRvkChaT9d5/GApcB9L3EKT8Up9vpOQYESo64DBNbG5ex7EXKfyhuW3u+shUbm
         wKcxpIad65+xIjY1aPEo6JtWmwXoVFlBe+Wq+v6KGiqvCEPzL1ikPtd2xITiz1OMli
         qyOKRDmuJEMJXg1hKcU2c5Q4grxNWVUDUzNiOWjU5z1/+AUhLuqiK04g0t6J/sUFvu
         Gt0RvOznEYwOQe/kUHdwKxBKijVaAuE2YyIM5MkuIncP0i6hz7vAd3MkffeaDjiqZJ
         l/lxUnpzun4gA==
Date:   Wed, 4 Mar 2020 16:08:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20200304160804.6daf438c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L_ubD/qdKwECXxCSoVa4ke3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L_ubD/qdKwECXxCSoVa4ke3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  707518348ae7 ("devlink: remove trigger command from devlink-region.rst")

Fixes tag

  Fixes: 0b0f945f5458 ("devlink: add a file documenting devlink regions", 2=
020-01-10)

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/L_ubD/qdKwECXxCSoVa4ke3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5fN7QACgkQAVBC80lX
0GwMlgf8Dygoxwl0X0rv2dDXN+aY/CishuG1osiVecepQPFnpu1+O9Bk4ufJPw6T
YVE9sdKtg2Ia6//b5MABqCRQvaZHdZmTeen53IUqiUQriin0//6QZCknAPfvBiMy
cCcIFiTIvq6Xf61fRDVAyhavsw3ysEZ+hIyHO72sD1Ye0uHEExy6SFBSwk0ObVxw
mODqt8UTDDxlmC4eje9Mg2qig8Vht/PxxRgBoXPQrBZhluUUS1X/8zh0ML2mIsWZ
uKkiWEs37pjy+clK4yFS9tx9UTIQkwGetsQ8ozMyz8e5qjJd70/V60HpabOpb+r4
YKybPO//2oKbfVruJBRiPpDX3ikbEA==
=zCxu
-----END PGP SIGNATURE-----

--Sig_/L_ubD/qdKwECXxCSoVa4ke3--
