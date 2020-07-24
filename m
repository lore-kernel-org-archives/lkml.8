Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F4C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A4F20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tTXT9i+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXCXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGXCXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:23:48 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB491C0619D3;
        Thu, 23 Jul 2020 19:23:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BCY0X6wN2z9sPB;
        Fri, 24 Jul 2020 12:23:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595557426;
        bh=bN8U7G1juy01wiajGZjiaE7j/5xz+BioEttOGYRZprE=;
        h=Date:From:To:Cc:Subject:From;
        b=tTXT9i+65peA3SqGimMv3+wCcp1LlYtJjaRHeiHy6qqPOZys/68gebTggPV8srH7t
         JsjZsBf5S2uOnuKSUIsllO6yHkQ5f9a3fXaEasLt8E6R+AwNDPTYeb1kSRhTguWR9S
         qTY6RvIAA4sfZ2mC5BcXcyhlzMV3g/v8NV93KIKen/q0SMXFU+S5Fg9YhJdyRgjB1y
         YZK+eGwo7tVbtYHo2Hg5Ty1XQagpI5L61ypT1srC7I8hZEtXDGCs6hqUw2gQrhRQxO
         R3wQk5bcg2qHFeMbPHhQl3QGQtJB+0mlFRFPdbd/X5Gxy27FOezWIZaTd7dV8UkmS0
         AzD3Es8DMGF8w==
Date:   Fri, 24 Jul 2020 12:23:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20200724122339.7abaf0e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EGZA=/AkJi0fr0zl4/ATvu/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EGZA=/AkJi0fr0zl4/ATvu/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/freescale/enetc/enetc_pf.c

between commit:

  26cb7085c898 ("enetc: Remove the mdio bus on PF probe bailout")

from the net tree and commits:

  07095c025ac2 ("net: enetc: Use DT protocol information to set up the port=
s")
  c6dd6488acd1 ("enetc: Remove the imdio bus on PF probe bailout")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/EGZA=/AkJi0fr0zl4/ATvu/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8aRisACgkQAVBC80lX
0GzPnggApnPI6idjigVTb3u7DyKeLobDIPoAl9w2ymwXZVKsPVjyFgg5ZWzNGQ4W
qtAfbYne78uWNTVeZ80MEbf44qWamM9HTv/7uADKdniPl6poTkC3/iAwRVsFe82n
GOJDNTSf/oaLXavuQu5DiM6JLknBaakIhZS7vP+7PVQBpH8IhopFzB/mwEI27Il1
fqNnbbJKUAUitAk2tAIOKLxY8DW+LtUIrecvjJmhx1DHZiPCSA/M+8pRDwfUR1O6
aE3UeoDfShj0MEuZ3DPc9WqenbQr4HyRWGIpuDe7PO0xLWlGDCbkKX5B4+fF4UVQ
D5EXaKZFdkQDRILpxqHYQQC2NGQ7tg==
=B/2n
-----END PGP SIGNATURE-----

--Sig_/EGZA=/AkJi0fr0zl4/ATvu/--
