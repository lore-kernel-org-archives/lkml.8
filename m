Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E297DC54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F7E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uEsJhQYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgCXV2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:28:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgCXV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:28:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48n49z72mdz9sQt;
        Wed, 25 Mar 2020 08:28:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585085320;
        bh=sQnpTPdxtJrr8r70hWS8fGyIgmHzEUNsiIkrhRaZ2+4=;
        h=Date:From:To:Cc:Subject:From;
        b=uEsJhQYVbpOzt8AbhtFAxlSUHmveXa0qOgys7j3lc+Px3LIfCJW7wTyPgPSgO0BTv
         J6R0OtqwT/rz2t15eXSwWCUSbCb/uv27BlOnSIuB0fqJ92JW4e9q/3vN+APjT0IMhX
         MGQlAr3Ib2seHgQykIc4byibdZBII5DjE8Z+AP8WigekSoyDCID2FkOQMvhVzyoVmL
         70cBE9tr0TBGwNMlsiA+Ltz6QuCjx+LO+E5oT6X6EugegaefcvugJrBTrB5weVj9i+
         EJKmm0Vo6KEQ93/E2F2xoK+IG+hS6wF4JJe3fjFZ9SQ6qFmVuwsTwu08M6L3lfC6XF
         dFTm8OgiRJDlQ==
Date:   Wed, 25 Mar 2020 08:28:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the i2c tree
Message-ID: <20200325082837.62555003@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KeOVOhEjvzxEdJ_RViyk6k7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KeOVOhEjvzxEdJ_RViyk6k7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b0498c43796f ("i2c: drivers: Use generic definitions for bus frequencies")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/KeOVOhEjvzxEdJ_RViyk6k7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl56e4UACgkQAVBC80lX
0GwvpQf+MY7hK7/z0tRd0kRWOP/VGcnbKZlEXvUINl8AgB4DQK3Z/dhx119metms
AU8g9WRRhyMRpqiUQzeyZBkmvobdnT8S9OM2l8gytXd6Gm7MRzbAcQgbso7+e3MB
oeiQXEsgltrLj4aVS5Zg2bFCsYbrtfli+BkYRUIkcg31AL62PbP5CIu3dNvhjtkr
Ce7HCEDmLTheQjNcxqHv9UTXlKAMCu0UEvDrR7CdhQg/NVD0K85QogA61p5L+dYX
7GSY/V+byrTse0KWjMF0MvUblHb78JGpqZ4HgPGmAMFYeU83DEr6UdMfxbcIvT6K
HVOGapOsKE3L/hUsdxMn+w6FHnyEtQ==
=gcDE
-----END PGP SIGNATURE-----

--Sig_/KeOVOhEjvzxEdJ_RViyk6k7--
