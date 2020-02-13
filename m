Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB4C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC80206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WpuYjPYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgBMEFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:05:18 -0500
Received: from ozlabs.org ([203.11.71.1]:52631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgBMEFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:05:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48J2wW5hw8z9s29;
        Thu, 13 Feb 2020 15:05:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581566715;
        bh=OgihZt7c9BLtQOmNmp8YnDZixVLslxy/IHs2OBp+TaM=;
        h=Date:From:To:Cc:Subject:From;
        b=WpuYjPYo0YZpGpGKoBq+zFMWRfrqSuxtXpWddJYRUGPUrZY3M354jNjCKPwu962uk
         GIMP3QeUUxueWkXFOuekrmfj0YIcZwbcnZylBVhPM0ItpBWYyKK8txoKdmhLvwH+5W
         M5Kra139qiHW+poMdjlCsGvlOINYEjWgRLg7doyMY9zd69ooJ8+bDmRd6zakyUywcO
         WBNoTSVGSIJpBcEKwb5eBFaa7g3wGBFGVANuH4/btZ5LjJtPx6Q+bo7FlJ0GaqjqJm
         J1luErcjktV43OZdapIBb/gaQ1u2+nkol+hvtvBcXk6tCw3ZT4gswcLpSKCYol14dg
         jEl8+/pLeegNw==
Date:   Thu, 13 Feb 2020 15:05:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the csky tree
Message-ID: <20200213150514.0478d0f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MbIiYJL4MhL0czCz3rROdJx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MbIiYJL4MhL0czCz3rROdJx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  85ea1329d674 ("csky: Replace <linux/clk-provider.h> by <linux/of_clk.h>")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/MbIiYJL4MhL0czCz3rROdJx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5EyvoACgkQAVBC80lX
0Gzbdgf/eqDlQdAWguhDLGD6gibFvhqiVMmNHG1V9Mp6q2tVhJS3tTfZ3Y3VxJdC
ctuR7pA8iHorhIDOZS81Y/weH1LT78sAqeMHa05brZRXHzsTsqxAeGSn/+Wp5blT
xvCDenO5nKqAzt125De58buaIxyneVfJOi/1YDHaEhVVe3+rIiJ7aiL3BNOHpKnf
kilkiLfhV3QLTCzIkjZEu3Jjp5Sfd+s/f9tUlZaM0Sx+16oY+nrUVPVeXmESdHBp
NOD4NO5DrC14gn0GOGLVj69c8avY4N9nCaW7eMM0hNFefid7OrLOdRTJoVLCtPj4
5NeA3JFsID54okPBBEmUOjBp2Itb5g==
=Q5r+
-----END PGP SIGNATURE-----

--Sig_/MbIiYJL4MhL0czCz3rROdJx--
