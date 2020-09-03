Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49963C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2272065E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WVbXYFP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgICInD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:43:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICInD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:43:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BhvTJ2kPFz9sSP;
        Thu,  3 Sep 2020 18:43:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599122580;
        bh=Iy5U+KyMIx18vEQtwtu6Fxd4Hl8O/BghnRnYf6ecj1s=;
        h=Date:From:To:Cc:Subject:From;
        b=WVbXYFP4p1EmJEBlVs/PVoFVUU5ZD+gvQ6l+Ny7Rpm0YnZ9Ift/GSw85l8T/HgC+w
         +aRdeATsxkXq8ZlTQuFx0I0DrCjo0oLjqMujrTyhCxKyoiP6vHMc7EuLM2DPdfgWU9
         iQXXx7GcfJFlbmBm4enVIPK0gHoGoT4LAmipQebQfDsJIlKAcwc0C/mwuR74UNe/BP
         bCYNGxsxjUWIyVjRZp+KpTiVaunSyo65OX4c2Z87uMpU2DnYRz3vecKBzbtOKu1pkv
         CdDnD5n8TcxD+URp4Xy2U61eQfDB00pLnvdYQt5CBm9QeoHBAtUbsntVmNdqSGJaNx
         0hCBEzdBcTwKw==
Date:   Thu, 3 Sep 2020 18:42:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huang Pei <huangpei@loongson.cn>
Subject: linux-next: Fixes tag needs some work in the mips-fixes tree
Message-ID: <20200903184259.74a4f24f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SegEZPdmtmuQMX1mny4Y17Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SegEZPdmtmuQMX1mny4Y17Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f8a005e1632c ("MIPS: add missing MSACSR and upper MSA initialization")

Fixes tag

  Fixes: cc97ab235f ("MIPS: Simplify FP context initialization")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/SegEZPdmtmuQMX1mny4Y17Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9QrJMACgkQAVBC80lX
0GwZ2gf9FCd/DbXTwmUyQ6vB38vafa/QVIVIm0KpYnYF+y/ApRJFXjjArmCNZ9qZ
qzkuPpTAQIj27j7HQHLvQtl3tov8Wo7kQvXec00ipQ5YsJV+JglEgFbqr10gnlf5
tPuHGSUCIvNONGwL8h4ues18VQdNJlrmGvqEb0aaM+VepuWukd7VSZ/3yqzImZMA
9s8OiLy4AMS/uhMhCJWH3uhjdYyqsLHMTwP9eZFvu8ybuisZeMaKKjGdyj9Uxp41
zR2bMkmBNrD8VQ5W+Q9fp7KtB+YLfAN3vSx2Di880HoXxb4mWBPk2Si8/iGweN9y
eMoCZCcto0M9Bq9AnvhLWdSP+zZV+g==
=KeCC
-----END PGP SIGNATURE-----

--Sig_/SegEZPdmtmuQMX1mny4Y17Y--
