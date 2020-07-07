Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3A3206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zh2oJhSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGIai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:30:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B9FC061755;
        Tue,  7 Jul 2020 01:30:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B1Fxm0NQNz9sRK;
        Tue,  7 Jul 2020 18:30:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594110636;
        bh=fCjZaQjF2DxSFXlTiSYwEUj677TAaVg9hEm0Lk481fI=;
        h=Date:From:To:Cc:Subject:From;
        b=Zh2oJhSHOASkW1j2gB8hrojuQJm9mNJlbr4Ax1Gqs6iEQMxJNt190BG7zV0vXjysZ
         vTNG1ISpwervJOlD9GjTevRrXEcTMRYefXGcICa8sssDXHo/FfAJFsnQRiALtRooxT
         pDS8zZLG65BNuuGQJ34+0hQKCmpOmoqK/AQu00XxB/MYaqK5JveM8BzFVYcbN0lhUL
         C5gkBK/JLO5atvzMEy6XB+Ug/MmjrWmQAPJkIwnUacVmlLSI+eTh3ngRmLul/dzoSE
         EhgOKlmhM18bMyPVxGLzD36S1dwKeoQ/y4Jhz0U0PA8YujT/6SX1yQKg1N6mdibxGl
         HbcN+AA91/pjQ==
Date:   Tue, 7 Jul 2020 18:30:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the generic-ioremap
 tree
Message-ID: <20200707183035.56420aaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BC7tsvFrhUsQLOb6SrFHxf3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BC7tsvFrhUsQLOb6SrFHxf3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2ee080ecf668 ("wip")

is missing a Signed-off-by from its author and comitter.

Not much of a commit message either :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/BC7tsvFrhUsQLOb6SrFHxf3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8EMqsACgkQAVBC80lX
0Gw0HAf+KC307/TZ1SyMwIQJzrQexw65PzfsBbkKz551WOMD3yVK1Re4riSrValj
WxmEcKlyPRdJFZCZKfBVKtgwU2nCBAMkUftSEA6QmeAKL8GwZ2CPgm3mQm2el28B
gLQBCOz7OTEoKmalcHcsCD/iXj3D7RfgH9Sj2o/TQD0sSlLYiXNHm0YR7h28zUkR
33cvUQz3S8TO2aAAPXm9B8c2sjcKIh95q1AnVLYo+ohidWA4UyP4SK5GbXzEo4vq
Ri1qCdPa3yW1SoFjsW1453UsEgx+1aRDU8GPbpZk49raQrcyzxpTEUnuuOD53X/Y
5jfp47/axYVkBgWiTa2NSyc9qPs0WQ==
=gD6z
-----END PGP SIGNATURE-----

--Sig_/BC7tsvFrhUsQLOb6SrFHxf3--
