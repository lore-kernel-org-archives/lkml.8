Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E18D2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ThjCtYRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG0KQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:16:05 -0400
Received: from ozlabs.org ([203.11.71.1]:44599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgG0KQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:16:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFbL948qpz9sPf;
        Mon, 27 Jul 2020 20:16:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595844963;
        bh=Wv52XDR7c826tRwrnj73BR2SJR4h7Dgq22Ma1+JBJvA=;
        h=Date:From:To:Cc:Subject:From;
        b=ThjCtYRKH51WECpigrW3SjBcgegD12ity5tRyrBFJ4VT+S52OCuJvhU7MxmeJLyl6
         IswDOZ1Tkbp54ltK/hvcNsdOAKRhunZ0X+50tTjzyGKG3t7ZVeECA1Dc8wPilsT6w7
         9VFKxXo4qPBl7pP46eiuxDJX7ZzIsmkx/qR5uK1jqxzqFZUWDaaeu1cza6ri6Edr+T
         5FLp2qvsU5ewGl6vCLbxHwufoaapyNtSZ0m8DTcF6i4GffKU2KsPCiifbLrtlaLRs/
         C4hbvqJcpM+looB1QFgd3b69cCuPbbMXWFtXiYYbEvOQtqDGVzPKbJ2UpgF25yM42k
         iSFQjUgntwnow==
Date:   Mon, 27 Jul 2020 20:16:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: linux-next: manual merge of the devfreq tree with the arm-soc tree
Message-ID: <20200727201600.7d3b31c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/++6XAr=93HCVz0ylAiagd2.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/++6XAr=93HCVz0ylAiagd2.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devfreq tree got a conflict in:

  MAINTAINERS

between commit:

  8a9ff8758159 ("MAINTAINERS: Add Krzysztof Kozlowski as maintainer of memo=
ry controllers")

from the arm-soc tree and commit:

  34886407581b ("PM / devfreq: tegra: Add Dmitry as a maintainer")

from the devfreq tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 2b1d2d3fbd4e,e2e95c877f0b..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -11202,13 -11086,15 +11202,22 @@@ F:	Documentation/core-api/boot-time-m=
m.
  F:	include/linux/memblock.h
  F:	mm/memblock.c
 =20
 +MEMORY CONTROLLER DRIVERS
 +M:	Krzysztof Kozlowski <krzk@kernel.org>
 +L:	linux-kernel@vger.kernel.org
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/memory-controllers/
 +F:	drivers/memory/
 +
+ MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
+ M:	Dmitry Osipenko <digetx@gmail.com>
+ L:	linux-pm@vger.kernel.org
+ L:	linux-tegra@vger.kernel.org
+ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
+ S:	Maintained
+ F:	drivers/devfreq/tegra20-devfreq.c
+ F:	drivers/devfreq/tegra30-devfreq.c
+=20
  MEMORY MANAGEMENT
  M:	Andrew Morton <akpm@linux-foundation.org>
  L:	linux-mm@kvack.org

--Sig_/++6XAr=93HCVz0ylAiagd2.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8eqWAACgkQAVBC80lX
0GzSTwgAjL8JGk/fTtMR3ol3fzQyjQSumf6MDY/Lu4F5m/FTuC+o6Sw0Tk6ba52r
Pckmi7+sT78glmp7vtxoPD6j47GliJGFmbSdJospvn1mxLKVs7WsN+F5NXcxGSpd
hAFy0bSXB+KdvhjFN7WNYZ78CexSMD1xwaRj0WhkZWaQwVOGJz4ttGC4vs+K4xiy
xraRnyBc7mGins+WmwjZ6XGdzEPyjN1qal8xXrmpJ1qCBD+wpxt+OQb+xFcmUBfY
Gk1ZjrD9e/g6rvSxeUqOYkkCmv9RIp4/iuLj4bXyAqLSM+7LM2fX4xbPTLeOkLym
opld6mvL1hupZxIC2VFeQfLnkkA/WA==
=r5nG
-----END PGP SIGNATURE-----

--Sig_/++6XAr=93HCVz0ylAiagd2.--
