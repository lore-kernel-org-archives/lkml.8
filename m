Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB842C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E4D2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jJHv4dkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgENW3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728482AbgENW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:29:41 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56EC061A0C;
        Thu, 14 May 2020 15:29:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49NR6n70DLz9sTD;
        Fri, 15 May 2020 08:29:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589495378;
        bh=JeunvOBzj/nn3DzNyB3xTBnP1+Ir5YCeDPCehLP/7j0=;
        h=Date:From:To:Cc:Subject:From;
        b=jJHv4dknuh4xybfYrlLlbHfRKcaTvQAfjiPv9EcobAtPFMcviu14hy8kNAscycqQc
         WFIQaNbFbO/PVx8d5HpEwWV2hLjOun9bySAOLaA9enmuqrA5kLuVsN8+aFs0fJvse0
         SvfN2MdxFAyVdivQLBOHsLefWftQlUHgHgduSBhYOMmCvEz8E59pQ2KsEb3GW2AQwD
         3TXo+7v/MGYFsJkyDn/3FJoAe3I7BP/6LZuCcS3QdFc+IYh+jW6U1MaT5qkeU5Y60q
         sJX8h1jzvUceS1lo47EuShPGzSjfY65EnXdcY5g23WlzNjbKpewxz9awef6UHhJx7c
         9cwfs8CEKI8bQ==
Date:   Fri, 15 May 2020 08:29:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: linux-next: Fixes tag needs some work in the integrity-fixes tree
Message-ID: <20200515082934.7a8ebec5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gjVtG1tEKHExZV1K3=CuFBa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gjVtG1tEKHExZV1K3=CuFBa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f438e9598695 ("evm: Fix a small race in init_desc()")

Fixes tag

  Fixes: 53de3b080d5e: "evm: Check also if *tfm is an error pointer in init=
_desc()"

has these problem(s):

  - missing space between the SHA1 and the subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

So

Fixes: 53de3b080d5e ("evm: Check also if *tfm is an error pointer in init_d=
esc()")

--=20
Cheers,
Stephen Rothwell

--Sig_/gjVtG1tEKHExZV1K3=CuFBa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl69xk4ACgkQAVBC80lX
0Gz8gQf/XSXD6YMSUC4GVhv8Myotbghpumgq0plm4JphQ41inYUn1ZJUi10Uq+93
p5twZ4HGoldEr1TMUKykK2cyZ2F4H0TqrYv1lFdGR5M3h6UNWNF7Tvx8kAjj5zvK
fsX4cVNn1pLPOBFaSNdd6kG7Qxop2lZDayZxhdzFwmqAB6geqlFs9uSknMF+eCsU
qSEMSmqhG79f8b5fcu7iI8uFkngAztixcesl7qZ4cO9xMRUKxv2iVr1p+A8V+FTK
EP/TY1S2sUvLY8CG1VgrMh8c2jV0rmR/ug3jwNTxW5sCOGk41VwjOGcrf40V5/TD
W3tEI3c1UMqRUaSsG8bueMu1PeeswQ==
=Y8ol
-----END PGP SIGNATURE-----

--Sig_/gjVtG1tEKHExZV1K3=CuFBa--
