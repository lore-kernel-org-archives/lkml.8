Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFCC33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E832053B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 19:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cz2xorTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgALT4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 14:56:30 -0500
Received: from ozlabs.org ([203.11.71.1]:55221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgALT43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 14:56:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47wnXl3B0Gz9sPW;
        Mon, 13 Jan 2020 06:56:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578858987;
        bh=JEaFgT13395F8z6RSXB4BOtl0VLZfQth8DbGdBHoACo=;
        h=Date:From:To:Cc:Subject:From;
        b=Cz2xorTD/sU2vA7umeBBu3Acqoo0PutXTtqK0/U3F4ghpBRquhGLSHN0VioS70NkB
         sd7IzVxruSaB9O8wF6v6H7UwY6vBRrZUyfMySd5Rws4BnVNXi/lfY6SfLAcZ5G5sQw
         3WBpxRfr8I4OmN/tpXpKf38Ye6hmjEEGohUUbOm+yEXXSjGIb4UlINklQH6pHfgeg0
         98CXmoDIHKwbL6X+f2dv/PdoQEs8FqiajutZrdI3s8EwBEMdmtbg3uTJKRXajUfkKt
         a4ILcud0/ecz3TVd5+wI/VuSYFCqgcVQL7Fbzzl3dfjPoZBSlHNPXOKxdD6LJpnYO+
         N18w9dfZZlBZw==
Date:   Mon, 13 Jan 2020 06:56:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: linux-next: Fixes tag needs some work in the arm-soc tree
Message-ID: <20200113065622.15eb3c87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=dfYuDVEKiAfgopGaB+pRQ0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=dfYuDVEKiAfgopGaB+pRQ0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

n commit

  0ff15a86d0c5 ("ARM: dts: stm32: Add power-supply for DSI panel on stm32f4=
69-disco")

Fixes tag

  Fixes: 18c8866266 ("ARM: dts: stm32: Add display support on stm32f469-dis=
co")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

Also, please keep the commit message tags together.

--=20
Cheers,
Stephen Rothwell

--Sig_/=dfYuDVEKiAfgopGaB+pRQ0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4beeYACgkQAVBC80lX
0Gwj4wgAof2ZXe39HMVp4vHI4FVJ9EfaCK9P1+4weTVebEXYokK1t2rX7VtpkHYd
MOdotYwdVeH3l2f7GUq462vygVU2Cs6LDWpnsT2LxpHUSpvLhEyhoXf+PMiNG5N/
a33sQo3k5M4ErHOWjMeN+3tvH5reX06MbNk1ihgMyYo1JBE+xildptitmQG010bJ
Pa+WSsiGXJPGrLvrjcIrWOfuaXDWunOPnqX2d4LJYUl7Kh1cdawJI4bYt0EdtrYm
7nJTaB9DMW7nZBtZbqLCQsHk+PLgzb0+iCBg+yYCEP91E3O+XYBBYsO/aeBKan+y
PoLERKhsUzuGG39l00SzpcJjf3MUwQ==
=iF0B
-----END PGP SIGNATURE-----

--Sig_/=dfYuDVEKiAfgopGaB+pRQ0--
