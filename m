Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0194A20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WnDxyBD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgE2MLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:11:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2MLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:11:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49YNhd4kC6z9sT2;
        Fri, 29 May 2020 22:11:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590754289;
        bh=osB1gIlDBBXEjeXVAF6KWKSbfiB8hYfQ/nUnza0+KOg=;
        h=Date:From:To:Cc:Subject:From;
        b=WnDxyBD0A8l3iSQFsGgD3JscNX6G5E1XXFLIinh3a1kyO8PmIK81pSbhq4DgAocfd
         ae1e2ncwfeyniSLoxWiJ0K6F+IyFamRpi/K15Uv8qhVJZe4MdnXZv5aXjtlk/W1dle
         8tq8x1B5SwMmtZQIK+mJOIlCXZGCW8vlrVwVDCceg3nTUelHvUGPuAbDegRaAzhdGA
         hLbYgEyQfx25RzmQQb6cVpXyExrJBEADGn6jr1DeBWaZ/n7EXvFA8YkFKuiozOm/jY
         YUIhhOAqDdtL9+DSc8jNRlFxvRp7AOfmsrsCUoWwwrOZySXf0tNfV/KhwVv1FkpbzE
         3UqV96q8iOGCQ==
Date:   Fri, 29 May 2020 22:11:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20200529221128.668844ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eD7.5XL7X+zXjnQdb9Ya69A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eD7.5XL7X+zXjnQdb9Ya69A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  560d6b3da024 ("ext4: mballoc: fix possible NULL ptr & remove BUG_ONs from=
 DOUBLE_CHECK")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/eD7.5XL7X+zXjnQdb9Ya69A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Q+/AACgkQAVBC80lX
0Gy7iQf/Q25HAnmdPNn/xFOcFYvuibvdurQDGPndGqvaNR//Nh1pF/NJz+/emkCt
Ry7iQz4cA5oEEZMytHwVVMcIjkMJXJKAmyxCmHdWb3OBIuYbw+iTdJLrrJ3AGmMl
FQa8cWZ7Z5mmexxYxMOp4UQ2Wl5S0SN1nf4rHNI++TElc89XOPiubW8O8ilEOOo7
LgNoOjuD6LUbhZz4F54VXKCgm1hoIfaGewavapBYCEI517pjWHfSeIdZEANAIkqJ
X4gHEr7oj615yCz04aDXfsWtyzURvIlSHWR7AO+x4jvCFayNTQv354+JFMI0ZA2F
7Y9+OICdLGYI0RhNrgeYgLFkK1fqtw==
=q2aj
-----END PGP SIGNATURE-----

--Sig_/eD7.5XL7X+zXjnQdb9Ya69A--
