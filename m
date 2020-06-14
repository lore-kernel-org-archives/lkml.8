Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EABC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E6B2067B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 22:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LzghhAlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgFNWIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 18:08:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgFNWIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 18:08:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49lTBX6GjCz9sQx;
        Mon, 15 Jun 2020 08:08:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592172533;
        bh=1/++QR+4EKEcqLfT+MyjoTvLJX1k1raXRvJ4WlGYVZQ=;
        h=Date:From:To:Cc:Subject:From;
        b=LzghhAlf9lG1vhb0vadRcAugvFP8Vzl3NolO85evUhG8+4WM0+umZAmVAqxoWRtPx
         c1F9C9l9PmMTgSCjve1A67LuD3WIzcYHVIP4ZBc4xf6i1cAftGMWTQrvv29+PPf62y
         qj27XV8MPX0hCdpn3C+f8Ec7tFfQLxFl0vLczyGGuL1LT2ONyUbWKw6pOO7pzFMMiW
         hDmytMyBYbz7/VJWKJoRVZwQRaJHAayS6xdd6uqpAeKwalQO02bbA+q5cyRn8JPQvM
         iEVk3eOyVZ8RYT33rK8FtZH81cfo6eEOhJRBcXoa34FoKElDsohJKSJNrGNoOSwE1O
         DbPjZErpaMJnA==
Date:   Mon, 15 Jun 2020 08:08:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the hwmon-staging
 tree
Message-ID: <20200615080852.1aa4d860@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q5bxGRJisZibO7lu_wfzj24";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q5bxGRJisZibO7lu_wfzj24
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3c1c958a118e ("hwmon: (adm1275) Enable adm1278 ADM1278_TEMP1_EN")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Q5bxGRJisZibO7lu_wfzj24
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7mn/QACgkQAVBC80lX
0GyIjwf+KMPst0oRE+n12u2+C6ZeFgdFctpnTBwBw7UtagmtaEl3ZB3nLuBtSDPp
H4C0TY7Odf4xYBqikopC+d8nAiUft4Jps3rj0RUqm4swZdAx7z8aRd8EMQrqEKjE
zCtKnDjxgV2XC/OCiISp6awrB1dC5D9znn/yL/QXRcArcj77OLPB0v2/y01KphfP
vEwcxxKatxKhGw8baCKvyUzd4h/RqTc2GNmtx1xqIiEyFaUmw0yBKpjdyseghdhm
MondXk7cs1FgweXSad9AWW1nJEwLg4Wrq0WnY22lSn0s82tioIiHD7ygrJob+DVd
AyjljyAow0U/+mlxOlPOThc3i8mx3w==
=AAaC
-----END PGP SIGNATURE-----

--Sig_/Q5bxGRJisZibO7lu_wfzj24--
