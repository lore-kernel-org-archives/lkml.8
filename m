Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED02C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 00:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5931F2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 00:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AVgBh5gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgC2AJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:09:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgC2AJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 20:09:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48qbZ50twNz9sSQ;
        Sun, 29 Mar 2020 11:09:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585440589;
        bh=NM3bXWs5UXC+X0OfYaSev+JCIxVt/KTf3j40vdt1Ccc=;
        h=Date:From:To:Cc:Subject:From;
        b=AVgBh5gEwkloPkSB2WrvgscfytufEJ4Mq9L3vU9vPcOqg/i5x30L5GNFizkYx0cPN
         WqqeI8rCs13EnjBcgtIpGQSwQf7wM3dFPknLneyq8lqkci5mVYhvCjGwr+DyRwKnDG
         de1Ts4MUhWPQQZR+out759RdUT6rZxNMxfBnVOte1AZHgZxBYgZKa0QczSiFEuVIud
         Lo2VyXaaggy+hTLgq1EQU/yYc3P5LSjMaJywQf9Vj2pg92EE3YcuEwI7/vTzKP6aFD
         or5G061tov6o+acKaHPErJvtQntdObPvIEFI+X1ksJf4oNAeWSjqIrGBKpf5ABOmbA
         4p2H+lV0fKr8w==
Date:   Sun, 29 Mar 2020 11:09:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20200329110942.78ddffb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hy_qQAo/L7tkLxsWA2vsKIx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hy_qQAo/L7tkLxsWA2vsKIx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d4061518c398 ("ASoC: tlv320adcx140: Remove undocumented property")

Fixes tag

  Fixes: 302c0b7490cd ("dt-bindings: sound: Add TLV320ADCx140 dt

has these problem(s):

  - Target SHA1 does not exist

Maybe yuou meant

Fixes: 4ee67cbd9766 ("dt-bindings: sound: Add TLV320ADCx140 dt bindings")

Also, please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/hy_qQAo/L7tkLxsWA2vsKIx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5/50cACgkQAVBC80lX
0GyaLggAj4756j+3CwYM/mTZ/ANR1o2aP5ERttFyQC84ZgoeuB1wvp84+FuEj4MO
7WxyU5/QgHLAO/Xo/fu8PZBfVy1p4QGwvy+v9iGPyX3xT0HsYo9GXhBmyIwFPOe1
Tw/wtUBg3k0vkjEhmGN1VDEVvHkzo00tUwBqa+vBSjI9dOFoOQiyk7PInlRcRTsm
9TayTZGEH99QKo3yyadxnaqbZQWM+hrzdXr+aDQbhO24KrvyVdxnBVTXPaGfGAZy
ikhrzct9CNx1b7GCrkDz2gr1nRDUmlHOcZP0eeRCZTf636OsjT5/IJkk93cYUDSP
BHfmh3dCuqjEFreQYcINLC46qTnS2Q==
=GUdz
-----END PGP SIGNATURE-----

--Sig_/hy_qQAo/L7tkLxsWA2vsKIx--
