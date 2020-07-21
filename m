Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E75C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5011F20709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EhM1gJiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgGUWdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGUWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:33:41 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D18C061794;
        Tue, 21 Jul 2020 15:33:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBD020WFSz9sQt;
        Wed, 22 Jul 2020 08:33:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595370818;
        bh=mEh9lByFt6+8XfLg34G91vSdHQ48/apE0hfFi62CUvI=;
        h=Date:From:To:Cc:Subject:From;
        b=EhM1gJiv7FHNRsr4Hqd3T1k0s7wnMx10ymdwYJgTT74xP9e8piISwg/G/cdTZ7ecs
         ibo5sggBlNG7mYJN4uo533S8MtY5TCOQUJVgq12QrbfOeEa4csNdU2Dv5N/UWhkfAb
         mtbS4iJg32VqUvYU8jyI4Wj7ox+tveKzL5NHElfi2MxbEsfnG2P1Vag0JYBILs6Rr9
         3/CtqbsX8V9jdH2vRQVFNU4DwiEvmUTaQGKDPoqroOhP2Ovv6pmG0zoq2mrqn/J4P8
         T5874mWUe6CVWcrzrh1cuhysyHf53Umya7SJE+zcQtDYSuArl8Q+92HWhJxnQThfwZ
         kMXon+TusLf+A==
Date:   Wed, 22 Jul 2020 08:33:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: linux-next: Fixes tag needs some work in the leds tree
Message-ID: <20200722083337.067e1445@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A.eKzdVutjbv5GyOp483DFO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A.eKzdVutjbv5GyOp483DFO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  347b711870ab ("leds: multicolor: Fix camel case in documentation")

Fixes tag

  Fixes: f5a6eb5c5e38 ("leds: multicolor: Introduce a multicolor class defi=
nition")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 59bb31e8549e ("leds: multicolor: Introduce a multicolor class defini=
tion")

--=20
Cheers,
Stephen Rothwell

--Sig_/A.eKzdVutjbv5GyOp483DFO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8XbUEACgkQAVBC80lX
0GzWTQf/fQ5WDTJaPGRjUvB8n0i6Bjfv5QQOQiBRLaBs9tZSQzmwuxqlfeuMWY40
PQfoipRFUbkGJYQKBk3MH35tsp+G89DvN6WXNPHBU3dKY8P5DKnUy/xhiSkTbZKn
y4Q9+fi3EOaRIsfxi2M92XCVpufGDE4TV3L7RIoCGM4Css82vrWJvRQ7PsIPn6QS
fkD5m9lilufRcfIcU+8NehjEcMHtiRR07N94jezShuV4h2DwW8vn03jUW1bw1cwh
XjworXjBdLf3TwJeJl9D5nfSg2Bq4GelCuV1D4GaqDN+xMVUbhjPlS4K5tIDwrlp
B7m1oJxyL8QbTjVfj4JQKYMps3sMiw==
=xtQT
-----END PGP SIGNATURE-----

--Sig_/A.eKzdVutjbv5GyOp483DFO--
