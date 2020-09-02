Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBEC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6207320758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ppTEVRVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIBFPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBFPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:15:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE8CC061244;
        Tue,  1 Sep 2020 22:15:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BhBwd6z5Kz9sTv;
        Wed,  2 Sep 2020 15:15:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599023746;
        bh=VCHVCIaiXznLeBXDorIqIyNQG7Ibsd7URED0Hz4D3I0=;
        h=Date:From:To:Cc:Subject:From;
        b=ppTEVRVlsBUNOzViTlEwTSBumTUpZi6rTy/QTWhfDGzCGnY3fDbrFvghd8ZPQ8Wbe
         t9VZIx8cZRxBYNMFWSoBWHj7rxNUllbwym+7RGoi+iNwH0WXJZ89fL876/NSmgC7SC
         Cs5amT7JvvQhpJR/75RcFiA3AW6cu9rrUu2HX7ongqFEt7DbyGfjWmHs5JxpoOVsLS
         nuoRB3NIVcLZuMSsXSoHc9PLnZ64oltgmPbu3k2/hfLTeXpdgSfh1Dx853IdO/0pqM
         oruWjqSyvEsM8NX/mkP3z2BSX5Pw3NLqRIPzUGD8ZeQwNo00viQfRo5cCyaPUNzz7V
         0kJJT8AfDH1+g==
Date:   Wed, 2 Sep 2020 15:15:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20200902151545.191f0146@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CE=S=B1ILfSoykyPwYnnpA3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CE=S=B1ILfSoykyPwYnnpA3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/ufs/ufshcd.h

between commit:

  8da76f71fef7 ("scsi: ufs-pci: Add quirk for broken auto-hibernate for Int=
el EHL")

from Linus' tree and commit:

  5df6f2def50c ("scsi: ufs: Introduce skipping manual flush for Write Boost=
er")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/ufs/ufshcd.h
index b5b2761456fb,a88dfac7c9e9..000000000000
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@@ -531,11 -531,10 +531,16 @@@ enum ufshcd_quirks=20
  	 */
  	UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR		=3D 1 << 10,
 =20
 +	/*
 +	 * This quirk needs to be enabled if the host controller has
 +	 * auto-hibernate capability but it doesn't work.
 +	 */
 +	UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8		=3D 1 << 11,
++
+ 	/*
+ 	 * This quirk needs to disable manual flush for write booster
+ 	 */
 -	UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL		=3D 1 << 11,
++	UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL		=3D 1 << 12,
  };
 =20
  enum ufshcd_caps {

--Sig_/CE=S=B1ILfSoykyPwYnnpA3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9PKoEACgkQAVBC80lX
0GxS6Qf6A0FWIww64fEJK8QUd6YGya69Gz5+f9eA/ip0eineTkfeJ0Yp8VbP5kqn
n5q+5TrKAqG60KC+i5YkqJLxtXUOOVTnS53BeVameMUzaMYb0Wt3jOEAYe7iW9MN
6FLu/sZcXigEAndi+6b6eS0q1kW/FQitf/1ED8heY0mw04SN28gb80ZbJwWX8oyv
MqO3e25VqFgWT6lDz7oLaiRyn+LpFCjXLvyJMkfOBg/Y/3waaectlqwA9K/g9Zyv
+kiQlBYiwdYadXfEN2skZ/PuqCM6gB5YHJlVo2rnJmUmPduFCGxl9eC+f5AmGPQ7
J+jQiCpVTydHBq2qofXNQ27AJIYJhA==
=F2x7
-----END PGP SIGNATURE-----

--Sig_/CE=S=B1ILfSoykyPwYnnpA3--
