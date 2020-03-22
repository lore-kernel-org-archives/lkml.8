Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF66C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04FC20753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ig4Wws9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCVXui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:50:38 -0400
Received: from ozlabs.org ([203.11.71.1]:54887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgCVXui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:50:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48lvQg4JHBz9sPk;
        Mon, 23 Mar 2020 10:50:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584921036;
        bh=ARu6Ei0cv/23Co1L6oD9zdq5jUCcNLUVYb7GCNu8lHk=;
        h=Date:From:To:Cc:Subject:From;
        b=ig4Wws9OBnBNm9obGL4PRJ2aLOVrQMPaHtZCYncP//G5FLws71giVvRT0nLGRW/8e
         kjhcwzfY64QfYtKXXr/ZlrCaArQ7StjQ7EfPcr1BfaJXpXbAQmWJMbkMahHEt7nQGG
         BbtgOIasv4ruVTH2oNUoWMPwvqGHFfzD/7QtXSeJTNDpkWMnWMu9ujkUCHTi+UmPz6
         2kjZ2iP8nxhZEASfHhSMQytDmKmJbxtUnYkAsp1Up5raCUVm+DRoTxrQagf5qYMWf0
         F3kvtLo7DOdzUsSEB1/LDgLscnLvWxxE3/YKGWqb/V4VgadQd+afg4IjdBqxTjIRmG
         CbliwvUN36iIA==
Date:   Mon, 23 Mar 2020 10:50:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: linux-next: manual merge of the jc_docs tree with Linus' tree
Message-ID: <20200323105032.2a068daa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hRIJeYCYBu1I/YyWZtHJhSo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hRIJeYCYBu1I/YyWZtHJhSo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  MAINTAINERS

between commit:

  726464596b5d ("MAINTAINERS: eCryptfs: Update maintainer address and downg=
rade status")

from Linus' tree and commit:

  19e91e543c82 ("MAINTAINERS: adjust to filesystem doc ReST conversion")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 8882742b0f5b,38f58b85eb06..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3917,10 -3906,10 +3917,10 @@@ W:	http://ceph.com
  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
  T:	git git://github.com/ceph/ceph-client.git
  S:	Supported
- F:	Documentation/filesystems/ceph.txt
+ F:	Documentation/filesystems/ceph.rst
  F:	fs/ceph/
 =20
 -CERTIFICATE HANDLING:
 +CERTIFICATE HANDLING
  M:	David Howells <dhowells@redhat.com>
  M:	David Woodhouse <dwmw2@infradead.org>
  L:	keyrings@vger.kernel.org
@@@ -5948,8 -5937,8 +5948,8 @@@ L:	ecryptfs@vger.kernel.or
  W:	http://ecryptfs.org
  W:	https://launchpad.net/ecryptfs
  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git
 -S:	Supported
 +S:	Odd Fixes
- F:	Documentation/filesystems/ecryptfs.txt
+ F:	Documentation/filesystems/ecryptfs.rst
  F:	fs/ecryptfs/
 =20
  EDAC-AMD64

--Sig_/hRIJeYCYBu1I/YyWZtHJhSo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl53+ckACgkQAVBC80lX
0Gwx+Qf9EQ5tXVNZ36wL5huTApq2krS0NR74/JD8qgmmiDVmxoK+16tlbDCHhwif
w7/PKw2RJXqx7fVBgObhMfnK6WgJfMaHfGcL1SeehvcxYnJguxHNHWXy1pQnkLGL
TsagmVxRwugoyPZbmuJXORLiWtz+Dlmjv6s9NgNqtznb2BEmmKVd8bZDLyYqQpjF
tUx/sJUa+88wiZ9wX+mia2YJ6JMKH9kXMxM22QGrCaumtO765KCQo4EdxIF7GbSX
OR4Ejd1Mm1ovPZiu6aXYw+MzAndKxYVoYzsKKAMQAOjsXF7zoH5vpPZ7lcVovKa9
TvoETRnb/pfv9Zympkp+7fUA9K9yiA==
=qBfV
-----END PGP SIGNATURE-----

--Sig_/hRIJeYCYBu1I/YyWZtHJhSo--
