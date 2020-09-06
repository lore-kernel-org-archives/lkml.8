Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8932078E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 21:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h2y5++3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIFVeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 17:34:21 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C50C061573;
        Sun,  6 Sep 2020 14:34:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bl4Rk44RKz9sSn;
        Mon,  7 Sep 2020 07:34:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599428050;
        bh=LVae7uBqBlhwsBI4H2pMKvqBdC6VZDlD7oXj1pVtqso=;
        h=Date:From:To:Cc:Subject:From;
        b=h2y5++3xKtXtWC3fLP1ZsqetZHKS0Ey5v7A/gfNlaMO04xPLrF9fwv+nTxom5FLG+
         2sWbYV2NMbjYp0TBU/HrJ8tY9ihVlE4buBksHKakllgpsn8PYkVskLTaNFi43XXBXL
         u2SJv9OZ9ewUZ0ngfQ8YdqRgOU+lBNX79hfYqduvDxBBlamSbPu+x3T6QuRlSA24sc
         RUHXqeWtyCXKztIrgcHvicf5I27XzFAye3pBwXA0hDqtCE4097ZNnRelMwqr7How2e
         0DOpfSk4Em3zP7Lfv9RrMZE6eV7aKFGDoN1ggFtVRmF8OGCQA/xqCfLfOID7O43Isw
         Rp8nfSZEWCUkg==
Date:   Mon, 7 Sep 2020 07:34:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20200907073409.622c6287@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JL2+ZEX9=TSdphYJlMdwa.a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JL2+ZEX9=TSdphYJlMdwa.a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0f7242be58fe ("clk: imx: fix composite peripheral flags")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/JL2+ZEX9=TSdphYJlMdwa.a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9VVdEACgkQAVBC80lX
0GybMAf/bF1Vv54wrq/vgkTnzmYfyiTJCo5LuATbGbOs9U1ZJaXpsCLRlwkUlcw5
mL8GR7p4TX/3C51wE5oepEwIX6fdoncl0jp57/C/OVtHqSukCVXP3NG+W8sEzfoj
E+yCtQuUXG/xaxwICf572k0pq3uIzv7bYH5WvNZMlJYU0KNii7nMIb0iRBPD+AB3
SA8MSrBYmKfqJg2++5JK59FS9C1KfS+7u1oKottT7C/MnB6nsaaFPb/SPuNn4JiN
EZPckDixhPATgsUBoiA5y6z4thejj5Txdx9pajAHVZZXi3vbHTQB8oSAMz9HTQLC
pq1gjZKmxwimIA6O90q5qVVy3Ov7ww==
=3lRe
-----END PGP SIGNATURE-----

--Sig_/JL2+ZEX9=TSdphYJlMdwa.a--
