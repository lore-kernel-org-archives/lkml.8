Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB49C3F2D8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0BA2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WnxtFWEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFE2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:28:33 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCFE2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:28:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48YZP85T9xz9sPK;
        Fri,  6 Mar 2020 15:28:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583468910;
        bh=UfePkVSA84l8BSsUoSZSfTBbZjB/agquaNc0EpI8Bh0=;
        h=Date:From:To:Cc:Subject:From;
        b=WnxtFWECUD9o3ICzg/s7w6PxdSE8qLxNUc49BEGy4JF1Tfj9pDBX0Ruk+oNN/26fL
         qL3+gSM8l6OVnx4CUG8O+9eFOzAGAQEnIZoMnEZff3gEZVTN1iU9qqiTyMFob5Ue/P
         DFo8W3gJYC8MAW8eyzS8YIAqZT4wxepf1OZm3lFX9iS9E4b96mWZiMO8gWzurRoDPy
         028FfqAH1cWWPBTewhExccGvwcekxwE8bneiDHpTVugUQNK8SeTVSUTXEGmlOIuStM
         RFz4i6dY2l7NyzP4jEJzfd5Nwa2f/2xLmx1FFy9fQJSQE8EYTpIxs3r0OcnHE26gGp
         cPEmwfMHketow==
Date:   Fri, 6 Mar 2020 15:28:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: linux-next: build warning after merge of the nvmem tree
Message-ID: <20200306152827.6fe507bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fLXQ7CvesYNnDtKNE+XJ+hD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fLXQ7CvesYNnDtKNE+XJ+hD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvmem tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/clk.h:13,
                 from drivers/nvmem/jz4780-efuse.c:25:
drivers/nvmem/jz4780-efuse.c: In function 'jz4780_efuse_read':
include/linux/kernel.h:842:29: warning: comparison of distinct pointer type=
s lacks a cast
  842 |   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                             ^~
include/linux/kernel.h:856:4: note: in expansion of macro '__typecheck'
  856 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
include/linux/kernel.h:866:24: note: in expansion of macro '__safe_cmp'
  866 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
include/linux/kernel.h:875:19: note: in expansion of macro '__careful_cmp'
  875 | #define min(x, y) __careful_cmp(x, y, <)
      |                   ^~~~~~~~~~~~~
drivers/nvmem/jz4780-efuse.c:76:24: note: in expansion of macro 'min'
   76 |   unsigned int chunk =3D min(bytes, (start + JZ_EFU_READ_SIZE)
      |                        ^~~

Introduced by commit

  50a09dfd394a ("nvmem: add driver for JZ4780 efuse")

--=20
Cheers,
Stephen Rothwell

--Sig_/fLXQ7CvesYNnDtKNE+XJ+hD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5h0WsACgkQAVBC80lX
0GyV+wgAg+FiaFMEaZ35Qm1UwGX7SGVkaLig4Y96xXyXWnDGwhyO5jpox/fGKISb
FprHwdTrQ1eR5Shm6CIeurNXI1toxGH1xTMTGOEjwYPtUSHVWjomhx78S+amJjad
9WOGuyWuYMLorlccuWPqxua7GhrKTLw+plUltqY+BZlGKGnWLyGupExg8+LyfM2R
/VKTeqQfBQQz2DP2RBqDA0T0SMafVHbA6fxF5HX4ViM1EaJcrJQSzaTNKycApFC7
DimT4fWkVnQhGBpTveqsDCBijQY4kM7dAQVoo9QqbInvlk7/jh5cjRCi5oOP6YwJ
5uMFeKd+nLFXmBUo+No5Dc+H1qLEWw==
=RUKW
-----END PGP SIGNATURE-----

--Sig_/fLXQ7CvesYNnDtKNE+XJ+hD--
