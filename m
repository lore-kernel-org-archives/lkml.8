Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E68C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4161E206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YQ0m9+zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHZABY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHZABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:01:20 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91DC061574;
        Tue, 25 Aug 2020 17:01:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BbmGz0SKWz9sPB;
        Wed, 26 Aug 2020 10:01:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598400076;
        bh=TwFxGEb4cUq9387ARgHf6vpuujgya5+1GaLjkV+Xl7I=;
        h=Date:From:To:Cc:Subject:From;
        b=YQ0m9+zZT4sdW0hbJ8zCKXqxtgYeUBUEq2OXge6GMFdlZw+58ghsY3f+GdH5xu3nY
         QBG3pKrwr7Cgeh3sFrU4BbZOwHaO7LHk+C81Qbaj0NkhBQ4/HZeA2ih/xORqyB/yqB
         oed0Hkc/o06ooYldpIqkz7fXWMQc7m0g9PMjJeqcnm4jhNLnYAo8nMrIaP1aK6Kr9l
         D++fgJRsUTopUaP/HtaWpIp/VUQkPDPkLWDd+BSc48HTeXF6FGUBlziB/kR8Q7JknL
         nXHvTVUgrPzQl0n9HBFN2uE1pMgakUf/x4tMTJTVPcZKQIFvrqv/zbeOCq15O3Etac
         TpNuKChpsb0zw==
Date:   Wed, 26 Aug 2020 10:01:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20200826100113.6126afad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3ptXOJpu8Wggpt40t=+s=uM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3ptXOJpu8Wggpt40t=+s=uM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got conflicts in:

  drivers/video/fbdev/arcfb.c
  drivers/video/fbdev/atmel_lcdfb.c
  drivers/video/fbdev/savage/savagefb_driver.c

between commit:

  df561f6688fe ("treewide: Use fallthrough pseudo-keyword")

from Linus' tree and commit:

  ad04fae0de07 ("fbdev: Use fallthrough pseudo-keyword")

from the drm-misc tree.

I fixed it up (they are much the same, I just used the version from Linus'
tree) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/3ptXOJpu8Wggpt40t=+s=uM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9FpkkACgkQAVBC80lX
0Gw9bgf/aNCbX377c4IdSb1IJKi9m2loeOLAZ6oUTJII1MBCyizcDavmyZb6vLW9
ODBXdC8+1FMrHcLElvvgMpCTqTwfjgCHW+2cJc7kRVoCSyfwMoF6noWgof7ATDHa
H+zhNvsb1kLuR3LGCkARBhaHjyyWbgAunSTWtCbBRL6jE2JGqsP1SFVMZq/YBmRT
RzlNiad8d8bTR57MngIn4PNtwv9ZRPDeNTR5Dv1+QDxYHVWSjbzElnZwyvkVwxvY
daAzpHLtQobic5OppUm1aaG6rUtuk7lawrnBOWTP8Adac/cpiaqqSw3leLQhWPnt
Nz+0y+3MLOq/qm/Pu6K/cqydjBBEfA==
=nvdp
-----END PGP SIGNATURE-----

--Sig_/3ptXOJpu8Wggpt40t=+s=uM--
