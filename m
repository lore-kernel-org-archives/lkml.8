Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EDEC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4DB20752
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PQ5REj8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDEBWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:22:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgDEBWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 21:22:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48vwrk54wQz9sRY;
        Sun,  5 Apr 2020 11:22:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586049750;
        bh=TYMWLbOGCBkuXZHDQKRf4ahJ6J3vlqb+GCti2VA7bvc=;
        h=Date:From:To:Cc:Subject:From;
        b=PQ5REj8JIOreHQ+DLYKyOi91hbFcCsK6z+wG4Id2f91A9yoQBCa8JvNUIcxl9WDtA
         PZ5yKHv3GttpWu+NLEijiY6aR6QiVJRdD2K80K18Ue4AdFWXAdj0zVFto4fQp/yo6n
         6VXqd9p5ddj9qJ0FpwT01uxAK0UDypIeoDAuVovC5aQ04R6N8GZ7RQQ7nAsHPixIJI
         PuV0+6ikLLHAHFb1lbBLJBV5x7Qwml6HiFi5g+kByDP2ftgUSJytvzEGdnI1mJ6cR/
         c6In1WuMY6RrOLAWJSVBUnklPz8E0zuqaZlJky49GhBAQJgdlPQcF/BOsJvfQuS5Vh
         A9wtXeeTzfTew==
Date:   Sun, 5 Apr 2020 11:22:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: linux-next: build failure in Linus' tree
Message-ID: <20200405112229.102bdf1b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1h022W_o8B7=4ktIZcHombK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1h022W_o8B7=4ktIZcHombK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Yesterday's linux-next build of Linus' (arm vf610m4_defconfig) failed
like this:

drivers/clocksource/timer-vf-pit.c:194: error: unterminated argument list i=
nvoking macro "BUG_ON"
drivers/clocksource/timer-vf-pit.c:131:2: error: =E2=80=98BUG_ON=E2=80=99 u=
ndeclared (first use in this function)
drivers/clocksource/timer-vf-pit.c:131:8: error: expected =E2=80=98;=E2=80=
=99 at end of input
drivers/clocksource/timer-vf-pit.c:131:2: error: expected declaration or st=
atement at end of input

Caused by commit

  cc2550b421aa ("clocksource: Replace setup_irq() by request_irq()")

A closing ')' is missing.

Reported-by: kernelci.org bot <bot@kernelci.org>

--=20
Cheers,
Stephen Rothwell

--Sig_/1h022W_o8B7=4ktIZcHombK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6JMtUACgkQAVBC80lX
0GwsIQf/c3baLxVRIz2FOu1OMLEPU9HgLlkWb0ahpeibMmz6Q0kFC8BW2xBi4HaW
a4clWM1WRp5jiVh1dtb0X5f2NKkMBJPde8QVu1j91v96DXUBCQgEMhloB1FqQc32
DxijS8X4A1ItMEDeJ4yPx5Y48fvv4cGH4VhxbyXUhbqHzQPkFkYcgNpOtiARorSZ
U57SCj/VhG2XM3mCfzecoqjnZ4Ldy9M1tA8uxWxkahqgQywT+sHuNGNBN0le1v62
yMmaU8CCECS73ocfpw62qAvFxPuTetIdumE9lQjw/tniaWZWf4A9PIszljTCd+gu
ncbr6xn9zv/PvOxEYHvFEAllSkg+Bg==
=zBnS
-----END PGP SIGNATURE-----

--Sig_/1h022W_o8B7=4ktIZcHombK--
