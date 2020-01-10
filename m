Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508BC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D292920848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IeZjAy2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgAJClX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:41:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58493 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbgAJClW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:41:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47v6gN3z7Qz9sR1;
        Fri, 10 Jan 2020 13:41:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578624080;
        bh=0409PjdYUDN2tRl7pY+r9SlmqoRrmI/S6XgezTiAG/k=;
        h=Date:From:To:Cc:Subject:From;
        b=IeZjAy2HIfssEW5/5gmetA7G4YRtH87MAdCfeMeSS6s2Xfj9+waQzcZfkZtGFppGp
         KgSfsuYb1fpq6i6GLI+lK4rYZHgmu7n5caXlXMxfAmd+fheYzOV6TJOW/hstua1BV4
         QHe/nFX+OrrAMl3HJkJvyYci8+ZnqwBFMFyPBu49fFqbjyzLL/mDn/f2VwlDL1U41x
         1YbCf0ZTjdT3lNloXyO4oaU+7bdNk50bBUEfw2WwMqf0SjqflTq1+QhRYu3wSkCzyH
         FYLvpVVjj380Wf/+mdI+ORwGtvf6YgdX7EdIadIvMYS/T9XCwDCeQ/Cpm1O1m0MXWK
         jbi2SrFKMuMBg==
Date:   Fri, 10 Jan 2020 13:41:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: linux-next: build warning after merge of the regulator tree
Message-ID: <20200110134119.0fa47da8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t4bHm0r.Fz01OXJ03OadvWg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t4bHm0r.Fz01OXJ03OadvWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the regulator tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from drivers/regulator/mpq7920.c:19:
drivers/regulator/mpq7920.c: In function 'mpq7920_parse_cb':
drivers/regulator/mpq7920.c:224:13: warning: conversion from 'long unsigned=
 int' to 'unsigned int' changes value from '18446744073709551551' to '42949=
67231' [-Woverflow]
  224 |     BIT(6), ~BIT(6));
include/linux/regmap.h:75:42: note: in definition of macro 'regmap_update_b=
its'
   75 |  regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
      |                                          ^~~

Introduced by commit

  6501c1f54a17 ("regulator: mpq7920: add mpq7920 regulator driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/t4bHm0r.Fz01OXJ03OadvWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4X5E8ACgkQAVBC80lX
0GwZagf/RaEN3QJX6V7LQm3WO6UvTfL6/Lsb3HYZZkakFz5Xo0B0qb/xYVBOo9IF
oqbCRBLKy9dgQ2Uc8CoVWPT6P1asN2kYj1Bra8XPXfOUSVyXIi0jvktniE3FA8T6
tmXJoYDJeNkuU7P0Ugmymsch2sMYXqjrgtjNfHzyPH6k70l10d/EODiNGuxT8UY5
wdwydY0BYKuirwXtXnM1ED2298tHQHz3aV+eCuB3ZyvSDnU4RtePn+6/IjMhEMPt
peC/uxYVkuRWJi8gbnxdz79PzRAeXCP64ECm5qZoJzht0wfaXmW5+xxbKMj0hhPc
xUdX3d0YjiZxTp/etABGz3AdBcZIaQ==
=2Xzn
-----END PGP SIGNATURE-----

--Sig_/t4bHm0r.Fz01OXJ03OadvWg--
