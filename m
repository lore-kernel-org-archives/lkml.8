Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC7C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1932D20717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EIRb29Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGRIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 04:37:19 -0400
Received: from ozlabs.org ([203.11.71.1]:47675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgGRIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 04:37:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B81ZN4Bfwz9sRN;
        Sat, 18 Jul 2020 18:37:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595061436;
        bh=gTeSEd/BlloWxyCEUk/UQCF++X75mENXYoBi+3X6SUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=EIRb29Ic6syzqhHvZfNbcE6JhtQ6Q9g4OE6j5gNZxlJHlf21u/VwrwCn3/EotlIyg
         A5J/6wjqYM45VV28I4NYs4qi3NaZw912nMWLKYJ7rALX2DIcQ0Tkh/GaYSFBk2GPVF
         eJ1z5IBpJdmyBIGJnNnM+TnG4qiFcxPp+/UWu8yoUKvuJwjzRm4E5ZIzpGDWYeKZBS
         8Da6NKSvDVcTPJqLHtQgvWU0wWK1M7x7pkGpqFuK+uZILCmtsS2vG8WVtrV5AlQW7O
         fmN0JTuroTuP18/M/HhtBPoBL5ujgbn25j9eT0qU3OEIbxQO5qyRrN3vVcmJ8IMnaX
         Qn+2nwt2hlepg==
Date:   Sat, 18 Jul 2020 18:37:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20200718183715.45af4cea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=dxtHhDdfCq/NMU.EBieV4L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=dxtHhDdfCq/NMU.EBieV4L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1315971fea66 ("net/mlx5e: Fix missing switch_id for representors")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/=dxtHhDdfCq/NMU.EBieV4L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8StLsACgkQAVBC80lX
0Gw5Zgf9FzV6F/5dA843iqyrVSt1hR15cASs1y0CTI56ISyDu0oBlHjcNkybjBod
y7G1171Ro4KXyy1oQMEiXbZqNmDFkoZ+85pVWJ3ESeSe5v8Uwji/Bkiqbru2Jo7y
/Ph0rB9liFwAaEk3KaC3fp/bnky+ijUaNk6DlKAR/mUqu+N5YHJyg8hVwIlPBjCM
omay03PsyW8Zqdmnrx0emqVcT9Z5NpkgbNOxaUlSj0tPVDhNTOVnzh5NerTOXBHZ
ZQByEWSx912m34HA68PPR2C+hl4sDZVXc/K+ZFDSv2irsX+kJAABLZvPyjjXlWr5
IhtZCQOXpNRfUO71UtMiTqv2FUFP9Q==
=ZhWK
-----END PGP SIGNATURE-----

--Sig_/=dxtHhDdfCq/NMU.EBieV4L--
