Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E3DC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BD20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rBc0xEE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgCPHng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:43:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbgCPHnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:43:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48gpFd530Zz9sPJ;
        Mon, 16 Mar 2020 18:43:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584344613;
        bh=XLT9Jf9yZQsFnwXj3AN1n6qKW2WgCf+CQFaUzBXFaMo=;
        h=Date:From:To:Cc:Subject:From;
        b=rBc0xEE92YsyDP21OMGZEscJfzyel2Bri4gGkgiiqLPcWXaqpkRlL8L0iVkxrUViC
         OH/159slzxHwC11FVtvF5eFh+18KA4Xy9KS6dF4ddqSUYSU6GrFsi4SM+nlZz0syQ9
         EsPa0n4ItSaHh0M6I6iJ+UQC8BStj54rqo75MIclgZ4AH3Q9jBm5ILVFD4+gourxj/
         UMFP216Y/1aBFnSQhZNYjAxU7rXaruB8+PU8/vqDlcWa1Jxkl10KzdzMKHgOeeXSbV
         YpsLiGbU5kCESKbQlsEJtD8uZIT2ecpE2No39ZeVkTPSQUwDJ+zhwXq3EobJzKfk2C
         miWt1objO8EBA==
Date:   Mon, 16 Mar 2020 18:43:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20200316184331.27d43eaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xaxcQLtuGHLKWlyJEIuxhuA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xaxcQLtuGHLKWlyJEIuxhuA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c258dccaf994 ("arm64: dts: imx8m: fix aips dts node")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/xaxcQLtuGHLKWlyJEIuxhuA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5vLiMACgkQAVBC80lX
0Gx1Cgf3W9PAKG6zbzl3Udv4sH5Np8/d8WdGsnQgCuqGOe0CnDWSyzwFj+gafA7D
isdD2MZR06iDMp6A1eoUFBWRc3zsvgJU3LDzHCTer29yem4sl1JpJVy+Z2AbhWQY
4JPwnD+aEQ3i+UhWcpAMmhPNV4RE0ciwMp4+0txOgLZwJ0OqbRnsZ5Gveq/wJvqB
qtKfPcLy0Kbeyd7COCHC4/ScpQwo5SGQA5xnce6aSSRDxexKNn61CmxY5VqTesAM
5N/OrfmKc0MbRFfvTfoRIEK9YXj9HUuaCF4W4fJvJogedCNDQCjRPvfN61RRUAk5
br0q45QPxAluDBmjP4t1TItXPMQ+
=gJWd
-----END PGP SIGNATURE-----

--Sig_/xaxcQLtuGHLKWlyJEIuxhuA--
