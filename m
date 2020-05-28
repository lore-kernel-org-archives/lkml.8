Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A549C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E23207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S2/nTTcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407494AbgE1VGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407447AbgE1VGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:06:52 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A14C08C5C6;
        Thu, 28 May 2020 14:06:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y0cm22Cnz9sRK;
        Fri, 29 May 2020 07:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590700009;
        bh=WMuvVSkbWnRK99QWF//rHgFtlj/spdIehcjorjYnRAM=;
        h=Date:From:To:Cc:Subject:From;
        b=S2/nTTcQC0kVJCxy/1dd0n8FCCL9ou03a1ALVoX2TSLOJxWZIKL6C6ZVscnAMbSMS
         ipRl0o0xxnCNLGzzl/L/SOQpBBohEqQiDpL+Ap7K3rQJrpoJ346ltdzrIDGrT/UCsH
         AH+3cnymKumNmvwP8CjYN3wVgCV/vRJyo0hcR9z4dd8OfuMLtXZ42VRxLmQAxQa8Ir
         Kcw4uJFXmxhTDLzQcEZgvGfOq41VTsA9oTey2bsZZyeaAbKJyO1N6/U+cqu2JfLKyD
         WM6yXpB8oChNNgqPWGGdGAaVzbhIiqOdSlI7mLQzQi7t9oJZ4IbWUfU7ZPX66CBQuK
         4o/6I9F6JQj+Q==
Date:   Fri, 29 May 2020 07:06:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: linux-next: Fixes tag needs some work in the spi-nor tree
Message-ID: <20200529070647.5946fe06@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HSNW/=ui7750GSO9BbhVub.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HSNW/=ui7750GSO9BbhVub.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5587fa489747 ("mtd: spi-nor: spansion: fix writes on S25FS512S")

Fixes tag

  Fixes: dfd2b74530e ("mtd: spi-nor: add Spansion S25FS512S ID")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/HSNW/=ui7750GSO9BbhVub.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QJ+cACgkQAVBC80lX
0Gz5Ogf+OfNCrR2csMZWNiC9Y7jFmoLrgT1AUQ4T8Qf4DfoP2SrUj2KsvWgWdMeT
9bQuoVsPiy48hbidu2Mq4vYI7s1/bY3EOXm3zhE1uVIUyJsK9Zq1y+F+T33ZsQjH
RxDSfmrDIuBtwFNZjl0HI6H/uGEMvknLj54iCz9OaMkzftd8s7MMEc8K869mdAZA
MHTf/YFZ2o7571VF80h8oi1OF7Wdzb5vWKPI73vP5/+8riSAWKvFrkLcCuBKa2Xj
vEabE9Vx0Vi0cFktGU6cal6t3EgxrOWZxIDX4w8IMBNBIoEUHHd898EwzpoloZI9
R5Tb9X4o8iI7mh4/WfPcJxAPfdX7Pg==
=J78k
-----END PGP SIGNATURE-----

--Sig_/HSNW/=ui7750GSO9BbhVub.--
