Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8881C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9970320787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uv6k698I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbgEYJ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:26:32 -0400
Received: from ozlabs.org ([203.11.71.1]:38069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389105AbgEYJ0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:26:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49VsD46c6fz9sRK;
        Mon, 25 May 2020 19:26:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590398789;
        bh=dpEaGF5R2kv01ZjhVoXB9HnIg8xgH3eOlPOgBNkICpo=;
        h=Date:From:To:Cc:Subject:From;
        b=uv6k698Im6ZT0yOU34zR9mWv7R4OYJExDdGbr3gfTQehOazrCKZqkLY1FswdkbowH
         onwWOTCI24PpntX1StGnio1UWVRyioyeNZFDiK3EXSq2AGiWop4mTToQHyOzVVOZtN
         its7/01J0sbxTVD740YzpQ1Nt0HOMqMRPZQmyrn8cJaLlhf7+x3r39l1ma2XfDUoey
         Og4QinE503IL2Lv/POLXlTzb3PSc6KurJI+BO8431UP04L3MayJFPQZc2oAWucMpZY
         eJebYZci2XlH9e2sC3bRx56X0TjUuHaAPFEMqQrJ/4/Xs62GtEsv8b1LPlaFDkUWE2
         K8/ZAzqXI/QYg==
Date:   Mon, 25 May 2020 19:26:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the notifications tree with the vfs
 tree
Message-ID: <20200525192625.18ae7c9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5EBdVhma5iqohTziYJPk.st";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5EBdVhma5iqohTziYJPk.st
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the notifications tree got a conflict in:

  include/linux/pipe_fs_i.h

between commit:

  f6dd975583bd ("pipe: merge anon_pipe_buf*_ops")

from the vfs tree and commits:

  8cfba76383e9 ("pipe: Allow buffers to be marked read-whole-or-error for n=
otifications")
  e7d553d69cf6 ("pipe: Add notification lossage handling")

from the notifications tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/pipe_fs_i.h
index 0c31b9461262,6626f511de6f..000000000000
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@@ -8,7 -8,10 +8,11 @@@
  #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
  #define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
  #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
 -#define PIPE_BUF_FLAG_WHOLE	0x10	/* read() must return entire buffer or e=
rror */
 +#define PIPE_BUF_FLAG_CAN_MERGE	0x10	/* can merge buffers */
++#define PIPE_BUF_FLAG_WHOLE	0x20	/* read() must return entire buffer or e=
rror */
+ #ifdef CONFIG_WATCH_QUEUE
 -#define PIPE_BUF_FLAG_LOSS	0x20	/* Message loss happened after this buffe=
r */
++#define PIPE_BUF_FLAG_LOSS	0x40	/* Message loss happened after this buffe=
r */
+ #endif
 =20
  /**
   *	struct pipe_buffer - a linux kernel pipe buffer

--Sig_/5EBdVhma5iqohTziYJPk.st
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Lj0EACgkQAVBC80lX
0Gws6Qf/VT52rUTYi6+64RiNS7LHAqE3+FoZ7Z7+jRBSJBwW85OtSL/HDcqj+plz
IVJTblFDTknBrw+qiii2wSrVyCOSDUumcoKeamtEMsi/3EYq6pa9qbuR8UL3fGPC
PZUduaKYHRKCNfxmOFQ3LytQY1XJbEXtQ0PLYSkFXy6SgW2cuFdZOT0+OJN5oDzJ
y0S6UqAj3hws11CK83Xnlb196HF8BOypUSx0ep49RMbBx4wVh3Bsd4iVMWsGVw7i
P2OCTkeYuFJfkHnKSwUTnXPcShIyUy+VCtMTALcvdJMtQnV/SPtFeApxFGyJnCBi
0V9VFmJ2jT3hsB91q5t+lV33KG3+CA==
=S4cI
-----END PGP SIGNATURE-----

--Sig_/5EBdVhma5iqohTziYJPk.st--
