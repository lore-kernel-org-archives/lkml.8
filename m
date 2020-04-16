Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE2BC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D4B221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XaJtElvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgDPWai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgDPWai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:30:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4839C061A0C;
        Thu, 16 Apr 2020 15:30:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 493DSr19S3z9sSG;
        Fri, 17 Apr 2020 08:30:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587076236;
        bh=qTJxlRbE+T+2YJFoXSIvLR1Gb9pVj+adyuv8+KIBxEo=;
        h=Date:From:To:Cc:Subject:From;
        b=XaJtElvzVrDKHG7powdtA0Ts2h+NyifwOx0F1ACwmQKtgrmStNdRUOJQzpfAIunML
         W2lEjJE4GDkuOwSDgKsOEvReodSlt+Oaz5lLd5I7vS6JtlYs9aJ6z3gTaemIXFVKh2
         Pv6FmszcEJUDbwtnuLnvoqaK+jLCzFjT0rzbdFE+CkAVO3A7aFYDqIrV5ts+VAQ7rc
         ySKeIMZEO/hEhUChMkrx9GRjVcWzTUiezSFXwo7thd8Pmt0Kme9jgolM0g5Kj65jIT
         ldGaQUxDjyj7Zu+4W9h0CrIqcTuSOcdOrqbYRN7YdRzTn9+z+3d2k7yFI9vnlMJk2c
         jdesAWZ/JEQow==
Date:   Fri, 17 Apr 2020 08:30:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20200417083035.3c46185a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3QkmPTDbeOyBUd5XnD27qhs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3QkmPTDbeOyBUd5XnD27qhs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  eb032d7b146b ("pinctrl: qcom: Remove duplicated include from pinctrl-msm.=
c")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3QkmPTDbeOyBUd5XnD27qhs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6Y3IsACgkQAVBC80lX
0GxgGgf/dsvBHhDEUwJgnIVuILKda03rJVWGfuNivysG5yd7H83AJOna3c6C3flL
K9t+ud2QJdnPJQo2G6iqXgieQ1x51Sy67JivyCdUoaExse83Qk7deoY9Xi7MqDm3
YN6OBRllhClQBHt1F3QVB9q/vUTW4lMg7E9Vp18qZ8SK2ukIUVHJGFkJY7oY8oVs
LEtkvYdWCB4Ls1XmNg7tGh/ohG7jIIFOOkBVJUtuGyFDDfKZg/A7i36DqKArX7Ol
TvU6WDjAdz6cptQt/LL/2AJ1CZGnUhHDSlIqF9z4szI4zbvis/0c531cAL353RUv
WRfdN8Ry2u8KdDp4UOLlnwxrLrlTAg==
=0hN1
-----END PGP SIGNATURE-----

--Sig_/3QkmPTDbeOyBUd5XnD27qhs--
