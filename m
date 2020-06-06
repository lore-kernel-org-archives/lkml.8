Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10350C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94FD207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cWhkDzXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgFFBOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 21:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgFFBOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 21:14:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCCCC08C5C2;
        Fri,  5 Jun 2020 18:14:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49f1l41B5Gz9sSS;
        Sat,  6 Jun 2020 11:14:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591406083;
        bh=PwEtzUjQsd7IBU3ABeimYkuoJz6U3Ajym1ghVHdVaRc=;
        h=Date:From:To:Cc:Subject:From;
        b=cWhkDzXiQqWZsd+VDsgl0xclhq6xAgdnWGq9ydKUuG4QcatGkK6M0YU3x0a1r2kN9
         HtzEJNEK+mIMy0Ka9bsVKiSUn4V+dgyYxAeICQ2ZLjElCPxbP09IjEpwsrZO9MAU2Y
         1ncOI4pFc6RSV0wTwvZAqMnWnbzMYxBPnXahlgqF4/WfyRrGe2aBOLK73EbSm+X9xV
         Md4eDYiHZ0sdlC4O4GEe1dXvN+4XUzYBNP/5F/24xWkdP2JFhu8zzYU39iTY7f7ME0
         XrluM35+eJS8GfNeJmCcAFuMppM+SgQfmcsmDez/T8nkML7lwIG0DVdDBeLSnyj+9S
         6sDi5voKK0JpQ==
Date:   Sat, 6 Jun 2020 11:14:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20200606111439.1fa49e93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I+IkMt82ascTo/8RdfVtFoq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I+IkMt82ascTo/8RdfVtFoq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1c82ca4f876d ("RISC-V: Force select RISCV_INTC for CONFIG_RISCV")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/I+IkMt82ascTo/8RdfVtFoq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7a7f8ACgkQAVBC80lX
0GxmIQgAjd58H04M2/NmTH4j1i3cywO5EndYhXzlg1I6uJ4L3T8GwAWpzuH70MD3
N7Xb7SZifybCmyTAMXPWJkdog0FBOaAD7jnEMjfZ8nHLnDd1u0tOYr0YkKD/DaRF
sR0vYFnrivlXYCJSGA6KeB0iL7uTmPQAMrLWZkqFL2OmTK6HsojoJaWJKxLUn2SP
Bw932Q5exxNrnUmjZilxl4ysyzcJtqBuTO/UNRsdiul8YI+YhtImVAX2gT78Li/d
e7Jp3xLkLx4BHn+AZ/pTIR0J1sxxF+l1lY6iqxJOMoHoiQWcg255ShfJAM38gI2s
be8sKAIvpM5PO9S+f9MgVSeQcZ4UMQ==
=XMMx
-----END PGP SIGNATURE-----

--Sig_/I+IkMt82ascTo/8RdfVtFoq--
